contract IPFSVerify {
	bytes memory prefix = hex"0a0a080212";
	bytes memory postfix = hex"18";

	function verifyHash(string contentString) returns(bytes32) {
	  bytes memory content = bytes(contentString);
	  bytes memory len = to_binary(content.length);
	  bytes memory withPrefix = concat(concat(prefix, len), content);
    bytes memory message = concat(concat(withPrefix, postfix), len);
    return sha256(message);
	}

	function to_binary(uint256 x) returns (bytes) {
	  if (x == 0) {
	    return new bytes(0);
	  } else {
	    byte s = byte(x % 256);
	    bytes memory r = new bytes(1);
	    r[0] = s;
	    return concat(to_binary(x / 256), r)
	  }
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
}