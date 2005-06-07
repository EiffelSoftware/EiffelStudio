indexing

	description: "Item to denote a feature_name.";
	date: "$Date$";
	revision: "$Revision$"

class FEATURE_NAME_TEXT

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

	make (t: like image; c: like e_class) is
			-- Initialize Current with class_i `e'
			-- and image `t'.
		require
			t_not_void: t /= Void
			c_not_void: c /= Void
		do
			image := t
			e_class := c
		ensure
			image_set: image = t 
			e_class_set: e_class = c
		end

feature -- Properties

	e_class: CLASS_C
			-- Eiffel class with e_feature is defined

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current class name text to `text'.
		do
			text.process_feature_name_text (Current)
		end

invariant
	image_not_void: image /= Void
	e_class_not_void: e_class /= Void

end
