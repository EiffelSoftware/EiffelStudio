indexing
	description: "Object representing a Build object."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_OBJECT
	
inherit
	
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
	
	GB_SHARED_OBJECT_EDITORS
		export
			{NONE} all
		end
	
	GB_XML_UTILITIES
		export
			{NONE} all
		end
	
	GB_SHARED_HISTORY
		export
			{NONE} all
		end
	
	GB_SHARED_COMMAND_HANDLER
		export
			{NONE} all
		end
	
	GB_XML_OBJECT_BUILDER
		export
			{NONE} all
			{GB_COMMAND_NAME_CHANGE, GB_COMPONENT, GB_OBJECT_HANDLER} object_handler
		end
	
	GB_SHARED_XML_HANDLER
		export
			{NONE} all
		end
	
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end
	
	EV_ANY_HANDLER
		export
			{NONE} all
		end
	
	GB_SHARED_ID
		export
			{NONE} all
		end
	
	GB_SHARED_STATUS_BAR
		export
			{NONE} all
		end

feature {GB_OBJECT_HANDLER} -- Initialization
	
	make_with_type (a_type: STRING) is
			-- Create `Current' with type `a_type'.
			-- Do not instantiate `object' from type.
		do
			type := a_type
				-- The names should never be `Void'.
			create name.make (0)
			create events.make (0)
			create constants.make (0)
			create edited_name.make (0)
		ensure
			type_assigned: type = a_type
		end
		
	make_with_type_and_object (a_type: STRING; an_object: EV_ANY) is
			-- Create `Current', attach `an_object' to `object' and
			-- `a_type' to `type'.
		require
			an_object_not_void: an_object /= Void
			type_matches_object: type_matches_object (a_type, an_object)
		do
			object := an_object
			type := a_type
			build_display_object
			create name.make (0)
			create events.make (0)
			create constants.make (0)
			create edited_name.make (0)
			id := new_id
		ensure
			type_assigned: type = a_type
			object_assigned: object = an_object
		end

feature -- Access

	id: INTEGER
		-- A unique id representing `Current'.
		-- This is stored in the XML.

	object: EV_ANY
		-- The vision2 object that `Current' represents.
		
	display_object: EV_ANY
		-- The representation of `object' used in `build_window'.
		
	layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		-- Representation of `object' used in GB_LAYOUT_CONSTRUCTOR.
		
	name: STRING
		-- User set name for `Current'.
		
	events: ARRAYED_LIST [GB_ACTION_SEQUENCE_INFO]
		-- All events connected to `Current'.
		
	constants: HASH_TABLE [GB_CONSTANT_CONTEXT, STRING]
		-- All constants connected to `Current'.
		
	type: STRING
		-- A type corresponding to the current vision2 object.
		-- Contains "EV_" at start.
		
	is_expanded: BOOLEAN
		-- Is representation of `Current' currently expanded?
		-- Used to expand and collapse `layout_constructor_item' as required
		-- when displaying or hiding `Current'. 
		
	short_type: STRING is
			-- Result is a short version of type with "EV_" removed from start.
		require
			valid_type: type.count > 4 and type.substring (1, 3).is_equal ("EV_")
		do
			Result := type.substring (4, type.count)
		ensure
			Result_correct : ("EV_" + Result).is_equal (type)
		end
		
		
	parent_object: GB_OBJECT is
			-- `Result' is object containing `Current'.
			-- `Void' if none.
		local
			layout_parent_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			if layout_item /= Void then
				layout_parent_item ?= layout_item.parent
					-- If the object is a window then the layout parent will be Void
				if layout_parent_item /= Void then
					Result ?= layout_parent_item.object		
				end
			end	
		ensure
			window_has_no_parent_object: is_instance_of (object, dynamic_type_from_string (ev_window_string)) implies Result = Void
		end
		
	top_level_parent_object: GB_OBJECT is
			-- `Result' is top level object containing `Current'.
			-- That is, the object that has no parent object of its own.
			-- Will return `Current' if `Current' has no `parent_object'.
		local
			a_parent_object: GB_OBJECT
		do
			from
				a_parent_object := Current
			until
				a_parent_object = Void
			loop
				Result := a_parent_object
				a_parent_object := a_parent_object.parent_object
				if a_parent_object /= Void then
					Result := a_parent_object
				end
			end
		ensure
			result_not_void: Result /= Void
		end
		
		
	all_children_recursive (a_list: ARRAYED_LIST [GB_OBJECT]) is
			-- Add all children of `Current' recursively, to
			-- `a_list'.
		require
			a_list_not_void: a_list /= Void
		local
			current_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			from
				layout_item.start
			until
				layout_item.off
			loop
				current_item ?= layout_item.item
				check
					current_item_not_void: current_item /= Void
				end
				a_list.extend (current_item.object)
				current_item.object.all_children_recursive (a_list)
				layout_item.forth
			end
		end

