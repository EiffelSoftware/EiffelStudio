indexing
	description: "EiffelVision pick and drop event data, implementation interface."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PND_EVENT_DATA_I

inherit
	EV_BUTTON_EVENT_DATA_I
		rename
			widget as source
		end

feature -- Access	
	
	data: ANY
			-- Transported data

	data_type: EV_PND_TYPE
			-- Transported data type

	target: EV_WIDGET
			-- Target Widget of the Pick And Drop event

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

	set_target (targ: EV_WIDGET) is
			-- Make `targ' the target of the PND action.
		do
			target := targ
		end

	set_absolute_x (value: INTEGER) is
			-- Make `value' the absolute x coordinate
		deferred
		end

	set_absolute_y (value: INTEGER) is
			-- Make `value' the absolute y coordinate
		deferred
		end


end -- class EV_PND_EVENT_DATA_I

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
