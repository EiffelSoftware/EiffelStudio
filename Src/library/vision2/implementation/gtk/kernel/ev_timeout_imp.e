indexing
	description: "Eiffel Vision timeout. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TIMEOUT_IMP

inherit
	EV_TIMEOUT_I

create
	make

feature -- Initialization

	make (an_interface: like interface) is
			-- Call base make only.
		do
			base_make (an_interface)
		end

	initialize is 
		do 
			is_initialized := True
		end

feature -- Access

	interval: INTEGER 
			-- Time between calls to `timeout_actions' in milliseconds.
			-- Zero when disabled.

	set_interval (an_interval: INTEGER) is
			-- Assign `an_interval' in milliseconds to `interval'.
			-- Zero disables.  
		do
			if timeout_connection_id > 0 then
				C.gtk_timeout_remove (timeout_connection_id)
				timeout_connection_id := 0
			end

			if an_interval > 0 then
				timeout_connection_id :=
					c_ev_gtk_callback_marshal_timeout_connect (
						an_interval, ~on_timeout
					)
			end
			interval := an_interval
		end

feature {NONE} -- Implementation

	timeout_connection_id: INTEGER
		-- GTK handle on timeout connection.

	C: EV_C_EXTERNALS is
			-- Access to external C functions.
		once
			create Result
		end

feature {EV_ANY_I} -- Implementation

	destroy is 
			-- Render `Current' unusable.
		do 
			set_interval (0)
			is_destroyed := True
		end

feature -- External implementation

	c_ev_gtk_callback_marshal_timeout_connect
		(a_delay: INTEGER; an_agent: PROCEDURE [ANY, TUPLE]): INTEGER is
			-- Call `an_agent' after `a_delay'.
		external
			"C (gint, EIF_OBJECT): EIF_INTEGER | %"gtk_eiffel.h%""
		end

end -- class EV_TIMEOUT_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

