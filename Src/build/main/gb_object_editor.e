indexing
	description: "Objects that allow you to edit the properties of a widget."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_OBJECT_EDITOR

inherit
	EV_VERTICAL_BOX
		undefine
			is_in_default_state
		redefine
			initialize
		end

	INTERNAL
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

	GB_DEFAULT_STATE
		export
			{NONE} all
		end

	GB_NAMING_UTILITIES
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
			{ANY} parent_window
		undefine
			default_create, copy, is_equal
		end

	EIFFEL_RESERVED_WORDS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	BUILD_RESERVED_WORDS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	EV_STOCK_COLORS
		rename
			implementation as stock_colors_implementation
		export
			{NONE} all
		undefine
			copy, is_equal, default_create
		end

	GB_GENERAL_UTILITIES
		export
			{NONE} all
		undefine
			copy, is_equal, default_create
		end

	GB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			copy, is_equal, default_create
		end

	GB_SHARED_PIXMAPS
		export
			{NONE} all
		undefine
			copy, is_equal, default_create
		end

	GB_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal, default_create
		end

create
	make_with_components

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			default_create
		ensure
			components_set: components = a_components
		end

feature {EV_ANY} -- Initialization

	initialize is
			-- Initialize `Current'.
		local
			tool_bar: EV_TOOL_BAR
			separator: EV_HORIZONTAL_SEPARATOR
			vertical_box1: EV_VERTICAL_BOX
		do
			Precursor {EV_VERTICAL_BOX}
			set_border_width (3)
			create vertical_box1
			create tool_bar
			vertical_box1.extend (tool_bar)
			vertical_box1.disable_item_expand (tool_bar)
			tool_bar.extend (components.commands.object_editor_command.new_toolbar_item (True, False))
			create separator
			vertical_box1.extend (separator)
			vertical_box1.disable_item_expand (separator)
			create attribute_editor_box
			create scrollable_holder
			create viewport
			viewport.resize_actions.force_extend (agent viewport_resized)
			viewport.set_minimum_width (Minimum_width_of_object_editor)
			create scrollable_holder
			vertical_box1.extend (scrollable_holder)
			create control_holder
			create scroll_bar
			scroll_bar.set_step (12)
			control_holder.set_minimum_width (Minimum_width_of_object_editor)
			vertical_box1.set_minimum_width (Minimum_width_of_object_editor + scroll_bar.width)
			scrollable_holder.extend (viewport)
			viewport.extend (control_holder)
			control_holder.extend (attribute_editor_box)
			control_holder.disable_item_expand (attribute_editor_box)

			control_holder.resize_actions.force_extend (agent update_scroll_bar)
			viewport.resize_actions.force_extend (agent update_scroll_bar)
			scroll_bar.change_actions.extend (agent scroll_bar_changed)
			scroll_bar.hide
			scrollable_holder.extend (scroll_bar)
			scrollable_holder.disable_item_expand (scroll_bar)
			extend (vertical_box1)
			vertical_box1.set_minimum_height (100)

			create item_parent
			control_holder.extend (item_parent)
			control_holder.disable_item_expand (item_parent)
			is_initialized := True
		end

feature -- Access

	object: GB_OBJECT
		-- Object currently referenced by `Current'.
		-- All object modifications are applied to this
		-- object.

	has_object: BOOLEAN is
			-- Is an object being edited in `Current'?
		do
			Result := object /= Void
		end

feature -- Status setting

	set_object (an_object: GB_OBJECT) is
			-- Assign `an_object' to `object'.
			-- Set up `Current' to modify `object'.
		require
			an_object_not_void: an_object /= Void
		do
			make_empty

			object := an_object

				-- Set title of parent window to
				-- reflect the name.
			set_title_from_name

			construct_editor

			update_scroll_bar
		ensure
			an_object_set: object = an_object
		end

	make_empty is
			-- Remove all editor objects from `Current'.
			-- Assign `Void' to `object'.
		local
			current_parent_window: EV_WINDOW
			locked_in_here: BOOLEAN
		do
			current_parent_window := parent_window (Current)
			if name_field /= Void then
				name_field.focus_in_actions.block
				name_field.focus_out_actions.block
			end
			object := Void
			if current_parent_window /= Void and (application.locked_window = Void) then
				locked_in_here := True
				current_parent_window.lock_update
			end
			item_parent.wipe_out
			attribute_editor_box.wipe_out
			if current_parent_window /= Void and locked_in_here then
				current_parent_window.unlock_update
			end
			if name_field /= Void then
				name_field.focus_in_actions.resume
				name_field.focus_out_actions.resume
			end

		ensure
			now_empty: attribute_editor_box.count = 0
			object_is_void: object = Void
		end

	update_current_object is
			-- Update fields for `object'. This ensures that
			-- representation of `object' displayed in `Current'
			-- is up to date. For now, we just rebuild the whole
			-- tool. This can be optimized later.
		require
			object_not_void: object /= Void
		do
			set_object (object)
		ensure
			object_not_changed: old object = object
		end

	replace_object_editor_item (a_type: STRING) is
			-- Replace object editor item of type `a_type' with a newly built one.
			-- This forces an update due to the current state of `object'.
		local
			editor_item: GB_OBJECT_EDITOR_ITEM
		do
			editor_item := editor_item_by_type (a_type)
			if editor_item /= Void then
				editor_item.creating_class.update_attribute_editor
			end
		end

	editor_item_by_type (a_type: STRING): GB_OBJECT_EDITOR_ITEM is
			-- `Result' is editor item of type `a_type', contained
			-- in `Current'. Void if none exists.
		require
			type_starts_ev: a_type.count > 3 and a_type.substring (1, 3).is_equal ("EV_")
		local
			editor_item: GB_OBJECT_EDITOR_ITEM
		do
			from
				item_parent.start
			until
				item_parent.off or Result /= Void
			loop
				editor_item ?= item_parent.item
				if editor_item /= Void and (editor_item.type_represented).is_equal (a_type) then
					Result := editor_item
				end
				item_parent.forth
			end
		end

	flush is
			-- Remove `object' if it has been deleted.
		do
			if object /= Void and then components.object_handler.deleted_objects.has (object.id) then
				make_empty
			end
		end

