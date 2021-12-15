// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.0 (token/ERC721/IERC721Receiver.sol)

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";
import "@openzeppelin/contracts/utils/introspection/IERC165.sol";

contract BatchNFT is IERC721Receiver, IERC1155Receiver {
    constructor() {}

    /*function approveAndTransfer721(
        IERC721 nft,
        uint256[] memory _tokenIds,
        address _from,
        address[] memory _to
    ) external {
        for(uint j = 0; j < _to.length; j++){
            for(uint256 i = 0; i < _tokenIds.length; i++){
                require(nft.ownerOf(_tokenIds[i]) == msg.sender, "NOT OWNER");
                nft.isApprovedForAll(_from, address(this));
                nft.safeTransferFrom(msg.sender, _to[j], _tokenIds[i]);
            }
        }    
    }

    function approveAndTransfer1155(
        IERC1155 nft,
        uint256[] memory _tokenIds,
        uint256[] memory _amounts,
        address _from,
        address[] memory _to
    ) external {
        bytes memory data;
        
        require(_from == msg.sender, "NOT OWNER");
        nft.setApprovalForAll(_from, true);
        nft.safeBatchTransferFrom(msg.sender, _to, _tokenIds, _amounts, data);
        
    }*/

    function approveAndTransfer(
        IERC1155[] memory nft1155,
        IERC721[] memory nft721,
        uint256[] memory _tokenIds1155,
        uint256[] memory _amount1155,
        uint256[] memory _tokenIds721,
        address _from,
        address[] memory _to
    ) external {
        for (uint256 adr = 0; adr < _to.length; adr++) {
            for (uint256 t1155 = 0; t1155 < nft1155.length; t1155++) {
                require(_from == msg.sender, "NOT OWNER");
                nft1155[t1155].setApprovalForAll(_from, true);
                nft1155[t1155].safeBatchTransferFrom(
                    msg.sender,
                    _to[adr],
                    _tokenIds1155,
                    _amount1155,
                    "0x"
                );
            }
            for (uint256 t721 = 0; t721 < nft721.length; t721++) {
                for (uint256 i = 0; i < _tokenIds721.length; i++) {
                    require(
                        nft721[t721].ownerOf(_tokenIds721[i]) == msg.sender,
                        "NOT OWNER"
                    );
                    nft721[t721].isApprovedForAll(_from, address(this));
                    nft721[t721].safeTransferFrom(
                        msg.sender,
                        _to[adr],
                        _tokenIds721[i]
                    );
                }
            }
        }
    }

    function ownerOf(IERC721 nft, uint256 tokenId)
        public
        view
        returns (address owner)
    {
        return nft.ownerOf(tokenId);
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external virtual override returns (bytes4) {
        return this.onERC721Received.selector;
    }

    function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    ) external virtual override returns (bytes4) {
        return this.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(
        address operator,
        address from,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    ) external virtual override returns (bytes4) {
        return this.onERC1155BatchReceived.selector;
    }

    function supportsInterface(bytes4 interfaceId)
        external
        view
        override
        returns (bool)
    {}
}
