indexing
	description: "EiffelVision key event data.% 
	%Class for representing button event data";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_KEY_EVENT_DATA
	
inherit
	EV_EVENT_DATA	
		redefine
			make,
			implementation
		end
	
creation
	make
	
feature {NONE} -- Initialization
	
	make is
		do
			!EV_KEY_EVENT_DATA_IMP! implementation
		end

feature -- Access	
	
	state: INTEGER is
			-- ??
		do
			Result := implementation.state
		end

	keyval: INTEGER is
			-- ??
		do
			Result := implementation.keyval
		end

	length: INTEGER is
			-- ??
		do
			Result := implementation.length
		end

	string: STRING is
		-- String given the char equivalent of the key
		do
			Result := implementation.string
		end

feature {EV_WIDGET_IMP} -- Implementation

	implementation: EV_KEY_EVENT_DATA_I

end -- class EV_KEY_EVENT_DATA

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
