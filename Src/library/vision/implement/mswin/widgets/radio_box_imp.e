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

create
	make

feature -- Initialization

	make (a_radio_box: RADIO_BOX; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Make a radio box.
		do
			create private_attributes
			parent ?= oui_parent.implementation
			create toggle_list.make
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

