indexing
	description: "Eiffel Vision menu item. Mswindows implementation."
	status: "See notice at end of class"
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
			set_pixmap
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text,
			text
		end

	EV_ID_IMP

	EV_MENU_ITEM_ACTION_SEQUENCES_IMP
	
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

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the menu item.
		do
			base_make (an_interface)
			make_id
		end

	initialize is
			-- Initialize `is_sensitive' True.
		do
			is_sensitive := True
			is_initialized := True
			set_text ("")
		end

feature -- Access

	text: STRING is
			-- Text displayed in label.
		do
			Result := wel_text
		end
		
	object_id: INTEGER is
			-- Run-time object Id of `Current'.
		do
			if internal_object_id = 0 then
				internal_object_id := eif_object_id (Current)
			end
			Result := internal_object_id
		end
		
feature -- Element change

	set_text (a_text: STRING) is
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

	enable_sensitive is
   			-- Set current item sensitive.
		do
			is_sensitive := True
			if has_parent then
				parent_imp.enable_item (id)
			end
   		end

	disable_sensitive is
   			-- Set current item insensitive.
		do
			is_sensitive := False
			if has_parent then
				parent_imp.disable_item (id)
			end
   		end

feature -- Element change

	set_parent_imp (a_parent_imp: like parent_imp) is
			-- Make `a_parent_imp' the parent of `Current'.
		do
			if a_parent_imp /= Void then
				parent_imp := a_parent_imp
			else
				parent_imp := Void
			end
		end

feature {NONE} -- Implementation

	wel_text: STRING is
			-- Caption of the menu item.
			--| For the specification given in the note of EV_MENU_ITEM,
			--| we do not have to take any special action.
			--| Does not return internal toolkit string because it is possible
			--| to set the string without parent.
		do
			Result := clone (real_text)
		end

	real_text: STRING

	wel_set_text (a_text: STRING) is
			-- Set `text' to `a_txt'. See `wel_text'.
		do
			real_text := clone (a_text)
		end

	text_length: INTEGER is
			-- Length of text'.
		do
			Result := real_text.count
		end

	parent_imp: EV_MENU_ITEM_LIST_IMP
			-- The menu or menu-bar this item is in.

	parent: EV_MENU_ITEM_LIST is
			-- Item list containing `Current'.
		do
			if parent_imp /= Void then
				Result ?= parent_imp.interface
			end
		end

	has_parent: BOOLEAN is
			-- Is this menu item in a menu?
		do
			Result := parent_imp /= Void and then parent_imp.item_exists (id)
		end

	remove_pixmap is
			-- Remove pixmap from `Current'.
		do
			if private_pixmap /= Void then
				private_pixmap := Void
				if parent_imp /= Void then
					parent_imp.internal_replace (Current, parent_imp.index_of (interface, 1))
				end
			end
		end

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		do
			Precursor (a_pixmap)
			if parent_imp /= Void then
				parent_imp.internal_replace (Current, parent_imp.index_of (interface, 1))
			end
		end
		
	internal_object_id: INTEGER
			-- Runtime Eiffel Object Id. Zero if no call to `eif_object_id'
			-- has been made so far.
			-- This is used for drawing owner-draw menu items
			
	dispose is
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

feature {EV_MENU_IMP} -- WEL Implementation

	plain_text: STRING is
			-- Plain text of menu item (equal "N&ew" when full_text = "N&ew%TCtrl+B")
		do
			Result := internal_plain_text (True)
		ensure
			Result_not_void: Result /= Void
		end
		
	plain_text_without_ampersands: STRING is
			-- Plain text of menu item (equal "New" when full_text = "N&ew%TCtrl+B")
			-- Ampersands are removed.
		do
			Result := internal_plain_text (False)
		ensure
			Result_not_void: Result /= Void
		end
		
	accelerator_text: STRING is
			-- Accelerator text of menu item (equal "Ctrl+B" when full text = "New%TCtrl+B")
		local
			tab_index: INTEGER
		do
			if text /= Void then
				tab_index := text.index_of ('%T', 1)
				if tab_index = 0 then
						-- No accelerator
					Result := ""
				else
					Result := text.substring (tab_index + 1, text.count)
				end
			else
				Result := ""
			end
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- WEL Implementation
		
	internal_plain_text (keep_ampersands: BOOLEAN): STRING is
			-- Plain text of menu item (equal "New" when full_text = "New%TCtrl+B")
			-- Set `keep_ampersands' to True to keep the ampersands.
		local
			tab_index: INTEGER
		do
			Result := clone (text)
			if Result /= Void then
				tab_index := Result.index_of ('%T', 1)
				if tab_index /= 0 then
					Result := Result.substring (1, tab_index - 1)
				end
				if not keep_ampersands then
					Result := remove_ampersands (Result)
				end
			else
				Result := ""
			end
		ensure
			Result_not_void: Result /= Void
		end
		
