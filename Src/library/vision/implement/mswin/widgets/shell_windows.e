indexing 
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
class
	SHELL_WINDOWS 
  
inherit 
	WEL_SIZE_CONSTANTS
		export
			{NONE} all
		end

	COMPOSITE_WINDOWS
		redefine
			on_size,
			height, 
			set_height,
			set_size,
			set_width,
			width,
			real_x,
			real_y
		end

	SHELL_I

	SIZEABLE_WINDOWS
		rename
			forbid_recompute_size as forbid_resize,
			allow_recompute_size as allow_resize
		end

	WEL_FRAME_WINDOW
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
			menu as wel_menu
		undefine
			on_hide,
			on_show,
			on_move,
			on_destroy,
			on_right_button_up,
			on_left_button_down,
			on_left_button_up,
			on_right_button_down,
			on_mouse_move,
			on_set_cursor,
			on_menu_command,
			on_size,
			on_key_up,
			on_key_down,
			on_draw_item
		redefine
			default_style,
			class_name
		end

feature -- Initialization

	make_with_coordinates (a_parent: WEL_COMPOSITE_WINDOW; a_name: STRING; a_x, a_y, a_width, a_height: INTEGER) is
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
			a_name_not_void: a_name /= Void
		do
			register_class
			internal_window_make (a_parent, a_name,
				default_style,
				a_x, a_y,
				a_width, a_height,
				default_id, default_pointer)
		ensure
			exists: exists
		end

	make_top_with_coordinates (a_name: STRING; a_x, a_y, a_width,
			a_height: INTEGER) is
		require
			a_name_not_void: a_name /= Void
		do
			register_class
			internal_window_make (Void, a_name,
				default_style,
				a_x, a_y,
				a_width, a_height,
				default_id, default_pointer)
		ensure
			exists: exists
		end

feature -- Access

	real_x: INTEGER is
			-- Relative x-position of the client-area to the screen.
		do
			Result := absolute_x + window_frame_width
		end

	real_y: INTEGER is
			-- Relative y-position of the client-area to the screen.
		do
			if has_menu then
				Result := absolute_y + title_bar_height + window_border_height +
					window_frame_height + menu_bar_height
			else
				Result := absolute_y + title_bar_height + window_border_height +
					window_frame_height
			end
		end

	height: INTEGER is
			-- Height of widget
		do
			if exists then
				Result := wel_height - shell_height
			else
				Result := private_attributes.height
			end
		end

	shell_height: INTEGER 
			-- Extra height of shell around widgets

	shell_width: INTEGER 
			-- Extra width of shell around widgets

	title: STRING is
		do
			if exists then
				Result := wel_text
			else
				Result := private_title
			end
		end

	private_title: STRING

	width: INTEGER is
			-- Width of widget
		do
			if exists then
				Result := wel_width - shell_width
			else
				Result := private_attributes.width
			end
		end
 
feature -- Status setting

	set_height (new_height: INTEGER) is
			-- Set height to `new_height'
		do
			private_attributes.set_height (new_height)
			if exists then
				wel_set_height (new_height + shell_height)
			end
		ensure then
			correct_client_height: exists implies client_height = new_height
		end

	set_size (new_width, new_height: INTEGER) is
			-- Set the height to `new_height',
			-- width to `new_width'.
		do
			set_width (new_width)
			set_height (new_height)
			if realized then
				resize_shell_children (new_width, new_height)
			end
		ensure then
			correct_width: exists implies client_width = new_width
			correct_height: exists implies client_height = new_height
		end

	set_width (new_width: INTEGER) is
			-- Set the client rect to have a width of
			-- `new_client_width'
		do
			private_attributes.set_width (new_width)
			if exists then
				wel_set_width (new_width + shell_width)
			end
		ensure then
			correct_width: exists implies client_width = new_width
		end

	set_override (flag: BOOLEAN)  is
		do
		end

	realize_current is
		do
			if title /= Void then
				make_top_with_coordinates (title, x, y, width+shell_width, height+shell_height)
			else
				make_top_with_coordinates ("", x, y, width+shell_width, height+shell_height)
			end
		end

feature {NONE} -- Implementation

	on_size (size_type: INTEGER; a_width, a_height: INTEGER) is
			-- Wm_size message
			-- See class WEL_SIZE_CONSTANTS for `size_type' value
		local
			resize_data: RESIZE_CONTEXT_DATA
			wa: WIDGET_ACTIONS
		do
			if size_type = Size_minimized then
				wa := unmap_actions.widget_actions (Current)
				if wa /= Void then
					shown := False
					wa.execute (Void)
				end
			elseif size_type = Size_maximized or size_type = Size_restored then
				wa := map_actions.widget_actions (Current)
				if wa /= Void then
					shown := True
					wa.execute (Void)
				end
			else
				!! resize_data.make (owner, a_width, a_height, size_type)
				resize_actions.execute (Current, resize_data)
			end
			resize_shell_children (a_width, a_height)
		end

	resize_shell_children (a_width, a_height: INTEGER) is
			-- resize the children to `a_width', `a_height'
		local
			local_children: LIST [WIDGET_WINDOWS]
			p: PRIMITIVE_WINDOWS
			m: MANAGER_WINDOWS
			b: BULLETIN_WINDOWS
			d: DIALOG_WINDOWS
		do
			private_attributes.set_height (a_height)
			private_attributes.set_width (a_width)				
			local_children := children_list
			from
				local_children.start
			variant
				local_children.count - local_children.index
			until
				local_children.off
			loop	
				d ?= local_children.item
				if d = Void then
					p ?= local_children.item
					if p /= Void then
						p.set_size (a_width, a_height)
					else
						b ?= local_children.item
						if b /= Void then
							b.set_size (a_width, a_height)
						else					
							m ?= local_children.item
							if m /= Void then
								m.set_size (a_width, a_height)
							end
						end
					end
				end
				local_children.forth
			end
		end

	default_style: INTEGER is
		once
			Result := Ws_overlappedwindow + Ws_visible
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionShell"
		end

end -- SHELL_WINDOWS
 
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

