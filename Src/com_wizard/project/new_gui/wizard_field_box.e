indexing
	description: "Text field with color validation"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_FIELD_BOX

inherit
	WIZARD_FIELD_BOX_IMP
		rename
			field_label as text_label,
			field_combo as text_combo
		export
			{NONE} all
		end

	WIZARD_TEXT_BOX
		undefine
			default_create,
			is_equal,
			copy
		end

feature -- Empty

end -- class WIZARD_FIELD_BOX

