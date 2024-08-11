import requests
import json
import os


class MultichainExplorerLibrary:


    def download_deployed_contract_from_explorer(self, network_type, explorer_url, address, api_key, output_filename):
        """Downloads Solidity source code of verified contracts from EVM blockchain Mainnet or Testnet explorers. 
           Creates a human readable Solidity file with a name (your-contract-name.sol) that you provide.
           Un-verified smart contracts will not work with the EVM blockchain explorer APIs.
           This keyword could theoretically work with any EVM blockchain explorer that is designed like Etherscan.
           This keyword requires a valid Etherscan, Polygonscan (or similar) API key etc.

           Helpful Documentation Examples: 
               https://docs.etherscan.io/
               https://docs.polygonscan.com/

           Required Keyword Arguments:
               network_type >>> One of these two arguments... Mainnet = api, or Testnet = api-testnet
               explorer_url >>> These arguments have been tested, but others may work... etherscan.io, polygonscan.com etc.
               address >>> Deployed contract address
               api_key >>> EVM blockchain explorer API key from Etherscan, Polygonscan etc.
               output_filename >>> Give your downloaded contract file a name         
        """

        url = f"https://{network_type}.{explorer_url}/api?module=contract&action=getsourcecode&address={address}&apikey={api_key}"
        explorer_response = requests.get(url)
        explorer_response.raise_for_status()

        solidity_code = explorer_response.json()['result'][0]['SourceCode']
        readable_solidity_code = ''

        if solidity_code.startswith('{'):
            sources = json.loads(solidity_code)['result'][0]['SourceCode']
            for filename in sources:
                readable_solidity_code += f"// File: {filename}\n{sources[filename]['content']}\n"
        else:
            readable_solidity_code = solidity_code
       
        if not os.path.exists('downloaded-deployed-contracts'):
            os.makedirs('downloaded-deployed-contracts')

        output_path = os.path.join('downloaded-deployed-contracts', output_filename)

        with open(output_path, 'w') as f:
            f.write(readable_solidity_code)

        print(f"Human-readable Ethereum smart contract file created: {output_path}")



    def get_contract_creation_information(self, network_type, explorer_url, address, api_key):
        """Get Contract Creator and Creation Tx Hash from the explorer API, then return the data as JSON.
           This keyword could theoretically work with any EVM blockchain explorer that is designed like Etherscan.
           This keyword requires a valid Etherscan, Polygonscan (or similar) API key etc.

           Helpful Documentation Examples: 
               https://docs.etherscan.io/
               https://docs.polygonscan.com/

           Required Keyword Arguments:
               network_type >>> One of these two arguments... Mainnet = api, or Testnet = api-testnet
               explorer_url >>> These arguments have been tested, but others may work... etherscan.io, polygonscan.com etc.
               address >>> Deployed contract address
               api_key >>> EVM blockchain explorer API key from Etherscan, Polygonscan etc.  
        """

        url = f"https://{network_type}.{explorer_url}/api?module=contract&action=getcontractcreation&contractaddresses={address}&apikey={api_key}"
        explorer_response = requests.get(url)
        explorer_response.raise_for_status()

        contract_data = explorer_response.json()

        return contract_data 


    def test_multichain_keywords(self, network_type, explorer_url, address, api_key, output_filename):
        """Just testing the library...         
        """
        
        print(f"Just a test, here are the contents of the Datadriver CSV file: {network_type}, {explorer_url}, {address}, {api_key}, {output_filename}")

