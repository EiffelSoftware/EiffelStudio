--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "Eiffel Vision dialog. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_DIALOG_IMP

inherit
	EV_DIALOG_I
		undefine
			propagate_background_color,
			propagate_foreground_color,
			last_call_was_destroy
		redefine
			interface
		end

	EV_TITLED_WINDOW_IMP
		redefine
			default_style,
			interface
		end

	WEL_DS_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	--| FIXME Default is_modal
	--| FIXME replace destroy agent with "cancel" result agent.

feature -- Basic operations

	block is
			-- Wait until window is closed by the user.
		local
			app: EV_APPLICATION
		do
			app := (create {EV_ENVIRONMENT}).application
			from until not is_show_requested loop
				app.sleep (100)
				app.process_events
			end
		end

	show_modal is
			-- Show and wait until window is closed.
		do
			if is_modal then
				show
			--	block
			else
				enable_modal
				show
			--	block
			--	disable_modal
			end
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
		do
			Result := Ws_popup + Ws_sysmenu + Ws_caption + Ds_modalframe
				+ Ds_setforeground
				--+ Ws_dlgframe
				--+ Ws_overlapped
				+ Ws_clipchildren
				--+ Ws_clipsiblings
		end

	interface: EV_DIALOG

end -- class EV_DIALOG_IMP

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
--| Revision 1.11  2000/04/19 00:40:52  brendel
--| Revised. enable/disable modal are still to be implemented.
--|
--| Revision 1.10  2000/04/04 19:29:50  rogers
--| Redefined initialize, to give the dialog a minimum size, to
--| fix the packing problem. Only a temporary solution.
--|
--| Revision 1.9  2000/02/29 17:59:02  rogers
--| Undefined last_call_was_destroy  inherited from EV_DIALOG_I as last_call_from_destroy is now re-defined in EV_WINDOW_IMP. Needs fixing.
--|
--| Revision 1.8  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.7  2000/02/14 11:40:42  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.10.7  2000/02/08 07:21:03  brendel
--| Minor changes to run through compiler.
--| Still needs major revision.
--|
--| Revision 1.6.10.6  2000/02/01 23:25:35  brendel
--| Removed undefine of set_default_minimum_size.
--|
--| Revision 1.6.10.5  2000/01/27 19:30:20  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.10.4  2000/01/27 18:08:23  brendel
--| Added blocking_window and set_blocking_window.
--| Still experimenting with default_options.
--|
--| Revision 1.6.10.3  2000/01/26 18:34:33  brendel
--| Implemented all features.
--|
--| Revision 1.6.10.2  2000/01/26 02:10:47  brendel
--| Added features block and show_modal.
--|
--| Revision 1.6.10.1  1999/11/24 17:30:26  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.6.3  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
