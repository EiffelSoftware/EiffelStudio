indexing
	description: "Object representing a Build object."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_OBJECT
	
inherit
	
	INTERNAL
	
	GB_ACCESSIBLE
	
	GB_ACCESSIBLE_OBJECT_HANDLER
	
	GB_ACCESSIBLE_OBJECT_EDITOR
	
	XML_UTILITIES
	
	GB_ACCESSIBLE_HISTORY
	
	GB_PICK_AND_DROP_SHIFT_MODIFIER

feature {NONE} -- Initialization
	
	make_with_type (a_type: STRING) is
			-- Create `Current' with type `a_type'.
			-- Do not instantiate `object' from type.
		do
			type := a_type
			create name.make (0)
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
		local
			new_type_element: XML_ELEMENT
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
			layout_item.set_text (name + ": " + layout_item.text)
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
		ensure
			layout_item_set: layout_item = a_layout_item
			layout_item_object_set: layout_item.object = Current
		end

feature {GB_OBJECT_HANDLER, GB_DELETE_TOOL_BAR_BUTTON, GB_OBJECT, GB_COMMAND_ADD_OBJECT} -- Status setting

	unparent is
			-- Removed `Current' from its parents. All representations
			-- of `an_object' must be removed from their parents to
			-- concide with this change.
		local
			container: EV_CONTAINER
			widget: EV_WIDGET
			parent_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			widget ?= object
			container ?= widget.parent
			check
				widget_or_parent_not_void: container /= Void and widget /= Void
				widget_contained_in_parent: container.has (widget)
			end
				-- Remove `object' from its parent.
			container.prune (widget)
			
			widget ?= display_object
			container ?= widget.parent
			check
				widget_or_parent_not_void: container /= Void and widget /= Void
				widget_contained_in_parent: container.has (widget)
			end
				-- Remove `display_object' from its parent.
			container.prune (widget)
			
				-- Remove `layout_item' from its parent.
			parent_item ?= layout_item.parent
			check
				parent_item_not_void: parent_item /= Void
				item_contained_in_parent: parent_item.has (layout_item)
			end
			parent_item.prune (layout_item)
			
	
			-- We should not remove it. We may be unparenting, to put in a different
			-- parent.
				-- Remove `Current' from objects stored in `object_handler'.
	--		object_handler.remove_object (Current)
		ensure
			-- object_parent_void
			-- display_object_parent_void
			layout_item_parent_void: layout_item.parent = Void
		--	object_handler_does_not_reference_current: not object_handler.objects.has (Current)
		end

feature {GB_OBJECT_HANDLER} -- Status setting

	unparent_during_type_change is
			-- Removed `Current' from its parent during a type change.
			-- We keep the existing layout item of the original widget which
			-- allows us to access the new object in the history after the type
			-- change has completed.
		local
			container: EV_CONTAINER
			widget: EV_WIDGET
			parent_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			widget ?= object
			container ?= widget.parent
			check
				widget_or_parent_not_void: container /= Void and widget /= Void
				widget_contained_in_parent: container.has (widget)
			end
				-- Remove `object' from its parent.
			container.prune (widget)
			
			widget ?= display_object
			container ?= widget.parent
			check
				widget_or_parent_not_void: container /= Void and widget /= Void
				widget_contained_in_parent: container.has (widget)
			end
				-- Remove `display_object' from its parent.
			container.prune (widget)
		end

feature {GB_OBJECT_HANDLER} -- Element change

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
		
	create_layout_item is
			-- Create a layout_item associated with `Current'.
		require
			no_layout_item_associated: layout_item = Void
		do
			create layout_item.make (Current)
		ensure
			lyout_item_initialized: layout_item /= Void
			layout_item_not_parented: layout_item.parent = Void
		end		

feature -- Basic operations

	build_drop_action_for_new_object is
			-- Set up drop actions on `Current'.
		require
			object_not_void: object /= Void
			layout_item_not_void: layout_item /= Void
		deferred
		end
		
	build_shift_drop_action_for_new_object is
			-- Set up drop actions on `Current'.
		require
			object_not_void: object /= Void
			layout_item_not_void: layout_item /= Void
		local
			local_parent_object: GB_OBJECT
			display: EV_PICK_AND_DROPABLE
			layout: EV_PICK_AND_DROPABLE
		do
			display ?= display_object
			check
				display_not_void: display /= Void
			end
			layout ?= layout_item
			check
				layout_not_void: layout /= Void
			end
					-- Clear these, from the last transport.
			display.drop_actions.wipe_out
			layout.drop_actions.wipe_out

			local_parent_object := parent_object
				-- If the object is a window then the parent will be Void.
				-- There is nothing do do in this case.
			if local_parent_object /= Void then
				if not local_parent_object.is_full then
					display.drop_actions.extend (agent add_new_object_in_parent (?))
					layout.drop_actions.extend (agent add_new_object_in_parent (?))

					
					-- Need a veto pebble function that checks correctly.
					display.drop_actions.set_veto_pebble_function (agent override_drop_on_child (?))
					layout.drop_actions.set_veto_pebble_function (agent override_drop_on_child (?))
				end
			end
		end	
		
		
	is_full: BOOLEAN is
			-- Is `Current' full?
		do
			Result := True
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
		do
			name := new_name
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
			object_editor: GB_OBJECT_EDITOR
		do
			io.putstring ("Calling retrieve pebble%N")
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
		
	set_up_drop_actions_for_all_objects is
			-- Check state of shift key, and set up drop actions
			-- to accept `pebble' ready for the transport.
		local
			environment: EV_ENVIRONMENT
			constructor: GB_LAYOUT_CONSTRUCTOR	
		do
			create environment
			if environment.application.shift_pressed then
				object_handler.for_all_objects_build_shift_drop_actions_for_new_object
			else
				object_handler.for_all_objects_build_drop_actions_for_new_object
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
				-- Check that the object is fully instantiated, and is not still
				-- representing a type.
			if an_object.object /= Void then
				if object_handler.object_contained_in_object (an_object, Current) or
				Current = an_object then
					Result := False
				end
			end
		end
		
feature {NONE} -- Implementation
		

	Name_string: STRING is "name"

end -- class GB_OBJECT
