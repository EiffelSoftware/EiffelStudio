indexing
	description: "This class represents a MS_WINDOWS bulletin"
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

class
	BULLETIN_WINDOWS

inherit
	MANAGER_WINDOWS
		redefine
			child_has_resized, 
			realize_current,
			show
		end;

	BULLETIN_I

	SIZEABLE_WINDOWS
		redefine
			resize_for_shell
		end

	WEL_CONTROL_WINDOW
		rename
			show as wel_show,
			hide as wel_hide,
			destroy as wel_destroy,
			x as wel_x,
			y as wel_y,
			width as wel_width,
			height as wel_height,
			set_x as wel_set_x,
			set_y as wel_set_y,
			set_width as wel_set_width,
			set_height as wel_set_height,
			shown as wel_shown,
			parent as wel_parent,
			text as wel_text,
			text_length as wel_text_length,
			set_text as wel_set_text,
			move as wel_move,
			set_focus as wel_set_focus,
			set_capture as wel_set_capture,
			release_capture as wel_release_capture,
			item as wel_item,
			children as wel_children,
			draw_menu as wel_draw_menu,
			make_top as wel_make_top,
			set_menu as wel_set_menu,
			menu as wel_menu,
			make as wel_make
		undefine
			class_background,
			on_show,
			on_hide,
			on_size,
			on_move,
			on_destroy,
			on_draw_item,
			on_key_down,
			on_key_up,
			on_left_button_down,
			on_left_button_up,
			on_menu_command,
			on_mouse_move,
			on_right_button_down,
			on_right_button_up,
			on_set_cursor
		redefine
			class_name
		end

	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end

creation 
	make

feature {NONE} -- Initialization 

	make (a_bulletin: BULLETIN; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a bulletin.
		do
			!! private_attributes
			default_position := true;
			parent ?= oui_parent.implementation;
			managed := man
		end;

feature -- Status setting

	realize_current is
			-- Display a bulletin
		local
			wc: WEL_COMPOSITE_WINDOW
		do
			if not realized then
				wc ?= parent
				resize_for_shell
				make_with_coordinates (wc, "", x, y, width, height);
				set_enclosing_size
				if not fixed_size_flag then
					resize_for_shell
				end
				shown := true
			end
		end;

	show is
			-- Show composite.
		do
			if 
				exists and then
				((parent /= Void and then parent.wel_shown)
				or (parent = Void))
			then
				wel_show
				show_children
			end
			shown := True
		end

feature {NONE} -- Implementation

	class_name: STRING is
		once
			Result := "EvisionBulletin"
		end

	child_has_resized is
			-- Action to perform when a child 
			-- has changed size
		do
			if not fixed_size_flag then
				set_enclosing_size
			end
		end;

	default_position: BOOLEAN;
			-- Is this to be centered around parent?

	resize_for_shell is
			-- Resize current widget if the parent is a shell.			
		local
			tw: TOP_WINDOWS
		do
			tw ?= parent
			if tw /= Void and then tw.exists then
				set_x_y (0, 0)
				set_size (tw.client_width, tw.client_height)
			end
		end

end -- class BULLETIN_WINDOWS
 
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
