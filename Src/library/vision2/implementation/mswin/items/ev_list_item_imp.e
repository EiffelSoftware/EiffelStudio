note
	description: "Eiffel Vision list item. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LIST_ITEM_IMP

inherit
	EV_LIST_ITEM_I
		redefine
			parent_imp, interface
		end

	EV_ITEM_IMP
		export
			{EV_LIST_IMP} pointer_motion_actions_internal,
			pointer_button_press_actions_internal,
			pointer_double_press_actions_internal
		undefine
			parent, pixmap_equal_to
		redefine
			set_pixmap, pixmap, remove_pixmap, on_parented, on_orphaned,
			parent_imp, interface, destroy
		end

	EV_TEXTABLE_IMP
		undefine
			set_text, text
		redefine
			interface
		end

	EV_TOOLTIPABLE_IMP
		redefine
			interface,
			set_tooltip,
			destroy
		end

	WEL_LVM_CONSTANTS
		export
			{NONE} all
		end

	WEL_ILC_CONSTANTS
		export {NONE}
			all
		end

	EV_LIST_ITEM_ACTION_SEQUENCES_IMP
		export
			{EV_LIST_IMP, EV_COMBO_BOX_IMP} select_actions_internal, deselect_actions_internal
		end

create
	make


feature -- Initialization

	old_make (an_interface: like interface)
			-- Create the widget with `par' as parent.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			create internal_text.make (0)
			create lv_item.make
			create cb_item.make
			set_is_initialized (True)
		end

feature -- Access

	wel_set_text (a_string: STRING_GENERAL)
			-- Set the text of the item to `a_string'
		do
			internal_text := a_string.twin
		end

	wel_text: STRING_32
			-- Text of the item.
		do
			if attached internal_text as l_internal_text then
				Result := l_internal_text.twin
			else
				Result := ""
			end
		end

	text_length: INTEGER
			-- Length of text in characters.
		do
			if attached internal_text as l_internal_text then
				Result := l_internal_text.count
			end
		end

	text: STRING_32
		do
			Result := lv_item.text
		end

	pixmap: detachable EV_PIXMAP
			-- Pixmap of `Current'.
		local
			pix_imp: detachable EV_PIXMAP_IMP
			image_icon: detachable WEL_ICON
			l_pixmap: detachable EV_PIXMAP

		do
				-- Retrieve the pixmap from the imagelist
			if has_pixmap then
				if private_pixmap = Void then
					create Result
					pix_imp ?= Result.implementation
					check
						pix_imp /= Void
					end
					if attached parent_imp as l_parent_imp and then attached l_parent_imp.image_list as l_image_list then
						image_icon := l_image_list.get_icon (image_index, Ild_normal)
							-- We now set the brivate bitmap id as we want to ensure when it is placed back in
							-- the image list, the icon already contained is used.
						pix_imp.set_private_bitmap_id (l_image_list.image_id_to_bitmap_id_index.item (image_index))
						image_icon.enable_reference_tracking
						pix_imp.set_with_resource (image_icon)
						image_icon.decrement_reference
					else
						check False end
					end
				else
					l_pixmap := private_pixmap
					check l_pixmap /= Void end
					Result := l_pixmap
				end
			end
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is `Current' selected?
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.internal_is_selected (Current)
			end
		end

