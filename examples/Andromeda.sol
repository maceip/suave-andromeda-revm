// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.8;

contract Andromeda {
    address public constant ATTEST_ADDR      = 0x0000000000000000000000000000000000040700;
    address public constant VOLATILESET_ADDR = 0x0000000000000000000000000000000000040701;
    address public constant VOLATILEGET_ADDR = 0x0000000000000000000000000000000000040702;
    address public constant RANDOM_ADDR      = 0x0000000000000000000000000000000000040703;

    function volatileSet(bytes32 key, bytes32 value) public view {
	bytes memory cdata = abi.encodePacked([key, value]);
        (bool success, bytes memory _out) = VOLATILESET_ADDR.staticcall(cdata);
	_out;
	require(success);
    }

    function volatileGet(bytes32 key) public view returns (bytes32) {
        (bool success, bytes memory value) = VOLATILEGET_ADDR.staticcall(abi.encodePacked((key)));
	require(success);
	require(value.length == 32);
	return abi.decode(value, (bytes32));
    }
    
    function attestSgx(bytes memory userdata) public view returns (bytes memory) {
        (bool success, bytes memory attestBytes) = ATTEST_ADDR.staticcall(userdata);
	require(success);
	return attestBytes;
    }

    function localRandom() payable public returns (bytes32) {
        (bool success, bytes memory randomBytes) = RANDOM_ADDR.staticcall("");
	require(success);
	require(randomBytes.length == 32);
	return bytes32(randomBytes);
    }
}
