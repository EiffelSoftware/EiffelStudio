indexing
	description: "Objects that allow you to edit the properties of a widget."
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
		undefine
			is_equal, copy, default_create
		end
		
	GB_CONSTANTS
		undefine
			is_equal, copy, default_create
		end

	GB_DEFAULT_STATE
	
	GB_ACCESSIBLE_OBJECT_EDITOR
		undefine
			default_create, copy, is_equal
		end
		
	GB_NAMING_UTILITIES
		undefine
			default_create, copy, is_equal
		end
		
	GB_ACCESSIBLE_COMMAND_HANDLER
		undefine
			default_create, copy, is_equal
		end
		
	GB_ACCESSIBLE_SYSTEM_STATUS
		undefine
			default_create, copy, is_equal
		end

feature -- Initialization

	initialize is
			-- Initialize `Current'.
		local
			
			tool_bar: EV_TOOL_BAR
			tool_bar_button: EV_TOOL_BAR_BUTTON
			separator: EV_HORIZONTAL_SEPARATOR
			vertical_box1: EV_VERTICAL_BOX
		do
			Precursor {EV_VERTICAL_BOX}
			create vertical_box1
			extend (vertical_box1)
			create tool_bar
			vertical_box1.extend (tool_bar)
			vertical_box1.disable_item_expand (tool_bar)
			tool_bar.extend (command_handler.object_editor_command.new_toolbar_item (True, False))
			create separator
			vertical_box1.extend (separator)
			vertical_box1.disable_item_expand (separator)
			create attribute_editor_box
			vertical_box1.extend (attribute_editor_box)
			vertical_box1.disable_item_expand (attribute_editor_box)
			create item_parent
			vertical_box1.extend (item_parent)
			vertical_box1.disable_item_expand (item_parent)
			set_minimum_width (Minimum_width_of_object_editor)
			is_initialized := True
		end
		
		do_not_allow_object_type (transported_object: GB_OBJECT): BOOLEAN is
			do
					-- If the object is not void, it means that
					-- we are not currently picking a type.
				if transported_object.object /= Void then
					Result := True
				end
			end

feature -- Access

	object: GB_OBJECT
		-- Object currently referenced by `Current'.
		-- All object modifications are applied to this
		-- object.

feature {GB_EV_ANY} -- Access

	window_parent: EV_WINDOW is
			-- `Result' is EV_WINDOW containing `Current'.
		local
			window: EV_WINDOW
		do
			window ?= parent
			if window /= Void then
				Result := window
			else
				Result := get_window_parent_recursively (parent)
			end
		end
		
	get_window_parent_recursively (w: EV_WIDGET): EV_WINDOW is
			-- Result is EV_WINDOW containing `w'.
		local
			window: EV_WINDOW
		do
			window ?= w.parent
			if window /= Void then
				Result := window
			else
				Result := get_window_parent_recursively (w.parent)
			end
		end

feature -- Measurement

feature -- Status report

feature -- Status setting

	set_object (an_object: GB_OBJECT) is
			-- Assign `an_object' to `object'.
			-- Set up `Current' to modify `object'.
		do
			make_empty
			
			object := an_object
			
			--| FIXME need to actually check the types that `Current' conforms to
			--| and then build the object_editors dynamically.
			construct_editor	
		end
		
	make_empty is
			-- Remove all editor objects from `Current'.
			-- Assign `Void' to `object'.
		do
			object := Void
			window_parent.lock_update
			item_parent.wipe_out
			attribute_editor_box.wipe_out
			window_parent.unlock_update
		ensure
			now_empty: attribute_editor_box.count = 0
			object_is_void: object = Void
		end
		
	update_current_object is
			--
		local
			an_object: GB_OBJECT
		do
			an_object := object
			set_object (an_object)
		end
		
	replace_object_editor_item (a_type: STRING) is
			-- Replace object editor item of type `a_type' with a newly built one.
			-- This forces an update due to the current state of `object'.
		local
			found: BOOLEAN
			editor_item: GB_OBJECT_EDITOR_ITEM
		do
			from
				item_parent.start
			until
				item_parent.off or found
			loop
				editor_item ?= item_parent.item
				check
					editor_item_not_void: editor_item /= Void
				end
				if editor_item.type_represented.is_equal (a_type) then
					found := True
					editor_item.creating_class.update_attribute_editor
				end
				item_parent.forth
			end
		end
		

