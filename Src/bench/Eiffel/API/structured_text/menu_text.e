indexing
	description: 
		"Hyperlinked text. If link is Void, treat as disabled link.%N%
		% Do not display to formats not supporting hyperlinking."
	date: "$Date$";
	revision: "$Revision $"

class
	MENU_TEXT

inherit
	BASIC_TEXT
		rename
			make as old_make
		redefine
			append_to
		end

create
	make

feature -- Initialization

    make (f: like link; t: like image) is
            -- Initialize Current with feature `f'
            -- and image `t'.
        do
            image := t
			link := f
        end

feature -- Properties

	link: STRING
			-- location of file (without extension).

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append string `text'.
		do
			text.process_menu_text (Current)
		end

end -- class STRING_TEXT

