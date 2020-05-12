note
	description: "Eiffel Vision menu item. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_ITEM_IMP

inherit
	EV_MENU_ITEM_I
		redefine
			interface,
			parent
		end

	EV_ITEM_IMP
		undefine
			parent
		redefine
			interface,
			set_capture,
			release_capture,
			set_heavy_capture,
			release_heavy_capture,
			remove_pixmap,
			set_pixmap,
			top_level_window_imp
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text,
			text
		end

	EV_ID_IMP

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

	WEL_CONSTANTS
		export
			{NONE} all
		end

	WEL_SHARED_FONTS
		export
			{NONE} all
		end

	WEL_SYSTEM_COLORS
		export
			{NONE} all
		end

	WEL_WINDOWS_VERSION
		export
			{NONE} all
		end

	WEL_SYSTEM_PARAMETERS_INFO
		export
			{NONE} all
		end

	DISPOSABLE
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	old_make (an_interface: attached like interface)
			-- Create the menu item.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `is_sensitive' True.
		do
			make_id
			is_sensitive := True
			set_is_initialized (True)
			set_text ("")
		end

feature -- Access

	text: STRING_32
			-- Text displayed in label.
		do
			Result := wel_text
		end

	object_id: INTEGER
			-- Run-time object Id of `Current'.
		do
			if internal_object_id = 0 then
				internal_object_id := eif_object_id (Current)
			end
			Result := internal_object_id
		end

feature -- Element change

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to `text'.
		do
			wel_set_text (a_text)
		end

feature -- Status report

	is_sensitive: BOOLEAN
			-- Can this item be clicked on?
			--| is not a function because we do not want to block the
			-- user from setting the sensitive state while unparented.

feature -- Status setting

	enable_sensitive
   			-- Set current item sensitive.
		do
			is_sensitive := True
			if has_parent and then attached parent_imp as l_parent_imp then
				l_parent_imp.enable_item (id)
			end
   		end

	disable_sensitive
   			-- Set current item insensitive.
		do
			is_sensitive := False
			if has_parent and then attached parent_imp as l_parent_imp then
				l_parent_imp.disable_item (id)
			end
   		end

feature -- Element change

	set_parent_imp (a_parent_imp: like parent_imp)
			-- Make `a_parent_imp' the parent of `Current'.
		do
			parent_imp := a_parent_imp
		end

feature -- Measurement

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		do
			if attached {EV_MENU_BAR_IMP} parent_imp as l_menu_bar then
				Result := screen_x - l_menu_bar.screen_x
			elseif attached {EV_MENU_IMP} parent_imp as l_menu then
				Result := screen_x - l_menu.screen_x
			else
				check parent_either_menu_bar_or_menu: False end
			end
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		do
			if attached {EV_MENU_BAR_IMP} parent_imp as a_menu_bar then
				Result := screen_y - a_menu_bar.screen_y
			elseif attached {EV_MENU_IMP} parent_imp as a_menu then
				Result := screen_y - a_menu.screen_y
			else
				check either_menu_bar_or_manu: False end
			end
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		do
			load_bounds_rect
			Result := bounds_rect.left
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		do
			load_bounds_rect
			Result := bounds_rect.top
		end

	width: INTEGER
			-- Horizontal size in pixels.
		do
			load_bounds_rect
			Result := bounds_rect.right - bounds_rect.left
		end

	height: INTEGER
			-- Vertical size in pixels.
		do
			load_bounds_rect
			Result := bounds_rect.bottom - bounds_rect.top
		end

	minimum_width: INTEGER
			-- Minimum horizontal size in pixels.
		do
				-- If this is called an invariant violation is triggered in WEL_DC
				-- It looks like the call to "load_bounds_rect" and then to "GetMenuItemRect" has some side-effects
				-- juliant, 16. Nov. 2006
			--Result := width
		end

	minimum_height: INTEGER
			-- Minimum vertical size in pixels.
		do
				-- If this is called an invariant violation is triggered in WEL_DC
				-- It looks like the call to "load_bounds_rect" and then to "GetMenuItemRect" has some side-effects
				-- juliant, 16. Nov. 2006
			--Result := height
		end

