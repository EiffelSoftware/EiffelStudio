indexing
	description: "Objects that represent a common editor constructor for pixmap and pixmapable objects."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_COMMON_PIXMAP_EDITOR_CONSTRUCTOR

inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
		
	GB_EV_PIXMAP_HANDLER
		undefine
			default_create
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		end
		
	GB_SHARED_PIXMAPS
		export
			{NONE} all
		undefine
			Visual_studio_information
		end
		
	GB_SHARED_CONSTANTS
		export
			{NONE} all
		end
		
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end
		
feature -- Access
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			horizontal_box: EV_HORIZONTAL_BOX
			frame: EV_FRAME
			frame_box: EV_VERTICAL_BOX
		do
			create Result
				-- Tool bar and menu separators do inherit from EV_PIXMAPABLE,
				-- however, the facilities are not exported.
			if not (object.type.is_equal ("EV_TOOL_BAR_SEPARATOR") or object.type.is_equal ("EV_MENU_SEPARATOR")) then
				initialize_attribute_editor (Result)
				create horizontal_box
				create frame_box
				create modify_button.make_with_text (Set_with_named_file_text)
				modify_button.select_actions.extend (agent modify_pixmap)
				modify_button.select_actions.extend (agent update_editors)
				horizontal_box.extend (modify_button)
				create filler_label
				horizontal_box.extend (filler_label)
				create constants_combo_box
				horizontal_box.extend (constants_combo_box)
				constants_combo_box.hide
				create constants_button
				constants_button.set_tooltip (Select_constant_tooltip)
				constants_button.set_pixmap (Icon_format_onces @ 1)
				constants_button.select_actions.extend (agent switch_constants_mode)
				horizontal_box.extend (constants_button)
				horizontal_box.disable_item_expand (modify_button)
				horizontal_box.disable_item_expand (constants_button)
				frame_box.extend (horizontal_box)
				create pixmap_container
				frame_box.extend (pixmap_container)
				create frame.make_with_text (gb_ev_pixmapable_pixmap)
				frame.extend (frame_box)
				Result.extend (frame)
				populate_constants
				parent_editor.add_pixmap_input_field (Current)
				update_attribute_editor
			end
		end

feature {GB_OBJECT_EDITOR} -- Implementation

	constant_removed (constant: GB_PIXMAP_CONSTANT) is
			-- Update `Current' to reflect removal of `constant' from system.
		require
			constant_not_void: constant /= Void
		local
			list_item: EV_LIST_ITEM
		do
			if constants_combo_box.selected_item /= Void and then
				constants_combo_box.selected_item.text.is_equal (constant.name) then
				constants_button.disable_select
			end
			list_item := list_item_with_matching_text (constants_combo_box, constant.name)
			check
				list_item_not_void: list_item /= Void
			end
			constants_combo_box.prune_all (list_item)
			constants_combo_box.first.enable_select
		end
		
	constant_changed (constant: GB_PIXMAP_CONSTANT) is
			-- `constant' has changed, so update representation in `Current'.
		require
			constant_not_void: constant /= Void
		local
			found: BOOLEAN
		do
			from
				constants_combo_box.start
			until
				constants_combo_box.off or found
			loop
				if constants_combo_box.item.data = constant then
					found := True
					constants_combo_box.item.set_pixmap (constant.small_pixmap)
				end
				constants_combo_box.forth
			end
		end

	constant_added (constant: GB_PIXMAP_CONSTANT) is
			-- Update `Current' to reflect addition of `constant' to system.
		require
			constant_not_void: constant /= Void
		local
			list_item: EV_LIST_ITEM
		do
			create list_item.make_with_text (constant.name)
			list_item.set_pixmap (constant.small_pixmap)
			list_item.set_data (constant)
			list_item.select_actions.extend (agent list_item_selected (list_item))
			constants_combo_box.extend (list_item)
		end
		