feature {EV_CONTAINER_IMP, EV_MENU_IMP} -- WEL Implementation

	set_accelerator_text_position (a_value: INTEGER) is
			-- Set the `accelerator_text_position' to `a_value'.
		require
			valid_value: a_value >= 0
		do
			accelerator_text_position := a_value
		ensure
			value_set: accelerator_text_position = a_value
		end

	set_plain_text_position (a_value: INTEGER) is
			-- Set the `plain_text_position' to `a_value'.
		require
			valid_value: a_value >= 0
		do
			plain_text_position := a_value
		ensure
			value_set: plain_text_position = a_value
		end

	desired_height: INTEGER is
			-- Desired height for this menu item
		local
			pixmap_height: INTEGER
			text_height: INTEGER
		do
			text_height := menu_font.string_height (real_text) + 4
			if pixmap_imp /= Void then
				pixmap_height := pixmap_imp.height + 4 -- We add + 4 for drawing the edge when the item is selected
				Result := text_height.max (pixmap_height)
			else
				Result := text_height
			end
		end

	on_measure_item (measure_item_struct: WEL_MEASURE_ITEM_STRUCT) is
			-- Process `Wm_measureitem' message.
		local
			par_imp: EV_MENU_IMP
		do
			par_imp ?= parent_imp
			if par_imp /= void then
				par_imp.on_measure_menu_item (measure_item_struct)
			else
				on_measure_menu_bar_item (measure_item_struct)
			end
		end
		
	on_draw_item (draw_item_struct: WEL_DRAW_ITEM_STRUCT) is
			-- Process `Wm_drawitem' message.
		local
			par_imp: EV_MENU_IMP
		do
			par_imp ?= parent_imp
			if par_imp /= void then
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

	erase_background (a_dc: WEL_DC; a_rect: WEL_RECT; a_background_color: WEL_COLOR_REF) is
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

	on_measure_menu_bar_item (measure_item_struct: WEL_MEASURE_ITEM_STRUCT) is
			-- Get the measure for an item within a menu bar
		local
			accel_text: STRING
			plain_text_width: INTEGER
			accel_text_width: INTEGER
			pixmap_width: INTEGER
		do
			plain_text_width := menu_font.string_width (plain_text_without_ampersands)
			accel_text := accelerator_text
			if not accel_text.is_empty then
				accel_text_width := menu_font.string_width (" "+accel_text)
			end
			if pixmap_imp /= Void then
				pixmap_width := pixmap_imp.width + Menu_bar_item_pixmap_text_space
			end
			
				-- Compute the result
			measure_item_struct.set_item_width (pixmap_width + plain_text_width + accel_text_width)
			measure_item_struct.set_item_height (desired_height)
			
				-- Update the tabultation margins
			set_accelerator_text_position (0)
			set_plain_text_position (pixmap_width + plain_text_width + accel_text_width)
		end
		
	on_draw_menu_item (draw_item_struct: WEL_DRAW_ITEM_STRUCT) is
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
			border_width: INTEGER
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
			if real_text /= void then
					-- Select the right colors
				if selected_state then
					background_color := system_color_highlight
					if disabled_state then
						foreground_color := system_color_btnshadow
						if foreground_color.is_equal (background_color) then
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
				text_top_pos := top_pos + ((draw_item_struct_rect.height - menu_font.string_height (real_text)) // 2)
				
					-- Compute the drawing flags
				draw_flags := Wel_drawing_constants.Dt_left
				if draw_item_struct.item_state & Wel_ownerdraw_constants.Ods_noaccel /= 0 then
					draw_flags := draw_flags | Wel_drawing_constants.Dt_hideprefix
				end

					-- Compute the right offset of the end of the plain text
				if accelerator_text_position = 0 then
					border_width := menu_font.string_width ("WC")
					right_plain_text_pos := right_pos - border_width
				else
					space_width := menu_font.string_width ("W")
					right_plain_text_pos := left_pos + accelerator_text_position - space_width
				end
				
					-- Draw the text
				if disabled_state and not selected_state then
							-- Draw highlighted text if needed
					if system_color_menu.is_equal (system_color_btnface) then
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

					rect.set_rect (left_pos + accelerator_text_position, text_top_pos, right_pos, bottom_pos)
					draw_dc.draw_text (accelerator_text, rect, Wel_drawing_constants.Dt_left | Wel_drawing_constants.Dt_expandtabs)
				else
					draw_dc.set_background_color (background_color)
					draw_dc.set_text_color (foreground_color)
	
					rect.set_rect (left_pos + plain_text_position, text_top_pos, right_plain_text_pos, bottom_pos)
					draw_dc.draw_text (plain_text, rect, draw_flags)

					rect.set_rect (left_pos + accelerator_text_position, text_top_pos, right_pos, bottom_pos)
					draw_dc.draw_text (accelerator_text, rect, Wel_drawing_constants.Dt_left | Wel_drawing_constants.Dt_expandtabs)
				end
				draw_dc.unselect_font
			end
		end

	on_draw_menu_item_left_part (draw_item_struct: WEL_DRAW_ITEM_STRUCT) is
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
			if selected_state then
				if disabled_state and pixmap_imp /= Void then
					background_color := system_color_menu
				else
					background_color := system_color_highlight
				end
				rect.set_rect (left_pos, top_pos, left_pos + plain_text_position - 2, bottom_pos)
				erase_background (draw_dc, rect, background_color)
				rect.set_rect (left_pos + plain_text_position - 2, top_pos, left_pos + plain_text_position, bottom_pos)
				erase_background (draw_dc, rect, system_color_highlight)
			else
				rect.set_rect (left_pos, top_pos, left_pos + plain_text_position, bottom_pos)
				erase_background (draw_dc, rect, system_color_menu)
			end
				
					-- Draw the pixmap if needed
			if pixmap_imp /= Void then
				if disabled_state then
					draw_flags := Wel_drawing_constants.Dss_disabled
				else
					draw_flags := Wel_drawing_constants.Dss_normal
				end
				icon_top_position := top_pos + (draw_item_struct_rect.height - pixmap_imp.height - 2) // 2
				wel_icon := extract_icon (pixmap_imp)
				draw_dc.draw_state_icon (Void, wel_icon, 1 + left_pos, icon_top_position, draw_flags)
				wel_icon.decrement_reference
			end
		end

	on_draw_menu_bar_item (draw_item_struct: WEL_DRAW_ITEM_STRUCT) is
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
			drawn_text: STRING
			flat_menu_enabled: BOOLEAN
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
			if is_windows_xp_compatible and flat_menu_enabled then
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
			if not (is_windows_xp_compatible and flat_menu_enabled) then
				if selected_state then
					draw_dc.draw_edge (draw_item_struct_rect, Wel_drawing_constants.Bdr_sunkenouter, Wel_drawing_constants.Bf_rect)
				elseif draw_item_state & Wel_ownerdraw_constants.Ods_hotlight /= 0 then
					draw_dc.draw_edge (draw_item_struct_rect, Wel_drawing_constants.Bdr_raisedinner, Wel_drawing_constants.Bf_rect)
				end
			end
				
					-- Draw the pixmap if needed
			if pixmap_imp /= Void then
				if disabled_state then
					draw_flags := Wel_drawing_constants.Dss_disabled
				else
					draw_flags := Wel_drawing_constants.Dss_normal
				end
				icon_top_position := top_pos + (draw_item_struct_rect.height - pixmap_imp.height) // 2
				wel_icon := extract_icon (pixmap_imp)
				draw_dc.draw_state_icon (Void, wel_icon, left_pos + left_pos_start, icon_top_position, draw_flags)
				wel_icon.decrement_reference
				left_pos_start := left_pos_start + pixmap_imp.width + Menu_bar_item_pixmap_text_space
			end

				-- Draw the text part
			if real_text /= void then
					-- Set the font properties
				draw_dc.select_font (menu_font)
				draw_dc.set_background_color (background_color)
				draw_dc.set_text_color (text_color)

					-- Compute where to put texts
				text_top_pos := top_pos + ((draw_item_struct_rect.height - menu_font.string_height (real_text)) // 2)
				create rect.make (left_pos + left_pos_start, text_top_pos, right_pos, bottom_pos)
				
					-- Compute the drawing flags
				draw_flags := Wel_drawing_constants.Dt_expandtabs | Wel_drawing_constants.Dt_left
				if draw_item_state & Wel_ownerdraw_constants.Ods_noaccel /= 0 then
					draw_flags := draw_flags | Wel_drawing_constants.Dt_hideprefix
				end
				
					-- Draw the text
				drawn_text := clone (plain_text)
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

feature {EV_ANY_I} -- Pick and Drop

	set_capture is
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

	release_capture is
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

	set_heavy_capture is
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

	release_heavy_capture is
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

	parent_is_sensitive: BOOLEAN is
			-- is parent of `Current' sensitive?
		do
			if parent_imp /= Void then
				Result := parent_imp.is_sensitive
			end
		end

feature {EV_ANY_I} -- Implementation

	on_activate is
			-- `Current' has been clicked on.
		do
			if select_actions_internal /= Void then
				select_actions_internal.call ([])
			end
		end

	interface: EV_MENU_ITEM
	
feature {NONE} -- Implementation

	remove_ampersands (a_string: STRING): STRING is
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
				amp_index := a_string.index_of ('&', prv_index)
			end
			Result.append (a_string.substring (prv_index, a_string.count))
		end
		
	extract_icon (a_pixmap_imp_state: EV_PIXMAP_IMP_STATE): WEL_ICON is
			-- Extract the icon from `pixmap_imp'.
		local
			pix_imp: EV_PIXMAP_IMP
		do
			pix_imp ?= a_pixmap_imp_state
			if pix_imp /= Void then
				Result := pix_imp.icon
				Result.increment_reference
			end
			if Result = Void then
				Result := a_pixmap_imp_state.build_icon
				Result.enable_reference_tracking
			end
		end
		
feature {NONE} -- Constants

	Menu_bar_item_pixmap_text_space: INTEGER is 4
			-- Space between the text and the pixmap in a menu bar item
		
end -- class EV_MENU_ITEM_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

