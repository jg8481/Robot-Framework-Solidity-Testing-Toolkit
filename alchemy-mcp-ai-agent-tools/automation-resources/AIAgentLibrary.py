import os
import signal
import subprocess


class AIAgentLibrary:
    """Robot Framework library that drives a local Codename Goose AI Agent.

    Goose runs locally against an Ollama model and reaches Alchemy's blockchain
    APIs through the Alchemy MCP Server, which is registered as a Goose stdio
    extension in automation-resources/config.yaml. This library intentionally
    contains no Docker execution paths; every prompt is handled by the local
    Goose CLI on this machine.

    Every Goose invocation is bounded by a hard timeout and a maximum number of
    agent turns so a stalled local model (a known challenge with open models and
    MCP tool calling) can never hang the automation forever. On a timeout the
    whole Goose process group is killed so no orphaned goose/ollama/MCP server
    child processes are left behind.
    """

    ## Default ceiling on agent turns. This stops local models from looping
    ## forever on MCP tool calls. It can be overridden from Robot Framework.
    DEFAULT_MAX_TURNS = 10

    def _run_goose(self, goose_command, llm_time_constraint):
        """Run a goose command in its own process group with a hard timeout."""
        timeout_seconds = int(float(llm_time_constraint))
        process = subprocess.Popen(
            goose_command,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            start_new_session=True,
        )
        try:
            stdout, _ = process.communicate(timeout=timeout_seconds)
            return stdout
        except subprocess.TimeoutExpired:
            ## Kill goose AND any MCP server / model child processes it spawned.
            try:
                os.killpg(os.getpgid(process.pid), signal.SIGKILL)
            except ProcessLookupError:
                pass
            stdout, _ = process.communicate()
            return (stdout or "") + (
                f"\nERROR: The local Goose AI Agent exceeded the {timeout_seconds} second "
                "LLM time constraint and was terminated."
            )

    def send_local_ai_agent_prompt_message(self, goose_ai_prompt, llm_time_constraint=240, max_turns=DEFAULT_MAX_TURNS):
        """
        Use the 'goose run' command to send a prompt message to a local Goose AI Agent
        running on a local machine that is also running Ollama. The configured Alchemy
        MCP Server stdio extension gives Goose access to live blockchain data.

        The call is bounded by ``llm_time_constraint`` (seconds) and ``max_turns`` so a
        stalled model cannot hang the run.
        """
        goose_command = [
            "goose",
            "run",
            "--no-session",
            "--max-turns",
            str(int(max_turns)),
            "-t",
            goose_ai_prompt,
        ]
        return self._run_goose(goose_command, llm_time_constraint)

    def send_local_ai_agent_instruction_file(self, instruction_file, llm_time_constraint=240, max_turns=DEFAULT_MAX_TURNS):
        """
        Use the 'goose run' command to send complex instructions through a markdown file
        to a local Goose AI Agent running on a local machine that is also running Ollama.

        The call is bounded by ``llm_time_constraint`` (seconds) and ``max_turns`` so a
        stalled model cannot hang the run.
        """
        goose_command = [
            "goose",
            "run",
            "--no-session",
            "--max-turns",
            str(int(max_turns)),
            "--instructions",
            instruction_file,
        ]
        return self._run_goose(goose_command, llm_time_constraint)
