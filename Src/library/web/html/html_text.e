class
	HTML_TEXT

inherit
	HTML_GENERATOR
		undefine
			out
		redefine
			put_basic
		end

create
	make
	
feature

	make is
		do
			create html_text.make (1)
		end

feature -- Redefinition

	put_basic (s: STRING) is
			-- Append 's' to the temporary string
		do
			html_text.append (s)
		end

feature -- Out representation

	out: STRING is
			-- Provide a STRING representation for the HTML text
		do
			Result := clone (html_text)
		end

feature -- Add some new features

	wipe_out is
			-- Restore a empty HTML text
		do
			html_text.wipe_out
				-- This is useful if we don't want to create each time
				-- a new object just for displaying HTML text
		end

	put_center (s: STRING) is
			-- Put 's' centered on the window
		do
			put_basic ("<CENTER>")
			put_basic (s)
			put_basic ("</CENTER>")
			put_basic ("%N")
		end;

	put_font (s: STRING; n: INTEGER) is
			-- Put 's' with font size set to 'n'
		do
			put_basic ("<FONT SIZE=")
			if n >= 0 then
				put_basic ("+")
			end
			put_basic (n.out)
			put_basic (">")
			put_basic (s)
			put_basic ("</FONT>")
			put_basic ("%N")
		end

	put_indent (s: STRING) is
		do
			put_basic ("<BLOCKQUOTE>")
			put_basic (s)
			put_basic ("</BLOCKQUOTE>")
			put_basic ("%N")
		end

	put_blink (s: STRING) is
		do
			put_basic("<BLINK>")
			put_basic(s)
			put_basic("</BLINK>")
			put_basic("%N")
		end

	put_address (s: STRING) is
		do
			put_basic ("<ADDRESS>")
			put_basic (s)
			put_basic ("</ADDRESS>")
			put_basic ("%N")
		end


feature {NONE}

	html_text: STRING

end -- class HTML_TEXT


--|----------------------------------------------------------------
--| EiffelWeb: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