feature -- Status setting

	set_text (a_text: STRING_GENERAL)
		do
			wel_set_text (a_text)
			lv_item.set_text (a_text)
			cb_item.set_text (a_text)
			if attached parent_imp as l_parent_imp then
				l_parent_imp.refresh_item (Current)
			end
		end

	enable_select
			-- Set `is_selected' `True'.
		do
				-- If `Current' is already selected, then
				-- there is no need to do anything.
			if not is_selected and then attached parent_imp as l_parent_imp then
				l_parent_imp.internal_select_item (Current)
			end
		end

	disable_select
			-- Set `is_selected' `False'.
		do
				-- If `Current' is not seelcted then
				-- there is no need to do anything.
			if is_selected and then attached parent_imp as l_parent_imp then
				l_parent_imp.internal_deselect_item (Current)
			end
		end

feature -- Measurement

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		do
			if attached parent_imp as l_parent_imp then
				Result := screen_x - l_parent_imp.screen_x
			end
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		do
			if attached parent_imp as l_parent_imp then
				Result := screen_y - l_parent_imp.screen_y
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
			Result := bounds_rect.width
		end

	height: INTEGER
			-- Vertical size in pixels.
		do
			load_bounds_rect
			Result := bounds_rect.height
		end

	minimum_width: INTEGER
			-- Minimum horizontal size in pixels.
		do
			Result := width
		end

	minimum_height: INTEGER
			-- Minimum vertical size in pixels.
		do
			Result := height
		end

feature {EV_ANY_I} -- Access

	index: INTEGER
			-- One-based Index of the current item.
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.internal_get_index (Current)
			end
		end

	parent_imp: detachable EV_LIST_ITEM_LIST_IMP
		-- Parent of `Current'

	set_parent_imp (par_imp: like parent_imp)
			-- Assign 'par_imp' to `parent_imp'.
		do
			parent_imp := par_imp
		end

feature {EV_LIST_ITEM_LIST_IMP} -- Implementation.

	relative_y: INTEGER
			-- `Result' is relative y coordinate in pixels to parent.
		require
			parent_not_void: parent_imp /= Void
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.get_item_position (index - 1).y
			end
		end

	is_displayed: BOOLEAN
			-- Can the user view `Current'?
		local
			local_index: INTEGER -- current index
			first_index: INTEGER -- first displayed index
			last_index: INTEGER	-- last displayed index
			combo_imp: detachable EV_COMBO_BOX_IMP
			is_visible: BOOLEAN -- Is the list visible?
		do
			if attached parent_imp as l_parent_imp then -- otherwise...it's not displayed
				local_index := index - 1
				first_index := l_parent_imp.top_index
				last_index := first_index + l_parent_imp.visible_count

				combo_imp ?= l_parent_imp
				if combo_imp /= Void then
						-- The parent is not a combo. Is the list visible?
					is_visible := combo_imp.is_list_shown
				else
						-- The parent is not a combo, the list is
						-- always visible
					is_visible := True
				end

				Result := is_visible and then
						  local_index >= first_index and
						  local_index < last_index
			end
		end

feature {EV_LIST_ITEM_LIST_IMP} -- Pixmap Handling

	has_pixmap: BOOLEAN
			-- Has `Current' a pixmap?

	image_index: INTEGER
			-- Index of pixmap assigned with Current in the imageList.

	set_pixmap (p: EV_PIXMAP)
			-- Assign `p' to the displayed pixmap.
		do
				-- We must destroy the pixmap before we set a new one,
				-- to ensure that we free up Windows GDI objects
			if attached private_pixmap as l_private_pixmap then
				l_private_pixmap.destroy
				private_pixmap := Void
			end
			private_pixmap := p.twin
			has_pixmap := True

				-- If the item is currently contained in the list then
			if parent_imp /= Void then
					-- Update the parent's image list.
				set_pixmap_in_parent
			end
		end

	remove_pixmap
			-- Remove pixmap from `Current'.
		do
			if has_pixmap then
				has_pixmap := False
				if attached private_pixmap as l_private_pixmap then
					l_private_pixmap.destroy
					private_pixmap := Void
				end

					-- If the item is currently contained in the list then..
				if parent_imp /= Void then
						-- Update the parent's image list.
					remove_pixmap_in_parent
				end
			end
		end

	set_pixmap_in_parent
			-- Add/Remove the pixmap to the parent by updating the
			-- parent's image list.
		local
			image_list: detachable EV_IMAGE_LIST_IMP
			l_parent_imp: like parent_imp
		do
			l_parent_imp := parent_imp
			check l_parent_imp /= Void end
			if has_pixmap then
				image_list := l_parent_imp.image_list
					-- Create the image list and associate it
					-- to the control if it's not already done.
				if image_list = Void then
					l_parent_imp.setup_image_list
					image_list := l_parent_imp.image_list
				end
				check image_list /= Void end

				if attached private_pixmap as l_private_pixmap then
					image_list.add_pixmap (l_private_pixmap)
					image_index := image_list.last_position
					l_private_pixmap.destroy
					private_pixmap := Void
				end
			else
				image_index := 0 -- transparent image.
			end
			l_parent_imp.set_pixmap_of_child (Current, index, image_index)
		end

	remove_pixmap_in_parent
			-- Remove pixmap of `Current'.
		do
			if attached parent_imp as l_parent_imp and then l_parent_imp.image_list /= Void then
				l_parent_imp.remove_pixmap_of_child (Current, index)
			end
		end

	set_tooltip (a_tooltip: STRING_GENERAL)
			-- Assign `a_tooltip' to `internal_tooltip_string'.
		do
			internal_tooltip_string := a_tooltip.as_string_32
			if internal_tooltip_string = a_tooltip then
				internal_tooltip_string := a_tooltip.as_string_32.string
			end
		end

