class BOOK
    
create
    make

feature {NONE} -- Initialization

    make (a_title: UC_STRING; an_author: AUTHOR; an_isbn: UC_STRING) is
        do
            set_title (a_title)
            set_author (an_author)
            set_isbn (an_isbn)
        end

feature -- Access

    title: UC_STRING

    isbn: UC_STRING

    author: AUTHOR
    
feature -- Status setting
    
    set_title (a_title: UC_STRING) is
        do
            title := a_title
        end
        
    set_author (an_author: AUTHOR) is
        do
            author := an_author
        end

    set_isbn (an_isbn: UC_STRING) is
        do
            isbn := an_isbn
        end

end -- class BOOK
