indexing
	description: "A WEL control holding the EiffelVision Tool Bar."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INTERNAL_TOOL_BAR_IMP

inherit
	WEL_CONTROL_WINDOW
		redefine
			default_style,
			background_brush,
			on_wm_erase_background,
			on_control_id_command
		end

creation
	make

feature {NONE} -- Implementation

	command_count: INTEGER is 10

feature {NONE} -- WEL Implementation

	toolbar: EV_TOOL_BAR_IMP is
			-- Child toolbar
		do
			Result ?= children.first
		end

   	background_brush: WEL_BRUSH is
   			-- Current window background color used to refresh the window when
   			-- requested by the WM_ERASEBKGND windows message.
   			-- By default there is no background 
		do
 			if exists and toolbar.background_color_imp /= Void then
 				create Result.make_solid (toolbar.background_color_imp)
 			end
 		end

	on_wm_erase_background (wparam: INTEGER) is
			-- Wm_erasebkgnd message.
			-- Ne need to erase the background because this
			-- containers has always the same size than the
			-- tool-bar.
		do
			disable_default_processing
		end

	on_control_id_command (control_id: INTEGER) is
			-- A command has been received from `control_id'.
		do
			(toolbar.ev_children @ control_id).on_activate
		end

	default_style: INTEGER is
			-- We redefine the default style.
		do
			Result := Ws_child + Ws_visible + Ws_clipchildren
		end

end -- class EV_INTERNAL_TOOL_BAR_IMP

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
