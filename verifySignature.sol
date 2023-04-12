// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract verifySignature {

    //retrieve the signature from console and metamask(get private key)
    //Step1. ethereum.enable() will call metamask provider.
    //Step2. use account and messagehash to get the signature.
    //Step3. use ecrecover function to recover signer address by ethSignMessage and signature.
    //Step4. compare the origin _signer is equals to the value return by ecrecover().
    function verify(address _signer, string memory _message, bytes memory signature) public pure returns (bool) {
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);
        return recoverSigner(ethSignedMessageHash, signature) == _signer;
    }

    //ex. message: welly
    //hash = 0x222e473b4c4dc42e7f1435a07ff2a64cfba83ded8269d3edcefcb210f7cdb924
    function getMessageHash(string memory _message) public pure returns (bytes32) {
        //just use keccak256 to hash the message
        return keccak256(abi.encodePacked(_message));
    }

    //ethSignedMessage = 0x6ca4f9831a07d781f47f91ad42add68733eaaa3afbc614c9fb5be4eaa6f81e51
    function getEthSignedMessageHash(bytes32 _messageHash) public pure returns (bytes32) {
        /*
        Signature is produced by signing a keccak256 hash with the following format:
        "\x19Ethereum Signed Message\n" + len(msg) + msg
        */
        return keccak256(
                abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash)
            );
    }

    //retrieve the signer address
    function recoverSigner( bytes32 _ethSignedMessageHash, bytes memory _signature) public pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = splitSig(_signature);

        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function splitSig(bytes memory sig) public pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(sig.length == 65, "invalid signature length");

        assembly {
            // first 32 bytes, after the length prefix
            r := mload(add(sig, 32))
            // second 32 bytes
            s := mload(add(sig, 64))
            // final byte (first byte of the next 32 bytes)
            v := byte(0, mload(add(sig, 96)))
        }
        //don't need to retruen (r,s,v) tuple
        //implict return
        //returns (r,s,v);
    }
}