indexing
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
class
	FORM_DIALOG_WINDOWS

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
			show,
			set_default_position,
			set_enclosing_size
		redefine
			class_name,
			dialog_realize, 
			on_size,
			realize,
			set_form_width,
			set_form_height,
			set_height,
			set_size,
			set_width,
			unrealize
		select
			unrealize
		end;

	FORM_WINDOWS
		rename
			make as form_make,
			wel_make as make_child,
			unrealize as form_unrealize
		undefine
			default_style,
			destroy,
			class_background,
			height,
			minimal_height,
			minimal_width,
			move_and_resize,
			on_menu_command,
			on_paint,
			realize_current,
			realized,
			resize_for_shell,
			width,
			wel_move
	redefine
			class_name,
			realize,
			on_size,
			initialize,
			set_form_height,
			set_form_width,
			set_width,
			set_height,
			set_size,
			show
		end

	FORM_D_I

	WEL_SIZE_CONSTANTS

creation 
	make

feature -- Initialization
 
	make (a_form_d: FORM_D; oui_parent: COMPOSITE) is
			-- Create the form dialog.
		do
			!! private_attributes
			parent ?= oui_parent.implementation;
			a_form_d.set_dialog_imp (Current);
			private_title := a_form_d.identifier;
			initialize
			managed := true
			shell_height := title_bar_height + window_border_height + 2 * window_frame_height
			shell_width := 2 * window_frame_width
			default_position := true
			private_attributes.set_width (100)
			private_attributes.set_height (100)
		end

	initialize is
			-- Initialize the current form
		do
			fraction_base := 100
			!! form_child_list.make
		end

feature -- Status setting

	dialog_realize is
			-- Realize the current widget
		local
			h,w: INTEGER
			xpos, ypos: INTEGER
		do
			if not exists then
				realize_current
				shown := true
				updating := true
				realize_children
				if not fixed_size_flag then
					set_enclosing_size
				end
				h := form_child_list.height (Current)
				if h > height then
					set_form_height (h)
				end			
				w := form_child_list.width (Current)
				if w > width then
					set_form_width (w)
				end
				updating := false
			end
			realized := true
			update_all
			if grab_style = modal then
				set_windows_insensitive
			end
			if default_position then
				xpos := parent.real_x + ((parent.width - width) // 2) 
				ypos := parent.real_y + ((parent.height - height) // 2)
				xpos := xpos.max (0)
				ypos := ypos.max (0)
				set_x_y (xpos, ypos)
			end
			wel_show
		end

	realize is
		do
			realized := true
		end

	set_form_height (new_height: INTEGER) is
			-- Set height for form to `new_height'
		do
			if height /= new_height then
				private_attributes.set_height (new_height)
				if exists then 
					wel_set_height (new_height + shell_height)
				end
			end
		end

	set_form_width (new_width: INTEGER) is
			-- Set height for form to `new_height'
		do
			if width /= new_width then
				private_attributes.set_width (new_width)
				if exists then 
					wel_set_width (new_width + shell_width)
				end
			end
		end

	set_height (new_height: INTEGER) is
			-- Set height to `new_height'.
		do
			if height /= new_height then
				private_attributes.set_height (new_height)
				if exists then 
					wel_set_height (new_height + shell_height)
				end
				if not updating then
					update_all
				end
			end	
		end

	set_size (new_width, new_height: INTEGER) is
			-- Set size to `new_width' and `new_height'.
		do
			if width /= new_width or height /= new_height then
				private_attributes.set_height (new_height)
				private_attributes.set_width (new_width)
				if exists then 
					resize (new_width + shell_width, new_height + shell_height)
				end
				update_all
			end
		end

	set_width (new_width: INTEGER) is
			-- Set width to `new_width'.
		do
			if width /= new_width then
				private_attributes.set_width (new_width)
				if exists then 
					wel_set_width (new_width + shell_width)
				end
				if not updating then
					update_all
				end
			end	
		end

	show is
			-- Show current form dialog and children.
		do
			set_enclosing_size
			update_all
			bulletin_show
		end

	unrealize is
		do
			realized := false
			form_unrealize
		end

	class_name: STRING is
			-- Set the class name for WEL.
		once
			Result := "EVisionFormDialog"
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Wm_size message
		do
			if size_type = size_restored then
				private_attributes.set_height (a_height)
				private_attributes.set_width (a_width)
				if not updating then
					update_all
				end
			end				
		end

end -- class FORM_DIALOG_WINDOWS

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


