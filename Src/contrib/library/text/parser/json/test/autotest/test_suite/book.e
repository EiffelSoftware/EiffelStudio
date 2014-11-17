class
	BOOK

create
	make

feature {NONE} -- Initialization

	make (a_title: STRING_32; a_author: AUTHOR; a_isbn: STRING_32)
			-- Create a book with `a_title' as `title',
			-- `a_author' as `author', and `a_isbn' as `isbn'.
		do
			set_title (a_title)
			set_author (a_author)
			set_isbn (a_isbn)
		ensure
			title_set: title = a_title
			author_set: author = a_author
			isbn_set: isbn = a_isbn
		end

feature -- Access

	title: STRING_32
			-- Main title.

	isbn: STRING_32
			-- ISBN.

	author: AUTHOR
			-- Author.

feature -- Change

	set_title (a_title: STRING_32)
			-- Set `title' with `a_title'.
		do
			title := a_title
		ensure
			title_set: title = a_title
		end

	set_author (a_author: AUTHOR)
			-- Set `author' with `a_author'.
		do
			author := a_author
		ensure
			author_set: author = a_author
		end

	set_isbn (a_isbn: STRING_32)
			-- Set `isbn' with `a_isbn'.
		do
			isbn := a_isbn
		ensure
			isbn_set: isbn = a_isbn
		end

end -- class BOOK
