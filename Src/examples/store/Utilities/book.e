class BOOK 
	
inherit

	ANY
		redefine
			out
		end

creation

	make

feature 

	make is
		do
			!! title.make (10)
			!! author.make (10)
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
			!!Result.make (0)
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

end -- class BOOK


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