feature {NONE} -- Implementation

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
		do
			window_parent.lock_update
			attribute_editor_box.wipe_out
			create label.make_with_text ("Type:")
			label.align_text_left
			attribute_editor_box.extend (label)
			attribute_editor_box.disable_item_expand (label)
			create label.make_with_text (object.type.substring (4, object.type.count))
			label.align_text_left
			attribute_editor_box.extend (label)
			attribute_editor_box.disable_item_expand (label)
			
			create label.make_with_text ("Name:")
			label.align_text_left
			attribute_editor_box.extend (label)
			attribute_editor_box.disable_item_expand (label)
			create name_field.make_with_text (object.name)
			name_field.change_actions.extend (agent update_visual_representations_on_name_change)
			attribute_editor_box.extend (name_field)
			attribute_editor_box.disable_item_expand (name_field)
			
			create separator
			attribute_editor_box.extend (separator)
			attribute_editor_box.disable_item_expand (separator)
			
			
			
			create handler
			supported_types := clone (handler.supported_types)
			from
				supported_types.start
			until
				supported_types.off
			loop
				current_type := supported_types.item
				current_type.to_upper
				if is_instance_of (object.object, dynamic_type_from_string (current_type.substring (4, current_type.count))) then
					gb_ev_any ?= new_instance_of (dynamic_type_from_string (current_type))
					gb_ev_any.set_parent_editor (Current)
					gb_ev_any.default_create
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
					
					item_parent.extend (gb_ev_any.attribute_editor)
				end
				supported_types.forth
			end
			window_parent.unlock_update
		end
		
	update_visual_representations_on_name_change is
			-- Update visual representations of `object' to reflect new name
			-- in `name_field'.
		local
			current_caret_position: INTEGER
		do
			if valid_class_name (name_field.text) or name_field.text.is_empty then
				if name_field.text.is_empty then
					object.layout_item.set_text (object.type.substring (4, object.type.count))
				else
					object.layout_item.set_text (name_field.text + ": " + object.type.substring (4, object.type.count))			
				end
				object.set_name (name_field.text)
					-- Must be performed after we have actually changed the name of the object.
				update_editors_for_name_change (object.object, Current)
					-- We now inform the system that the user has modified something
				system_status.enable_project_modified
				command_handler.update	
			else
				current_caret_position := name_field.caret_position
				name_field.change_actions.block
					-- We must handle three different cases in order to restore the text if an
					-- invalid character was received.
				if current_caret_position = name_field.text.count + 1 then
					name_field.set_text (name_field.text.substring (1, name_field.text.count - 1))
					name_field.set_caret_position (current_caret_position)
				elseif current_caret_position = 2 then
					name_field.set_text (name_field.text.substring (2, name_field.text.count))	
					name_field.set_caret_position (1)
				else
					name_field.set_text (name_field.text.substring (1, current_caret_position - 2) + name_field.text.substring (current_caret_position, name_field.text.count))
					name_field.set_caret_position (current_caret_position - 1)
				end
				name_field.change_actions.resume
			end
		end

	item_parent: EV_VERTICAL_BOX
		-- An EV_VERTICAL_BOX to hold all GB_OBJECT_EDITOR_ITEM.
		
	name_field: EV_TEXT_FIELD
		-- Entry for the object name.
		
	attribute_editor_box: EV_VERTICAL_BOX
		-- All attribute editors are placed in here.
	
feature {GB_ACCESSIBLE_OBJECT_EDITOR} -- Implementation

	update_name_field is
			-- Update `name_field' to reflect `object.name'.
			-- Used when a name changes from another
			-- object editor. All must be updated.
		do
			name_field.change_actions.block
			name_field.set_text (object.name)
			name_field.change_actions.resume
		end

end -- class GB_OBJECT_EDITOR
