indexing
	description: "Dialog with a bulletin in it."
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	BULLETIN_DIALOG_WINDOWS

inherit
	COLORED_FOREGROUND_WINDOWS

	DIALOG_WINDOWS
		rename
			allow_resize as allow_recompute_size,
			forbid_resize as forbid_recompute_size
		undefine
			child_has_resized,
			on_destroy,
			make_with_coordinates,
			set_default_position,
			show,
			maximal_width,
			maximal_height
		redefine
			class_name,
			dialog_realize, 
			on_size,
			realize,
			unrealize
		select
			unrealize
		end

	BULLETIN_WINDOWS
		rename
			make as bulletin_make,
			wel_make as make_child,
			unrealize as bulletin_unrealize
		undefine
			set_enclosing_size,
			resize_for_shell,
			default_style,
			destroy,
			class_background,
			height,
			minimal_height,
			minimal_width,
			move_and_resize,
			on_menu_command,
			on_paint,
			real_x,
			real_y,
			realized,
			realize_current,
			set_height,
			set_size, 
			set_width,
			wel_move,
			width
		redefine
			class_name,
			on_size,
			realize
		end

	BULLETIN_D_I

	WEL_SIZE_CONSTANTS

creation
	make

feature {NONE} -- Initialization

	make (a_bulletin_d : BULLETIN_D; oui_parent: COMPOSITE) is
			-- Create a bulletin for a dialog
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			a_bulletin_d.set_dialog_imp (Current)
			managed := True
			shell_height := title_bar_height + 2 * window_border_height + window_frame_height
			shell_width := 2 * window_frame_width
		end

	dialog_realize is
			-- Realize the current widget
		local
			h,w: INTEGER
		do
			if not exists then
				realize_current
				realize_children
				if not fixed_size then
					set_enclosing_size
				end
			end
			realized := true
			if grab_style = modal then
				set_windows_insensitive
			end
			show
		end

feature -- Status setting

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Wm_size message
		do
			if size_type = size_restored then
				private_attributes.set_height (a_height)
				private_attributes.set_width (a_width)
			end				
		end

	realize is
			-- Realize the bulletin.
		do
			realized := true
		end
	
	unrealize is
		do
			bulletin_unrealize
			realized := false
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EVisionBulletinDialog"
		end

end -- class BULLETIN_DIALOG_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