feature {GB_OBJECT_HANDLER, GB_OBJECT, GB_COMMAND_CHANGE_TYPE} -- Deletion
			
		delete is
				-- Perform any necessary pre processing for
				-- a deletion of `Current' from the system.
			do
				-- Redefine in descendents that need to handle
				-- special processing for a delete.
			end

feature {GB_XML_STORE, GB_XML_LOAD, GB_XML_OBJECT_BUILDER}

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of sepecific attributes of `Current'
			-- in `element'.
		require
			element_not_void: element /= Void
		do
			add_element_containing_integer (element, Id_string, id)
			if not name.is_empty then
				add_element_containing_string (element, name_string, name)
			end
			add_element_containing_integer (element, "Expanded", is_expanded.to_integer)
		end
		
	modify_from_xml (element: XM_ELEMENT) is
			-- Update `Current' based on information held in `element'.
		require
			element_not_void: element /= Void
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Id_String)
				-- Although every saved object should have an ID, 
				-- we allow there to be none, to maintain backwards compatibility.
			if element_info /= Void then
				id := (element_info.data).to_integer	
			end
			element_info := full_information @ (name_string)
			if element_info /= Void then
				name := element_info.data
				layout_item.set_text (name + ": " + short_type)
			end
			element_info := full_information @ ("Expanded")
			if element_info /= Void then
				if element_info.data.to_integer = 1 then
					is_expanded := True
				end
			end
		end

feature {GB_LAYOUT_CONSTRUCTOR_ITEM, GB_OBJECT_HANDLER, GB_WINDOW_SELECTOR} -- Status setting

	set_layout_item (a_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM) is
			-- Assign `a_layout_item' to `layout_item'.
		require
			layout_item_not_void: a_layout_item /= Void
		do
			layout_item ?= a_layout_item
			layout_item.set_object (Current)
			build_drop_actions_for_layout_item
		ensure
			layout_item_set: layout_item = a_layout_item
			layout_item_object_set: layout_item.object = Current
		end
		
feature {GB_OBJECT_HANDLER, GB_COMMAND_DELETE_OBJECT, GB_OBJECT, GB_COMMAND_ADD_OBJECT} -- Status setting

	unparent is
			-- Removed `Current' from its parents. All representations
			-- of `an_object' must be removed from their parents to
			-- concide with this change.
		
		do
			unparent_ev_object (object)
			unparent_ev_object (display_object)

			layout_item.unparent
			
				-- Notify the system that we have modified something.
			system_status.enable_project_modified
			command_handler.update
		ensure
			layout_item_parent_void: layout_item.parent = Void
		end

feature {GB_OBJECT_HANDLER} -- Status setting

	unparent_during_type_change is
			-- Removed `Current' from its parent during a type change.
			-- We keep the existing layout item of the original widget which
			-- allows us to access the new object in the history after the type
			-- change has completed.
		do
			unparent_ev_object (object)
			unparent_ev_object (display_object)
			
				-- Notify the system that we have modified something.
			system_status.enable_project_modified
			command_handler.update
		end
		
feature {GB_OBJECT_HANDLER, GB_ID_COMPRESSOR} -- Status setting

	assign_id is
			-- Assign a new `id' to `Current'.
		require
			id_not_assigned: id = 0
		do
			id := new_id
		ensure
			id_set: id /= 0
		end

