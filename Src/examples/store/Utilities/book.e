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

end -- class BOOK


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact: http://contact.eiffel.com
--| Customer support: http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