feature {GB_COMMAND_ADD_CONSTANT, GB_COMMAND_DELETE_CONSTANT, GB_PIXMAP_SETTINGS_DIALOG, GB_CONSTANT} -- Implementation

	constant_added (a_constant: GB_CONSTANT) is
			-- Update `Current' to reflect adition of constant `a_constant'.
		require
			constant_not_void: a_constant /= Void
		do
			for_all_input_fields (agent constant_added_internal (?, a_constant))
		end

	constant_added_internal (input_field: GB_INPUT_FIELD; a_constant: GB_CONSTANT) is
			-- Update `input_field' to reflect the addition of `a_constant'.
		require
			input_field_not_void: input_field /= Void
			a_constant_not_void: a_constant /= Void
		do
			if input_field.type.is_equal (a_constant.type) then
				input_field.constant_added (a_constant)
			end
		end

	constant_changed (a_constant: GB_CONSTANT) is
			--  Update `Current' to reflect modification of constant `a_constant'.
		do
			for_all_input_fields (agent constant_changed_internal (?, a_constant))
		end

	constant_changed_internal (input_field: GB_INPUT_FIELD; a_constant: GB_CONSTANT) is
			-- Update `input_field' to reflect the modification of `a_constant'.
		require
			input_field_not_void: input_field /= Void
			a_constant_not_void: a_constant /= Void
		do
			if input_field.type.is_equal (a_constant.type) then
				input_field.constant_added (a_constant)
			end
		end

	constant_removed (a_constant: GB_CONSTANT) is
			-- Update `Current' to reflect removal of constant `a_constant'.
		require
			constant_not_void: a_constant /= Void
		do
			for_all_input_fields (agent constant_removed_internal (?, a_constant))
		end

	constant_removed_internal (input_field: GB_INPUT_FIELD; a_constant: GB_CONSTANT) is
			-- Update `input_field' to reflect the removal of `a_constant'.
		require
			input_field_not_void: input_field /= Void
			a_constant_not_void: a_constant /= Void
		do
			if input_field.type.is_equal (a_constant.type) then
				input_field.constant_removed (a_constant)
			end
		end

