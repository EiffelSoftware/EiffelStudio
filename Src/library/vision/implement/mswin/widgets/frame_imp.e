indexing
	description: "This class represents a MS_IMPframe";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	FRAME_IMP

inherit
	MANAGER_IMP
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
			set_enclosing_size,
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
			class_background,
			background_brush,
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
			class_name, on_paint
		end

creation
	make

feature -- Initialization

	make (a_frame: FRAME; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Make the frame.
		local
			wlf: WEL_LOG_FONT
		do
			!! wlf.make (1, "Arial")
			!! box_text_font.make_indirect (wlf)
			!! private_attributes
			parent ?= oui_parent.implementation
			managed := man
		end

	realize is
			-- Realize current frame and set the enclosing size.
		do
			if not exists then
				realize_current
				realize_children
				if form_height /= 0 or form_width /= 0 then
						-- if size is set children size accordingly
					set_child_size
				else 
						-- else set size according to children size
					set_enclosing_size
				end
				shown := true
			end
				-- set initial focus
			if initial_focus /= Void then
				initial_focus.wel_set_focus
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
			private_box.set_font (box_text_font)
		end

feature -- Status report

	height: INTEGER is 2
			-- Height of frame

	width: INTEGER is 2
			-- Width of frame

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
			-- Adjust size according the child size
		do
			if realized then
				set_enclosing_size
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
			l: LIST [WIDGET_IMP]
		do
			if realized then
				l := children_list
				if not l.is_empty then
					l.first.set_form_width ((form_width - 2 * width).max (0))
					l.first.set_form_height ((form_height - box_text_height - 2 * height).max (0))
					l.first.set_x_y (width, box_text_height + height)
				end
			end
		end

	set_enclosing_size is
			-- Set the enclosing size.
		local
			l: LIST [WIDGET_IMP]
			a_width: INTEGER
			a_height: INTEGER
		do
			if realized then
				l := children_list
				if not l.is_empty then
					a_width := l.first.form_width
					a_height := l.first.form_height
					set_size (a_width + 2 * width,
						a_height + box_text_height + 2 * height)
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

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
		do
			if box_text_font /= Void then
				private_box.set_font (box_text_font)
			end
		end

	box_text_font: WEL_FONT
			-- Font for the box title

	private_box: WEL_GROUP_BOX
			-- Frame around the window

	private_box_id: INTEGER is 1
			-- Id for the private_box

end -- class FRAME_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

