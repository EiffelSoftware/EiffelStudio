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

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2001/06/07 23:08:03  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.4.2.2  2001/05/18 18:13:16  king
--| Removed destroy_just_called code
--|
--| Revision 1.4.2.1  2000/05/03 19:08:38  oconnor
--| mergred from HEAD
--|
--| Revision 1.7  2000/05/02 15:14:10  brendel
--| Removed redundent line.
--|
--| Revision 1.6  2000/02/22 18:39:35  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:28  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.4.6  2000/02/04 04:20:42  oconnor
--| released
--|
--| Revision 1.4.4.5  2000/01/27 19:29:30  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.4.4  2000/01/19 07:55:32  oconnor
--| added default state checking, reorganised count, added resent_count.
--|
--| Revision 1.4.4.3  2000/01/18 19:28:28  king
--| Altered count to only reset on reset of timeout
--|
--| Revision 1.4.4.2  2000/01/18 01:04:06  king
--| Implemented timeout to use action_sequence
--|
--| Revision 1.4.4.1  1999/11/24 17:29:46  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
