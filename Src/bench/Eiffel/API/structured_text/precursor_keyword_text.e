indexing
	description:
		"Precursor construct. Is primarily a keyword, but is also a feature."
	author: "brendel"
	date: "$Date$"
	revision: "$Revision$"

class
	PRECURSOR_KEYWORD_TEXT

inherit
	KEYWORD_TEXT
		rename
			make as old_make
		end

	FEATURE_TEXT
		rename
			make as feature_text_make
		undefine
			append_to
		end

	SHARED_TEXT_ITEMS

create
	make

feature {NONE} -- Initialization

	make (f: like e_feature) is
			-- Create with `f'.
		do
			feature_text_make (f, ti_Precursor_keyword.image)
		end
		
end -- class PRECURSOR_KEYWORD_TEXT
