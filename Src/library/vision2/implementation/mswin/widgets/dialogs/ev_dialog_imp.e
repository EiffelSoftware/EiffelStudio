--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision dialog. Mswindows interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_DIALOG_IMP

inherit
	EV_DIALOG_I
		undefine
			propagate_background_color,
			propagate_foreground_color
		redefine
			interface
		end

	EV_TITLED_WINDOW_IMP
		redefine
			default_style,
			interface
		end

create
	make

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
			enable_modal
			show
			block
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
		do
			Result := Ws_border + Ws_dlgframe --+ Ws_sysmenu 
					+ Ws_overlapped --+ Ws_clipchildren
					--+ Ws_clipsiblings
		end

	interface: EV_DIALOG

end -- class EV_DIALOG_IMP

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
