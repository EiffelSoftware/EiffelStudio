class BOOK_COLLECTION
    
create
    make

feature {NONE} -- Initialization

    make (a_name: UC_STRING) is
        do
            set_name (a_name)
            create book_index.make (10)
        end

feature -- Access

    name: UC_STRING
    
    books: DS_LIST [BOOK] is
        local
            c: DS_HASH_TABLE_CURSOR [DS_LIST [BOOK], UC_STRING]
        do
            from
                create {DS_LINKED_LIST [BOOK]} Result.make
                c := book_index.new_cursor
                c.start
            until
                c.after
            loop
                Result.append_last (c.item)
                c.forth
            end    
        end
    
    books_by_author (an_author: UC_STRING): DS_LIST [BOOK] is
        do
            if book_index.has (an_author) then
                Result := book_index @ an_author
            else
                create {DS_LINKED_LIST [BOOK]} Result.make
            end    
        end
        
feature -- Status setting
    
    set_name (a_name: UC_STRING) is
        do
            name := a_name
        end
        
    add_book (a_book: BOOK) is
        local
            l: DS_LIST [BOOK]
        do
            if book_index.has (a_book.author.name) then
                l := book_index @ a_book.author.name
            else
                create {DS_LINKED_LIST [BOOK]} l.make
                book_index.put (l, a_book.author.name)
            end
            l.put_last (a_book)
        end
        
    add_books (book_list: like books) is
        local
            c: DS_LIST_CURSOR [BOOK]
        do
            from
                c := book_list.new_cursor
                c.start
            until
                c.after
            loop
                add_book (c.item)
                c.forth
            end    
        end
        
feature {NONE} -- Implementation

    book_index: DS_HASH_TABLE [DS_LIST [BOOK], UC_STRING]
    
end -- class BOOK_COLLECTION
