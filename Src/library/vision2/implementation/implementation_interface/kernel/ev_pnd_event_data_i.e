indexing
	description: "EiffelVision pick and drop event data, implementation interface."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PND_EVENT_DATA_I

inherit
	EV_BUTTON_EVENT_DATA_I

feature -- Access	
	
	data: ANY
			-- Transported data

	data_type: EV_PND_TYPE
			-- Transported data type

feature -- Element change
	
	set_data (value: like data) is
			-- Make `value' the new data.
		do
			data := value
		end
	
	set_data_type (value: EV_PND_TYPE) is
			-- Make `value' the new data type.
		do
			data_type := value
		end

end -- class EV_PND_EVENT_DATA_I

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
