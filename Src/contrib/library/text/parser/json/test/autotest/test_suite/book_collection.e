class BOOK_COLLECTION

create
    make

feature {NONE} -- Initialization

    make (a_name: STRING_32)
        do
            set_name (a_name)
            create book_index.make (10)
        end

feature -- Access

    name: STRING_32

    books: LIST [BOOK]
        do
            from
                create {LINKED_LIST [BOOK]} Result.make
				book_index.start
            until
                book_index.after
            loop
                Result.append (book_index.item_for_iteration)
                book_index.forth
            end
        end

    books_by_author (an_author: STRING_32): detachable LIST [BOOK]
        do
            if book_index.has (an_author) then
                Result := book_index @ an_author
            else
                create {LINKED_LIST [BOOK]} Result.make
            end
        end

feature -- Status setting

    set_name (a_name: STRING_32)
        do
            name := a_name
        end

    add_book (a_book: BOOK)
        local
            l: detachable LIST [BOOK]
        do
            if book_index.has (a_book.author.name) then
                l := book_index.at ( a_book.author.name )
            else
                create {LINKED_LIST [BOOK]} l.make
                book_index.put (l, a_book.author.name)
            end
            if attached l as la then
           	 	la.force (a_book)
            end

        end

    add_books (book_list: like books)

        do
            from
                book_list.start
            until
                book_list.after
            loop
                add_book (book_list.item)
                book_list.forth
            end
        end

feature {NONE} -- Implementation

    book_index: HASH_TABLE [LIST [BOOK], STRING_32]

end -- class BOOK_COLLECTION
