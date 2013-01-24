note
	description:
		"EiffelVision notebook, Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_NOTEBOOK_IMP

inherit
	EV_NOTEBOOK_I
		redefine
			interface,
			is_usable
		end

	EV_WIDGET_LIST_IMP
		undefine
			is_usable,
			count
		redefine
			enable_sensitive,
			disable_sensitive,
			set_default_minimum_size,
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size,
			on_size,
			interface,
			child_added,
			make,
			insert_i_th,
			remove_i_th,
			i_th,
			next_tabstop_widget,
			return_current_if_next_tabstop_widget
		end

	EV_FONTABLE_IMP
		undefine
			is_usable
		redefine
			set_font,
			interface
		end

	WEL_TAB_CONTROL
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			font as wel_font,
			set_font as wel_set_font,
			shown as is_displayed,
			destroy as wel_destroy,
			item as wel_item,
			enabled as is_sensitive,
			width as wel_width,
			height as wel_height,
			x as x_position,
			y as y_position,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			on_desactivate as wel_on_desactivate,
			has_capture as wel_has_capture
		undefine
			set_width,
			set_height,
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_key_up,
			on_set_cursor,
			on_draw_item,
			on_color_control,
			on_set_focus,
			on_kill_focus,
			on_wm_vscroll,
			on_wm_hscroll,
			on_key_down,
			on_mouse_wheel,
			on_char,
			show,
			hide,
			on_destroy,
			on_size,
			background_brush,
			background_brush_gdip,
			x_position,
			y_position,
			on_sys_key_down,
			on_sys_key_up,
			on_notify,
			default_process_message,
			on_wm_dropfiles
		redefine
			default_style,
			default_ex_style,
			hide_current_selection,
			on_tcn_selchange,
			on_wm_theme_changed,
			on_erase_background,
			count
		end

	WEL_TCIF_CONSTANTS
		export
			{NONE} all
		end

	WEL_VK_CONSTANTS
		export
			{NONE} all
		end

	WEL_ILC_CONSTANTS
		export
			{NONE} all
		end

	EV_SHARED_IMAGE_LIST_IMP
		export
			{NONE} all
		end

	EV_NOTEBOOK_ACTION_SEQUENCES_IMP

create
	make


feature -- Initialization

	old_make (an_interface: like interface)
			-- Create `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			create ev_children.make (2)
			tab_pos := {EV_NOTEBOOK}.tab_top
			initialize_pixmaps
			index := 0

				-- Retrieve the theme for the tab.
			wel_make (default_parent, 0, 0, 0, 0, 0)
			open_theme := application_imp.theme_drawer.open_theme_data (wel_item, "Tab")

			Precursor {EV_WIDGET_LIST_IMP}
			check_notebook_assertions := True
		end

feature {EV_ANY_I} --  Access

	top_level_window_imp: detachable EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	tab_pos: INTEGER
			-- Actual position of the tabs.

feature -- Status report

	count: INTEGER
			-- <Precursor>
		do
			Result := ev_children.count
		end

feature {EV_ANY_I} -- Status report

	current_page: INTEGER
			-- One-based index of the currently opened page.
		do
			Result := current_selection + 1
		end

	tab_position: INTEGER
			-- Position of the tabs.
		do
			Result := tab_pos
		end

	pointed_tab_index: INTEGER
			-- index of tab currently under mouse pointer, or 0 if none.
		local
			hit_test_info: WEL_TC_HITTESTINFO
			point: WEL_POINT
		do
			create point.make_by_cursor_position
			point.set_x (point.x - screen_x)
			point.set_y (point.y - screen_y)
			create hit_test_info.make_with_point (point)
			Result := {WEL_API}.send_message_result_integer (wel_item, tcm_hittest, to_wparam (0), hit_test_info.item) + 1
		end

	item_tab (an_item: EV_WIDGET): EV_NOTEBOOK_TAB
			-- Tab associated with `an_item'.
		do
			create Result.make_with_widgets (attached_interface, an_item)
		end