feature {NONE} -- Implementation

	wel_text: STRING_32
			-- Caption of the menu item.
			--| For the specification given in the note of EV_MENU_ITEM,
			--| we do not have to take any special action.
			--| Does not return internal toolkit string because it is possible
			--| to set the string without parent.
		do
			if attached real_text as l_real_text then
				Result := l_real_text.twin
			else
				create Result.make_empty
			end
		end

	real_text: detachable STRING_32

	wel_set_text (a_text: READABLE_STRING_GENERAL)
			-- Set `text' to `a_txt'. See `wel_text'.
		do
			if a_text /= Void then
				if a_text.is_string_32 then
					real_text := a_text.as_string_32.twin
				else
					real_text := a_text.as_string_32
				end
			end

				-- Force the menu bar to be recomputed.
			if attached parent_imp as l_parent_imp then
				l_parent_imp.rebuild_control
			end
		end

	text_length: INTEGER
			-- Length of text'.
		do
			if attached real_text as l_real_text then
				Result := l_real_text.count
			end
		end

	parent_imp: detachable EV_MENU_ITEM_LIST_IMP
			-- The menu or menu-bar this item is in.

	parent: detachable EV_MENU_ITEM_LIST
			-- Item list containing `Current'.
		do
			if
				attached parent_imp as l_parent_imp and then
				attached {EV_MENU_ITEM_LIST} l_parent_imp.interface as l_interface
			then
				Result := l_interface
			end
		end

	has_parent: BOOLEAN
			-- Is this menu item in a menu?
		do
			Result := attached parent_imp as l_parent_imp and then l_parent_imp.item_exists (id)
		end

	remove_pixmap
			-- Remove pixmap from `Current'.
		do
			if private_pixmap /= Void then
				private_pixmap := Void
				if attached parent_imp as l_parent_imp then
					l_parent_imp.internal_replace (Current, l_parent_imp.index_of (interface, 1))

						-- Force the menu bar to be recomputed.
					l_parent_imp.rebuild_control
				end
			end
		end

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Assign `a_pixmap' to `pixmap'.
		do
			Precursor (a_pixmap)
			if attached parent_imp as l_parent_imp then
				l_parent_imp.internal_replace (Current, l_parent_imp.index_of (interface, 1))

						-- Force the menu bar to be recomputed.
				l_parent_imp.rebuild_control
			end
		end

	internal_object_id: INTEGER
			-- Runtime Eiffel Object Id. Zero if no call to `eif_object_id'
			-- has been made so far.
			-- This is used for drawing owner-draw menu items

	dispose
			-- Destroy the inner structure of `Current'.
			--
			-- This function should be called by the GC when the
			-- object is collected or by the user if `Current' is
			-- no more usefull.
		do
			if internal_object_id /= 0 then
				eif_object_id_free (internal_object_id)
				internal_object_id := 0
			end
		end

feature {EV_MENU_ITEM_IMP} -- Implementation

	top_level_window_imp: detachable EV_WINDOW_IMP
			-- Window containing `Current' in parenting hierarchy.
		do
			if attached parent_imp as l_parent_imp then
				if attached {EV_MENU_IMP} l_parent_imp as l_menu then
					Result := l_menu.top_level_window_imp
				elseif attached {EV_MENU_BAR_IMP} l_parent_imp as l_menu_bar then
					Result := l_menu_bar.top_level_window_imp
				else
					check
						parent_was_menu_or_bar: False then
					end
				end
			end
		end

