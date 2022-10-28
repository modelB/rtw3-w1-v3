// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.3/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.7.3/utils/Counters.sol";

contract Newark is ERC721, ERC721Enumerable, ERC721URIStorage {
    using Counters for Counters.Counter;
    mapping (address => uint8) countsByAddress;
    uint256 MAX_SUPPLY = 100000;
    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("Newark", "NWK") {}

    function safeMint(address to, string memory uri) public {
        uint256 tokenId = _tokenIdCounter.current();
        uint8 userMintCount = countsByAddress[to];
        require(_tokenIdCounter.current() <= MAX_SUPPLY, "I'm sorry we reached the cap");
        require(userMintCount < 5, "Max Mint per wallet reached");
        _tokenIdCounter.increment();
        countsByAddress[to] = userMintCount + 1;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