feature {EV_ANY_I} -- Status setting

	set_default_minimum_size
			-- Set the current minimum size.
		do
			internal_set_font
			if tab_pos = {EV_NOTEBOOK}.Tab_top
					or else tab_pos = {EV_NOTEBOOK}.Tab_bottom then
				ev_set_minimum_height (tab_height, False)
			else
				ev_set_minimum_width (tab_height, False)
			end
		end

	set_tab_position (pos: INTEGER)
			-- set position of tabs (left, right, top or bottom) according
			-- to value of `pos'.
		local
			ww: detachable EV_WIDGET_IMP
		do
 			tab_pos := pos
 			set_style (basic_style)
			internal_set_font
			ww ?= selected_window
			notify_change (Nc_minsize, ww, False)
		end

	set_current_page (an_index: INTEGER)
			-- Make the `an_index'-th page the currently opened page.
		do
			set_current_selection (an_index - 1)
		end

	set_insensitive (flag: BOOLEAN)
			-- Set current widget in insensitive mode if
   			-- `flag', otherwise make sensitive.
		local
			counter: INTEGER
			child_imp: detachable EV_WIDGET_IMP
		do
			if not is_sensitive /= flag then
				from
					counter := 1
				until
					counter > count
				loop
					child_imp := ev_children.i_th (counter)
					if flag then
						child_imp.disable_sensitive
					else
						child_imp.enable_sensitive
					end
					counter := counter + 1
				end
			end
		end

	enable_sensitive
			-- Enable notebook.
		do
			set_insensitive (False)
			Precursor {EV_WIDGET_LIST_IMP}
		end

	disable_sensitive
			-- Disable notebook.
		do
			set_insensitive (True)
			Precursor {EV_WIDGET_LIST_IMP}
		end

feature {EV_ANY_I} -- Element change

	set_font (f: EV_FONT)
			-- Set `font' to `f'.
			-- When the tabs are vertical, we set back the default font
			-- by using `{WEL_API}.send_message' (feature not implemented in WEL)
			-- because vertical fonts doesn't work with everything.
		do
			private_font := f
			internal_set_font
		end

	set_top_level_window_imp (a_window: detachable EV_WINDOW_IMP)
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		local
			counter: INTEGER
			child_imp: detachable EV_WIDGET_IMP
		do
			top_level_window_imp := a_window
			from
				counter := 1
			until
				counter > count
			loop
				child_imp := ev_children.i_th (counter)
				child_imp.set_top_level_window_imp (a_window)
				counter := counter + 1
			end
		end

feature {EV_ANY_I} -- Basic operation

	get_child_index (a_child: EV_WIDGET_IMP): INTEGER
			-- `Result' is 1 based index of `a_child' in `Current' or 0 if not
			-- contained.
		require
			valid_child: is_child (a_child)
		local
			test: BOOLEAN
			child_imp: detachable EV_WIDGET_IMP
			nb: INTEGER
		do
			from
				Result := 0
				nb := count
			until
				test or else Result = nb
			loop
				child_imp := ev_children.i_th (Result + 1)
				test := a_child = child_imp
				Result := Result + 1
			end
			if not test then
					-- If we can't find the widget then return 0.
				Result := 0
			end
		end

feature -- Assertion features

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN
			-- Is `a_child' a child of `Current'?
			-- We cannot use the usual context.
			-- A child is a child if the notebook is
			-- its parent.
		local
			counter: INTEGER
			child_imp: detachable EV_WIDGET_IMP
		do
			from
				counter := 1
			until
				(counter > count) or Result
			loop
				child_imp := ev_children.i_th (counter)
				Result := a_child = child_imp
				counter := counter + 1
			end
		end

	child_added (a_child: EV_WIDGET_IMP): BOOLEAN
			-- Has `a_child' been added properly?
		do
			Result := not a_child.is_show_requested
		end

feature {NONE} -- Implementation

	compute_minimum_width (a_is_size_forced: BOOLEAN)
			-- Recompute the minimum_width of `Current'.
		local
			child_imp: detachable EV_WIDGET_IMP
			counter, nb, value: INTEGER
		do
			from
				counter := 1
				nb := count
			until
				counter > nb
			loop
				child_imp := ev_children.i_th (counter)
				value := child_imp.minimum_width.max (value)
				counter := counter + 1
			end

				-- We found the biggest child.
			if
				tab_pos = {EV_NOTEBOOK}.Tab_right
				or else tab_pos = {EV_NOTEBOOK}.Tab_left
			then
				ev_set_minimum_width (value + tab_height + 4, a_is_size_forced)
			else
				ev_set_minimum_width (value + 6, a_is_size_forced)
			end
		end

	compute_minimum_height (a_is_size_forced: BOOLEAN)
			-- Recompute the minimum_height of `Current'.
		local
			counter: INTEGER
			child_imp: detachable EV_WIDGET_IMP
			value: INTEGER
		do
			from
				counter := 1
				value := 0
			until
				counter > count
			loop
				child_imp := ev_children.i_th (counter)
				value := child_imp.minimum_height.max (value)
				counter := counter + 1
			end

				-- We found the biggest child.
			if
				tab_pos = {EV_NOTEBOOK}.Tab_top
				or else tab_pos = {EV_NOTEBOOK}.Tab_bottom
			then
				ev_set_minimum_height (value + tab_height + 4, a_is_size_forced)
			else
				ev_set_minimum_height (value + 6, a_is_size_forced)
			end
		end

	compute_minimum_size (a_is_size_forced: BOOLEAN)
			-- Recompute both the minimum_width and then
			-- minimum_height of `Current'.
		local
			counter: INTEGER
			child_imp: detachable EV_WIDGET_IMP
			mw, mh: INTEGER
		do
			from
				counter := 1
				mw := 0; mh := 0
			until
				counter > count
			loop
				child_imp := ev_children.i_th (counter)
				mw := child_imp.minimum_width.max (mw)
				mh := child_imp.minimum_height.max (mh)
				counter := counter + 1
			end

			-- We found the biggest child.
			if
				tab_pos = {EV_NOTEBOOK}.Tab_top
				or else tab_pos = {EV_NOTEBOOK}.Tab_bottom
			then
				ev_set_minimum_size (mw + 6, mh + tab_height + 4, a_is_size_forced)
			elseif
				tab_pos = {EV_NOTEBOOK}.Tab_left
				or else tab_pos = {EV_NOTEBOOK}.Tab_right
			then
				ev_set_minimum_size (mw + tab_height + 4, mh + 6, a_is_size_forced)
			end
		end

	ev_apply_new_size (a_x_position, a_y_position,
				a_width, a_height: INTEGER; repaint: BOOLEAN)
				-- Apply new size when minimum size changed but not size.
		do
				-- Resize ourself first.
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			resize_children (False)
		end

	resize_children (from_on_size: BOOLEAN)
			-- Resize children to match `sheet_rect'.
		local
			i: INTEGER
			tab_rect: WEL_RECT
			child_imp: detachable EV_WIDGET_IMP
		do
			from
				tab_rect := sheet_rect
				i := 1
			until
				i > count
			loop
				child_imp := ev_children.i_th (i)
				if from_on_size then
					child_imp.set_move_and_size (tab_rect.x, tab_rect.y, tab_rect.width, tab_rect.height)
				else
					child_imp.ev_apply_new_size (tab_rect.x, tab_rect.y, tab_rect.width, tab_rect.height, child_imp.is_displayed)
				end
				if not child_imp.is_show_requested then
						-- Hidden notebook items don't get a proper size if we don't force a resizing.
					child_imp.wel_move_and_resize (tab_rect.x, tab_rect.y, tab_rect.width, tab_rect.height, child_imp.is_displayed)
				end
				i := i + 1
			end
		end

feature {NONE} -- WEL Implementation

 	default_style: INTEGER
 			-- Default windows style used to create `Current'.
		do
			Result := Ws_child + Ws_group + Ws_tabstop
				+ Ws_visible + Ws_clipchildren + Ws_clipsiblings
				+ Tcs_singleline
		end

 	default_ex_style: INTEGER
 			-- Default windows style used to create `Current'.
		do
			Result := Ws_ex_controlparent
		end

 	basic_style: INTEGER
 			-- Default style used to create the control
 		do
 			Result := Ws_child + Ws_group + Ws_tabstop
				+ Ws_clipchildren + Ws_clipsiblings
				+ Ws_visible
			if tab_pos = {EV_NOTEBOOK}.tab_top then
				Result := Result + Tcs_singleline
			elseif tab_pos = {EV_NOTEBOOK}.tab_bottom then
 				Result := Result + Tcs_bottom + Tcs_singleline
 			elseif tab_pos = {EV_NOTEBOOK}.tab_left then
 				Result := Result + Tcs_vertical + Tcs_fixedwidth
					+ Tcs_multiline
			elseif tab_pos = {EV_NOTEBOOK}.tab_right then
 				Result := Result + Tcs_right + Tcs_vertical
					+ Tcs_fixedwidth + Tcs_multiline
 			end
 		end

	tab_height: INTEGER
			-- The height of the tabs in `Tab_top' or `Tab_bottom' status,
			-- the width of the tabs otherwise.
		do

			if tab_pos = {EV_NOTEBOOK}.Tab_top then
				Result := sheet_rect.top - client_rect.top
			elseif tab_pos = {EV_NOTEBOOK}.Tab_left then
				Result := sheet_rect.left - client_rect.left
			elseif tab_pos = {EV_NOTEBOOK}.Tab_bottom then
				Result := client_rect.bottom - sheet_rect.bottom
			elseif tab_pos = {EV_NOTEBOOK}.Tab_right then
				Result := client_rect.right - sheet_rect.right
			else
				Result := 0
			end
		end

	hide_current_selection
			-- Hide the currently selected page.
		local
			ww: detachable EV_WIDGET_IMP
		do
			ww ?= selected_window
			if ww /= Void and then ww.exists then
				ww.show_window (ww.wel_item, Sw_hide)
			end
		end

	on_size (size_type, a_width, a_height: INTEGER)
			-- `Current' has been resized.
		do
			resize_children (True)
			Precursor {EV_WIDGET_LIST_IMP} (size_type, a_width, a_height)
		end

	on_tcn_selchange
			-- Selection has changed.
			-- Shows the current selected page by default.
		local
			ww: detachable EV_WIDGET_IMP
		do
			ww ?= selected_window
			check ww /= Void end
			ww.show_window (ww.wel_item, sw_show)

			if selection_actions_internal /= Void then
				selection_actions.call (Void)
			end
		end

feature {NONE} -- Feature that should be directly implemented by externals

	get_wm_hscroll_code (wparam, lparam: POINTER): INTEGER
			-- Encapsulation of the external cwin_get_wm_hscroll_code.
		do
			Result := cwin_get_wm_hscroll_code (wparam, lparam)
		end

	get_wm_hscroll_hwnd (wparam, lparam: POINTER): POINTER
			-- Encapsulation of the external cwin_get_wm_hscroll_hwnd
		do
			Result := cwin_get_wm_hscroll_hwnd (wparam, lparam)
		end

	get_wm_hscroll_pos (wparam, lparam: POINTER): INTEGER
			-- Encapsulation of the external cwin_get_wm_hscroll_pos
		do
			Result := cwin_get_wm_hscroll_pos (wparam, lparam)
		end

	get_wm_vscroll_code (wparam, lparam: POINTER): INTEGER
			-- Encapsulation of the external cwin_get_wm_vscroll_code.
		do
			Result := cwin_get_wm_vscroll_code (wparam, lparam)
		end

	get_wm_vscroll_hwnd (wparam, lparam: POINTER): POINTER
			-- Encapsulation of the external cwin_get_wm_vscroll_hwnd
		do
			Result := cwin_get_wm_vscroll_hwnd (wparam, lparam)
		end

	get_wm_vscroll_pos (wparam, lparam: POINTER): INTEGER
			-- Encapsulation of the external cwin_get_wm_vscroll_pos
		do
			Result := cwin_get_wm_vscroll_pos (wparam, lparam)
		end

	check_notebook_assertions: BOOLEAN
		-- Are assertions for `Current' from Ev_NOTEBOOK_I going to be checked?

	disable_notebook_assertions
			-- Effectively turn of assertions from EV_NOTEBOOK_I
		do
			check_notebook_assertions := False
		end

	enable_notebook_assertions
			-- Effectively turn on assertions from EV_NOTEBOOK_I
		do
			check_notebook_assertions := True
		end

	is_usable: BOOLEAN
			-- Is `Current' usable?
		do
			if check_notebook_assertions then
				Result := Precursor {EV_NOTEBOOK_I}
			end
		end

feature {NONE} -- Implementation

	ev_children: ARRAYED_LIST [EV_WIDGET_IMP]
			-- Internal list of children.

	i_th (i: INTEGER): EV_WIDGET
			-- `Result' is item at `i'-th position.
		do
			Result := ev_children.i_th (i).attached_interface
		end

	insert_i_th (v: attached like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			wel_tci: detachable WEL_TAB_CONTROL_ITEM
			wel_win: detachable WEL_WINDOW
			v_imp: detachable EV_WIDGET_IMP
		do
				-- Should `v' be a pixmap,
				-- promote implementation to EV_WIDGET_IMP.
			v.implementation.on_parented

			v_imp ?= v.implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			ev_children.go_i_th (i)
			ev_children.put_left (v_imp)
			wel_win ?= v_imp
			check
				wel_win_not_void: wel_win /= Void
			end
			create wel_tci.make
			wel_tci.set_text ("")
			wel_tci.set_window (wel_win)
			insert_item (i - 1, wel_tci)
			v_imp.wel_set_parent (Current)
			v_imp.set_top_level_window_imp (top_level_window_imp)
				-- If another item is already selected, we need to ensure
				-- that we hide `v_imp' as otherwise, it may appear to be the
				-- widget of the currently selected tab, when it should not be
				-- displayed as its tab is not selected.
			if selected_item_index /= i then
				v_imp.show_window (v_imp.wel_item, Sw_hide)
			end
			notify_change (Nc_minsize, v_imp, False)
				-- Call `new_item_actions' on `Current'.
			new_item_actions.call ([v])
		end

	remove_i_th (i: INTEGER)
			-- Remove item at `i'-th position.
		local
			v_imp: detachable EV_WIDGET_IMP
			wel_win: detachable WEL_WINDOW
		do
			v_imp ?= i_th (i).implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			wel_win ?= v_imp
			check
				wel_win_not_void: wel_win /= Void
			end
			remove_item_actions.call ([v_imp.attached_interface])
			ev_children.go_i_th (i)
			ev_children.remove
			disable_notebook_assertions
			if selected_item_index = i then
				if selected_item_index > 1 then
					set_current_page (selected_item_index - 1)
				elseif count > selected_item_index then
					set_current_page (selected_item_index + 1)
				end
			end
			delete_item (i - 1)
				-- | FIXME The WEL_TAB_CONTROL hides and
				-- shows the children depending on if the current tab is visible.
				-- The next line ensures that when we remove the child,
				-- it is always made visible again. This ignores the actual
				-- state of the child set from Vision2, so at some point, we need
				-- to fix this. This behaviour is deemed to be better than always being hidden.
				-- Julian
			v_imp.show
			v_imp.wel_set_parent (Default_parent)
			enable_notebook_assertions
			notify_change (Nc_minsize, v_imp, False)
		end

feature {EV_NOTEBOOK_TAB_IMP} -- Implementation

	selected_item_index: INTEGER
			-- One based index of topmost page.	
		do
			Result := current_page
		end

	select_item (v: like item)
			-- Select page containing `v'.
		local
			an_index: INTEGER
			child_imp: detachable EV_WIDGET_IMP
		do
			child_imp ?= v.implementation
			check
				child_imp_not_void: child_imp /= Void
			end
			an_index := get_child_index (child_imp)
				-- Only select a page if it is not already selected.
			if an_index /= selected_item_index then
				set_current_selection (an_index - 1)
			end
		end

	set_item_text (v: like item; a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to the label for `an_item'.
		local
			a_wel_item: WEL_TAB_CONTROL_ITEM
			child_index: INTEGER
			item_imp: detachable EV_WIDGET_IMP
		do
			item_imp ?= v.implementation
			check item_imp /= Void end
			child_index := get_child_index (item_imp)
			create a_wel_item.make
			a_wel_item.set_text (a_text)
			a_wel_item.set_mask (Tcif_text)
			update_item (child_index - 1, a_wel_item)
		end

	image_list: detachable EV_IMAGE_LIST_IMP
		-- Image list associated with `Current'.
		-- `Void' if none.

	set_item_pixmap (v: EV_WIDGET; a_pixmap: detachable EV_PIXMAP)
			-- Assign `a_text' to the label for `an_item'.
		require else
			has_an_item: has (v)
		local
			a_wel_item: WEL_TAB_CONTROL_ITEM
			child_index: INTEGER
			item_imp: detachable EV_WIDGET_IMP
			l_image_list: like image_list
		do
			item_imp ?= v.implementation
			check item_imp /= Void end
			child_index := get_child_index (item_imp)
			create a_wel_item.make
				-- Ensure that the item mask allows `iimage' to be a required member.
			a_wel_item.set_mask (tcif_image)

			if a_pixmap /= Void then
				l_image_list := image_list
				if l_image_list = Void then
						-- If no image list is associated with `Current', retrieve
						-- and associate one.
					l_image_list := get_imagelist_with_size (pixmaps_width, pixmaps_height)
					check l_image_list /= Void end
					image_list := l_image_list
					{WEL_API}.send_message (wel_item, tcm_setimagelist, to_wparam (0), l_image_list.item)
				end
				l_image_list.add_pixmap (a_pixmap)
					-- Set the `iimage' to the index of the image to be used
					-- from the image list.
				a_wel_item.set_iimage (l_image_list.last_position)
			else
					-- An `iimage' value of -1 signifies that no image
					-- is associated with a tab.
				a_wel_item.set_iimage (-1)
			end

				-- Update status of tab item.
			update_item (child_index - 1, a_wel_item)
		end

	item_pixmap (v: like item): detachable EV_PIXMAP
			-- `Result' is pixmap associated with `Current' or `Void' if none.
		require
			has_an_item: has (v)
		local
			a_wel_item: WEL_TAB_CONTROL_ITEM
			image_icon: WEL_ICON
			image_index: INTEGER
			pix_imp: detachable EV_PIXMAP_IMP
			l_image_list: like image_list
		do
			l_image_list := image_list
			if l_image_list /= Void then
				create a_wel_item.make
					-- Ensure the mask is set so the `iitem' state is retrieved.
				a_wel_item.set_mask (tcif_image)
					-- Note that `get_item' is not used as this does not set the `mask' enabling
					-- `iimage' to be returned. I did not want to change the behaviour in WEL_TAB_CONTROL_ITEM
					-- to avoid breaking something. Julian
				{WEL_API}.send_message (wel_item, Tcm_getitem, to_wparam (index_of (v, 1) - 1), a_wel_item.item)
				image_index := a_wel_item.iimage
					-- `image_index' may be -1 in the case where a tab does not have an associated image.
					-- If so, there is nothing to do as the returned pixmap must be `Void'.
				if image_index >= 0 then
						-- An image index greater or equal to zero indicates an image is used,
						-- so we retrieve this image and
					image_icon := l_image_list.get_icon (image_index, Ild_normal)
					create Result
					pix_imp ?= Result.implementation
					check
						pix_imp /= Void
					end
					image_icon.enable_reference_tracking
					pix_imp.set_with_resource (image_icon)
					image_icon.decrement_reference
				end
			end
		end

	pixmaps_size_changed
			-- Size of pixmaps displayed in tabs of `Current' has changed
			-- so update to reflect this new size.
		do
			cwin_set_item_size (wel_item, label_index_rect.width, pixmaps_height.max (font.height))
			set_default_minimum_size
		end

	item_text (v: like item): STRING_32
			-- Label of `v'.
		local
			a_wel_item: WEL_TAB_CONTROL_ITEM
			child_index: INTEGER
			item_imp: detachable EV_WIDGET_IMP
		do
			item_imp ?= v.implementation
			check item_imp /= Void end
			child_index := get_child_index (item_imp)
			a_wel_item := get_item (child_index - 1)
			Result := a_wel_item.text
		end

	selected_item: detachable like item
			-- Page displayed topmost.
		do
			Result := ev_children.i_th (current_selection + 1).interface
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
			if application_imp.themes_active then
					-- On Windows XP when thems are active, the tab control draws
					-- all of its background itself. Therefore we do not need to paint anything.
					-- This helps to reduce flicker.
				disable_default_processing
				set_message_return_value (to_lresult (1))
			else
				Precursor {WEL_TAB_CONTROL} (paint_dc, invalid_rect)
			end
		end

	on_wm_theme_changed
			-- `Wm_themechanged' message received by Windows so update current theming.
		do
			application_imp.theme_drawer.close_theme_data (open_theme)
			application_imp.update_theme_drawer
			open_theme := application_imp.theme_drawer.open_theme_data (wel_item, "Tab")
		end

	next_tabstop_widget (start_widget: EV_WIDGET; search_pos: INTEGER; forwards: BOOLEAN): EV_WIDGET_IMP
			-- Return the next widget that may by tabbed to as a result of pressing the tab key from `start_widget'.
			-- `search_pos' is the index where searching must start from for containers, and `forwards' determines the
			-- tabbing direction. If `search_pos' is less then 1 or more than `count' for containers, the parent of the
			-- container must be searched next.
		require else
			valid_search_pos: search_pos >= 0 and search_pos <= count + 1
		local
			w: detachable EV_WIDGET
			w_imp: detachable EV_WIDGET_IMP
			container: detachable EV_CONTAINER
			l_result: detachable EV_WIDGET_IMP
		do
			l_result := return_current_if_next_tabstop_widget (start_widget, search_pos, forwards)
			if l_result = Void and is_sensitive then
					-- Otherwise iterate through children and search each but only if
					-- we are sensitive. In the case of a non-sensitive container, no
					-- children should recieve the tab stop.
				from
					go_i_th (search_pos)
				until
					off or l_result /= Void
				loop
					if index = selected_item_index then
							-- We only need to search the item if it is the currently
							-- selected item, as all other items may not be tabbed to.
						w := item
						check w /= Void end
						w_imp ?= w.implementation
						check w_imp /= Void end
						if forwards then
							l_result := w_imp.next_tabstop_widget (start_widget, 1, forwards)
						else
							container ?= w_imp.interface
							if container /= Void then
								l_result := w_imp.next_tabstop_widget (start_widget, container.count, forwards)
							else
								l_result := w_imp.next_tabstop_widget (start_widget, 1, forwards)
							end
						end
					end
					if l_result = Void then
						if forwards then
							forth
						else
							back
						end
					end
				end
			end
			if l_result = Void then
				l_result := next_tabstop_widget_from_parent (start_widget, search_pos, forwards)
			end
			check l_result /= Void end
			Result := l_result
		end

	return_current_if_next_tabstop_widget (start_widget: EV_WIDGET; search_pos: INTEGER; forwards: BOOLEAN): detachable EV_WIDGET_IMP
			-- If `Current' is not equal to `start_widget' then return `Current' but only if `search_pos' is 1 and `forwards' or
			-- `search_pos' is 0 and not `forwards. This ensures that we return a container in the correct order (before or after)
			-- its children dependent on the state of `forwards'.
		do
			if attached_interface /= start_widget then
				if (forwards and search_pos = 1) or (not forwards and search_pos < selected_item_index) then
						-- We perform special handling here for notebooks, as only the `selected_item_index' tab
						-- needs to be searched within the notebook. That is why we check `search_pos' against
						-- `selected_item_index'. The standard version for widget lists checks against 0.
					if has_tabstop then
						Result := Current
					end
				end
			else
				Result := Precursor {EV_WIDGET_LIST_IMP} (start_widget, search_pos, forwards)
			end

		end

feature {EV_XP_THEME_DRAWER_IMP} -- Implementation

	open_theme: POINTER
		-- Theme currently open for `Current'. May be Void while running on Windows versions that
		-- do no support theming.

feature {NONE} -- Font implementation

	internal_set_font
			-- Set actual font.
		local
			local_font_windows: detachable EV_FONT_IMP
		do
			if
				(tab_pos = {EV_NOTEBOOK}.Tab_top)
				or else (tab_pos = {EV_NOTEBOOK}.Tab_bottom)
				--| FIXME, there appears to be no way to use a custom font
				-- when the tabs are left or right. In this case, we use the default
				-- font. Julian
			then
				if private_font /= Void then
					local_font_windows ?= private_font.implementation
					check
						valid_font: local_font_windows /= Void
					end
					wel_set_font (local_font_windows.wel_font)
				else
					set_default_font
				end
			else
				{WEL_API}.send_message (wel_item, Wm_setfont, to_wparam (0), cwin_make_long (1, 0))
			end
			notify_change (nc_minsize, Current, False)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_NOTEBOOK note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- EV_NOTEBOOK_IMP
