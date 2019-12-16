# EvmRewriter

## Usage

usage: evm_rewriter.py [-h] -b BYTECODE -m METADATA [-t TIMEOUT] [-d]

An EVM ByteCode Rewriter

optional arguments:
    -h, --help          show this help message and exit
    -b BYTECODE, --bytecode BYTECODE
                        EVM bytecode file (HEX)
    -m METADATA, --metadata METADATA
                        Vulnerability metadata file (JSON)
    -t TIMEOUT, --timeout TIMEOUT
                        Timeout for analyzing and rewriting in seconds
                        (default to 30 seconds)
    -d, --debug         Debug output
