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

creation
	make

feature {NONE} -- Initalization

	make (a_check_box: CHECK_BOX; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Make a check box.
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			!! toggle_list.make
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
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