feature {EV_ITEM_LIST_I} -- Implementation

	on_parented
		do
			if parent_imp /= Void and private_pixmap /= Void then
				set_pixmap_in_parent
			end
		end

	on_orphaned
			-- `Current' has just been orphaned.
		do
				-- Retrieve the pixmap from the imagelist.
			if has_pixmap and then private_pixmap = Void then
				private_pixmap := pixmap
			end
		end

feature {NONE} -- Implementation

	internal_text: STRING_32
			-- Text of `Current'.

	destroy
			-- Destroy `Current'.
		do
			Precursor {EV_ITEM_IMP}
		end

	bounds_rect: WEL_RECT
			-- Rect struct to hold size information
			-- This is shared and should only be used right after a call to `load_bounds_rect'
		once
			create Result.make (0, 0, 0, 0)
		end

	load_bounds_rect
			-- Load bounds rect.
		local
			a_list: detachable EV_LIST_IMP
			a_box: detachable EV_COMBO_BOX_IMP
			a_rect: WEL_RECT
			an_index, a_height: INTEGER
			l_parent_imp: like parent_imp
		do
			create a_rect.make (0, 0, 0, 0)
			l_parent_imp := parent_imp
			a_list ?= l_parent_imp
			if a_list = Void then
				a_box ?= l_parent_imp
				if a_box = Void then
					bounds_rect.set_rect (0, 0, 0, 0)
				else
					an_index := a_box.index_of (interface, 1)
					a_height := {WEL_API}.send_message_result_integer (a_box.wel_item, {WEL_CB_CONSTANTS}.cb_getitemheight, {WEL_DATA_TYPE}.to_wparam(0), a_rect.item)
					if {WEL_API}.send_message_result_boolean (a_box.wel_item, {WEL_CB_CONSTANTS}.cb_getdroppedcontrolrect, {WEL_DATA_TYPE}.to_wparam(0), a_rect.item) then
						bounds_rect.set_rect (a_rect.left, a_rect.top + (an_index * a_height), a_rect.right, a_rect.top + ((an_index + 1) * a_height))
					else
						bounds_rect.set_rect (0, 0, 0, 0)
					end
				end
			elseif attached parent as l_parent then
				check l_parent_imp /= Void end
				if {WEL_API}.send_message_result_boolean (a_list.wel_item, lvm_getitemrect, {WEL_DATA_TYPE}.to_wparam(l_parent_imp.index_of (interface, 1)), a_rect.item) then
					bounds_rect.set_rect (l_parent.screen_x+a_rect.left, l_parent.screen_y+a_rect.top, l_parent.screen_x+a_rect.right, l_parent.screen_y+a_rect.bottom)
				else
					bounds_rect.set_rect (0, 0, 0, 0)
				end
			end
		end

feature {EV_LIST_ITEM_LIST_IMP} -- Implementation

	lv_item: WEL_LIST_VIEW_ITEM
		-- An internal WEL_LIST_VIEW item

	cb_item: WEL_COMBO_BOX_EX_ITEM
		-- An internal WEL_COMBO_BOX_EX item

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_LIST_ITEM note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_LIST_ITEM_IMP