feature {GB_OBJECT_HANDLER, GB_OBJECT, GB_BUILDER_WINDOW} -- Element change

	create_object_from_type is
			-- Create an object of type `type' and assign
			-- to `object'.
		require
			no_object_associated: object = Void
		do
			object := vision2_object_from_type (type)
		ensure
			object_initialized: object /= Void
		end
		
	can_add_child (object_representation: ANY): BOOLEAN is
			-- May an object represented by `object_representation' be added
			-- to `Current'. `object_representation' may be either a GB_COMPONENT or a 
			-- GB_OBJECT. We do not just create an object from the component and use that,
			-- as this can be very slow, and this feature is called many times during
			-- a pick and drop.
		local
			env: EV_ENVIRONMENT
			local_parent_object: GB_OBJECT
			an_object: GB_OBJECT
			a_component: GB_COMPONENT
			new_type: STRING
			new_short_type: STRING
			funct_result: BOOLEAN
		do
			an_object ?= object_representation
				-- We get the new type of the object to be added. With this
				-- information, we can then see if `Current' will accept
				-- a child of this type.
			if an_object /= Void then
				new_type := an_object.type
				new_short_type := an_object.short_type
			else
				-- If we are not an object, then we must be a component.
				a_component ?= object_representation
				check
					is_component: a_component /= Void
				end
				new_type := a_component.root_element_type
				new_short_type := new_type.substring (4, new_type.count)
			end
			Result := True
			create env
			if env.application.shift_pressed then
				local_parent_object := parent_object
					-- If we are at the top level. i.e. a window,
					-- there will be no parent.
				if local_parent_object /= Void then
					Result := not local_parent_object.is_full
					if local_parent_object /= Void then
							-- We only need to check this if we are not a component,
							-- as this means there is no way we could be contained in `Current'.
						if an_object /= Void then
							funct_result := parent_object.override_drop_on_child (an_object)
							if not funct_result then
									-- Now display output if we are attempting to insert the object in itself
									-- or one of its children.
								display_parent_in_child_message (an_object, parent_object, new_type)			
							end
							Result := Result and funct_result
						end
						funct_result := local_parent_object.accepts_child (new_type)
							-- We now display information in status bar regarding full status.
						display_invalid_drop_message (parent_object, new_type, funct_result)
						Result := Result and funct_result
					end
				else
					Result := False
				end
			else
				Result := not is_full

				funct_result := accepts_child (new_type)
					-- We now display information in status bar regarding full status.
				display_invalid_drop_message (Current, new_type, funct_result)					
				Result := Result and funct_result
					-- We only need to check this if we are not a component,
					-- as this means there is no way we could be contained in `Current'.
				if an_object /= Void then
					funct_result := override_drop_on_child (an_object)
					if not funct_result then
							-- Now display output if we are attempting to insert the object in itself
							-- or one of its children.
						display_parent_in_child_message (an_object, Current, new_type)
					end
					Result := Result and funct_result
				end
			end
			if Result then
				status_bar_label.remove_text
			end
		end

	create_layout_item is
			-- Create a layout_item associated with `Current'.
		require
			no_layout_item_associated: layout_item = Void
		do
			create layout_item.make (Current)
			build_drop_actions_for_layout_item
		ensure
			lyout_item_initialized: layout_item /= Void
			layout_item_not_parented: layout_item.parent = Void
		end
		
feature {GB_OBJECT_HANDLER, GB_OBJECT, GB_TYPE_SELECTOR_ITEM} -- Access
		
	accepts_child (a_type: STRING):BOOLEAN is
			-- Does `Current' accept `an_object'.
			-- Redefine in descendents to allow children
			-- of correct type to be added.
		do
			Result := False
		end
		
feature {GB_INTEGER_INPUT_FIELD, GB_EV_ANY} -- Basic operations

	add_constant_context (context: GB_CONSTANT_CONTEXT) is
			-- Add `context' to `constants'.
		require
			context_not_void: context /= Void
			context_object_is_current: context.object = Current
		do
			constants.extend (context, context.property + context.attribute)
		ensure
			constants.has (context.property + context.constant.name)
		end

