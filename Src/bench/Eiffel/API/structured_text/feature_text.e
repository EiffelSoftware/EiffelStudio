indexing

	description: 
		"Item to denote a feature.";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_TEXT

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

    make (f: like e_feature; t: like image) is
            -- Initialize Current with feature `f'
            -- and image `t'.
        do
            image := t;
			e_feature := f
        ensure
            set: image = t and then
					e_feature = f
        end;

feature -- Properties

	e_feature: E_FEATURE;
			-- Eiffel feature associated with image

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current class name text to `text'.
		do
			text.process_feature_text (Current)
		end

end -- class FEATURE_TEXT
