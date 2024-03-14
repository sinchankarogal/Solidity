// SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;
contract StructType{
    struct Book{
        string name;
        string writer;
        uint id;
        bool available;
    }
    Book book1;
    Book book2=Book("Building Ethereum Apps","Roberto Infante",2,false);
    function set_book_details() public{
        book1=Book("Introduction to solidity","Chris Dannen",1,true);
    }
    function book_info() public view returns(string memory, string memory,uint,bool){
       return(book2.name,book2.writer,book2.id,book2.available);
    }

    function getBook1() public view returns (string memory, string memory, uint, bool) {
    return (book1.name, book1.writer, book1.id, book1.available);
}
}

