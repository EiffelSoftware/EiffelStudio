indexing
	description: "Objects that allow user input of a pixmap value."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_PIXMAP_INPUT_FIELD
	
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
		
create
	make
	
feature {NONE} -- Initialization

	make (any: ANY; a_parent: EV_CONTAINER; a_type, label_text, tooltip: STRING; an_execution_agent: PROCEDURE [ANY, TUPLE [EV_PIXMAP, STRING]];
		a_validate_agent: FUNCTION [ANY, TUPLE [EV_PIXMAP], BOOLEAN]; a_pixmap_agent: FUNCTION [ANY, TUPLE [], EV_PIXMAP];
		a_pixmap_path_agent: FUNCTION [ANY, TUPLE [], STRING]) is
			-- Create `Current' with `gb_ev_any' as the client of `Current', we need this to call `update_atribute_editors'.
			-- Build widget structure into `a_parent'. Use `label_text' as the text of the label next to the text field for entry.
			-- `an_execution_agent' is to execute the setting of the attribute.
			-- `a_validate_agent' is used to query whether the current value is valid as an argument for `execution_agent'.
			-- `tooltip' is tooltip to be displayed on visible parts of control.
		require
			gb_ev_any_not_void: any /= Void
			a_parent_not_void: a_parent /= Void
			label_text_not_void_or_empty: label_text /= Void and not label_text.is_empty
			an_agent_not_void: an_execution_agent /= Void
			a_validate_agent_not_void: a_validate_agent /= Void
		local
			vertical_box: EV_VERTICAL_BOX
		do
			call_default_create (any)
			internal_gb_ev_any.parent_editor.add_pixmap_input_field (Current)
			internal_type := a_type
			object ?= internal_gb_ev_any.object
			check
				object_not_void: object /= Void
			end
			create frame.make_with_text (label_text)
			create vertical_box
			frame.extend (vertical_box)
			create horizontal_box
			vertical_box.extend (horizontal_box)
			horizontal_box.set_padding_width (object_editor_padding_width)
			horizontal_box.set_border_width (Object_editor_padding_width)

			create modify_button.make_with_text (select_button_text)
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
			constants_button.select_actions.extend (agent remove_constant)
			constants_button.select_actions.extend (agent update_editors)
			horizontal_box.extend (constants_button)
			horizontal_box.disable_item_expand (modify_button)
			horizontal_box.disable_item_expand (constants_button)
			create pixmap_container
			Current.extend (frame)
			vertical_box.extend (pixmap_container)
			a_parent.extend (Current)

			execution_agent := an_execution_agent
			validate_agent := a_validate_agent
			return_pixmap_agent := a_pixmap_agent
			pixmap_path_agent := a_pixmap_path_agent
			populate_constants

		ensure
			execution_agent_not_void: execution_agent /= Void
			validate_agent_not_void: validate_agent /= Void
			internal_gb_ev_any_not_void: internal_gb_ev_any /= Void
		end

feature {GB_EV_EDITOR_CONSTRUCTOR, GB_EV_ANY} -- Implementation

	update_constant_display (a_value: EV_PIXMAP) is
			-- Update widgets and display based on state of current constant selected.
		local
			constant_context: GB_CONSTANT_CONTEXT
			list_item: EV_LIST_ITEM
			has_pixmap: BOOLEAN
			pixmap: EV_PIXMAP
			l_pixmap_path: STRING
			error_label: EV_LABEL
		do
			constant_context := object.constants.item (internal_gb_ev_any.type + internal_type)
			if constant_context /= Void then
				constants_button.select_actions.block
				constants_button.enable_select
				constants_button.select_actions.resume
				list_item := list_item_with_matching_text (constants_combo_box, constant_context.constant.name)
				check
					list_item_not_void: list_item /= Void
				end
				list_item.select_actions.block
				list_item.enable_select
				list_item.select_actions.resume
				if last_selected_constant = Void then
					last_selected_constant := constant_context.constant
				end
				switch_constants_mode	
			else
				pixmap_path_agent.call (Void)
				l_pixmap_path := pixmap_path_agent.last_result
				return_pixmap_agent.call (Void)
				pixmap := return_pixmap_agent.last_result
				has_pixmap := pixmap /= Void
			
				constants_button.select_actions.block
				constants_button.disable_select
				switch_constants_mode
				constants_button.select_actions.resume
				if has_pixmap then
					add_pixmap_to_pixmap_container (pixmap)
					modify_button.set_text (Remove_button_text)
					modify_button.set_tooltip (remove_tooltip)
				else
					pixmap_container.wipe_out
					filler_label.wipe_out
					modify_button.set_text (Select_button_text)
					modify_button.set_tooltip (Select_tooltip)
					if l_pixmap_path /= Void then
						create error_label.make_with_text (Pixmap_missing_string)
						error_label.set_tooltip (l_pixmap_path)
						pixmap_container.extend (error_label)
						modify_button.set_text (clear_text)
						modify_button.set_tooltip (clear_tooltip)
					end
				end
			end
		end
		
	hide_frame is
			-- Ensure no frame is applied to `Current' and remove border from top level box.
		local
			container: EV_CONTAINER
			widget: EV_WIDGET
		do
			container := frame.parent
			container.prune (frame)
			widget := frame.item
			frame.wipe_out
			horizontal_box.set_border_width (0)
			container.extend (widget)
		ensure
			 frame_not_used: frame.parent = Void and frame.is_empty
		end
		
		
