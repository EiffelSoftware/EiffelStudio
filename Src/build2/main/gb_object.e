indexing
	description: "Object representing a Build object."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_OBJECT
	
inherit
	
	INTERNAL
	
	GB_SHARED_TOOLS
	
	GB_SHARED_OBJECT_HANDLER
	
	GB_SHARED_OBJECT_EDITORS
	
	GB_XML_UTILITIES
	
	GB_SHARED_HISTORY
	
	GB_SHARED_SYSTEM_STATUS
	
	GB_SHARED_COMMAND_HANDLER
	
	GB_XML_OBJECT_BUILDER
	
	GB_SHARED_XML_HANDLER
	
	GB_WIDGET_UTILITIES
	
	EV_ANY_HANDLER

feature {GB_OBJECT_HANDLER} -- Initialization
	
	make_with_type (a_type: STRING) is
			-- Create `Current' with type `a_type'.
			-- Do not instantiate `object' from type.
		do
			type := a_type
				-- The names should never be `Void'.
			create name.make (0)
			create edited_name.make (0)
		ensure
			type_assigned: type = a_type
		end
		
	make_with_type_and_object (a_type: STRING; an_object: EV_ANY) is
			-- Create `Current', attach `an_object' to `object' and
			-- `a_type' to `type'.
		require
			an_object_not_void: an_object /= Void
			type_matches_object: is_instance_of (an_object, dynamic_type_from_string (a_type))
		do
			object := an_object
			type := a_type
			build_display_object
			create name.make (0)
			create edited_name.make (0)
		ensure
			type_assigned: type = a_type
			object_assigned: object = an_object
		end

feature -- Access

	object: EV_ANY
		-- The vision2 object that `Current' represents.
		
	display_object: EV_ANY
		-- The representation of `object' used in `build_window'.
		
	layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		-- Representation of `object' used in GB_LAYOUT_CONSTRUCTOR.
		
	name: STRING
		-- User set name for `Current'.
		
	type: STRING
		-- A type corresponding to the current vision2 object.
		-- Contains "EV_" at start.
		
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
			window_has_no_parent_object: is_instance_of (object, dynamic_type_from_string (object_handler.ev_window_string)) implies Result = Void
		end
		
feature {GB_XML_STORE, GB_XML_LOAD}

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of sepecific attributes of `Current'
			-- in `element'. For now, only a name needs to be stored.
		do
			add_element_containing_string (element, name_string, name)
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update `Current' based on information held in `element'.
			-- Currently, only the name needs to be stored.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (name_string)
			name :=  element_info.data
			layout_item.set_text (name + ": " + short_type)
		end
		
	xml_storage_required: BOOLEAN is
			-- Does `Current' need to store internal attributes
			-- to XML?
		do
			if not name.is_empty then
				Result := True
			end
		end

feature {GB_LAYOUT_CONSTRUCTOR_ITEM, GB_OBJECT_HANDLER} -- Status setting

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
		local
			parent_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			unparent_ev_object (object)
			unparent_ev_object (display_object)

				-- Remove `layout_item' from its parent.
			parent_item ?= layout_item.parent
			check
				parent_item_not_void: parent_item /= Void
				item_contained_in_parent: parent_item.has (layout_item)
			end
			parent_item.prune (layout_item)
			
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

feature {GB_OBJECT_HANDLER, GB_OBJECT} -- Element change

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
		do
			an_object ?= object_representation
				-- We get the new type of the object to be added. With this
				-- information, we can then see if `Current' will accept
				-- a child of this type.
			if an_object /= Void then
				new_type := an_object.type
			else
				-- If we are not an object, then we must be a component.
				a_component ?= object_representation
				check
					is_component: a_component /= Void
				end
				new_type := a_component.root_element_type
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
							Result := Result and override_drop_on_child (an_object)
						end
						Result := Result and local_parent_object.accepts_child (new_type)
					end
				else
					Result := False
				end
			else
				Result := not is_full
				Result := Result and accepts_child (new_type)
					-- We only need to check this if we are not a component,
					-- as this means there is no way we could be contained in `Current'.
				if an_object /= Void then
					Result := Result and override_drop_on_child (an_object)
				end
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
			-- Does `Current' accept `an_object'. By default,
			-- widgets are accepted. Redefine in primitives
			-- that must hold items to allow insertion.
		local
			current_type: INTEGER
		do
			current_type := dynamic_type_from_string (a_type)
			if type_conforms_to (current_type, dynamic_type_from_string ("EV_WIDGET")) then
				Result := True
			end
		end

