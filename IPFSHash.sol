contract IPFSVerify {
    // prefix 0a then the length of the unixfs message then 080212
    bytes prefix1 = hex"0a";
    bytes prefix2 = hex"080212";
    bytes postfix = hex"18";

    function verifyHash(string contentString) returns (bytes32) {
        bytes memory content = bytes(contentString);
        bytes memory len = to_binary(content.length);
        bytes memory len2 = to_binary(6 + content.length);
        //return sha256 hash of the protobuf message;
        return sha256(prefix1, len2, prefix2, len, content, postfix, len);
    }
    
    function concat(bytes byteArray, bytes byteArray2) returns (bytes) {
        bytes memory returnArray = new bytes(byteArray.length + byteArray2.length);
        for (uint16 i = 0; i < byteArray.length; i++) {
            returnArray[i] = byteArray[i];
        }
        for (i; i < (byteArray.length + byteArray2.length); i++) {
            returnArray[i] = byteArray2[i - byteArray.length];
        }
        return returnArray;
    }
    
    function to_binary(uint256 x) returns (bytes) {
        if (x == 0) {
            return new bytes(0);
        }
        else {
            byte s = byte(x % 256);
            bytes memory r = new bytes(1);
            r[0] = s;
            return concat(to_binary(x / 256), r);
        }
    }
}
