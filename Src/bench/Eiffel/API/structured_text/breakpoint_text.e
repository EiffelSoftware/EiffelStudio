indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BREAKPOINT_TEXT

inherit

	BASIC_TEXT
		rename
			make as old_make
		redefine
			append_to
		end

creation

	make

feature -- Initialization

    make (f: like e_feature; indx: INTEGER) is
            -- Initialize Current with feature `f'
            -- and image `t'.
        do
        	image := indx.out
			e_feature := f
			index := indx
        ensure
            set: e_feature = f and then index = indx
        end;

feature -- Properties

	e_feature: E_FEATURE;
			-- Eiffel feature associated with image

	index: INTEGER
			--index of breakpoint.	

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current class name text to `text'.
		do
			text.process_breakpoint_index (Current)
		end

end -- class BREAKPOINT_TEXT
