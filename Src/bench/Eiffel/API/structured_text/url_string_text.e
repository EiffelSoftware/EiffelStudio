indexing
	description: 
		"Basic string text that is an URL."
	date: "$Date$"
	revision: "$Revision $"

class URL_STRING_TEXT

inherit
	STRING_TEXT
		redefine
			append_to
		end

create
	make

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append string `text'.
		do
			text.process_string_text (Current)
		end

feature -- Element change

	set_link (l: STRING) is
		do
			link := l
			if link.substring (1, 4).is_equal ("www.") then
				link.prepend ("http://")
			end
		end

feature -- Access

	link: STRING
			-- The actual URL. Needless to say this could well
			-- be different from `image'.

end -- class STRING_TEXT