feature -- Basic operations
		
	is_full: BOOLEAN is
			-- Is `Current' full?
		do
			Result := True
		end
		
	add_new_component_in_parent (a_component: GB_COMPONENT) is
			-- Add `a_component' to parent of `Current', before `Current'.
		require
			object_parent_not_full: not parent_object.is_full
		do
			add_new_object_in_parent (a_component.object)
			
		end

	add_new_object_in_parent (an_object: GB_OBJECT) is
			-- Add `an_object' to parent of `Current', before `Current'.
		require
			object_parent_not_full: not parent_object.is_full		
		local
			command_add: GB_COMMAND_ADD_OBJECT
			insert_position: INTEGER
		do
			insert_position := parent_object.layout_item.index_of (layout_item, 1)
			
				-- We must now check that the item being inserted before is not contained in the same parent as `Current'.
				-- If this is the case, and the item is before `Current' in the parent, then we must use an insert_position
				-- one less than normal.
			if parent_object.layout_item.has (an_object.layout_item) and
				parent_object.layout_item.index_of (an_object.layout_item, 1) < parent_object.layout_item.index_of (layout_item, 1) then
				insert_position := insert_position - 1
			end
			create command_add.make (parent_object, an_object, insert_position)
			command_add.execute
		end
		
	add_new_component (a_component: GB_COMPONENT) is
			-- Add object representation of `a_component' to `Current'.
		require
			object_not_full: not is_full
		do
			add_new_object (a_component.object)
		end

	add_new_object (an_object: GB_OBJECT) is
			-- Add `an_object' to `Current'.
		require
			object_not_full: not is_full
		local
			command_add: GB_COMMAND_ADD_OBJECT
		do
				-- `an_object' may already be contained in `Current'.
				-- If this is the case, then the insert position is the number of
				-- items held in the layout item, as we are effectively moving it to the end.
			if layout_item.has (an_object.layout_item) then
				create command_add.make (Current, an_object,layout_item.count)
			else
				create command_add.make (Current, an_object, layout_item.count + 1)
			end
			command_add.execute
				-- Now we expand the layout item.
			if not layout_item.is_expanded then
				layout_item.expand
			end
		ensure
			layout_item_not_void: an_object.layout_item /= Void
		end
		
	set_id (a_new_id: INTEGER) is
			-- Assign `new_id' to `id'.
		require
			non_negative: a_new_id >= 0
		do
			id := a_new_id
		ensure
			id_assigned: id = a_new_id
		end
		
feature {GB_ID_COMPRESSOR}

	update_internal_id_references (conversion_data: HASH_TABLE [INTEGER, INTEGER]) is
			-- For all ids, used in `Current', including `id', and ids used in any
			-- properties, convert from their current_value  to hash_table [current_value] value.
		do
			id := conversion_data @ id
		end

feature {GB_COMMAND_NAME_CHANGE, GB_COMPONENT, GB_OBJECT_HANDLER} -- Basic operation

	set_name (new_name: STRING) is
			-- Assign `new_name' to `name'.
		require
			name_not_void: new_name /= Void
			no_object_has_name: not object_handler.name_in_use (new_name, Current)
		do
			name := new_name
			edited_name := new_name
		ensure
			name_assigned: name.is_equal (new_name)
		end

