indexing

	description: 
		"Item to denote a feature with an error.";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_ERROR_TEXT

inherit

	FEATURE_TEXT
		rename
			make as feat_make
		redefine
			append_to
		end

create

	make

feature -- Initialization

    make (f: like e_feature; a_pos: like position; t: like image) is
            -- Initialize Current with feat `f', position `p'
            -- and image `t'.
        do
			feat_make (f, t);
			position := a_pos
        ensure
            set: image = t and then
				e_feature = f and then
				position = a_pos
        end;

feature -- Access

	position: INTEGER
			-- Position of error in feature

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current class name text to `text'.
		do
			text.process_feature_error (Current)
		end

end -- class FEATURE_ERROR_TEXT
