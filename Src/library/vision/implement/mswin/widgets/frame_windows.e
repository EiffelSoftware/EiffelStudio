indexing
	description: "This class represents a MS_WINDOWS frame";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	FRAME_WINDOWS

inherit
	MANAGER_WINDOWS
		redefine
			child_has_resized,
			height,
			realize,
			on_size,
			set_form_height,
			set_form_width,
			set_size,
			set_width,
			set_height,
			width
		end

	FRAME_I

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			menu as wel_menu,
			set_menu as wel_set_menu,
			show as wel_show,
			hide as wel_hide,
			destroy as wel_destroy,
			children as wel_children,
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
			item as wel_item
		undefine
			on_show,
			on_hide,
			on_draw_item,
			on_right_button_up,
			on_menu_command,
			on_left_button_down,
			on_left_button_up,
			on_right_button_down,
			on_mouse_move,
			on_destroy,
			on_set_cursor,
			on_key_up,
			on_size,
			on_move,
			on_key_down
		redefine
			class_name
		end

creation
	make

feature -- Initialization

	make (a_frame: FRAME; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Make the frame.
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			managed := man
		end

	realize is
			-- Realize current frame and set the enclosing size.
		local	
			wc: WEL_COMPOSITE_WINDOW
		do
			if not exists then
				realize_current
				realize_children
				set_child_size
				set_enclosing_size
				shown := true
			end
		end

	realize_current is
			-- Realize current frame.
		local
			wc: WEL_COMPOSITE_WINDOW
		do
			wc ?= parent
			make_with_coordinates (wc, "", x, y, private_attributes.width,
				 private_attributes.height)
			!! private_box.make (Current, "", 0, 0, 0, 0, private_box_id)
		end

feature -- Status report

	height: INTEGER is
		do
			Result := 2
		end

	width: INTEGER is
			-- Width of frame
		do
			Result := 2
		end

feature -- Status setting

	set_form_height (a_height: INTEGER) is
			-- Set height to `new_height'.
		do
			private_attributes.set_height (a_height)
			if exists then
				wel_set_height (a_height)
			end
			set_child_size
		end

	set_form_width (new_width: INTEGER) is
			-- Set width to `new_width'.
		do
			private_attributes.set_width (new_width)
			if exists then
				wel_set_width (new_width)
			end
			set_child_size
		end

	set_height (a_height: INTEGER) is
			-- Set height to `new_height'.
		do
			if private_attributes.height /= a_height then
				private_attributes.set_height (a_height)
				if exists then
					wel_set_height (a_height)
				end
				set_child_size
				if parent /= Void then
					parent.child_has_resized
				end
			end
		end

	set_width (new_width: INTEGER) is
			-- Set width to `new_width'.
		do
			if private_attributes.width /= new_width then
				private_attributes.set_width (new_width)
				if exists then
					wel_set_width (new_width)
				end
				set_child_size
				if parent /= Void then
					parent.child_has_resized
				end
			end
		end

	set_size (new_width, new_height: INTEGER) is
			-- Set the height to new_height,
			-- width to `new_width'.
		do
			if private_attributes.width /= new_width
			or else private_attributes.height /= new_height then
				private_attributes.set_width (new_width)
				private_attributes.set_height (new_height)
				if exists then
					resize (new_width, new_height)
				end
				set_child_size
				if parent /= Void then
					parent.child_has_resized
				end
			end
		end

	child_has_resized is
			-- Adjust size of child
		local
			l: LIST [WIDGET_WINDOWS]
			a_width: INTEGER
			a_height: INTEGER
		do
			if realized then
				l := children_list
				if not l.empty then
					a_width := l.first.form_width
					a_height := l.first.form_height
					set_form_width (a_width + 4)
					set_form_height (a_height + (box_text_height // 2) + 4)
				end
			end
		end

feature {NONE} -- Implementation

	box_text_height: INTEGER is
			-- Text height of the box title
		local
			a_log_font: WEL_LOG_FONT
		do
			a_log_font := private_box.font.log_font
			Result := a_log_font.height
		end

	set_child_size is
			-- Set size of the child
		local
			l: LIST [WIDGET_WINDOWS]
			a: ANY
		do
			if realized then
				l := children_list
				if not l.empty then
					l.first.set_form_width ((form_width - 5).max(0))
					l.first.set_form_height ((form_height - (box_text_height // 2) - 5).max (0))
					l.first.set_x_y (2, (box_text_height // 2) + 2)
				end
			end
		end

	on_size (code, new_width, new_height: INTEGER) is
			-- Resize the frame according to parent.
		require else
			box_not_void: private_box /= Void
			box_exists: private_box.exists
		local
			resize_data: RESIZE_CONTEXT_DATA
		do
			!! resize_data.make (owner, new_width, new_height, code)
			private_box.resize ((new_width).max (0), (new_height).max (0))
			resize_actions.execute (Current, resize_data)
		end

	class_name: STRING is
		once
			Result := "EvisionFrame"
		end

	private_box: WEL_GROUP_BOX
			-- Frame around the window

	private_box_id: INTEGER is 1
			-- Id for the private_box

end -- class FRAME_WINDOWS

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

