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

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