feature {NONE} -- Implementation

	modify_pixmap is
			-- Update displayed pixmap.
		deferred
		end

	add_pixmap_to_pixmap_container (pixmap: EV_PIXMAP) is
			-- Add `pixmap' to `pixmap_container'.
		local
			x_ratio, y_ratio: REAL
			new_x, new_y: INTEGER
			biggest_ratio: REAL
			a_pixmap: EV_PIXMAP
			a_pixmapable: EV_PIXMAPABLE
			a_path: STRING
		do
			a_pixmap ?= first
			if a_pixmap /= Void then
				a_path := a_pixmap.pixmap_path
			else
				a_pixmapable ?= first
				if a_pixmapable /= Void then
					a_path := a_pixmapable.pixmap_path
				end
			end
			if a_path /= Void then
				pixmap.set_tooltip (a_path)
					-- We also add a tooltip to the space to the right
					-- of the buttom, through `filler_label'.
				filler_label.set_tooltip (a_path)
			end
			x_ratio := pixmap.width / minimum_width_of_object_editor
			y_ratio := pixmap.height / minimum_width_of_object_editor
			if x_ratio > 1 and y_ratio < 1 then 
				new_x := minimum_width_of_object_editor
				new_y := (pixmap.height / x_ratio).truncated_to_integer
			end
			if y_ratio > 1 and x_ratio < 1 then
				new_y := minimum_width_of_object_editor
				new_x := (pixmap.width / y_ratio).truncated_to_integer
			end
			if y_ratio > 1 and x_ratio > 1 then
				biggest_ratio := x_ratio.max (y_ratio)
				new_x := (pixmap.width / biggest_ratio).truncated_to_integer
				new_y := (pixmap.height / biggest_ratio).truncated_to_integer
			end
			if new_x /= 0 and new_y /= 0 then
				pixmap.stretch (new_x, new_y)	
			end
			pixmap_container.wipe_out
			pixmap_container.extend (pixmap)
			pixmap.set_minimum_size (pixmap.width, pixmap.height)
		end
		
	switch_constants_mode is
			-- Switch interface between constants selection
			-- and standard selection modes.
		do
			if constants_button.is_selected then
				if pixmap_container.full then
					modify_pixmap
				end
				filler_label.hide
				modify_button.hide
				constants_combo_box.show
			else
				filler_label.show
				modify_button.show
				constants_combo_box.hide
				remove_selected_constant
			end
		end
		
	populate_constants is
			-- Fill `constants_combo_box' with representations
			-- of all pixmap constants for selection.
		local
			pixmap_constants: ARRAYED_LIST [GB_CONSTANT]
			pixmap_constant: GB_PIXMAP_CONSTANT
			list_item: EV_LIST_ITEM
			lookup_string: STRING
		do
			constants_combo_box.wipe_out
			create list_item.make_with_text (select_constant_string)
			constants_combo_box.extend (list_item)
			pixmap_constants := constants.pixmap_constants
			from
				pixmap_constants.start
			until
				pixmap_constants.off
			loop
				pixmap_constant ?= pixmap_constants.item
				create list_item.make_with_text (pixmap_constant.name)
				list_item.set_data (pixmap_constant)
				list_item.set_pixmap (pixmap_constant.small_pixmap)
				constants_combo_box.extend (list_item)
				lookup_string := type + Pixmap_path_string
				if object.constants.has (lookup_string) and
					pixmap_constant = object.constants.item (lookup_string).constant then
					constants_button.enable_select
					list_item.enable_select
					last_selected_constant ?= list_item.data
				end
				list_item.select_actions.extend (agent list_item_selected (list_item))
				pixmap_constants.forth
			end
		end
		
	last_selected_constant: GB_CONSTANT
		-- Last constant selected in `Current'.
		
	set_pixmapable_constant (a_pixmap: EV_PIXMAP) is
			-- Set pixmapable representation to `a_pixmap'.
		require
			a_pixmap_not_void: a_pixmap /= Void
		local
			a_pixmapable: EV_PIXMAPABLE
		do
			a_pixmapable ?= first
			check
				object_was_pixmapable: a_pixmapable /= Void
			end
			a_pixmapable.set_pixmap (a_pixmap)
			a_pixmapable ?= objects @ 2
			a_pixmapable.set_pixmap (a_pixmap)
		end
		
	set_pixmap_constant (new_pixmap: EV_PIXMAP) is
			-- Set pixmap representation to `a_pixmap'.
		local
			a_pixmap: EV_PIXMAP
		do
			a_pixmap ?= first
			if a_pixmap /= Void then
				a_pixmap.hide
				a_pixmap.copy (new_pixmap)
				a_pixmap.show
				a_pixmap ?= objects @ 2
				a_pixmap.hide
				a_pixmap.copy (new_pixmap)
				a_pixmap.show
			end
		end

	list_item_selected (list_item: EV_LIST_ITEM) is
			-- `list_item' has been selected from `constants_combo_box'.
		require
			list_item_not_void: list_item /= Void
			list_item_has_data: list_item.data /= Void
		local
			constant: GB_PIXMAP_CONSTANT
			constant_context: GB_CONSTANT_CONTEXT
			a_pixmap: EV_PIXMAP
			
		do
			if list_item.data /= Void then
				constant ?= list_item.data
				check
					data_was_constant: constant /= Void
				end
				a_pixmap ?= first
				if a_pixmap /= Void then
					set_pixmap_constant (constant.pixmap)
				else
					set_pixmapable_constant (constant.pixmap)
				end
				create constant_context.make_with_context (constant, object, type, Pixmap_path_string)
				constant.add_referer (constant_context)
				object.add_constant_context (constant_context)
				internal_remove_selected_constant
				last_selected_constant := constant
				enable_project_modified
			end
		end

	remove_selected_constant is
				-- Remove constant, and clear pixmaps from current.
			local
				a_pixmap: EV_PIXMAP
			do
				if last_selected_constant /= Void then
					internal_remove_selected_constant
					a_pixmap ?= first
					if a_pixmap /= Void then
						for_all_objects (agent {EV_PIXMAP}.clear)
					else
						for_all_objects (agent {EV_PIXMAPABLE}.remove_pixmap)
					end
				end
			end

	internal_remove_selected_constant is
			-- Update `object' and `last_selected_constant' to reflect the
			-- fact that a user is no longer referencing `last_selected_constant'.
			-- Does not remove the pixmap from the pixmapable control.
		local
			constant: GB_INTEGER_CONSTANT
			constant_context: GB_CONSTANT_CONTEXT
		do
			if last_selected_constant /= Void then
				constant_context := object.constants.item (type + Pixmap_path_string)
				constant ?= constant_context.constant
				last_selected_constant.remove_referer (constant_context)
				object.constants.remove (type + Pixmap_path_string)
				last_selected_constant := Void
			end
		end		

	pixmap_container: EV_CELL
		-- Holds a representation of the loaded pixmap.
		
	filler_label: EV_LABEL
	
	error_label: EV_LABEL
		
	modify_button: EV_BUTTON
		-- Is either "Select" or "Remove"
		-- depending on current context.

	pixmap_path_string: STRING is "Pixmap_path"
	
	Remove_tooltip: STRING is "Remove pixmap"
		-- Tooltip on `modify_button' when able to remove pixmap.
		
	Select_tooltip: STRING is "Select pixmap"
		-- Tooltip on `modify_button' when able to remove pixmap.
		
	constants_button: EV_TOGGLE_BUTTON
		-- Button to select pixmap constants.
		
	constants_combo_box: EV_COMBO_BOX
		-- A combo box to hold all pixmap constants.
		
end -- class GB_EV_COMMON_PIXMAP_EDITOR_CONSTRUCTOR
