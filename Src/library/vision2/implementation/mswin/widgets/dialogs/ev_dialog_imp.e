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
			default_ex_style,
			interface,
			on_get_min_max_info,
			on_wm_close
		end

create
	make

feature {NONE} -- Initialization

	--| FIXME replace destroy agent with "cancel" result agent.
	--| FIXME Default is_modal

feature -- Basic operations

feature {NONE} -- Externals

	show_modal is
			-- Show and wait until window is closed.
		do
			if is_modal then
				show
				block
			else
				enable_modal
				show
				block
				disable_modal			
			end
		end
	
	on_get_min_max_info (min_max_info: WEL_MIN_MAX_INFO) is
			-- Called by WEL to request min/max size of window.
			-- Is called just before move and/or resize.
		local
			max_size, max_position: WEL_POINT
		do
				-- Prevent the maximize state.
			Precursor (min_max_info)
			create max_size.make (width, height)
			create max_position.make (x_position, y_position)
 			min_max_info.set_max_size (max_size)
			min_max_info.set_max_position (max_position)
		end

feature -- Status Report

	is_closeable: BOOLEAN
			-- Is the window closeable by the user?
			-- (Through a clik on the Window Menu, or by
			-- pressing ALT-F4)

feature -- Status Setting
	
	enable_closeable is
			-- Set the window to be closeable by the user
			-- (Through a clik on the Window Menu, or by
			-- pressing ALT-F4)
		do
			is_closeable := True
		end

	disable_closeable is
			-- Set the window not to be closeable by the user
		do
			is_closeable := False
		end

feature {NONE} -- WEL Implementation
	
	on_wm_close is
			-- User clicked on "close" ('X').
		do
			if is_closeable then
				interface.close_actions.call ([])
			end
			on_wm_close_executed := True
				-- Do not actually close the window.
			set_default_processing (False)
		end

	default_style: INTEGER is
			-- By default we don't show the "Window Menu"
		do
			Result := set_flag (Result, Ws_overlapped)
			Result := set_flag (Result, Ws_dlgframe)
			Result := set_flag (Result, Ws_border)
			Result := set_flag (Result, Ws_thickframe)
			Result := set_flag (Result, Ws_clipchildren)
			Result := set_flag (Result, Ws_clipsiblings)
			Result := set_flag (Result, Ws_minimizebox)
			Result := set_flag (Result, Ws_sysmenu)
		end

	default_ex_style: INTEGER is
		do
			Result := set_flag (Result, Ws_ex_controlparent)
			Result := set_flag (Result, Ws_ex_toolwindow)
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
--| Revision 1.16  2000/05/13 01:10:36  pichery
--| Fixed bugs.
--|
--| Revision 1.15  2000/05/01 19:52:09  pichery
--| Removed feature `block' (now implemented in
--| EV_TITLED_WINDOW_IMP).
--|
--| Revision 1.14  2000/04/29 03:31:33  pichery
--| New dialog implementation
--|
--| Revision 1.13  2000/04/20 18:27:50  brendel
--| Block now also ends when window is destroyed.
--|
--| Revision 1.12  2000/04/20 16:29:15  brendel
--| Uncommented imp of show_modal.
--|
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