feature {GB_OBJECT_HANDLER, GB_TITLED_WINDOW_OBJECT} -- Implementation

	build_display_object is
			-- Build `display_object' from type of `Current'
			-- and hence `object'.
		require
			display_object_void: display_object = Void
		local
			pick_and_dropable: EV_PICK_AND_DROPABLE
		do
			display_object ?= vision2_object_from_type (type)
			pick_and_dropable ?= display_object
			if pick_and_dropable /= Void then
				pick_and_dropable.set_pebble_function (agent retrieve_pebble)
				pick_and_dropable.drop_actions.extend (agent add_new_component_wrapper (?))
				pick_and_dropable.drop_actions.extend (agent add_new_object_wrapper (?))
				pick_and_dropable.drop_actions.set_veto_pebble_function (agent can_add_child (?))
			end
		ensure
			display_object_not_void: display_object /= Void
		end
		
	retrieve_pebble: ANY is
			-- Retrieve pebble for transport.
			-- A convenient was of setting up the drop
			-- actions for GB_TYPE_SELECTOR_ITEM.
		do
				
			if application.ctrl_pressed and application.shift_pressed then
					-- If ctrl and shift is pressed, we must highlight
					-- the object in the layout constructor.
				Layout_constructor.highlight_object (Current)
			elseif application.ctrl_pressed then
					-- If the ctrl key is pressed, then we must
					-- start a new object editor for `Current', instead
					-- of beginning the pick and drop.
				new_object_editor (Current)
			else
				type_selector.update_drop_actions_for_all_children (Current)
				Result := Current
			end
			
		end

	set_up_display_object_events (a_display_object, an_object: EV_ANY) is
			-- Add events necessary for `display_object'.
			-- Some objects such as EV_TOGGLE_BUTTON can be modified
			-- by the user in the display window. We need to set up events
			-- on `display_object' so that we can notify the system that the
			-- change has taken place. There are only a few such events
			-- like these, but we need to be able to handle them.
		local
			handler: GB_EV_HANDLER
			supported_types: ARRAYED_LIST [STRING]
			current_type: STRING
			gb_ev_any: GB_EV_ANY
		do
			create handler
			supported_types := clone (handler.supported_types)
			from
				supported_types.start
			until
				supported_types.off
			loop
				current_type := supported_types.item
				current_type.to_upper
				if is_instance_of (display_object, dynamic_type_from_string (current_type.substring (4, current_type.count))) then
					gb_ev_any ?= new_instance_of (dynamic_type_from_string (current_type))
					gb_ev_any.default_create
					gb_ev_any.set_up_user_events (a_display_object, an_object)
				end
				supported_types.forth
			end
		end
		
feature {GB_OBJECT} -- Implementation
		
	override_drop_on_child (an_object: GB_OBJECT): BOOLEAN is
			-- If `Current' is held within `an_object' or
			-- `Current' is `an_object' then do not allow drop.
		do
			Result := True
				
				-- If an object is Void then we are transporting a type.
			if an_object /= Void then
					-- Check that the object is fully instantiated, and is not still
					-- representing a type.
				if an_object.object /= Void then
					if object_handler.object_contained_in_object (an_object, Current) or
					Current = an_object then
						Result := False
					end
				end
			end
		end
		
feature {GB_OBJECT_EDITOR, GB_GENERAL_UTILITIES} -- Implementation

	edited_name: STRING
		-- The name being entered for `Current' in an object editor.
		
	set_edited_name (a_name: STRING) is
			-- Assign `a_name' to `edited_name'.
		require
			name_not_void: a_name /= Void
		do
			edited_name := a_name
		ensure
			name_set: edited_name.is_equal (a_name)
		end
		

	cancel_edited_name is
			-- Assign `name' to `edited_name'.
		do
			edited_name := name
			if name.is_empty then
				layout_item.set_text (type.substring (4, type.count))
			else
				layout_item.set_text (name + ": " + type.substring (4, type.count))			
			end
		end

	output_name: STRING is
			-- Representation of `name' of `Current'
			-- Used so that we do not have to distinguish between the
			-- cases where we are editing a name or not editing a name.
			-- When we are not editing, `edited_name' and `name' are
			-- identical.
		do
			if edited_name.is_equal (name) then
				Result := name
			else
				Result := edited_name
			end
		end
		
		