feature -- Basic operations
		
	is_full: BOOLEAN is
			-- Is `Current' full?
		do
			Result := True
		end
		
	add_new_component_in_parent (a_component: GB_COMPONENT) is
			-- Add `a_component' to parent of `Current', before `Current'.
		do
			add_new_object_in_parent (new_object (xml_handler.xml_element_representing_named_component (a_component.name), True))
		end
		
		
	add_new_object_in_parent (an_object: GB_OBJECT) is
			-- Add `an_object' to parent of `Current', before `Current'.
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
			history.cut_off_at_current_position
			command_add.execute
		end
		
	add_new_component (a_component: GB_COMPONENT) is
			-- Add object representation of `a_component' to `Current'.
		do
			add_new_object (new_object (xml_handler.xml_element_representing_named_component (a_component.name), True))
		end

	add_new_object (an_object: GB_OBJECT) is
			-- Add `an_object' to `Current'.
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
			history.cut_off_at_current_position
			command_add.execute
				-- Now we expand the layout item.
			if not layout_item.is_expanded then
				layout_item.expand
			end
		ensure
			layout_item_not_void: an_object.layout_item /= Void
		end
		
	vision2_object_from_type (a_type: STRING): EV_ANY is
			-- `Result' is a vision2 object of type `a_type'
		local
			passed: BOOLEAN
			an_object: EV_ANY
		do
			passed := c_check_assert (False)
			an_object ?= new_instance_of (dynamic_type_from_string (type))
			an_object.default_create
			passed := c_check_assert (True)	
			Result := an_object
		ensure
			result_not_void: Result /= Void
		end
		
	set_name (new_name: STRING) is
			-- Assign `new_name' to `name'.
		require
			name_not_void: new_name /= Void
			no_object_has_name: not object_handler.named_object_exists (new_name, Current)
		do
			name := new_name
			edited_name := new_name
		ensure
			name_assigned: name.is_equal (new_name)
		end

feature {GB_OBJECT_HANDLER} -- Implementation

	build_display_object is
			-- Build `display_object' from type of `Current'
			-- and hence `object'.
		require
			display_object_void: display_object = Void
		deferred
		ensure
			display_object_not_void: display_object /= Void
		end
		
	retrieve_pebble: ANY is
			-- Retrieve pebble for transport.
			-- A convenient was of setting up the drop
			-- actions for GB_TYPE_SELECTOR_ITEM.
		local
			environment: EV_ENVIRONMENT
		do
			create environment
				-- If the ctrl key is pressed, then we must
				-- start a new object editor for `Current', instead
				-- of beginning the pick and drop.
			if environment.application.ctrl_pressed then
				new_object_editor (Current)
			else
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
		
feature {GB_OBJECT_EDITOR} -- Implementation

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
		
	accept_edited_name is
			-- Assign `edited_name' to `name'
		do
			name := edited_name
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
		
feature {NONE} -- Implementation

	build_drop_actions_for_layout_item is
			-- Build the drop actions for the layout item.
			-- Wipe out any existing actions.
		do
			layout_item.drop_actions.wipe_out
			layout_item.drop_actions.extend (agent add_new_object_wrapper (?))
			layout_item.drop_actions.extend (agent add_new_component_wrapper (?))
			layout_item.drop_actions.set_veto_pebble_function (agent can_add_child (?))
		end

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

end -- class GB_OBJECT