feature {EV_MENU_IMP} -- WEL Implementation

	plain_text: STRING_32
			-- Plain text of menu item (equal "N&ew" when full_text = "N&ew%TCtrl+B")
		do
			Result := internal_plain_text (True)
		ensure
			Result_not_void: Result /= Void
		end

	plain_text_without_ampersands: STRING_32
			-- Plain text of menu item (equal "New" when full_text = "N&ew%TCtrl+B")
			-- Ampersands are removed.
		do
			Result := internal_plain_text (False)
		ensure
			Result_not_void: Result /= Void
		end

	accelerator_text: STRING_32
			-- Accelerator text of menu item (equal "Ctrl+B" when full text = "New%TCtrl+B")
		local
			tab_index: INTEGER
		do
			if text /= Void then
				tab_index := text.index_of ('%T', 1)
				if tab_index = 0 then
						-- No accelerator
					create Result.make_empty
				else
					Result := text.substring (tab_index + 1, text.count)
				end
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- WEL Implementation

	internal_plain_text (keep_ampersands: BOOLEAN): STRING_32
			-- Plain text of menu item (equal "New" when full_text = "New%TCtrl+B")
			-- Set `keep_ampersands' to True to keep the ampersands.
		local
			tab_index: INTEGER
		do
			if text /= Void then
				Result := text.twin
				tab_index := Result.index_of ('%T', 1)
				if tab_index /= 0 then
					Result := Result.substring (1, tab_index - 1)
				end
				if not keep_ampersands then
					Result := remove_ampersands (Result)
				end
			else
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

feature {EV_MENU_CONTAINER_IMP, EV_MENU_IMP} -- WEL Implementation

	set_accelerator_text_position (a_value: INTEGER)
			-- Set the `accelerator_text_position' to `a_value'.
		require
			valid_value: a_value >= 0
		do
			accelerator_text_position := a_value
		ensure
			value_set: accelerator_text_position = a_value
		end

	set_plain_text_position (a_value: INTEGER)
			-- Set the `plain_text_position' to `a_value'.
		require
			valid_value: a_value >= 0
		do
			plain_text_position := a_value
		ensure
			value_set: plain_text_position = a_value
		end

	desired_height: INTEGER
			-- Desired height for this menu item
		local
			pixmap_height: INTEGER
			text_height: INTEGER
		do
			if attached real_text as l_real_text then
				text_height := menu_font.string_height (l_real_text) + 4
				if attached pixmap_imp as l_pixmap_imp then
					pixmap_height := l_pixmap_imp.height + 4 -- We add + 4 for drawing the edge when the item is selected
					Result := text_height.max (pixmap_height)
				else
					Result := text_height
				end
			end
		end

	on_measure_item (measure_item_struct: WEL_MEASURE_ITEM_STRUCT)
			-- Process `Wm_measureitem' message.
		do
			if attached {EV_MENU_IMP} parent_imp as par_imp then
				par_imp.on_measure_menu_item (measure_item_struct)
			else
				on_measure_menu_bar_item (measure_item_struct)
			end
		end

	on_draw_item (draw_item_struct: WEL_DRAW_ITEM_STRUCT)
			-- Process `Wm_drawitem' message.
		do
			if attached {EV_MENU_IMP} parent_imp as par_imp then
				on_draw_menu_item (draw_item_struct)
			else
				on_draw_menu_bar_item (draw_item_struct)
			end
		end

