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
			class_background,
			set_height,
			set_size, 
			set_width,
			child_has_resized,
			on_destroy,
			make_with_coordinates,
			set_default_position,
			maximal_width,
			maximal_height
		redefine
			class_name,
			on_size,
			unrealize,
			default_position
		select
			unrealize
		end

	BULLETIN_WINDOWS
		rename
			make as bulletin_make,
			wel_make as make_child,
			unrealize as bulletin_unrealize
		undefine
			show,
			set_enclosing_size,
			resize_for_shell,
			default_style,
			destroy,
			height,
			minimal_height,
			minimal_width,
			move_and_resize,
			on_menu_command,
			on_accelerator_command,
			on_paint,
			real_x,
			real_y,
			realize,
			realized,
			realize_current,
			wel_move,
			width
		redefine
			class_name,
			on_size,
			default_position
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

feature -- Access

	default_position: BOOLEAN
			-- Use default position?

feature -- Status setting

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Wm_size message
		do
			if size_type = size_restored then
				private_attributes.set_height (a_height)
				private_attributes.set_width (a_width)
			end
		end

	unrealize is
		do
			if insensitive_list /= Void then
				set_windows_sensitive
			end
			bulletin_unrealize
			wel_destroy
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