feature {GB_OBJECT_EDITOR} -- Implementation
		
	constant_removed (constant: GB_PIXMAP_CONSTANT) is
			-- Update `Current' to reflect removal of `constant' from system.
		require
			constant_not_void: constant /= Void
		local
			list_item: EV_LIST_ITEM
			item_selected: BOOLEAN
		do
			if constants_combo_box.selected_item /= Void and then
				constants_combo_box.selected_item.text.is_equal (constant.name) then
				constants_button.disable_select
			end
			list_item := list_item_with_matching_text (constants_combo_box, constant.name)
			check
				list_item_not_void: list_item /= Void
			end
			item_selected := list_item.is_selected
			constants_combo_box.prune_all (list_item)
--			if item_selected then
--				constants_combo_box.first.enable_select
--			end
		end
		
	constant_changed (constant: GB_PIXMAP_CONSTANT) is
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
			list_item.set_pixmap (constant.small_pixmap)
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
				pixmap_container.wipe_out
				filler_label.wipe_out
			else
				filler_label.show
				modify_button.show
				constants_combo_box.hide
				constants_combo_box.first.enable_select
				remove_selected_constant
			end
		end
		
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
		
	pixmap_container: EV_CELL
		-- Holds a representation of the loaded pixmap.
		
	execution_agent: PROCEDURE [ANY, TUPLE [EV_PIXMAP]]
		-- Agent to execute command associated with value entered into `Current'.
		
	validate_agent: FUNCTION [ANY, TUPLE [EV_PIXMAP], BOOLEAN]
		-- Is integer a valid integer for `execution_agent'.
		
	return_pixmap_agent: FUNCTION [ANY, TUPLE [], EV_PIXMAP]
	
	pixmap_path_agent: FUNCTION [ANY, TUPLE [], STRING]
		
	internal_gb_ev_any: GB_EV_ANY
		-- instance of GB_EV_ANY that is client of `Current'.
		
	frame: EV_FRAME
		-- Frame used for displaying title around `Current'.
		
	horizontal_box: EV_HORIZONTAL_BOX
		-- Main horizontal box used in construction of `Current'.
		
	internal_type: STRING
		--| The type of the property as it will appear in a constant context.
		--| For example "EV_BUTTONText" is how the constant may appear in an object
		--| reference, and "Text" is the internal type.
		
	last_selected_constant: GB_CONSTANT
		-- Last constant that was selected in `Current'.
		-- Must be stored so that when a user switches from using a constant,
		-- to an actual value, we can remove the constant from the object.
		-- Note that this will be set, if `Current' is built with a constant.
		
	object: GB_OBJECT
		-- Object referenced by `Current'.
		
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
			if pixmap.width < 32 then
				filler_label.wipe_out
				filler_label.extend (pixmap)
			else
				pixmap_container.wipe_out
				pixmap_container.extend (pixmap)
			end
			pixmap.set_minimum_size (pixmap.width, pixmap.height)
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
				lookup_string := internal_type
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
		