feature {GB_CODE_GENERATOR} -- Implementation

	extend_xml_representation (child_name: STRING): STRING is
			-- `Result' is XML representation of code required to extend
			-- the current_object_type.
		do
			Result := "extend (" + child_name + ")"
		end
		
feature {GB_LAYOUT_CONSTRUCTOR} -- Implementation

	build_drop_actions_for_layout_item is
			-- Build the drop actions for the layout item.
			-- Wipe out any existing actions.
		do
			layout_item.drop_actions.wipe_out
			layout_item.drop_actions.extend (agent add_new_object_wrapper (?))
			layout_item.drop_actions.extend (agent add_new_component_wrapper (?))
			layout_item.drop_actions.set_veto_pebble_function (agent can_add_child (?))
		end
		
feature {GB_BUILDER_WINDOW} -- Implementation

	add_new_object_wrapper (an_object: GB_OBJECT) is
			-- If shift pressed then add `an_object' to
			-- parent of `Current', else add to `Current'.
		local
			env: EV_ENVIRONMENT
		do
			create env
			if not env.application.shift_pressed then
				check
					object_not_full: not is_full
				end
				add_new_object (an_object)
			else
				add_new_object_in_parent (an_object)
			end
		end
		
	add_new_component_wrapper (a_component: GB_COMPONENT) is
			-- If shift pressed then add `a_component' to
			-- parent of `Current', else add to `Current'.
		local
			env: EV_ENVIRONMENT
		do
			create env
			if not env.application.shift_pressed then
				check
					object_not_full: not is_full
				end
				add_new_component (a_component)
			else
				add_new_component_in_parent (a_component)
			end
		end
		
feature {GB_LAYOUT_CONSTRUCTOR_ITEM} -- Implementation

	register_expand is
			-- Assign `True' to `is_expanded'.
		do
			is_expanded := True
		end
		
	register_collapse is
			-- Assign `False' to `is_expanded'.
		do
			is_expanded := False
		end
		
feature -- Contract Support

	type_matches_object (a_type: STRING; an_object: ANY): BOOLEAN is
			-- Is `an_object' an instance of `a_type'?
		require
			an_object_not_void: an_object /= Void
		do
			Result := is_instance_of (an_object, dynamic_type_from_string (a_type))
		end
		
feature {NONE} -- Implementation

	vision2_object_from_type (a_type: STRING): EV_ANY is
			-- `Result' is a vision2 object of type `a_type'
		local
			passed: BOOLEAN
			an_object: EV_ANY
		do
			passed := feature {ISE_RUNTIME}.check_assert (False)
			an_object ?= new_instance_of (dynamic_type_from_string (type))
			an_object.default_create
			passed := feature {ISE_RUNTIME}.check_assert (True)
			Result := an_object
		ensure
			result_not_void: Result /= Void
		end
		
	display_invalid_drop_message (obj2: GB_OBJECT; new_type: STRING; does_accept_child: BOOLEAN) is
			-- Display message in status bar indicating the invalid drop status of `obj2'.
			-- `new_type' is the type of the transported object, and `does_accept_child' is
			-- result of last call to `override_drop_on_child' which is False if the child is
			-- of the wrong type to be contained.
		require
			target_not_void: obj2 /= Void
			new_type_not_empty: new_type /= Void and not (new_type.count = 0)
		local
			status_start: STRING
		do
			if application.shift_pressed then
				status_start := "Parent of p"
			else
				status_start := "P"
			end
			if obj2.is_full and obj2.layout_item.count = 0 then
				set_status_text (status_start + "ointed target (" + obj2.short_type + ") does not accept children.")
			elseif not does_accept_child then
				set_status_text (status_start + "ointed target (" + obj2.short_type + ") does not accept children of type " + new_type + ".")
			elseif obj2.is_full then
				set_status_text (status_start + "ointed target (" + obj2.short_type + ") is full.")
			end
		end
		
		
	display_parent_in_child_message (obj1, obj2: GB_OBJECT; new_type: STRING) is
			-- Display message in status bar indicating that `ob1' cannot be parented
			-- in `obj2' as `ob2' is `obj1' or is parent of `obj1'.
		do
			if obj1 = obj2 then
				set_status_text ("Cannot parent " + new_type + " in itself.")
			else
				set_status_text ("Cannot parent " + new_type + " in one of its children.")
			end
		end

end -- class GB_OBJECT
