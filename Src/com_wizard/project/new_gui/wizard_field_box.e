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
		end

	WIZARD_TEXT_BOX
		export
			{ANY} setup
		undefine
			default_create,
			is_equal,
			copy
		end

feature -- Empty

end -- class WIZARD_FIELD_BOX