feature {GB_OBJECT_EDITORS} -- Implementation

	name_in_use (a_name: STRING): BOOLEAN is
			-- Is `a_name' a valid name for `object'? Not if it is already
			-- in use.
		require
			a_name_not_void: a_name /= Void
		do
			Result := components.object_handler.name_in_use (a_name, object) or (reserved_words.has (name_field.text.as_lower)) or
				(build_reserved_words.has (name_field.text.as_lower)) or components.constants.all_constants.item (a_name) /= Void
		end

	end_name_change_on_object is
			-- Update the object to reflect the edited name.
			-- If the edited name is not valid, then we restore the name of `object'
			-- to the previous name before the editing began.
		local
			command_name_change: GB_COMMAND_NAME_CHANGE
		do
			name_field.change_actions.block
				-- If the name exists, we must restore the name of `object' to
				-- the name before the name change began.
			if name_in_use (name_field.text) or (object.is_top_level_object and name_field.text.is_empty) then
				object.cancel_edited_name
				check
					object_names_now_equal: object.edited_name.is_equal (object.name)
				end
				set_title_from_name
				update_editors_for_name_change
				name_field.set_foreground_color (black)
				name_field.set_text (object.name)
			else
					-- Now check that the name has actually changed. If it has not changed,
					-- then do nothing.
				if not object.edited_name.is_equal (object.name) then
						-- Use the text in `name_field' as the new name of the object.
						-- We have guaranteed that the name is unique at this point.
					create command_name_change.make (object, object.edited_name, object.name, components)
					command_name_change.execute
				end
			end
			name_field.change_actions.resume
		end

feature {GB_OBJECT_EDITOR} -- Implementation

	update_event_selection_button_text is
			-- Change text displayed on `event_selection_button',
			-- dependent on number of items in events from `object'.
		do
			if object.events.is_empty then
				event_selection_button.set_text (Event_selection_text)
			else
				event_selection_button.set_text (Event_modification_text)
			end
		end

feature {NONE} -- Implementation

	viewport_resized is
			-- Adjust contents of `viewport' in response to viewport
			-- resizing
		do
			viewport.set_item_width (viewport.width)
		end

	do_not_allow_object_type (transported_object: GB_OBJECT): BOOLEAN is
		do
				-- If the object is not void, it means that
				-- we are not currently picking a type.
			if transported_object.object /= Void then
				Result := True
			end
		end

	set_title_from_name is
			-- Update title of top level window to reflect the
			-- name of the object in `Current'.
		do
			if not (current = components.object_editors.docked_object_editor) then
				if object.output_name.is_empty then
					parent_window (Current).set_title (object.short_type)
				else
					parent_window (Current).set_title (object.output_name)
				end
			end
		end

	construct_editor is
			-- Build `Current'. Build all attribute editors and populate,
			-- to represent `object'.
		require
			object_not_void: object /= Void
		local
			handler: GB_EV_HANDLER
			supported_types: ARRAYED_LIST [STRING]
			current_type: STRING
			gb_ev_any: GB_EV_ANY
			display_object: GB_DISPLAY_OBJECT
			separator: EV_HORIZONTAL_SEPARATOR
			label: EV_LABEL
			current_window_parent: EV_WINDOW
			locked_in_here: BOOLEAN
			horizontal_box: EV_HORIZONTAL_BOX
			tool_bar: EV_TOOL_BAR
			flatten_button, shallow_flatten_button: EV_TOOL_BAR_BUTTON
			text: STRING
		do
			current_window_parent := parent_window (Current)
			if current_window_parent /= Void and (application.locked_window = Void) then
				locked_in_here := True
				current_window_parent.lock_update
			end
			attribute_editor_box.wipe_out

			create label.make_with_text ("Type:")
			label.align_text_left
			attribute_editor_box.extend (label)
			attribute_editor_box.disable_item_expand (label)
			create label.make_with_text (object.actual_type)
			label.align_text_left
			attribute_editor_box.extend (label)
			attribute_editor_box.disable_item_expand (label)

			if components.system_status.is_in_debug_mode then
					-- provide additional information when in debug mode.
				create label
				text := (object.id.out + "%N")
				from
					object.instance_referers.start
				until
					object.instance_referers.off
				loop
					text.append (object.instance_referers.item_for_iteration.out + ", ")
					object.instance_referers.forth
				end
				if object.instance_referers.count > 0 then
					text.remove_tail (2)
				end
				label.set_text (text)
				attribute_editor_box.extend (label)
				label.pointer_double_press_actions.force_extend (agent show_id_dialog)
			end

			create label.make_with_text ("Name:")
			label.align_text_left
			attribute_editor_box.extend (label)
			attribute_editor_box.disable_item_expand (label)
			create name_field.make_with_text (object.name)

			--| FIXME - revisit
			--| I dont think this shoud be called here. Julian.
			object.set_edited_name (object.name)


			name_field.focus_in_actions.extend (agent start_name_change_on_object)
			name_field.focus_out_actions.extend (agent end_name_change_on_object)
			name_field.change_actions.extend (agent update_visual_representations_on_name_change)
			name_field.return_actions.extend (agent update_name_when_return_pressed)
			attribute_editor_box.extend (name_field)
			attribute_editor_box.disable_item_expand (name_field)

			if object.is_top_level_object then
				create client_check_button.make_with_text ("Generate as client")
				attribute_editor_box.extend (client_check_button)
				attribute_editor_box.disable_item_expand (label)
				if object.generate_as_client then
						-- Ensure that the button reflects the current state of `object'.
					client_check_button.enable_select
				end
				client_check_button.select_actions.extend (agent update_client_setting)
			end

			create separator
			separator.set_minimum_height (Object_editor_padding_width * 2)
			attribute_editor_box.extend (separator)
			attribute_editor_box.disable_item_expand (separator)

			if not object.is_instance_of_top_level_object then
				-- If `object' is representing a top level object, it is locked and must not be modified
				-- as all modification must be performed directly through the top level object itself.				
				create handler
				supported_types := handler.supported_types.twin
				from
					supported_types.start
				until
					supported_types.off
				loop
					current_type := supported_types.item
					current_type.to_upper
					if is_instance_of (object.object, dynamic_type_from_string (current_type.substring (4, current_type.count))) then
						gb_ev_any ?= new_instance_of (dynamic_type_from_string (current_type))
						gb_ev_any.set_components (components)
						gb_ev_any.set_parent_editor (Current)
						gb_ev_any.default_create
						gb_ev_any.set_object (object)
						check
							gb_ev_any_exists: gb_ev_any /= Void
						end
						gb_ev_any.add_object (object.object)

							-- We need to check that the display_object is not of type `GB_DISPLAY_OBJECT'.
							-- If it is, we must add its child, as this is the object that must be modified.
						display_object ?= object.display_object
						if display_object /= Void then
							gb_ev_any.add_object (display_object.child)
						else
							gb_ev_any.add_object (object.display_object)
						end

							-- Now add a separator between each attribute editor.
						create separator
						separator.set_minimum_height (Object_editor_padding_width * 2)
						item_parent.extend (separator)
						item_parent.disable_item_expand (separator)

							-- Add the new editor to `item_parent'.
						item_parent.extend (gb_ev_any.attribute_editor)
					end
					supported_types.forth
				end

					-- Now we add the button which will bring up the events window.
					-- We do not display the events button if the type is a tool bar separator
					-- or a menu separator, as the export status of the events is hidden.
				if not object.type.is_equal ("EV_TOOL_BAR_SEPARATOR") and
				not object.type.is_equal ("EV_MENU_SEPARATOR") then
					create event_selection_button
					create tool_bar
					tool_bar.extend (event_selection_button)
					update_event_selection_button_text
					create horizontal_box
					horizontal_box.extend (tool_bar)
					horizontal_box.disable_item_expand (tool_bar)
					attribute_editor_box.extend (horizontal_box)
					event_selection_button.select_actions.extend (agent show_event_dialog)
				end
			else
					-- We are representing a top level widget so perform some slightly modified building in this case.

					-- Build and insert a button that may be used to flatten `object'.
				create horizontal_box

				create tool_bar
				create shallow_flatten_button.make_with_text ("Flatten")
				shallow_flatten_button.select_actions.extend (agent flatten_object (False))
				tool_bar.extend (shallow_flatten_button)
				horizontal_box.extend (tool_bar)
				horizontal_box.disable_item_expand (tool_bar)

				create tool_bar
 				create flatten_button.make_with_text ("Deep Flatten")
				attribute_editor_box.extend (horizontal_box)
				flatten_button.select_actions.extend (agent flatten_object (True))
				tool_bar.extend (flatten_button)
				horizontal_box.extend (tool_bar)
				horizontal_box.disable_item_expand (tool_bar)

			end

			if current_window_parent /= Void and locked_in_here then
				current_window_parent.unlock_update
			end
		end

	flatten_object (deep_flatten: BOOLEAN) is
			-- Flatten `object'.
		require
			object_not_void: object /= Void
		local
			command_flatten: GB_COMMAND_FLATTEN_OBJECT
		do
			create command_flatten.make (object, deep_flatten, components)
			command_flatten.execute
		end


	update_client_setting is
			-- Update client setting of `object'.
		require
			object_is_top_level: object.is_top_level_object
		local
			warning_dialog: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
				-- Warn user if the file already exists.
			if preferences.dialog_data.show_changing_client_type_warning then
				if object.widget_selector_item.file_exists then
					create warning_dialog.make_initialized (2, preferences.dialog_data.show_changing_client_type_warning_string, changing_client_warning, "Do not show again", preferences.preferences)
					warning_dialog.set_icon_pixmap (Icon_build_window @ 1)
					warning_dialog.set_cancel_action (agent undo_client_change)
					warning_dialog.set_ok_action (agent internal_update_client_setting)
					warning_dialog.show_modal_to_window (parent_window (Current))
				else
					internal_update_client_setting
				end
			else
				internal_update_client_setting
			end
		end

	undo_client_change is
			-- Restore `client_check_button' to original state before it was
			-- selected by a user.
		do
			client_check_button.select_actions.block
			client_check_button.toggle
			client_check_button.select_actions.resume
		end


	internal_update_client_setting is
			-- Actually perform the client setting of `object' in response
			-- to a change.
		require
			object_is_top_level: object.is_top_level_object
		do
			if client_check_button.is_selected then
				object.enable_client_generation
			else
				object.disable_client_generation
			end
			components.system_status.mark_as_dirty
		end

	show_event_dialog is
			-- Display the event dialog
		require
			object_not_void: object /= Void
		local
			event_dialog: GB_EVENT_SELECTION_DIALOG
		do
			create event_dialog.make_with_object (object, components)
			event_dialog.show_modal_to_window (parent_window (Current))
			update_event_selection_button_text
			components.object_editors.update_editors_by_calling_feature (object.object, Current, agent {GB_OBJECT_EDITOR}.update_event_selection_button_text)
		end

	update_visual_representations_on_name_change is
			-- Update visual representations of `object' to reflect new name
			-- in `name_field'.
		local
			current_text: STRING
		do
			current_text := name_field.text.as_lower
			if valid_class_name (current_text) or current_text.is_empty then
				object.set_edited_name (current_text)
				if name_in_use (current_text) then
					name_field.set_foreground_color (red)
				else
					name_field.set_foreground_color (black)
				end
					-- Update title of window.
				set_title_from_name
					-- Must be performed after we have actually changed the name of the object.
				update_editors_for_name_change
					-- We now inform the system that the user has modified something
				components.system_status.mark_as_dirty
			else
				undo_last_character (name_field)
			end
		end

	update_editors_for_name_change is
			-- Call `update_editors_by_calling_feature' with object.object,
			-- `Current', and the procedure update_name_field as arguments.
		do
			components.object_editors.update_editors_by_calling_feature (object.object, Current, agent {GB_OBJECT_EDITOR}.update_name_field)
		end


	start_name_change_on_object is
			-- Inform object that a name change has begun.
		require
			object_not_void: object /= Void
		do
				-- Ensure edited_namd and name for the object are
				-- identical. We should be in a state where name is valid
				-- and unique at this point.
			object.set_edited_name (object.name)
		end

	update_name_when_return_pressed is
			-- Return has been pressed in `name_field'. We must now either accept the new
			-- name for `object' if it is valid and unique. If it is not, then we notify the user
			-- with a warning dialog, telling them that the name already exists, and giving the option
			-- to continue changing the name, or to cancel the name change.
		local
			my_dialog: GB_DUPLICATE_OBJECT_NAME_DIALOG
			previous_caret_position: INTEGER
			command_name_change: GB_COMMAND_NAME_CHANGE
		do
			name_field.focus_out_actions.block
			if not name_field.text.is_empty and then name_in_use (name_field.text) then
				previous_caret_position := name_field.caret_position
				create my_dialog.make_with_text (Duplicate_name_warning_part1 + name_field.text + Duplicate_name_warning_part2)
				my_dialog.show_modal_to_window (parent_window (Current))
				my_dialog.destroy
				if my_dialog.selected_button.is_equal ("Modify") then
					restore_name_field (name_field.text, previous_caret_position)
				else
						-- Restore name as edit was "cancelled".
					restore_name_field (object.name, object.name.count + 1)
						-- Reflect changes in all editors.
					update_editors_for_name_change
				end
			elseif not object.edited_name.is_equal (object.name) then

					-- This is a command so it is added to the history. Pressing Return
					-- does accept the name, even though we still have the focus in the text field
					-- and are editing it.
				create command_name_change.make (object, object.edited_name, object.name, components)
				command_name_change.execute
			end
			name_field.focus_out_actions.resume
		end

	restore_name_field (a_text: STRING; caret_position: INTEGER) is
			-- Assign `a_text' to text of `name_field', set the caret position
			-- to `caret_position' and give `name_field' the focus.
		require
			a_text_not_void: a_text /= Void
			valid_caret_position : caret_position >= 1 and caret_position <= a_text.count + 1
		do
			name_field.set_text (a_text)
			name_field.set_caret_position (caret_position)
			name_field.set_focus
		ensure
			text_set: name_field.text.is_equal (a_text)
			caret_position_set: name_field.caret_position = caret_position
			focus_set: name_field.has_focus
		end

	update_scroll_bar is
			-- Show/hide the scroll bar as appropriate. Modify the
			-- range of the scroll bar as needed.
		local
			interval: INTEGER_INTERVAL
			timeout: EV_TIMEOUT
			locked_in_this_feature: BOOLEAN
		do
			if viewport.height < control_holder.minimum_height then
				if not scroll_bar.is_show_requested then
					if (application.locked_window = Void) then
						locked_in_this_feature := True
						parent_window (Current).lock_update
					end
					viewport.resize_actions.pause
					control_holder.resize_actions.pause
						-- There is no way ti resize a box in a viewport to
						-- be smaller, so we must rebuild a new box,
						-- and expand it by putting the items in.
					control_holder.wipe_out
					viewport.prune_all (control_holder)
					create control_holder
					viewport.extend (control_holder)
					control_holder.extend (attribute_editor_box)
					control_holder.disable_item_expand (attribute_editor_box)
					control_holder.extend (item_parent)
					control_holder.disable_item_expand (item_parent)

						-- Set up the minimum width on the new box.
					control_holder.set_minimum_width (Minimum_width_of_object_editor)
					viewport.set_minimum_width (Minimum_width_of_object_editor)
					control_holder.resize_actions.force_extend (agent update_scroll_bar)
						-- Create a timeout and set up the action to fix a Windows
						-- Vision2 bug. See comment in `show_scroll_bar_again'.
					create timeout.make_with_interval (5)
					timeout.actions.extend (agent show_scroll_bar_again (timeout))
					scroll_bar.show

					viewport.resize_actions.resume
					control_holder.resize_actions.resume
					if locked_in_this_feature then
						parent_window (Current).unlock_update
					end
				end
			else
				scroll_bar.hide
				scroll_bar_changed (0)
				control_holder.set_minimum_width (Minimum_width_of_object_editor + scroll_bar.width)
				viewport.set_minimum_width (Minimum_width_of_object_editor + scroll_bar.width)
			end
				-- If the scroll bar is visible then we must update the values
				-- to match the size of the
			if scroll_bar.is_show_requested then
				create interval.make (0, control_holder.minimum_height - viewport.height)
				if viewport.height > 0 then
					scroll_bar.set_leap (viewport.height)
				end
				scroll_bar.value_range.adapt (interval)
				scroll_bar_changed (scroll_bar.value)
			end
		end

	show_scroll_bar_again (a_timeout: EV_TIMEOUT) is
			-- Call show on `scroll_bar' and destroy `a_timeout'.
			-- This is needed, as there is a Vision2 resizing bug on Windows
			-- which stops teh scroll bar being displayed when it is first shown, as you
			-- resize the main window smaller. Therefore,
			-- we call show on it after the resizing has occured to combat this problem.
			-- There should be no ill effects on either platform.
		do
			scroll_bar.show
			a_timeout.destroy
		end

	scroll_bar_changed (value: INTEGER) is
			-- Set the offset of the controls to `Value'
			-- within the viewport.
		do
			viewport.set_y_offset (value)
		end

	item_parent: EV_VERTICAL_BOX
		-- An EV_VERTICAL_BOX to hold all GB_OBJECT_EDITOR_ITEM.

	name_field: EV_TEXT_FIELD
		-- Entry for the object name.

	event_selection_button: EV_TOOL_BAR_BUTTON
		-- Brings up the event selection dialog.

	attribute_editor_box: EV_VERTICAL_BOX
		-- All attribute editors are placed in here.

	scrollable_holder: EV_HORIZONTAL_BOX
		-- Holds the viewport and a scrollbar.

	scroll_bar: EV_VERTICAL_SCROLL_BAR
		-- Scroll bar to control the positioning of the object editor.

	viewport: EV_VIEWPORT
		-- Viewport containg the attribute editors.

	control_holder: EV_VERTICAL_BOX
		-- Holds the controls, and is placed in the scrollable area.

	client_check_button: EV_CHECK_BUTTON
		-- Enables a user to specify if `Current' uses EiffelVision as a client or not.

	for_all_input_fields (action: PROCEDURE [ANY, TUPLE [GB_INPUT_FIELD]]) is
			-- For all input fields within `Current', call `action'.
		require
			action_not_void: action /= Void
		do
			for_all_input_fields_internal (item_parent, action)
		end

	for_all_input_fields_internal (a_parent: EV_WIDGET_LIST; action: PROCEDURE [ANY, TUPLE [GB_INPUT_FIELD]]) is
			-- For all input fields within `a_parent', call `action'.
		require
			a_parent_not_void: a_parent /= Void
			action_not_void: action /= Void
		local
			widget_list: EV_WIDGET_LIST
			input_field: GB_INPUT_FIELD
			a_cursor: CURSOR
			current_item: EV_WIDGET
		do
			from
				a_cursor := a_parent.cursor
				a_parent.start
			until
				a_parent.off
			loop
				current_item := a_parent.item
				input_field ?= current_item
				if input_field /= Void then
					action.call ([input_field])
				else
					widget_list ?= current_item
					if widget_list /= Void then
						for_all_input_fields_internal (widget_list, action)
					end
				end
				a_parent.forth
			end
			a_parent.go_to (a_cursor)
		ensure
			index_not_changed: old a_parent.index = a_parent.index
		end

