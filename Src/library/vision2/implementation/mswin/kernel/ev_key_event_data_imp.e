indexing
	description: "EiffelVision key event data"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_KEY_EVENT_DATA_IMP

inherit
	EV_KEY_EVENT_DATA_I
		select
			interface
		end

	EV_EVENT_DATA_IMP
		rename
			interface as parent_interface
		redefine
			fill
		end

creation
	make


feature {NONE} -- Implementation

	fill (mi: WEL_MESSAGE_INFORMATION) is
			-- Set the attributes of this data.
		local
			key_msg: WEL_KEY_MESSAGE
		do
			key_msg ?= mi
			check
				valid_msg: key_msg /= Void
			end
			interface.set_keyval (key_msg.code)
			interface.set_state (key_msg.data)
			interface.set_string (key_msg.code.ascii_char.out)
		end


end -- class EV_KEY_EVENT_DATA_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

