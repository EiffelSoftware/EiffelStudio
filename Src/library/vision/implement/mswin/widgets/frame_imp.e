indexing
	description: "This class represents a MS_WINDOWS frame";
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
			class_name,
			default_style
		end

	WEL_BS_CONSTANTS

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
			if initial_focus /= void then
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
		end

feature -- Status report

	height: INTEGER is
			-- Height of frame
		once
			Result := wel_height
		end

	width: INTEGER is
			-- Width of frame
		once
			Result := wel_width
		end

feature -- Status setting

	set_form_height (new_height: INTEGER) is
			-- Set height (including the frame) to `new_height'.
		do
			private_attributes.set_height (new_height)
			if exists then
				wel_set_height (new_height)
			end
			set_child_size
		end

	set_form_width (new_width: INTEGER) is
			-- Set width (including the frame) to `new_width'.
		do
			private_attributes.set_width (new_width)
			if exists then
				wel_set_width (new_width)
			end
			set_child_size
		end

	set_height (new_height: INTEGER) is
			-- Set inside height of frame to `new_height'.
		do
			if private_attributes.height /= new_height then
				private_attributes.set_height (new_height + frame_height)
				if exists then
					wel_set_height (new_height + frame_height)
				end
				set_child_size
				if parent /= Void then
					parent.child_has_resized
				end
			end
		end

	set_width (new_width: INTEGER) is
			-- Set inside width of frame to `new_width'.
		do
			if private_attributes.width /= new_width then
				private_attributes.set_width (new_width + frame_width)
				if exists then
					wel_set_width (new_width + frame_width)
				end
				set_child_size
				if parent /= Void then
					parent.child_has_resized
				end
			end
		end

	set_size (new_width, new_height: INTEGER) is
			-- Set the inside height of frame to new_height,
			-- width to `new_width'.
		do
			if private_attributes.width /= new_width + frame_width
			or else private_attributes.height /= new_height + frame_height then
				private_attributes.set_width (new_width + frame_width)
				private_attributes.set_height (new_height + frame_height)
				if exists then
					resize (new_width + frame_width, new_height + frame_height)
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
		do
			-- Vision does not provide the setting of title yet.
		end

	set_child_size is
			-- Set size of the child to fit in the frame
		local
			l: LIST [WIDGET_IMP]
			a: ANY
		do
			if realized then
				l := children_list
				if not l.empty then
					l.first.set_form_width (form_width)
					l.first.set_form_height (form_height)
					l.first.set_x_y (0,0)
				end
			end
		end

	set_enclosing_size is
			-- Set the size of frame to enclose the size of the child
		local
			l: LIST [WIDGET_IMP]
			a_width: INTEGER
			a_height: INTEGER
		do
			if realized then
				l := children_list
				if not l.empty then
					a_width := l.first.form_width
					a_height := l.first.form_height
					set_size (a_width, a_height)
				end
			end
		end

	on_size (code, new_width, new_height: INTEGER) is
			-- Resize the frame according to parent.
		local
			resize_data: RESIZE_CONTEXT_DATA
		do
			!! resize_data.make (owner, new_width, new_height, code)
			resize_actions.execute (Current, resize_data)
		end

	class_name: STRING is
		once
			Result := "EvisionFrame"
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := {WEL_CONTROL_WINDOW} Precursor + Ws_dlgframe
		end

	frame_height: INTEGER is 
			-- Height of frame border
		once
			Result := 2 * dialog_window_frame_height
		end

	frame_width: INTEGER is 
			-- Width of frame border
		once
			Result := 2 * dialog_window_frame_width
		end

end -- class FRAME_IMP

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

