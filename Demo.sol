// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Demo is ERC721URIStorage, AccessControl {
    using Counters for Counters.Counter;
    
    // Create a new role identifier for the minter role
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
     bytes32 public constant TOKENURI_UPDATER_ROLE = keccak256("TOKENURI_UPDATER_ROLE");
    Counters.Counter private _tokenIds;

    constructor(address minter) public ERC721("NFT Demo", "Demo") 
    {
        // Setup Admin role
        _setRoleAdmin(MINTER_ROLE, DEFAULT_ADMIN_ROLE);
        // Grant the minter role to a specified account
        _setupRole(MINTER_ROLE, minter);

        // Setup Admin role
        _setRoleAdmin(TOKENURI_UPDATER_ROLE, DEFAULT_ADMIN_ROLE);
        // Grant the minter role to a specified account
        _setupRole(MINTER_ROLE, minter);
    }

    function mintNFT(address recipient, string memory tokenURI)
        external onlyRole(MINTER_ROLE)
        returns (uint256)
    {   
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }


    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
