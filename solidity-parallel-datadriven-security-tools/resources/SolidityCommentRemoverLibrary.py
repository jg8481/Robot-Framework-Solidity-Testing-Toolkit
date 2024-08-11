import re


class SolidityCommentRemoverLibrary:


    def remove_multi_line_solidity_comments(self, file_path):
        """Removes multi-line Solidity comments commonly starting with '/**' and ending with '*/'.
           Uses the Python regular expression module in the standard library.
        """

        with open(file_path, 'r') as file:
            content = file.read()

        # Regular expression to match multi-line comments
        pattern = re.compile(r'/\*[\s\S]*?\*/', re.MULTILINE)
        content_no_comments = re.sub(pattern, '', content)

        with open(file_path, 'w') as file:
            file.write(content_no_comments)


    def remove_single_line_solidity_comments(self, file_path):
        """Removes single-line Solidity comments commonly starting with '//'.
           Uses the Python regular expression module in the standard library.
        """

        with open(file_path, 'r') as file:
            content = file.read()

        # Regular expression to match single-line comments
        pattern = re.compile(r'//.*', re.MULTILINE)
        content_no_comments = re.sub(pattern, '', content)

        with open(file_path, 'w') as file:
            file.write(content_no_comments)