indexing
	description: "This class represents a MS_IMPradio box"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	RADIO_BOX_IMP

inherit
	RADIO_BOX_I

	BOX_WINDOWS
		rename
			make as row_column_make
		redefine
			class_name
		end

creation
	make

feature -- Initialization

	make (a_radio_box: RADIO_BOX; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Make a radio box.
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			!! toggle_list.make
			initialize
			only_one := True
			managed := man
		end

	set_always_one (flag: BOOLEAN) is
			-- Set `only_one' to `flag'.
		do
			only_one := flag
		end

feature {NONE} -- Implementation

	only_one: BOOLEAN
			-- Can there be only one checked radio button?

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionRadioBox"
		end

end -- class RADIO_BOX_IMP
 

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

