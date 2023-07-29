// SPDX-License-Identifier: MIT
// 1. Pragma
pragma solidity ^0.8.7;
// 2. Imports
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";
import { Contract, errors } from "ethers";


//interfaces,libraries, contracts

 error FundMe_NotOwner();

//navedeno u dugackom komentaru regulativa komentarisanja i ostavljanja podataka o projektu
/**@title A sample Funding Contract
 * @author Dara
 * @notice This contract is for creating a sample funding contract
 * @dev This implements price feeds as our library
 */

contract FundMe {
    //type declarations
    using PriceConverter for uint256;

//State variables

uint256 public constant MINIMUM_USD = 50*10**18;
address private immutable i_owner;
address[] private s_funders;
mapping (address => uint256) private s_addressToAmountFunded;
AggregatorV3Interface private s_priceFeed;

//Events

//Modifier

modifier onlyOwner() {
    //require(msg.msg.sender == i_owner);
    if(msg.sender != i_owner) revert FundMe_NotOwner();
    _;
    
}
 // Functions Order:
    //// constructor
    //// receive
    //// fallback
    //// external
    //// public
    //// internal
    //// private
    //// view / pure

    constructor(address priceFeed){
        s_priceFeed = AggregatorV3Interface(priceFeed);
        i_owner= msg.sender;
    }

    ///@notice Funds our contract based on the ETH/USD price

    function fund() public payable{
        require(
            msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD,
            'Not enough ETH'

        );
        //require(PriceConverter.getConversionRate(msg.value) >= MINIMUM_USD,'Not enough ETH') //OVAJ IZRAZ JE JEDNAK  IZRAZU GORE

        s_addressToAmountFunded[msg.sender] += msg.value;
        s_funders.push(msg.sender);
    }

    function withdraw() public onlyOwner{
        for(
            uint256 funderIndex = 0;
            funderIndex < s_funders.lenght;
            funderIndex++;
        ){
            address funder = s_funders[funderIndex];
            s_addressToAmountFunded[funder]=0;
        }

        s_funders = new address[](0);
         // Transfer vs call vs Send- we are not using transfer in this case
        // payable(msg.sender).transfer(address(this).balance);

        (bool success, )= i_owner.call{value: address(this).balance}("");
        require(success);
    }

    
    }

    function cheaperWitdraw() public only owner {

        //manje vise isto kao u prethodnom primeru , samo je 'dohvatio' JEDNOM varijable iz storage-a da ne mora pri svakoj iteraciji da ih vadi iz skladista 
        address[] memory funders = s_funders;
        //mappings can't be in memory
        for(
            uint256 funderIndex = 0;
            funderIndex < funders.lenght;
            funderIndex++;

        ){
            address funder = funders[funderIndex];
            s_addressToAmountFunded[funder] = 0;
        }

        s_funders = new address[](0);
        // payable(msg.sender).transfer(address(this).balance);
        (bool success, ) = i_owner.call{value: address(this).balance}("");
        require(success);

    }
  /** @notice Gets the amount that an address has funded
     *  @param fundingAddress the address of the funder
     *  @return the amount funded
     */

    /*
    we can save data in two place in solidity:
    in storage
    in memory

    If we save variable in memory - we can save a lot of gas, every time we fetch variable from storage,
    it costs us more  unlike we fetch it from memory which is something like non-permanent storage and it lasts only for the time being of contract

    U skladiste(storage) ne idu:
    -varijable koje su immutable
    -konstante
    -kada stavimo ispred varijable rec memory
    -varijable koje su definisane unutar funkcije, one su deo ugovora i traju samo tokom trajanja istog


    Oznake za varijable (za procenu potrosnje gasa):

    i_imeVarijable -immutuable variable
    s_imeVarijable - storage variable // OVA VARIJABLA TROSI NAJVISE GASA

    CONST_VARIABLE -konstante se pisu velikim slovima
    */


   function getAddressToAmountFunded(address fundingAddress) public view returns(uint256){
    return s_addressToAmountFunded[fundingAddress];
   }

   function getVersion()public view returns (uint256){
    return s_priceFeed.version();
   }

   function getFunder(uint256 index)public view returns (address){
    return s_funders[index];
   }  
   
   function getOwner() public view returns (address){
    return i_owner;
   }

   function getPriceFeed() public view returns (AggregatorV3Interface){
    return s_priceFeed;
   }
   
   