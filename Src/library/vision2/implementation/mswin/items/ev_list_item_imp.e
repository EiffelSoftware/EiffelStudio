indexing
	description: "Eiffel Vision list item. Mswindows implementation."
	status: "See notice at end of class"
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
			parent
		redefine
			set_pixmap, pixmap, remove_pixmap, on_parented, on_orphaned,
			parent_imp, interface
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
			set_tooltip
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


feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the widget with `par' as parent.
		do
			base_make (an_interface)
			--wel_make
			create internal_text.make (0)
		end

	initialize is
			-- Initialize `Current'.
		do
			create lv_item.make
			create cb_item.make
			is_initialized := True
		end

feature -- Access

	wel_set_text (a_string: STRING) is
			-- Set the text of the item to `a_string'
		do
			internal_text := clone (a_string)	
		end
	
	wel_text: STRING is
			-- Text of the item.
		do
			Result := clone (internal_text)
		end

	text_length: INTEGER is
			-- Length of text in characters.
		do
			Result := internal_text.count
		end

	text: STRING is
		do
			Result := lv_item.text
		end

	pixmap: EV_PIXMAP is
			-- Pixmap of `Current'.
		local
			pix_imp: EV_PIXMAP_IMP
			image_icon: WEL_ICON
		do
				-- Retrieve the pixmap from the imagelist
			if has_pixmap then
				if private_pixmap = Void then
					create Result
					pix_imp ?= Result.implementation
					check
						pix_imp /= Void
					end
					image_icon := parent_imp.image_list.get_icon (image_index, Ild_normal)
					image_icon.enable_reference_tracking
					pix_imp.set_with_resource (image_icon)
					image_icon.decrement_reference
				else
					Result := private_pixmap
				end
			end
		end 

feature -- Status report

	is_selected: BOOLEAN is
			-- Is `Current' selected?
		do
			if parent_imp /= Void then
				Result := parent_imp.internal_is_selected (Current)
			end
		end

feature -- Status setting

	set_text (a_text: STRING) is
		do
			wel_set_text (a_text)
			lv_item.set_text (a_text)
			cb_item.set_text (a_text)
			if parent_imp /= Void then
				parent_imp.refresh_item (Current)
			end
		end

	enable_select is
			-- Set `is_selected' `True'.
		do
				-- If `Current' is already selected, then
				-- there is no need to do anything.
			if not is_selected then
				parent_imp.internal_select_item (Current)	
			end
		end

	disable_select is
			-- Set `is_selected' `False'.
		do
				-- If `Current' is not seelcted then
				-- there is no need to do anything.
			if is_selected then
				parent_imp.internal_deselect_item (Current)	
			end
		end

feature {EV_ANY_I} -- Access

	index: INTEGER is
			-- One-based Index of the current item.
		do
			Result := parent_imp.internal_get_index (Current)
		end

	parent_imp: EV_LIST_ITEM_LIST_IMP
		-- Parent of `Current'
	
	set_parent_imp (par_imp: like parent_imp) is
			-- Assign 'par_imp' to `parent_imp'.
		do
			if par_imp /= Void then
				parent_imp := par_imp
			else
				parent_imp := Void
			end
		end

feature {EV_LIST_ITEM_LIST_IMP} -- Implementation.

	relative_y: INTEGER is
			-- `Result' is relative y coordinate in pixels to parent.
		require
			parent_not_void: parent_imp /= Void
		do
			Result := parent_imp.get_item_position (index - 1).y
		end

	is_displayed: BOOLEAN is
			-- Can the user view `Current'?
		local
			local_index: INTEGER -- current index
			first_index: INTEGER -- first displayed index
			last_index: INTEGER	-- last displayed index
			combo_imp: EV_COMBO_BOX_IMP
			is_visible: BOOLEAN -- Is the list visible?
		do
			if parent_imp /= Void then -- otherwise...it's not displayed
				local_index := index - 1
				first_index := parent_imp.top_index
				last_index := first_index + parent_imp.visible_count

				combo_imp ?= parent_imp
				if combo_imp /= Void then
						-- The parent is not a combo. Is the list visible?
					is_visible := combo_imp.list_shown
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

	set_pixmap (p: EV_PIXMAP) is
			-- Assign `p' to the displayed pixmap.
		do
				-- We must destroy the pixmap before we set a new one,
				-- to ensure that we free up Windows GDI objects
			if private_pixmap /= Void then
				private_pixmap.destroy
				private_pixmap := Void
			end
			private_pixmap := clone (p)
			has_pixmap := True

				-- If the item is currently contained in the list then
			if parent_imp /= Void then
					-- Update the parent's image list.
				set_pixmap_in_parent
			end
		end

	remove_pixmap is
			-- Remove pixmap from `Current'.
		do
			if has_pixmap then
				has_pixmap := False
				if private_pixmap /= Void then
					private_pixmap.destroy
					private_pixmap := Void
				end

					-- If the item is currently contained in the list then..
				if parent_imp /= Void then
						-- Update the parent's image list.
					remove_pixmap_in_parent
				end
			end
		end

	set_pixmap_in_parent is
			-- Add/Remove the pixmap to the parent by updating the 
			-- parent's image list.
		local
			image_list: EV_IMAGE_LIST_IMP
		do
			if has_pixmap then
				image_list := parent_imp.image_list
					-- Create the image list and associate it
					-- to the control if it's not already done.
				if image_list = Void then
					parent_imp.setup_image_list
					image_list := parent_imp.image_list
				end

				if private_pixmap /= Void then
					image_list.add_pixmap (private_pixmap)
					image_index := image_list.last_position
					private_pixmap.destroy
					private_pixmap := Void
				end
			else
				image_index := 0 -- transparent image.
			end
			parent_imp.set_pixmap_of_child (Current, index, image_index)
		end

	remove_pixmap_in_parent is
			-- Remove pixmap of `Current'.
		do
			if parent_imp.image_list /= Void then
				parent_imp.remove_pixmap_of_child (Current, index)
			end
		end

	set_tooltip (a_tooltip: STRING) is
			-- Assign `a_tooltip' to `internal_tooltip_string'.
		do
			internal_tooltip_string := clone (a_tooltip)
		end

feature {EV_ITEM_LIST_I} -- Implementation

	on_parented is
		do
			if parent_imp /= Void then
				set_pixmap_in_parent
			end
		end

	on_orphaned is
			-- `Current' has just been orphaned.
		do
				-- Retrieve the pixmap from the imagelist.
			if has_pixmap and then private_pixmap /= Void then
				private_pixmap := pixmap
			end
		end

feature {NONE} -- Implementation

	internal_text: STRING
			-- Text of `Current'.

feature {EV_LIST_ITEM_LIST_IMP} -- Implementation

	lv_item: WEL_LIST_VIEW_ITEM
		-- An internal WEL_LIST_VIEW item

	cb_item: WEL_COMBO_BOX_EX_ITEM
		-- An internal WEL_COMBO_BOX_EX item

feature {EV_ANY_I} -- Implementation

	interface: EV_LIST_ITEM

end -- class EV_LIST_ITEM_IMP

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

