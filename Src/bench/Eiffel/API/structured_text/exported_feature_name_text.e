indexing
	description: "Item to denote an exported feature_name.";
	date: "$Date$";
	revision: "$Revision $"

class 
	EXPORTED_FEATURE_NAME_TEXT

inherit
	FEATURE_NAME_TEXT
		rename
			make as feature_make
		export
			{NONE} feature_make
		redefine
			append_to
		end

creation
	make

feature -- Initialization

	make (t: like image; c: like e_class; name: like exported_name) is
			-- Initialize Current with class_i `e'
			-- and image `t'.
		do
			feature_make (t, c)
			exported_name := name
		ensure
			set: image = t
				and then e_class = c
				and then exported_name = name
		end

feature -- Properties

	exported_name: STRING
			-- Exported name of feature

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current class name text to `text'.
		do
			text.process_exported_feature_name_text (Current)
		end

end -- class EXPORTED_FEATURE_NAME_TEXT

