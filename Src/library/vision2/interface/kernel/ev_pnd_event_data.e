indexing
	description: "EiffelVision pick and drop event data.% 
				%Class for representing pick and drop event data."
	status: "See notice at end of class";
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PND_EVENT_DATA

inherit
	EV_BUTTON_EVENT_DATA
	
creation
	make
	
feature -- Access	
	
	data: EV_PND_DATA
			-- Transported data

	data_type: EV_PND_TYPE
			-- Transported data type

feature {EV_PND_TARGET_I} -- Element change
	
	set_data (new_data: EV_PND_DATA) is
		do
			data := new_data
		end
	
	set_data_type (new_type: EV_PND_TYPE) is
		do
			data_type := new_type
		end
	
end -- class EV_PND_EVENT_DATA

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

