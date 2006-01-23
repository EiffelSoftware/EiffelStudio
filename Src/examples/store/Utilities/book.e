indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class BOOK 
	
inherit

	ANY
		redefine
			out
		end

create

	make

feature 

	make is
		do
			create title.make (10)
			create author.make (10)
		end

	author, title: STRING

	quantity: INTEGER

	price: REAL

	still_published: BOOLEAN

	set_references (b, a : STRING) is
			-- Set `author' with `a', and `title' with `b'.
		require
			arguments_exist: not (a = Void) and not (b = Void)
		do
			author := a
			title := b
		ensure
			author = a
			title = b
		end

	set_quantity (a : INTEGER ) is
			-- Set `quantity' with `a'.
		do
			quantity := a
		ensure
			quantity  = a
		end

	set_still_published (a : BOOLEAN ) is
			-- Set `still_published' with `a'.
		do
			still_published := a
		ensure
			still_published = a
		end

	set_price (a: REAL) is
			-- Set `price' with `a'.
		do
			price := a
		ensure
			price = a
		end

	out: STRING is 
			-- Print book.
		do
			create Result.make (0)
			Result.append (author)
			Result.append ("/")
			Result.append (title)
			Result.append ("/")
			Result.append (quantity.out)
			Result.append ("/")
			Result.append (price.out)
			Result.append ("/")
			Result.append (still_published.out)
			Result.append  ("%N")
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class BOOK


