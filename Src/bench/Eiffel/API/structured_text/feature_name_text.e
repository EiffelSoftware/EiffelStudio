indexing

	description: 
		"Item to denote a class_name.";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_NAME_TEXT

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

    make (t: like image; f: like e_feature; c: like e_class) is
            -- Initialize Current with class_i `e'
            -- and image `t'.
        do
            image := t;
            e_class := c;
			e_feature := f
        ensure
            set: image = t and then
                    e_class = c and then
					e_feature = f
        end;

feature -- Properties

	e_feature: E_FEATURE
			-- Eiffel feature associated with image

	e_class: E_CLASS;
			-- Eiffel class with e_feature is defined

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current class name text to `text'.
		do
			text.process_feature_name_text (Current)
		end

end -- class FEATURE_NAME_TEXT
