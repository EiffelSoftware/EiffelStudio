indexing
	description: 
		"Stone for a feature that has a error"
	date: "$Date$"
	revision: "$Revision $"

class
	FEATURE_ERROR_STONE

inherit
	FEATURE_STONE
		rename
			make as feat_make
		redefine
			line_number
		end

create
	make

feature {NONE} -- Initialization

	make (a_feature: E_FEATURE; a_line: INTEGER) is
			-- Initialize stone with `a_feature' and error position `a_pos.
		do
			feat_make (a_feature)
			line_number := a_line
		end

feature -- Access

	line_number: INTEGER
			-- Line number of error 

end -- class FEATURE_ERROR_STONE
