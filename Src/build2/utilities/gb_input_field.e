indexing
	description: "Objects that are a general representation of input fields."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_INPUT_FIELD
	
inherit
	EV_VERTICAL_BOX
	
	GB_SHARED_OBJECT_EDITORS
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end
	
	GB_GENERAL_UTILITIES
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end
		
	GB_SHARED_PIXMAPS
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end
		
	GB_SHARED_CONSTANTS
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end
		
	INTERNAL
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end
		
	GB_EV_PIXMAP_HANDLER
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end
		
	CONSTANTS_IMP
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

feature -- Access

	constants_combo_box: EV_COMBO_BOX
		-- Combo box which will contain all INTEGER constants.
		
	type: STRING is
			-- Type of constant represented.
		deferred
		end
		
	constants_button: EV_TOOL_BAR_TOGGLE_BUTTON
		-- Button to switch between constants or values.
		
	object: GB_OBJECT
		-- Object referenced by `Current'.
		
	internal_gb_ev_any: GB_EV_ANY
		-- instance of GB_EV_ANY that is client of `Current'.
		
	label: EV_LABEL
		-- Label used to display title tag.
		
	internal_type: STRING
		--| The type of the property as it will appear in a constant context.
		--| For example "EV_BUTTONText" is how the constant may appear in an object
		--| reference, and "Text" is the internal type.

feature -- Status setting

	constant_added (constant: GB_CONSTANT) is
			-- Update `Current' to reflect addition of `constant' to system.
		require
			constant_not_void: constant /= Void
		local
			list_item: EV_LIST_ITEM
		do
			create list_item.make_with_text (constant.name)
			list_item.set_data (constant)
			if constant.small_pixmap /= Void then
				list_item.set_pixmap (constant.small_pixmap)
			end
			list_item.select_actions.extend (agent list_item_selected (list_item))
			list_item.deselect_actions.extend (agent list_item_deselected (list_item))
			constants_combo_box.extend (list_item)
		ensure
			list_count_increased: constants_combo_box.count = old constants_combo_box.count + 1
		end
		
	constant_changed (constant: GB_CONSTANT) is
			-- `constant' has changed, so update representation in `Current'.
		require
			constant_not_void: constant /= Void
		local
			list_item: EV_LIST_ITEM
		do
			list_item := list_item_with_matching_text (constants_combo_box, constant.name)
			check
				list_item_not_void: list_item /= Void
			end
		end
		
	constant_removed (constant: GB_CONSTANT) is
			-- Update `Current' to reflect removal of `constant' from system.
		require
			constant_not_void: constant /= Void
		local
			list_item: EV_LIST_ITEM
		do
			if constants_button.is_selected then
				if constants_combo_box.selected_item /= Void and then
					constants_combo_box.selected_item.text.is_equal (constant.name) then
					constants_button.disable_select
				end
			end
			list_item := list_item_with_matching_text (constants_combo_box, constant.name)
			check
				list_item_not_void: list_item /= Void
			end
			constants_combo_box.prune_all (list_item)
		ensure
			list_count_decreased: constants_combo_box.count = old constants_combo_box.count - 1
		end
		
	list_item_selected (list_item: EV_LIST_ITEM) is
			-- `list_item' has been selected from `constants_combo_box'.
		require
			list_item_not_void: list_item /= Void
			list_item_has_data: list_item.data /= Void
		deferred
		end
		
	list_item_deselected (list_item: EV_LIST_ITEM) is
			-- `list_item' has been deselected from `constants_combo_box'.
		require
			list_item_not_void: list_item /= Void
			list_item_has_data: list_item.data /= Void
		deferred
		end

feature {NONE} -- Implementation

	call_default_create (any: ANY) is
			-- Call `default_create' and assign `any' to `internal_gb_ev_any'.
		require
			gb_ev_any_not_void: any /= Void
		local
			gb_ev_any: GB_EV_ANY
		do
			gb_ev_any ?= any
			check
				gb_ev_any_not_void: gb_ev_any /= Void
			end
			internal_gb_ev_any := gb_ev_any
			default_create
		end
		
	add_label (label_text, tooltip: STRING) is
			-- Add a label to `Current' with `text' `label_text' and
			-- tooltip `tooltip'.
		require
			label_text_not_void_or_empty: label_text /= Void and not label_text.is_empty
		do
			create label.make_with_text (label_text)
			label.set_tooltip (tooltip)
			extend (label)
			disable_item_expand (label)
			label.align_text_left
		end
		
	create_constants_button is
			-- Create and initialize `constants_button'.
		do
			create constants_button
			constants_button.set_tooltip (Select_constant_tooltip)
			constants_button.select_actions.extend (agent switch_constants_mode)
			constants_button.set_pixmap (Icon_format_onces @ 1)
		ensure
			constants_button_not_void: constants_button /= Void
		end
		
	switch_constants_mode is
			-- Switch constants mode based on selected state of `constants_button'.
		deferred
		end
		
	update_editors is
			-- Update editors.
		do
			update_editors_for_property_change (internal_gb_ev_any.objects.first, internal_gb_ev_any.type, internal_gb_ev_any.parent_editor)
		end

end -- class GB_INPUT_FIELD
