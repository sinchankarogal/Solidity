// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract Library {
    enum BookStatus { Available, Borrowed }

    struct Book {
        string title;
        address borrower;
        BookStatus status;
    }

    Book[] public books;

    function addBook(string memory _title) public {
        books.push(Book(_title, address(0), BookStatus.Available));
    }

    function borrowBook(uint _index) public {
        require(_index < books.length, "Invalid book index");
        require(books[_index].status == BookStatus.Available, "Book is not available");

        books[_index].borrower = msg.sender;
        books[_index].status = BookStatus.Borrowed;
    }

    function returnBook(uint _index) public {
        require(_index < books.length, "Invalid book index");
        require(books[_index].borrower == msg.sender, "You haven't borrowed this book");

        books[_index].borrower = address(0);
        books[_index].status = BookStatus.Available;
    }

    function checkAvailability(uint _index) public view returns (BookStatus) {
        require(_index < books.length, "Invalid book index");
        return books[_index].status;
    }
}
