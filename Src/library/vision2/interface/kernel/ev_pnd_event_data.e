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
		redefine
			make,
			implementation
		end

creation
	make

feature {NONE} -- Initialization
	
	make is
		do
			!EV_PND_EVENT_DATA_IMP! implementation
		end

feature -- Access	
	
	data: ANY is
			-- Transported data
		do
			Result := implementation.data
		end

	data_type: EV_PND_TYPE is
			-- Transported data type
		do
			Result := implementation.data_type
		end

feature {EV_PND_TARGET_I} -- Element change
	
	set_data (new_data: like data) is
		do
			implementation.set_data (new_data)
		end
	
	set_data_type (new_type: EV_PND_TYPE) is
		do
			implementation.set_data_type (new_type)
		end

feature {EV_PND_TARGET_I} -- Implementation
	
	implementation: EV_PND_EVENT_DATA_I

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

