note
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	make
		do
			create html_text.make (1)
		end

feature -- Redefinition

	put_basic (s: STRING)
			-- Append 's' to the temporary string
		do
			html_text.append (s)
		end

feature -- Out representation

	out: STRING
			-- Provide a STRING representation for the HTML text
		do
			if html_text /= Void then
				Result := html_text.twin
			end
		end

feature -- Add some new features

	wipe_out
			-- Restore a empty HTML text
		do
			html_text.wipe_out
				-- This is useful if we don't want to create each time
				-- a new object just for displaying HTML text
		end

	put_center (s: STRING)
			-- Put 's' centered on the window
		do
			put_basic ("<CENTER>")
			put_basic (s)
			put_basic ("</CENTER>")
			put_basic ("%N")
		end;

	put_font (s: STRING; n: INTEGER)
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

	put_indent (s: STRING)
		do
			put_basic ("<BLOCKQUOTE>")
			put_basic (s)
			put_basic ("</BLOCKQUOTE>")
			put_basic ("%N")
		end

	put_blink (s: STRING)
		do
			put_basic("<BLINK>")
			put_basic(s)
			put_basic("</BLINK>")
			put_basic("%N")
		end

	put_address (s: STRING)
		do
			put_basic ("<ADDRESS>")
			put_basic (s)
			put_basic ("</ADDRESS>")
			put_basic ("%N")
		end


feature {NONE}

	html_text: STRING;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class HTML_TEXT

