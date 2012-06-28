class BOOK

create
    make

feature {NONE} -- Initialization

    make (a_title: STRING_32; an_author: AUTHOR; an_isbn: STRING_32)
        do
            set_title (a_title)
            set_author (an_author)
            set_isbn (an_isbn)
        end

feature -- Access

    title: STRING_32

    isbn: STRING_32

    author: AUTHOR

feature -- Status setting

    set_title (a_title: STRING_32)
        do
            title := a_title
        end

    set_author (an_author: AUTHOR)
        do
            author := an_author
        end

    set_isbn (an_isbn: STRING_32)
        do
            isbn := an_isbn
        end

end -- class BOOK
