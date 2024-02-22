use ethers::{abi::Uint, types::Address};

pub type CallContext = (Uint, Address, Address);
