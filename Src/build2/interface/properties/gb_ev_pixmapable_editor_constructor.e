indexing
	description: "Builds an attribute editor for modification of objects of type EV_PIXMAPABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_PIXMAPABLE_EDITOR_CONSTRUCTOR
	
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
		
feature -- Access

	ev_type: EV_PIXMAPABLE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_PIXMAPABLE"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			horizontal_box: EV_HORIZONTAL_BOX
			frame: EV_FRAME
			frame_box: EV_VERTICAL_BOX
		do
			create Result
			initialize_attribute_editor (Result)
			create horizontal_box
			create frame_box
			create modify_button
			modify_button.select_actions.extend (agent modify_pixmap)
			modify_button.select_actions.extend (agent update_editors)
			horizontal_box.extend (modify_button)
			create filler_label
			horizontal_box.extend (filler_label)
			create constants_combo_box
			horizontal_box.extend (constants_combo_box)
			constants_combo_box.hide
			create constants_button
			constants_button.set_pixmap (Icon_format_onces @ 1)
			constants_button.select_actions.extend (agent switch_constants_mode)
			horizontal_box.extend (constants_button)
			horizontal_box.disable_item_expand (modify_button)
			horizontal_box.disable_item_expand (constants_button)
			populate_constants
			frame_box.extend (horizontal_box)
			create pixmap_container
			frame_box.extend (pixmap_container)
			create frame.make_with_text (gb_ev_pixmapable_pixmap)
			frame.extend (frame_box)
			Result.extend (frame)
			update_attribute_editor
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
			local
				error_label: EV_LABEL
		do
			if object.constants.item (type + Pixmap_path_string) /= Void then
				constants_button.enable_select
				switch_constants_mode	
			else			
				if first.pixmap /= Void then
					add_pixmap_to_pixmap_container (first.pixmap)
					modify_button.set_text (Remove_string)
					modify_button.set_tooltip (Remove_tooltip)
				else
					pixmap_container.wipe_out
					modify_button.set_text (Select_button_text)
					modify_button.set_tooltip (Select_tooltip)
						-- Remove tooltip from `filler_label',
						-- no need to remove it from the pixmap
						-- as the pixmap will no be no longer visible.
					filler_label.remove_tooltip
					if first.pixmap_path /= Void then
						create error_label.make_with_text ("Error - named pixmap missing.")
						error_label.set_tooltip (first.pixmap_path)
						pixmap_container.extend (error_label)
						modify_button.set_text (Remove_string)
						modify_button.set_tooltip (Remove_tooltip)
					end
				end
			end
		end
		
feature {NONE} -- Implementation

	modify_pixmap is
			-- Display a dialog allowing user input for
			-- selected pixmap.
		local
			dialog: EV_FILE_OPEN_DIALOG
			new_pixmap: EV_PIXMAP
			shown_once, opened_file: BOOLEAN
			error_dialog: EV_WARNING_DIALOG
		do
			if first.pixmap = Void and first.pixmap_path = Void then
				from
					create dialog
				until
					(dialog.file_name.is_empty and shown_once) or opened_file
				loop
					shown_once := True
					dialog.show_modal_to_window (parent_window (parent_editor))
					if not dialog.file_name.is_empty and then valid_file_extension (dialog.file_name.substring (dialog.file_name.count -2, dialog.file_name.count)) then
						create new_pixmap
						new_pixmap.set_with_named_file (dialog.file_name)
							-- Must set the pixmap before the stretch takes place.
						for_all_objects (agent {EV_PIXMAPABLE}.set_pixmap (new_pixmap))
						for_all_objects (agent {EV_PIXMAPABLE}.set_pixmap_path (dialog.file_name))
						add_pixmap_to_pixmap_container (clone (new_pixmap))
						modify_button.set_text (Remove_string)
						modify_button.set_tooltip (Remove_tooltip)
						opened_file := True
					elseif not dialog.file_name.is_empty then
						create error_dialog
						error_dialog.set_text (invalid_type_warning)
						error_dialog.show_modal_to_window (parent_window (parent_editor))
					end
				end
			else
				for_all_objects (agent {EV_PIXMAPABLE}.remove_pixmap)
				for_all_objects (agent {EV_PIXMAPABLE}.set_pixmap_path (Void))
				pixmap_container.wipe_out
				modify_button.set_text (Select_button_text)
				modify_button.set_tooltip (Select_tooltip)
					-- Remove tooltip from `filler_label',
					-- no need to remove it from the pixmap
					-- as the pixmap will no be no longer visible.
				filler_label.remove_tooltip
				rebuild_associated_editors (first)
			end	
		end

	add_pixmap_to_pixmap_container (pixmap: EV_PIXMAP) is
			-- Add `pixmap' to `pixmap_container'.
		local
			x_ratio, y_ratio: REAL
			new_x, new_y: INTEGER
			biggest_ratio: REAL
		do
			pixmap.set_tooltip (first.pixmap_path)
				-- We also add a tooltip to the space to the right
				-- of the buttom, through `filler_label'.
			filler_label.set_tooltip (first.pixmap_path)
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
			-- of all all pixmap constants for selection.
		local
			pixmap_constants: ARRAYED_LIST [GB_CONSTANT]
			pixmap_constant: GB_PIXMAP_CONSTANT
			list_item: EV_LIST_ITEM
			lookup_string: STRING
		do
			constants_combo_box.wipe_out
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

	list_item_selected (list_item: EV_LIST_ITEM) is
			-- `list_item' has been selected from `constants_combo_box'.
		require
			list_item_not_void: list_item /= Void
			list_item_has_data: list_item.data /= Void
		local
			constant: GB_PIXMAP_CONSTANT
			constant_context: GB_CONSTANT_CONTEXT
		do
			if list_item.data /= Void then
				constant ?= list_item.data
				check
					data_was_constant: constant /= Void
				end
				objects.first.set_pixmap (constant.pixmap)
				(objects @ 2).set_pixmap (constant.pixmap)
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
			do
				if last_selected_constant /= Void then
					internal_remove_selected_constant
					for_all_objects (agent {EV_PIXMAPABLE}.remove_pixmap)
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
		
	modify_button: EV_BUTTON
		-- Is either "Select" or "Remove"
		-- depending on current context.

	pixmap_path_string: STRING is "Pixmap_path"
	
	Remove_string: STRING is "Remove"
		-- String on `modify_button' when able to remove pixmap.

	Remove_tooltip: STRING is "Remove pixmap"
		-- Tooltip on `modify_button' when able to remove pixmap.
		
	Select_tooltip: STRING is "Select pixmap"
		-- Tooltip on `modify_button' when able to remove pixmap.
		
	constants_button: EV_TOGGLE_BUTTON
		-- Button to select pixmap constants.
		
	constants_combo_box: EV_COMBO_BOX
		-- A combo box to hold all pixmap constants.
		
end -- class GB_EV_PIXMAPABLE_EDITOR_CONSTRUCTOR