feature {NONE} -- WEL Implementation

	accelerator_text_position: INTEGER
			-- Position in pixels where the accelerator starts being written.

	plain_text_position: INTEGER
			-- Position in pixels where the plain text starts being written.

	erase_background (a_dc: WEL_DC; a_rect: WEL_RECT; a_background_color: WEL_COLOR_REF)
			-- Erase the background for the rectangle `a_rect' using the
			-- Device context `a_dc'. If `hilited_state' is set, use the
			-- background color corresponding to the hilited state.
		local
			a_background_brush: WEL_BRUSH
		do
			create a_background_brush.make_solid (a_background_color)
			a_dc.fill_rect (a_rect, a_background_brush)
			a_background_brush.delete
		end

	on_measure_menu_bar_item (measure_item_struct: WEL_MEASURE_ITEM_STRUCT)
			-- Get the measure for an item within a menu bar
		local
			accel_text: STRING_32
			plain_text_width: INTEGER
			accel_text_width: INTEGER
			pixmap_width: INTEGER
		do
			plain_text_width := menu_font.string_width (plain_text_without_ampersands)
			accel_text := accelerator_text
			if not accel_text.is_empty then
				accel_text_width := menu_font.string_width ({STRING_32} " "+accel_text)
			end
			if attached pixmap_imp as l_pixmap_imp then
				pixmap_width := l_pixmap_imp.width + Menu_bar_item_pixmap_text_space
			end

				-- Compute the result
			measure_item_struct.set_item_width (pixmap_width + plain_text_width + accel_text_width)
			measure_item_struct.set_item_height (desired_height)

				-- Update the tabultation margins
			set_accelerator_text_position (0)
			set_plain_text_position (pixmap_width + plain_text_width + accel_text_width)
		end

	on_draw_menu_item (draw_item_struct: WEL_DRAW_ITEM_STRUCT)
			-- Process `Wm_drawitem' message for classic menu item
			-- (i.e. not menu item in the menu bar).
		local
			draw_dc: WEL_CLIENT_DC
			draw_item_struct_rect: WEL_RECT
			draw_flags: INTEGER
			foreground_color, background_color: WEL_COLOR_REF
			left_pos, top_pos, bottom_pos, right_pos: INTEGER
			text_top_pos: INTEGER
			selected_state, disabled_state: BOOLEAN
			rect: WEL_RECT
			right_plain_text_pos: INTEGER
			space_width: INTEGER
		do
			draw_dc := draw_item_struct.dc
			draw_item_struct_rect := draw_item_struct.rect_item
			left_pos := draw_item_struct_rect.left
			right_pos := draw_item_struct_rect.right
			top_pos := draw_item_struct_rect.top
			bottom_pos := draw_item_struct_rect.bottom
			selected_state := (draw_item_struct.item_state & Wel_ownerdraw_constants.Ods_selected /= 0)
			disabled_state := (draw_item_struct.item_state & Wel_ownerdraw_constants.Ods_disabled /= 0)

				-- Draw the left part (pixmap, check mark)
			on_draw_menu_item_left_part (draw_item_struct)

				-- Draw the text part
			if attached real_text as l_real_text then
					-- Select the right colors
				if selected_state then
					background_color := system_color_highlight
					if disabled_state then
						foreground_color := system_color_btnshadow
						if foreground_color.same_color (background_color) then
							foreground_color := system_color_btnhighlight
						end
					else
						foreground_color := system_color_highlighttext
					end
				else
					background_color := system_color_menu
					foreground_color := system_color_menutext
				end

					-- Erase the text area
				create rect.make (left_pos + plain_text_position, top_pos, right_pos, bottom_pos)
				erase_background (draw_dc, rect, background_color)

					-- Set the font properties
				draw_dc.select_font (menu_font)
				draw_dc.set_background_transparent
				draw_dc.set_background_color (background_color)

					-- Compute where to put texts
				text_top_pos := top_pos + ((draw_item_struct_rect.height - menu_font.string_height (l_real_text)) // 2)

					-- Compute the drawing flags
				draw_flags := Wel_drawing_constants.Dt_left
				if draw_item_struct.item_state & Wel_ownerdraw_constants.Ods_noaccel /= 0 then
					draw_flags := draw_flags | Wel_drawing_constants.Dt_hideprefix
				end

					-- Default spacing between text and accelerator, and the right border.
					-- We use the letter `o' so that the spacing is proportional to the chosen font.
					-- See `{EV_MENU_IMP}.on_measure_menu_item'.
				space_width := menu_font.string_width ("o")
					-- Compute the right offset of the end of the plain text
				if accelerator_text_position = 0 then
					right_plain_text_pos := right_pos - space_width
				else
					right_plain_text_pos := left_pos + accelerator_text_position - space_width
				end

					-- Draw the text
				if disabled_state and not selected_state then
							-- Draw highlighted text if needed
					if system_color_menu.same_color (system_color_btnface) then
						draw_dc.set_text_color (system_color_btnhighlight)

						rect.set_rect (1 + left_pos + plain_text_position, 1 + text_top_pos, right_plain_text_pos, bottom_pos)
						draw_dc.draw_text (plain_text, rect, draw_flags)

						rect.set_rect (1 + left_pos + accelerator_text_position, 1 + text_top_pos, right_pos, bottom_pos)
						draw_dc.draw_text (accelerator_text, rect, Wel_drawing_constants.Dt_left | Wel_drawing_constants.Dt_expandtabs)
					end

						-- Draw dark text
					draw_dc.set_text_color (system_color_btnshadow)
					rect.set_rect (left_pos + plain_text_position, text_top_pos, right_plain_text_pos, bottom_pos)
					draw_dc.draw_text (plain_text, rect, draw_flags)

					if not accelerator_text.is_empty then
						rect.set_rect (left_pos + accelerator_text_position, text_top_pos, right_pos, bottom_pos)
						draw_dc.draw_text (accelerator_text, rect, Wel_drawing_constants.Dt_left | Wel_drawing_constants.Dt_expandtabs)
					end
				else
					draw_dc.set_background_color (background_color)
					draw_dc.set_text_color (foreground_color)

					rect.set_rect (left_pos + plain_text_position, text_top_pos, right_plain_text_pos, bottom_pos)
					draw_dc.draw_text (plain_text, rect, draw_flags)

					if not accelerator_text.is_empty then
						rect.set_rect (left_pos + accelerator_text_position, text_top_pos, right_pos, bottom_pos)
						draw_dc.draw_text (accelerator_text, rect, Wel_drawing_constants.Dt_left | Wel_drawing_constants.Dt_expandtabs)
					end
				end
				draw_dc.unselect_font
			end
		end

	on_draw_menu_item_left_part (draw_item_struct: WEL_DRAW_ITEM_STRUCT)
			-- Process `Wm_drawitem' message, for the left part.
			-- In the left part, one draw the pixmap, check state..
			-- or nothing.
		local
			draw_dc: WEL_CLIENT_DC
			draw_item_struct_rect: WEL_RECT
			draw_item_state: INTEGER
			wel_icon: WEL_ICON
			icon_top_position: INTEGER
			left_pos, top_pos, bottom_pos: INTEGER
			background_color: WEL_COLOR_REF
			selected_state, disabled_state: BOOLEAN
			draw_flags: INTEGER
			rect: WEL_RECT
			l_bitmap: WEL_BITMAP
		do
			draw_dc := draw_item_struct.dc
			draw_item_struct_rect := draw_item_struct.rect_item
			draw_item_state := draw_item_struct.item_state
			left_pos := draw_item_struct_rect.left
			top_pos := draw_item_struct_rect.top
			bottom_pos := draw_item_struct_rect.bottom
			selected_state := (draw_item_state & Wel_ownerdraw_constants.Ods_selected /= 0)
			disabled_state := (draw_item_state & Wel_ownerdraw_constants.Ods_disabled /= 0)

					-- First erase the background
			create rect.make (0, 0, 0, 0)
			if disabled_state and pixmap_imp /= Void and not selected_state then
				background_color := system_color_menu
			else
				background_color := system_color_highlight
			end
			if selected_state then

				rect.set_rect (left_pos, top_pos, left_pos + plain_text_position - 2, bottom_pos)
				erase_background (draw_dc, rect, background_color)
				rect.set_rect (left_pos + plain_text_position - 2, top_pos, left_pos + plain_text_position, bottom_pos)
				erase_background (draw_dc, rect, system_color_highlight)
			else
				rect.set_rect (left_pos, top_pos, left_pos + plain_text_position, bottom_pos)
				erase_background (draw_dc, rect, system_color_menu)
			end

					-- Draw the pixmap if needed
			if attached pixmap_imp as l_pixmap_imp then
				if disabled_state then
					draw_flags := Wel_drawing_constants.Dss_disabled
				else
					draw_flags := Wel_drawing_constants.Dss_normal
				end
				icon_top_position := top_pos + (draw_item_struct_rect.height - l_pixmap_imp.height - 2) // 2
				left_pos := left_pos + 1

				wel_icon := extract_icon (l_pixmap_imp)
				if disabled_state and then attached disabled_image as l_disabled_image then
					l_bitmap := l_pixmap_imp.get_bitmap
					l_disabled_image.draw_grayscale_bitmap_or_icon_with_memory_buffer (l_bitmap, wel_icon, draw_dc, left_pos, icon_top_position, background_color, l_pixmap_imp.has_mask)
					l_bitmap.decrement_reference
				else
					draw_dc.draw_state_icon (Void, wel_icon, left_pos, icon_top_position, draw_flags)
				end
				wel_icon.decrement_reference

			end
		end

	on_draw_menu_bar_item (draw_item_struct: WEL_DRAW_ITEM_STRUCT)
			-- Process `Wm_drawitem' message.
		local
			draw_dc: WEL_CLIENT_DC
			draw_item_struct_rect: WEL_RECT
			draw_flags: INTEGER
			draw_item_state: INTEGER
			rect: WEL_RECT
			left_pos, top_pos, bottom_pos, right_pos: INTEGER
			text_top_pos: INTEGER
			selected_state, disabled_state: BOOLEAN
			wel_icon: WEL_ICON
			icon_top_position: INTEGER
			text_color, background_color: WEL_COLOR_REF
			desired_width: INTEGER
			left_pos_start: INTEGER
			drawn_text: STRING_32
			flat_menu_enabled: BOOLEAN
			l_bitmap: WEL_BITMAP
		do
			draw_dc := draw_item_struct.dc
			draw_item_struct_rect := draw_item_struct.rect_item
			draw_item_state := draw_item_struct.item_state
			left_pos := draw_item_struct_rect.left
			right_pos := draw_item_struct_rect.right
			top_pos := draw_item_struct_rect.top
			bottom_pos := draw_item_struct_rect.bottom
			selected_state := (draw_item_state & Wel_ownerdraw_constants.Ods_selected /= 0)
			disabled_state := (draw_item_state & Wel_ownerdraw_constants.Ods_disabled /= 0)
			desired_width := plain_text_position -- We have used this variable to store the desired width in `on_measure_menu_bar_item'.
			left_pos_start := (right_pos - left_pos - desired_width) // 2
			flat_menu_enabled := has_flat_menu

				-- First erase the background
			if flat_menu_enabled then
				if selected_state then
					background_color := system_color_menuhilight
					text_color := system_color_highlighttext
				else
					background_color := system_color_menubar
					text_color := system_color_menutext
				end
			else
				background_color := system_color_menu
				text_color := system_color_menutext
			end
			erase_background (draw_dc, draw_item_struct_rect, background_color)

					-- Draw a border around the item for top menu when menus are not flat.
			if not (flat_menu_enabled) then
				if selected_state then
					draw_dc.draw_edge (draw_item_struct_rect, Wel_drawing_constants.Bdr_sunkenouter, Wel_drawing_constants.Bf_rect)
				elseif draw_item_state & Wel_ownerdraw_constants.Ods_hotlight /= 0 then
					draw_dc.draw_edge (draw_item_struct_rect, Wel_drawing_constants.Bdr_raisedinner, Wel_drawing_constants.Bf_rect)
				end
			end

					-- Draw the pixmap if needed
			if attached pixmap_imp as l_pixmap_imp then
				if disabled_state then
					draw_flags := Wel_drawing_constants.Dss_disabled
				else
					draw_flags := Wel_drawing_constants.Dss_normal
				end
				icon_top_position := top_pos + (draw_item_struct_rect.height - l_pixmap_imp.height) // 2

				wel_icon := extract_icon (l_pixmap_imp)
				if disabled_state and then attached disabled_image as l_disabled_image then
					l_bitmap := l_pixmap_imp.get_bitmap
					l_disabled_image.draw_grayscale_bitmap_or_icon_with_memory_buffer (l_bitmap, wel_icon, draw_dc, left_pos, icon_top_position, background_color, l_pixmap_imp.has_mask)
					l_bitmap.decrement_reference
				else
					draw_dc.draw_state_icon (Void, wel_icon, left_pos + left_pos_start, icon_top_position, draw_flags)
				end
				wel_icon.decrement_reference
				left_pos_start := left_pos_start + l_pixmap_imp.width + Menu_bar_item_pixmap_text_space
			end

				-- Draw the text part
			if attached real_text as l_real_text then
					-- Set the font properties
				draw_dc.select_font (menu_font)
				draw_dc.set_background_color (background_color)
				draw_dc.set_text_color (text_color)

					-- Compute where to put texts
				text_top_pos := top_pos + ((draw_item_struct_rect.height - menu_font.string_height (l_real_text)) // 2)
				create rect.make (left_pos + left_pos_start, text_top_pos, right_pos, bottom_pos)

					-- Compute the drawing flags
				draw_flags := Wel_drawing_constants.Dt_expandtabs | Wel_drawing_constants.Dt_left
				if draw_item_state & Wel_ownerdraw_constants.Ods_noaccel /= 0 then
					draw_flags := draw_flags | Wel_drawing_constants.Dt_hideprefix
				end

					-- Draw the text
				drawn_text := plain_text.twin
				drawn_text.append_character (' ')
				drawn_text.append (accelerator_text)
				if disabled_state then
					draw_dc.draw_disabled_text (drawn_text, rect, draw_flags)
				else
					draw_dc.draw_text (drawn_text, rect, draw_flags)
				end
				draw_dc.unselect_font
			end
		end

	disabled_image: detachable WEL_GDIP_GRAYSCALE_IMAGE_DRAWER
			-- Grayscale image drawer.
			-- Void if Gdi+ not installed.
		local
			l_gdip_starter: WEL_GDIP_STARTER
		once
			create l_gdip_starter
			if l_gdip_starter.is_gdi_plus_installed then
				create Result
			end
		end

feature {EV_ANY_I} -- Pick and Drop

	set_capture
			-- Grab user input.
			-- Works only on current windows thread.
		do
			--| To be implemented.
			--| This may work without redefinition.
			--| These have been left as re-defined to make sure it is not
			--| overlooked in the future.
			check
				To_be_implemented: False
			end
		end

	release_capture
			-- Release user input.
			-- Works only on current windows thread.
		do
			--| To be implemented.
			--| This may work without redefinition.
			--| These have been left as re-defined to make sure it is not
			--| overlooked in the future.
			check
				To_be_implemented: False
			end
		end

	set_heavy_capture
			-- Grab user input.
			-- Works on all windows threads.
		do
			--| To be implemented.
			--| This may work without redefinition.
			--| These have been left as re-defined to make sure it is not
			--| overlooked in the future.
			check
				To_be_implemented: False
			end
		end

	release_heavy_capture
			-- Release user input
			-- Works on all windows threads.
		do
			--| To be implemented.
			--| This may work without redefinition.
			--| These have been left as re-defined to make sure it is not
			--| overlooked in the future.
			check
				To_be_implemented: False
			end
		end

feature {NONE} -- Contract Support

	parent_is_sensitive: BOOLEAN
			-- is parent of `Current' sensitive?
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.is_sensitive
			end
		end

feature {EV_ANY_I} -- Implementation

	on_activate
			-- `Current' has been clicked on.
		do
			if select_actions_internal /= Void then
				select_actions_internal.call (Void)
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_MENU_ITEM note option: stable attribute end

feature {NONE} -- Implementation

	remove_ampersands (a_string: STRING_32): STRING_32
			-- Remove all single ampersands in `a_string'.
			-- Double ampersands are replaced by a single ampersand.
		local
			prv_index: INTEGER
			amp_index: INTEGER
		do
			create Result.make (a_string.count)
			from
				prv_index := 1
				amp_index := a_string.index_of ('&', prv_index)
			until
				amp_index = 0
			loop
				Result.append (a_string.substring (prv_index, amp_index - 1))
				prv_index := amp_index + 1
					-- We search at `prv_index + 1' so that double ampersands are indeed
					-- replaced by a single ampersand.
				amp_index := a_string.index_of ('&', prv_index + 1)
			end
			Result.append (a_string.substring (prv_index, a_string.count))
		end

	extract_icon (a_pixmap_imp_state: EV_PIXMAP_IMP_STATE): WEL_ICON
			-- Extract the icon from `pixmap_imp'.
		local
			l_result: detachable WEL_ICON
		do
			if attached {EV_PIXMAP_IMP} a_pixmap_imp_state as pix_imp then
				l_result := pix_imp.icon
			end
			if l_result /= Void then
				l_result.increment_reference
			else
				l_result := a_pixmap_imp_state.build_icon
				l_result.enable_reference_tracking
			end
			Result := l_result
		end

	bounds_rect: WEL_RECT
			-- Rect struct which holds boundary information
			-- This struct is shared.
		once
			create Result.make (0, 0, 0, 0)
		ensure
			result_not_void: Result /= Void
		end

	load_bounds_rect
			-- Load bounds rect.
		do
			if attached parent_imp as l_parent_imp then
				if {WEL_API}.get_menu_item_rect (Default_pointer, l_parent_imp.wel_item, l_parent_imp.index_of (interface, 1)-1, bounds_rect.item) = 0 then
					bounds_rect.set_rect (0, 0, 0, 0)
				end
			else
				bounds_rect.set_rect (0, 0, 0, 0)
			end
		end

feature {NONE} -- Constants

	Menu_bar_item_pixmap_text_space: INTEGER = 4;
			-- Space between the text and the pixmap in a menu bar item

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
