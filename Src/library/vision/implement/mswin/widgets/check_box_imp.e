indexing
	description: "This class represents a MS_IMPcheck box"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	CHECK_BOX_IMP

inherit
	CHECK_BOX_I

	BOX_WINDOWS
		rename
			make as row_column_make
		redefine
			class_name
		end

create
	make

feature {NONE} -- Initalization

	make (a_check_box: CHECK_BOX; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Make a check box.
		do
			create private_attributes
			parent ?= oui_parent.implementation
			create toggle_list.make
			initialize
			managed := man
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionCheckBox"
		end

end -- class CHECK_BOX_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

