indexing 
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
class
	SHELL_IMP
  
inherit 
	WEL_SIZE_CONSTANTS
		export
			{NONE} all
		end

	COMPOSITE_IMP
		redefine
			on_size,
			on_set_cursor,
			height, 
			set_height,
			set_size,
			set_width,
			width,
			real_x,
			real_y,
			set_enclosing_size
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
			class_background,
			background_brush,
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
			default_ex_style,
			class_name,
			on_get_min_max_info
		end

feature -- Initialization

	make_with_coordinates (a_parent: WEL_WINDOW; a_name: STRING; a_x, a_y, a_width, a_height: INTEGER) is
		require
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
			if exists then
				Result := absolute_x + window_frame_width
			else
				Result := private_attributes.x + window_frame_width
			end
		end

	real_y: INTEGER is
			-- Relative y-position of the client-area to the screen.
		do
			if exists then
				if has_menu then
					Result := absolute_y + title_bar_height + window_border_height +
						window_frame_height + menu_bar_height
				else
					Result := absolute_y + title_bar_height + window_border_height +
						window_frame_height
				end
			else
				Result := private_attributes.y + title_bar_height + window_border_height +
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
			if private_attributes.height /= new_height then
				private_attributes.set_height (new_height)
				if exists then
					wel_set_height (maximal_height.min (new_height + shell_height))
				end
			end
			if realized then
				resize_shell_children (width, maximal_height.min (new_height + shell_height))
			end
		ensure then
			correct_client_height: exists implies client_height = new_height
		end

	set_size (new_width, new_height: INTEGER) is
			-- Set the height to `new_height',
			-- width to `new_width'.
		do
			if private_attributes.width /= new_width
			or else private_attributes.height /= new_height then
				private_attributes.set_height (new_height)
				private_attributes.set_width (new_width)
				if exists then
					resize (maximal_width.min (new_width + shell_width),
						maximal_height.min (new_height + shell_height))
				end
			end
			if realized then
				resize_shell_children (maximal_width.min (new_width + shell_width)
					, maximal_height.min (new_height + shell_height))
			end
		ensure then
			correct_width: exists implies client_width = new_width
			correct_height: exists implies client_height = new_height
		end

	set_width (new_width: INTEGER) is
			-- Set the client rect to have a width of
			-- `new_client_width'
		do
			if private_attributes.width /= new_width then
				private_attributes.set_width (new_width)
				if exists then
					wel_set_width (maximal_width.min (new_width + shell_width))
				end
			end
			if realized then
				resize_shell_children (maximal_width.min (new_width + shell_width), height)
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

	set_enclosing_size is
			-- Set the enclozing size.
		local
			c: ARRAYED_LIST [WIDGET_IMP]
			maxxw, maxyh, tmp, w, h: INTEGER
			current_item: WIDGET_IMP
			dw: DIALOG_IMP
			psw: POPUP_SHELL_IMP
		do
			from 
				c := children_list
				c.start
			until
				c.after
			loop
				current_item := c.item
				if current_item /= Void and then current_item.managed then
					dw ?= current_item
					if dw = Void then
						psw ?= current_item
						if psw = Void then
							tmp := current_item.x + current_item.width
							if tmp > maxxw then
								maxxw := tmp
							end
							tmp := current_item.y + current_item.height
							if tmp > maxyh  then
								maxyh := tmp
							end
						end
					end

				end
				c.forth
			end
			w := width
			h := height
			if w < maxxw and then h < maxyh then
				set_size (maxxw, maxyh)
			else
				if w < maxxw then
					set_width (maxxw)
				end

				if h < maxyh then
					set_height (maxyh)
				end
			end
		end

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
			else
				if size_type = Size_maximized or size_type = Size_restored then
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
		end

	resize_shell_children (a_width, a_height: INTEGER) is
			-- resize the children to `a_width', `a_height'
		local
			local_children: LIST [WIDGET_IMP]
			p: PRIMITIVE_IMP
			m: MANAGER_IMP
			b: BULLETIN_IMP
			d: DIALOG_IMP
		do
			children_resizing := True
			private_attributes.set_height (a_height)
			private_attributes.set_width (a_width)				
			local_children := children_list
			from
				local_children.start
			variant
				local_children.count + 1 - local_children.index
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
			children_resizing := False
		end

	children_resizing: BOOLEAN
			-- Are the children currently being resized

	default_style: INTEGER is
		once
			Result := Ws_overlappedwindow + Ws_visible
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionShell"
		end

	default_ex_style: INTEGER is
			-- Windows 3D look
		once
			Result := 0
		end

	on_get_min_max_info (min_max_info: WEL_MIN_MAX_INFO) is
		local
		 	track: WEL_POINT
			w: INTEGER
			h: INTEGER
		do
			if fixed_size_flag then
				if is_restored then
					w := private_attributes.width + shell_width 
					h := private_attributes.height + shell_height 
				else
					w := wel_width
					h := wel_height
				end
				!! track.make (w, h)
				min_max_info.set_min_track_size (track)
				min_max_info.set_max_track_size (track)
			end
			if minimized then
				is_restored := True
			else
				is_restored := False
			end
		end

	on_set_cursor (hit_code: INTEGER) is
		do
			if fixed_size_flag then
				disable_default_processing
			end
		end

	is_restored: BOOLEAN
			--Is the shell restored ?

end -- SHELL_IMP
 


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