feature {NONE} -- Implementation

	modify_pixmap is
			-- Display a dialog allowing user input for
			-- selected pixmap.
		local
			dialog: EV_FILE_OPEN_DIALOG
			new_pixmap: EV_PIXMAP
			shown_once, opened_file: BOOLEAN
			error_dialog: EV_WARNING_DIALOG
			must_add_pixmap: BOOLEAN
		do
			pixmap_path_agent.call (Void)
			must_add_pixmap := pixmap_path_agent.last_result = Void
			if not constants_button.is_selected and then must_add_pixmap then
				from
					create dialog
				until
					(dialog.file_name.is_empty and shown_once) or opened_file
				loop
					shown_once := True
					dialog.show_modal_to_window (parent_window (Current))
					if not dialog.file_name.is_empty and then valid_file_extension (dialog.file_name.substring (dialog.file_name.count -2, dialog.file_name.count)) then
						create new_pixmap
						new_pixmap.set_with_named_file (dialog.file_name)
						execute_agent (new_pixmap, dialog.file_name)
							-- Must set the pixmap before the stretch takes place.
						add_pixmap_to_pixmap_container (new_pixmap.twin)
						modify_button.set_text (Remove_button_text)
						modify_button.set_tooltip (Remove_tooltip)
						opened_file := True
					elseif not dialog.file_name.is_empty then
						create error_dialog
						error_dialog.set_text (invalid_type_warning)
						error_dialog.show_modal_to_window (parent_window (Current))
					end
				end
			else
				execute_agent (Void, Void)
				pixmap_container.wipe_out
				filler_label.wipe_out
				modify_button.set_text (select_button_text)
				modify_button.set_tooltip (set_with_named_file_tooltip)
			end	
		end
		
	execute_agent (new_value: EV_PIXMAP; new_path: STRING) is
			-- call `execution_agent'. `new_value' may be Void
			-- in the case where we must remove the pixmap.
		do
			execution_agent.call ([new_value, new_path])
		end
		
	remove_constant is
			-- Remove constant represented within `Current' from associated properties.
		do
			execute_agent (Void, Void)
		end
		
	update_editors is
			--
		do
			update_editors_for_property_change (internal_gb_ev_any.objects.first, internal_gb_ev_any.type, internal_gb_ev_any.parent_editor)
		end
		
		
	filler_label: EV_CELL
	
	remove_selected_constant is
			-- Update `object' and `last_selected_constant' to reflect the
			-- fact that a user is no longer referencing `last_selected_constant'.
		local
			constant: GB_PIXMAP_CONSTANT
			constant_context: GB_CONSTANT_CONTEXT
		do
			if last_selected_constant /= Void then
				constant_context := object.constants.item (internal_gb_ev_any.type + internal_type)
				if constant_context /= Void then
					constant ?= constant_context.constant
					if not constants_combo_box.is_displayed then
							-- Now assign the value of `last_selected_item' to the control, but only
							-- if `constants_combo_box' is not displayed, meaning that a user has just
							-- changed from constants to non constants.
							execute_agent (Void, Void)
					end
					constant_context.destroy
				end
			last_selected_constant := Void
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
		do
			if list_item.data /= Void then
				constant ?= list_item.data
				check
					data_was_constant: constant /= Void
				end
--				FIXME No need to perform validation for pixamps.
--				validate_agent.call ([constant.pixmap])
--				if validate_agent.last_result then
					remove_selected_constant
					create constant_context.make_with_context (constant, object, internal_gb_ev_any.type, internal_type)
					constant.add_referer (constant_context)
					object.add_constant_context (constant_context)
					execute_agent (constant.pixmap, constant.pixmap.pixmap_path)
					last_selected_constant := constant
					update_editors
--				else
--					constants_combo_box.first.enable_select
--				end
			end
		end
		

invariant
	invariant_clause: True -- Your invariant here

end -- class GB_PIXMAP_INPUT_FIELD
