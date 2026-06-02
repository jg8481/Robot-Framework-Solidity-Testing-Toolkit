import subprocess


class AIAgentLibrary:
    """Robot Framework library that drives a local Codename Goose AI Agent.

    Goose runs locally against an Ollama model and reaches Alchemy's blockchain
    APIs through the Alchemy MCP Server, which is registered as a Goose stdio
    extension in automation-resources/config.yaml. This library intentionally
    contains no Docker execution paths; every prompt is handled by the local
    Goose CLI on this machine.
    """

    def send_local_ai_agent_prompt_message(self, goose_ai_prompt):
        """
        Use the 'goose run' command to send a prompt message to a local Goose AI Agent
        running on a local machine that is also running Ollama. The configured Alchemy
        MCP Server stdio extension gives Goose access to live blockchain data.
        """
        ollama_runner = f'echo "{goose_ai_prompt}" | goose run -i - && sleep 2'
        process = subprocess.Popen(ollama_runner, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        stdout, stderr = process.communicate()
        return stdout

    def send_local_ai_agent_instruction_file(self, instruction_file):
        """
        Use the 'goose run' command to send complex instructions through a markdown file
        to a local Goose AI Agent running on a local machine that is also running Ollama.
        """
        ollama_runner = [
            "goose",
            "run",
            "--instructions",
            instruction_file
        ]
        result = subprocess.run(ollama_runner, capture_output=True, text=True, check=True)
        return result.stdout