feature -- Implementation

	update_name_field is
			-- Update `name_field' to reflect `object.name'.
			-- Used when a name changes from another
			-- object editor. All must be updated.
		do
			set_title_from_name
			name_field.change_actions.block
			name_field.set_text (object.edited_name)
			name_field.change_actions.resume
		end

	update_merged_containers is
			-- Update object editors to reflect merged
			-- containers having changed.
		local
			container_object: GB_CONTAINER_OBJECT
		do
			container_object ?= object
			if container_object /= Void then
				replace_object_editor_item ("EV_CONTAINER")
			end
		end

feature {NONE} -- Debug information

	show_id_dialog is
			-- Show a dialog permitting enty of a particular object id to be viewed.
		require
			is_in_debug_mode: components.system_status.is_in_debug_mode
		local
			dialog: EV_DIALOG
			text_field: EV_TEXT_FIELD
			vertical_box: EV_VERTICAL_BOX
			instance_viewer: GB_INSTANCE_VIEWER
			horizontal_box: EV_HORIZONTAL_BOX
			close_button: EV_BUTTON
		do
			create dialog
			create vertical_box
			create text_field
			dialog.extend (vertical_box)
			text_field.return_actions.extend (agent highlight_object (text_field))
			text_field.return_actions.extend (agent dialog.hide)
			create instance_viewer.make_with_object_and_parent (object, vertical_box, components)
			vertical_box.extend (text_field)
			vertical_box.disable_item_expand (text_field)
			create horizontal_box
			vertical_box.extend (horizontal_box)
			vertical_box.disable_item_expand (horizontal_box)
			horizontal_box.extend (create {EV_CELL})
			create close_button.make_with_text ("Close")
			close_button.select_actions.extend (agent dialog.destroy)
			horizontal_box.extend (close_button)
			horizontal_box.disable_item_expand (close_button)
			dialog.set_default_cancel_button (close_button)
			dialog.set_minimum_size (640, 480)
			dialog.show_modal_to_window (parent_window (Current))
		end

	highlight_object (text_field: EV_TEXT_FIELD) is
			-- Ensure `an_object' is highlighted object in `Current'.
			-- Only if `an_object' is contained in the structure of `Current', and
			-- is not a titled window.
		local
			an_object: GB_OBJECT
		do
			if text_field.text.is_integer then
				an_object := components.object_handler.objects.item (text_field.text.to_integer)
				if an_object /= Void then
					an_object.top_level_parent_object.widget_selector_item.enable_select
					an_object.layout_item.enable_select
					an_object.layout_item.parent_tree.ensure_item_visible (an_object.layout_item)
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_OBJECT_EDITOR
