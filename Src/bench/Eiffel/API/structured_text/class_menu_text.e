indexing
	description: 
		"Hyperlinked text. If link is Void, treat as disabled link.%N%
		% Do not display to formats not supporting hyperlinking."
	date: "$Date$";
	revision: "$Revision $"

class
	CLASS_MENU_TEXT

inherit
	MENU_TEXT
		redefine
			append_to
		end

create
	make

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append string `text'.
		do
			text.process_class_menu_text (Current)
		end

end -- class STRING_TEXT


