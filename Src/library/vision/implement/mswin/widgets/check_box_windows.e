indexing
	description: "This class represents a MS_WINDOWS check box"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	CHECK_BOX_WINDOWS

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

end -- class CHECK_BOX_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| 
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006 
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com> 
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------
