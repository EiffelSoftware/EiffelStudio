indexing
	description: "An object which handles objects of type GB_OBJECT."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_OBJECT_HANDLER
	
inherit
	INTERNAL
		export
			{NONE} all
			{ANY} dynamic_type_from_string, is_instance_of
		end
	
	GB_CONSTANTS
		export
			{NONE} all
			{ANY} gb_primitive_object_class_name
		end
	
	GB_SHARED_OBJECT_EDITORS
		export
			{NONE} all
		end
	
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		end
	
	GB_SHARED_COMMAND_HANDLER
		export
			{NONE} all
		end
	
	GB_XML_UTILITIES
		export
			{NONE} all
		end
	
	GB_SHARED_DEFERRED_BUILDER
		export
			{NONE} all
		end
	
	GB_LAYOUT_CONSTRUCTOR_STATE_HANDLER
		export
			{NONE} all
		end
	
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end
		
	GB_NAMING_UTILITIES
		export
			{NONE} all
		end
		
	GB_GENERAL_UTILITIES
		export
			{NONE} all
		end
	
create
	initialize

feature {NONE} -- Initialization
	
	initialize is
			-- Create `Current'.
		do
			create objects.make (20)
			create deleted_objects.make (20)
		ensure
			objects_not_void: objects /= Void
		end
		
feature -- Access

	object_contained_in_object (parent_object, child_object: GB_OBJECT): BOOLEAN is
			-- Is `child_object' a child (recursively) of `parent_object'?
		require
			parent_not_void: parent_object /= Void
			child_object_not_void: child_object /= Void
		do
			object_contained_in_object_result := False
			recursive_do_all (parent_object, agent is_child (child_object, ?))
			Result := object_contained_in_object_result
		end
		
	is_child (child_object: GB_OBJECT; parent_object: GB_OBJECT) is
			-- Is `child_object' a direct child of `parent_object'?
		require
			child_object_not_void: child_object /= Void
			parent_object_not_void: parent_object /= Void
		do
			if not object_contained_in_object_result then
				object_contained_in_object_result := child_object.parent_object = parent_object
			end
		end
		
	objects_all_named (some_objects: ARRAYED_LIST [GB_OBJECT]): BOOLEAN is
			-- Are all GB_OBJECT in `objects' named?
		require
			some_objects_not_void: some_objects /= Void
		do
			Result := True
			from
				some_objects.start
			until
				some_objects.off or not Result
			loop
				if some_objects.item.name.is_empty then
					Result := False
				end
				some_objects.forth
			end
		end
		
feature -- Basic operation

	add_object (container, new_object: GB_OBJECT; position: INTEGER) is
			-- Add `new_object' to `container' at position `position'.
		require
			container_object_exists: container /= Void
			new_object_exists: new_object /= Void
			position_valid: position >= 1 and position <= container.layout_item.count + 1
		local
			all_editors_local: ARRAYED_LIST [GB_OBJECT_EDITOR]
			parent_object: GB_PARENT_OBJECT
		do
				-- When we change the type of an object, we keep the
				-- original layout_item. This is why the layout item
				-- may not be void, and the other attributes may be.
			if new_object.layout_item = Void then
				new_object.create_layout_item
			end
			if new_object.object = Void then
				new_object.create_object_from_type
				new_object.build_display_object
					-- We must only set up these events for widgets, as items do not have the correct
					-- events that we can hook to.
				if type_conforms_to (dynamic_type_from_string (new_object.type), dynamic_type_from_string (Ev_widget_string)) then
					new_object.set_up_display_object_events (new_object.display_object, new_object.object)	
				end
			end
			parent_object ?= container
			check
				not_a_parent_type: parent_object /= Void
			end
			parent_object.add_child_object (new_object, position)

				-- If we are moving an object within objects, then it will already
				-- exist in `objects' and should not be added again.-
			if not objects.has (new_object) then
				objects.extend (new_object)
			end
			
				-- We must now update the object editors to take into account
				-- This information. Some representations of objects in the editor
				-- display information regarding their children, so a call to
				-- this function requires and update to the object editor.
			all_editors_local := all_editors
			from
				all_editors_local.start
			until
				all_editors_local.off
			loop
				if container = all_editors_local.item.object then
					all_editors_local.item.update_current_object
				end
				all_editors_local.forth
			end
			
				-- Notify the system that we have modified something.
			system_status.enable_project_modified
			command_handler.update
		ensure
			new_object_added_to_object_list: objects.has (new_object)
			new_object_only_occurs_once_in_object_list: objects.occurrences (new_object) = 1
			new_object_layout_item_not_void: new_object.layout_item /= Void
			new_object_display_object_not_void: new_object.display_object /= Void
			new_object_object_not_void: new_object.object /= Void
		end

	move_object_contents (new_object, old_object: GB_OBJECT; in_type_change: BOOLEAN) is
			-- Take all children of `old_object', and their representations,
			-- and move into `new_object'. If `in_type_change' then do not unparent
			-- layout items of children, so use `unparent_during_type_change' otherwise using
			-- `unparent'.
		require
			new_object_not_void: new_object /= Void
			old_object_not_Void: old_object /= Void
				-- Not true, as replacing the type means we have a layout item.
			--new_object_empty: new_object.layout_item.count = 0
			new_object_not_a_primitive: not is_instance_of (new_object, dynamic_type_from_string (gb_primitive_object_class_name))
			old_object_not_a_primitive: not is_instance_of (old_object, dynamic_type_from_string (gb_primitive_object_class_name))
		local
			cell_object: GB_CELL_OBJECT
			container_object: GB_CONTAINER_OBJECT
			child_object: GB_OBJECT
			children: ARRAYED_LIST [GB_OBJECT]
		do
			cell_object ?= new_object
			container_object ?= new_object
			check
				new_object_is_cell_or_container: cell_object /= Void or container_object /= Void
			end
			children := clone (old_object.children)

			from
				children.start
			until
				children.off
			loop
				child_object := children.item
				old_object.remove_child (child_object)
			
				if cell_object /= Void then
					cell_object.add_child_object (child_object, 1)	
				else
					container_object.add_child_object (child_object, container_object.object.count + 1)
				end
				children.forth
			end
		end
		
	replace_object (an_object, new_object: GB_OBJECT) is
			-- Replace `an_object' with `new_object'.
			-- We must transfer the children of the object, the display_object children
			-- and the layout_item children.
		require
			an_object_not_void: an_object /= Void
			an_object_object_not_void: an_object.object /= Void
			an_object_display_item_not_void: an_object.display_object /= Void
			
		local
			parent_object: GB_OBJECT
			original_position: INTEGER
			local_all_editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
			table_object: GB_TABLE_OBJECT
			assertion_result: BOOLEAN
		do
			parent_object := an_object.parent_object
			original_position := parent_object.children.index_of (an_object, 1)
			assertion_result := (create {ISE_RUNTIME}).check_assert (False)
			
			parent_object.remove_child (an_object)

				-- Add new object to parent of old object.
			add_object (parent_object, new_object, original_position)
			
			 -- Now, if we are a table, we must resize the table to fit all
			 -- the new contents.
			 table_object ?= new_object
			if table_object /= Void then
				table_object.resize_to_accomodate (an_object.children.count)
			end
				
			
				-- Now we must swap the children over.	
				-- We only do this if `an_object' is a container or a cell.
				--| FIXME when we support replacing types of primitives with items, ie
				--| combo box to list and back, we need to modify this.
			if (is_instance_of (an_object, dynamic_type_from_string (gb_cell_object_class_name)) or
				is_instance_of (an_object, dynamic_type_from_string (gb_container_object_class_name))) and
				(is_instance_of (new_object, dynamic_type_from_string (gb_cell_object_class_name)) or
				is_instance_of (new_object, dynamic_type_from_string (gb_container_object_class_name))) then
					
				move_object_contents (new_object, an_object, True)
			end
			
			if assertion_result then
				assertion_result := (create {ISE_RUNTIME}).check_assert (True)
			end
	
				-- Now we must update all the object editors.
				-- If `an_object' was in an editor then clear the editor, as
				-- the objects type has changed.
				
			local_all_editors := all_editors
			from
				local_all_editors.start
			until
				local_all_editors.off
			loop
				if local_all_editors.item.object = an_object then
					local_all_editors.item.make_empty
				end
				local_all_editors.forth
			end
		end	
		
	add_initial_window is
			-- Add a new window when there are no other contained.
		local
			window_object: GB_TITLED_WINDOW_OBJECT
		do
			window_object ?= build_object_from_string_and_assign_id ("EV_TITLED_WINDOW")
			check
				object_was_window: window_object /= Void
			end
			add_new_window (window_object)
			window_selector.set_item_for_prebuilt_window (window_object)
			window_object.set_as_root_window
		end
		
	add_root_window (a_type: STRING): GB_TITLED_WINDOW_OBJECT is
			-- Add a new root item and return the newly created object.
			-- The only root item types that are currently supported
			-- are GB_TITLED_WINDOW_OBJECT and GB_DIALOG which is a descendent
			-- therefore, the result is always a window object.
			--| FIXME, this is a function with a side effect.
		do
			Result ?= build_object_from_string_and_assign_id (a_type)
			add_new_window (Result)
			window_selector.set_item_for_prebuilt_window (Result)
		ensure
			result_not_void: Result /= Void
		end

	add_new_window (window_object: GB_TITLED_WINDOW_OBJECT) is
			-- Perform necessary initialization for new window,
			-- `window_object'.
		local
			layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
			titled_window: EV_TITLED_WINDOW
			display_win: GB_DISPLAY_WINDOW
			builder_win: GB_BUILDER_WINDOW
		do
			create layout_item.make (window_object)
				-- We must only add the layout item if there is
				-- no window currently displayed.
			if layout_constructor.is_empty then
				layout_constructor.add_root_item (layout_item)	
			end
			window_object.set_layout_item (layout_item)
			window_object.build_drop_actions_for_layout_item
			create display_win
			titled_window ?= display_win
			titled_window.set_size (Default_window_dimension, Default_window_dimension)
			window_object.set_object (titled_window)
			window_object.build_display_object
		end

	remove_object (an_object: GB_OBJECT) is
			-- Remove `an_object' from `objects'.
		do
			objects.prune_all (an_object)
		ensure
			not_in_objects: not objects.has (an_object)
		end

	build_object_from_string_and_assign_id (a_text: STRING): GB_OBJECT is
			-- Generate `Result' from `text' with a new id assigned.
		do
			Result := build_object_from_string (a_text)
			Result.assign_id
				-- As `Result' has just been built, we add it to `objects'.
			add_object_to_objects (Result)
		end

	build_object_from_string (a_text: STRING): GB_OBJECT is
			-- Generate `Result' from `text'.
			-- `Result' will not have and id.
		require
			text_valid: a_text.count > 0 -- This is not a  complete check, but is better than nothing.
		local
			cell_object: GB_CELL_OBJECT
			primitive_object: GB_PRIMITIVE_OBJECT
			split_area_object: GB_SPLIT_AREA_OBJECT
			table_object: GB_TABLE_OBJECT
			widget_list_object: GB_WIDGET_LIST_OBJECT
			tool_bar_item_object: GB_TOOL_BAR_ITEM_OBJECT
			tool_bar_object: GB_TOOL_BAR_OBJECT
			list_object: GB_LIST_OBJECT
			list_item_object: GB_LIST_ITEM_OBJECT
			combo_box_object: GB_COMBO_BOX_OBJECT
			menu_bar_object: GB_MENU_BAR_OBJECT
			titled_window_object: GB_TITLED_WINDOW_OBJECT
			dialog_object: GB_DIALOG_OBJECT
			menu_object: GB_MENU_OBJECT
			menu_item_object: GB_MENU_ITEM_OBJECT
			tree_item_object: GB_TREE_ITEM_OBJECT
			tree_object: GB_TREE_OBJECT
			current_type: INTEGER
			text: STRING
		do	
			text := a_text
			current_type := dynamic_type_from_string (text)		
			if type_conforms_to (current_type, dynamic_type_from_string (Ev_cell_string)) then
				if type_conforms_to (current_type, dynamic_type_from_string (Ev_dialog_string)) then
					create dialog_object.make_with_type (text)
					Result ?= dialog_object
				elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_titled_window_string)) then
					create titled_window_object.make_with_type (text)
					Result ?= titled_window_object
				else
					create cell_object.make_with_type (text)
					Result ?= cell_object
				end
			elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_container_string)) then
				if type_conforms_to (current_type, dynamic_type_from_string (Ev_widget_list_string)) then
					create widget_list_object.make_with_type (text)
					Result ?= widget_list_object
				elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_table_string)) then
					create table_object.make_with_type (text)
					Result ?= table_object
				elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_split_area_string)) then
					create split_area_object.make_with_type (text)
					Result ?= split_area_object
				else
					check
						invalid_type_conformance: False
					end
				end
			elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_primitive_string)) then
				if type_conforms_to (current_type, dynamic_type_from_string (Ev_tool_bar_string)) then
					create tool_bar_object.make_with_type (text)
					Result := tool_bar_object
				elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_list_string)) then
					create list_object.make_with_type (text)
					Result := list_object
				elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_combo_box_string)) then
					create combo_box_object.make_with_type (text)
					Result := combo_box_object
				elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_tree_string)) then
					create tree_object.make_with_type (text)
					Result := tree_object
				else
					create primitive_object.make_with_type (text)
					Result ?= primitive_object
				end
			elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_menu_bar_string)) then
				create menu_bar_object.make_with_type (text)
				Result ?= menu_bar_object
			elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_menu_string)) then
				create menu_object.make_with_type (text)
				Result ?= menu_object
			elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_menu_item_string)) then
				create menu_item_object.make_with_type (text)
				Result ?= menu_item_object
			elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_item_string)) then
				if type_conforms_to (current_type, dynamic_type_from_string (Ev_tool_bar_item_string)) then
					create tool_bar_item_object.make_with_type (text)
					Result ?= tool_bar_item_object
				elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_list_item_string)) then
					create list_item_object.make_with_type (text)
					Result ?= list_item_object
				elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_tree_item_string)) then
					create tree_item_object.make_with_type (text)
					Result ?= tree_item_object					
				else
					check
						invalid_type_conformance: False
					end
				end	
			end
		ensure
			Result_not_void: Result /= Void
		end
		
	clear_all_objects is
			-- Remove all objects, so we are back in the intial
			-- state of the system.
		do			
				-- Wipe `deleted_objects'.
			deleted_objects.wipe_out
				-- Wipe out `objects' but restore the
			
			objects.wipe_out
			
			window_selector.wipe_out
		end
		
	string_used_globally_as_object_or_feature_name (a_string: STRING): BOOLEAN is
			-- Is `a_string' used anywhere in the system as feature name or object_name?
		local
			object_events: ARRAYED_LIST [GB_ACTION_SEQUENCE_INFO]
		do
			from
				objects.start
			until
				objects.off or Result
			loop
				if objects.item.name.as_lower.is_equal (a_string) then
					Result := True
				end
				object_events := objects.item.events
				from
					object_events.start
				until
					object_events.off
				loop
					if a_string.is_equal (object_events.item.feature_name.as_lower) then
						Result := True
					end
					object_events.forth
				end
				objects.forth
			end
		end
		
	all_object_and_event_names: ARRAYED_LIST [STRING] is
			-- `Result' is all object and event names in system.
		local
			object_events: ARRAYED_LIST [GB_ACTION_SEQUENCE_INFO]
		do
			create Result.make (objects.count)
			from
				objects.start
			until
				objects.off
			loop
				if not objects.item.name.is_empty then
					Result.extend (objects.item.name)
				end
				object_events := objects.item.events
				from
					object_events.start
				until
					object_events.off
				loop
					Result.extend (object_events.item.feature_name.as_lower)
					object_events.forth
				end
				objects.forth
			end
		ensure
			Result /= Void
		end

	string_is_object_name (object_name: STRING; an_object: GB_OBJECT; compare_original_object: BOOLEAN): BOOLEAN is
			-- Is `object_name' a valid named for `an_object', or does it clash
			-- with an existing name in the scope of `an_object'. For example, objects in
			-- different windows may have the same name, but windows must have unique names as
			-- must objects in the same window.
		require
			object_name_not_void: object_name /= Void
			an_object_not_void: an_object /= Void
		local
			parent_object: GB_OBJECT
			window_objects: ARRAYED_LIST [GB_OBJECT]
		do
			if not object_name.is_empty then
				string_is_object_name_result := False
				parent_object := an_object.top_level_parent_object
				recursive_do_all (parent_object, agent check_object_name (object_name, an_object, compare_original_object,  ?))
				Result := string_is_object_name_result
				if parent_object = an_object then
					-- `an_object' is a window as it has no parent, therefore, we must check that the name
					-- does not clash with that of any other titled windows.
					window_objects ?= Window_selector.objects
					from
						window_objects.start
					until
						window_objects.off
					loop
						if window_objects.item.name.as_lower.is_equal (object_name.as_lower) then
							Result := True
						end
						window_objects.forth
					end
				end
			end
		end
		
	check_object_name (object_name: STRING; original_object: GB_OBJECT; compare_original_object: BOOLEAN; an_object: GB_OBJECT) is
			-- Is `object_name' a valid object name for `original_object' in the scope of `an_object'. If `compare_original_object' then
			-- check must include the original object, and result may be queried from `string_is_object_name_result'.
		local
			current_name_lower, name_lower: STRING
		do
			if (not compare_original_object and then original_object /= an_object) or compare_original_object then
				name_lower := object_name.as_lower
				current_name_lower := an_object.name.as_lower
				if current_name_lower.is_equal (name_lower) then
					string_is_object_name_result := True
				end
			end
		end
		
	string_is_object_name_result: BOOLEAN
		-- Result used for `string_is_object_name'.
		
	string_is_feature_name_result: BOOLEAN
		-- Result used for `string_is_object_name'.
		
	string_is_feature_name (object_name: STRING; an_object: GB_OBJECT): BOOLEAN is
			-- Is `object_name' already used as a feature name for event connection?
		require
			object_name_not_void: object_name /= Void
			an_object_not_void: an_object /= Void
		local
			parent_object: GB_OBJECT
		do
				-- Do nothing if `object_name' is empty.
			if not object_name.is_empty then
				string_is_feature_name_result := False
				parent_object := an_object.top_level_parent_object
				recursive_do_all (parent_object, agent check_feature_name (object_name, an_object, ?))
				Result := string_is_feature_name_result
			end
		end
		
	check_feature_name (object_name: STRING; original_object, an_object: GB_OBJECT) is
			-- Is `object_name' a valid feature name for `original_object', in the context
			-- of `an_object'? Result may be queried from `string_is_feature_name_result'.
		local
			object_events: ARRAYED_LIST [GB_ACTION_SEQUENCE_INFO]
			name_lower: STRING
		do
			if original_object /= an_object then
				name_lower := object_name.as_lower
					-- Access events of `current_object' locally, for speed
				object_events := an_object.events
					-- No need to check further if `object_events' is empty.
					-- Note that we always check the events, even if `an_object' /= `Void'.
				if not object_events.is_empty then
					from
						object_events.start
					until
							-- No need to loop if already found.
						object_events.off or string_is_feature_name_result
					loop
						if name_lower.is_equal (object_events.item.feature_name) then
							string_is_feature_name_result := True
						end
						object_events.forth
					end
				end
			end
		end
		
	valid_constant_name (a_name: STRING): BOOLEAN is
			-- Is `a_name' a valid name for a constant?
		require
			name_valid: a_name /= Void
		do
			string_is_feature_name_result := False
			string_is_object_name_result := False
			objects.do_all (agent check_object_name (a_name, Void, True,  ?))
			objects.do_all (agent check_feature_name (a_name, Void, ?))
			Result := not (string_is_feature_name_result or string_is_object_name_result)
		end
		
		
	name_in_use (object_name: STRING; an_object: GB_OBJECT): BOOLEAN is
			-- Is `object_name' a valid name for `an_object'? Must check
			-- all other object names in the current scope (window) as `an_object',
			-- including names of all connceted events in scope.
			-- Case insensitive, does not compare name of `an_object'.
			-- Returns `False' if `object_name' is empty. This is because you are
			-- allowed to have as many "unnamed" objects as you wish.
		require
			object_name_not_void: object_name /= Void
			an_object_not_void: an_object /= Void
		do
			Result := string_is_object_name (object_name, an_object, False) or
				string_is_feature_name (object_name, an_object)
		end
		
	existing_feature_matches (feature_name, type: STRING; an_object: GB_OBJECT): BOOLEAN is
			-- Do all action sequences with feature named `feature_name' connected, in scope of `an_object'
			-- have a type that is compatible (argument wise) with `type'?
		require
			feature_name_not_empty: feature_name /= Void and then not feature_name.is_empty
			type_exists: type /= Void and then not type.is_empty
			feature_name_already_used: string_is_feature_name (feature_name, an_object)
		local
			parent_object: GB_OBJECT
		do
			existing_feature_matches_result := True
			parent_object := an_object.top_level_parent_object
			recursive_do_all (parent_object, agent check_feature_clash (feature_name.as_lower, type, ?))
			Result := existing_feature_matches_result
		end
		
	check_feature_clash (feature_name, type: STRING; an_object: GB_OBJECT) is
			-- Is feature name valid for action sequence type `type' in the context of
			-- `an_object'. Store result in `existing_feature_matches_result'.
		local
			object_events: ARRAYED_LIST [GB_ACTION_SEQUENCE_INFO]
			action_sequence1, action_sequence2: GB_EV_ACTION_SEQUENCE
			first_types, second_types: STRING
		do
			object_events := an_object.events
				-- Note that we always check the events, even if `an_object' /= `Void'.
			if not an_object.events.is_empty then
				from
					object_events.start
				until
						-- No need to loop if already found not to match.
					object_events.off or not existing_feature_matches_result
				loop
					if feature_name.is_equal (object_events.item.feature_name) then
						action_sequence1 ?= new_instance_of (dynamic_type_from_string ("GB_" + type))
						check
							action_sequence_not_void: action_sequence1 /= Void
						end
						action_sequence2 ?= new_instance_of (dynamic_type_from_string ("GB_" + object_events.item.type))
						check
							action_sequence_not_void: action_sequence2 /= Void
						end
						first_types := action_sequence1.argument_types_as_string
						second_types := action_sequence2.argument_types_as_string
						if not equal (first_types, second_types) then
							existing_feature_matches_result := False
						end
					end
					object_events.forth
				end
			end
		end

	existing_feature_matches_result: BOOLEAN
		-- Last result of call to `existing_feature_matches'

	mark_as_deleted (an_object: GB_OBJECT) is
			-- Move `an_object' and all children at all levels in
			-- to `deleted_objects'.
		require
			an_object_not_void: an_object /= Void
			an_object_not_deleted: objects.has (an_object)
			-- All children objects contained in `objects'.
		local
			temp_object: GB_OBJECT
		do
			objects.prune_all (an_object)
			deleted_objects.extend (an_object)
			from
				objects.start
			until
				objects.off
			loop
				temp_object := objects.item
				if object_contained_in_object (an_object, temp_object) then
					objects.remove
					deleted_objects.extend (temp_object)
				else
					objects.forth
				end
			end
		ensure
			object_deleted: deleted_objects.has (an_object)
		end
		
	mark_existing (an_object: GB_OBJECT) is
			-- Move `an_object' and all children at all levels in to
			-- `objects'.
		require
			an_object_not_void: an_object /= Void
			an_object_deleted: deleted_objects.has (an_object)
			-- All children objects contained in `deleted_objects'.
		local
			temp_object: GB_OBJECT
		do
			deleted_objects.prune_all (an_object)
			objects.extend (an_object)
			from
				deleted_objects.start
			until
				deleted_objects.off
			loop
				temp_object := deleted_objects.item
				if object_contained_in_object (an_object, temp_object) then
					deleted_objects.remove
					objects.extend (temp_object)
				else
					deleted_objects.forth
				end
			end
		ensure
			object_removed_from_deleted: objects.has (an_object)
		end
		
	recursive_do_all (an_object: GB_OBJECT; action: PROCEDURE [ANY, TUPLE [GB_OBJECT]]) is
			-- For `an_object' and all objects parented at any level in
			-- `an_object', call `action' with the current object as
			-- the argument.
			-- Semantics not guaranteed if `action' changes the structure
		require
			an_object_not_void: an_object /= Void
			action_not_void: action /= Void
		local
			t: TUPLE [GB_OBJECT]
			cursor: CURSOR
			children: ARRAYED_LIST [GB_OBJECT]
		do
			create t
			t.put (an_object, 1)
			action.call (t)
			children := an_object.children
			cursor := children.cursor
			from
				children.start
			until
				children.off
			loop
				recursive_do_all (children.item, action)
				children.forth
			end
			if children.valid_cursor (cursor) then
				children.go_to (cursor)
			end
		end
		
	object_from_display_widget (ev_any: EV_ANY): GB_OBJECT is
			-- `Result' is GB_OBJECT with `ev_any' as `object'.
			-- Only checks in `objects'.
		local
			local_objects: ARRAYED_LIST [GB_OBJECT]
			counter: INTEGER
		do
			local_objects ?= objects
			from
				counter := 1
			until
				counter > local_objects.count or
				Result /= Void
			loop
				if (local_objects @ counter).object = ev_any then
					Result := local_objects @ counter
				end
				counter := counter + 1
			end
		end
		
	object_from_id (an_id: INTEGER): GB_OBJECT is
			-- `Result' is GB_OBJECT with id `an_id'.
			-- Only checks in `objects'.
		local
			local_objects: ARRAYED_LIST [GB_OBJECT]
			counter: INTEGER
		do
			local_objects ?= objects
			from
				counter := 1
			until
				counter > local_objects.count or
				Result /= Void
			loop
				if (local_objects @ counter).id = an_id then
					Result := local_objects @ counter
				end
				counter := counter + 1
			end
		end
		
	deep_object_from_id (an_id: INTEGER): GB_OBJECT is
			-- `Result' is GB_OBJECT with id `an_id'.
			-- Checks in `objects' and `deleted_objects'.
		local
			local_objects: ARRAYED_LIST [GB_OBJECT]
			counter: INTEGER
		do
			Result := object_from_id (an_id)
			if Result = Void then
				local_objects ?= deleted_objects
				from
					counter := 1
				until
					counter > local_objects.count or
					Result /= Void
				loop
					if (local_objects @ counter).id = an_id then
						Result := local_objects @ counter
					end
					counter := counter + 1
				end	
			end
		end
		
	add_default_names (some_objects: ARRAYED_LIST [GB_OBJECT]) is
			-- For all objects in `some_objects', add a default name, if
			-- they do not have a name assigned.
		local
			names: ARRAYED_LIST [STRING]
			an_object: GB_OBJECT
			titled_window_object: GB_TITLED_WINDOW_OBJECT
		do
				-- We firstly find all names that are used, as we must know all of them
				-- before we actually start to set them.
			create names.make (2)
			from
				some_objects.start
			until
				some_objects.off
			loop
				if not some_objects.item.name.is_empty then
					names.extend (clone (some_objects.item.name))
				end
				some_objects.forth
			end
				-- Now actually perform the renaming.
			from
				some_objects.start
			until
				some_objects.off
			loop
				an_object := some_objects.item
				if an_object.name.is_empty then
					an_object.set_name (unique_name_from_array (names, an_object.short_type))
					titled_window_object ?= an_object
					if titled_window_object /= Void then
						titled_window_object.window_selector_item.set_text (name_and_type_from_object (an_object))	
					end
						--Add the new name to `names' so that it is not used again.
					names.extend (an_object.name)
				end
				rebuild_associated_editors (an_object.object)
				some_objects.forth
			end
				-- Update project so it may be saved.
			system_status.enable_project_modified
			command_handler.update
		end
		
feature {GB_TITLED_WINDOW_OBJECT} -- Basic operations

	set_root_window (a_window: GB_TITLED_WINDOW_OBJECT) is
			-- Assign `a_window' to `root_window'.
		require
			a_window_not_void: a_window /= Void
		do
			root_window_object := a_window
		ensure
			window_set: root_window_object = a_window
		end
		
feature {GB_CLOSE_PROJECT_COMMAND} -- Basic operations		

	remove_root_window is
			-- Ensure `rot_window' is Void.
		do
			root_window_object := Void
		ensure
			root_window_void: root_window_object = Void
		end

feature {GB_XML_OBJECT_BUILDER} -- Basic operations

	build_object (new_object: GB_OBJECT) is
			-- Build internal representations of `new_object'
			-- such as the layout item and display object.
			-- `new_object' is not added to `objects'.
		require
			new_object_exists: new_object /= Void
		do
			if new_object.layout_item = Void then
				new_object.create_layout_item
			end
			if new_object.object = Void then
				new_object.create_object_from_type
				new_object.build_display_object
					-- We only set up the user events on widgets at the moment.
				if type_conforms_to (dynamic_type_from_string (new_object.type), dynamic_type_from_string (Ev_widget_string)) then
					new_object.set_up_display_object_events (new_object.display_object, new_object.object)
				end
			end
		ensure
			new_object_layout_item_not_void: new_object.layout_item /= Void
			new_object_display_object_not_void: new_object.display_object /= Void
			new_object_object_not_void: new_object.object /= Void
		end
		
feature {GB_EV_WIDGET_EDITOR_CONSTRUCTOR} -- Implementation

	reset_object (an_object: GB_OBJECT) is
			-- Reset `an_object' by rebuilding. An XML representation
			-- of the object is built, and then a new object is generated from
			-- this XML. The new object replaces the old version with the same ID,
			-- and the contents are transferred across.
		local
			store: GB_XML_STORE
			element: XM_ELEMENT
			load: GB_XML_LOAD
			new_object, parent_object: GB_OBJECT
			table_parent_object: GB_TABLE_OBJECT
			original_position, x, y, width, height: INTEGER
			fixed: EV_FIXED
			widget, old_builder_contents: EV_WIDGET
			table: EV_TABLE
			container_object: GB_CONTAINER_OBJECT
			titled_window_object: GB_TITLED_WINDOW_OBJECT
			old_contents: EV_WIDGET
			old_window, new_window,  old_builder_window, new_builder_window: EV_TITLED_WINDOW
			locked_in_here: BOOLEAN
			old_window_selector_item: GB_WINDOW_SELECTOR_ITEM
			old_builder_menu_bar, old_window_menu_bar: EV_MENU_BAR
		do
			if ((create {EV_ENVIRONMENT}).application.locked_window = Void) then
				locked_in_here := True
				parent_window (Layout_constructor).lock_update
			end
			titled_window_object ?= an_object
				-- We must handle windows as a special case,
				-- as they are built by Build and are not completely dynamic
				-- like other objects.
				
			if titled_window_object = Void then
				store_layout_constructor
				parent_object := an_object.parent_object
				table_parent_object ?= parent_object
				
				if table_parent_object /= Void then
						-- If the object is parented in a table, store
						-- relevent information to enable us to restore the position.
					widget ?= an_object.object
					x := table_parent_object.object.item_column_position (widget)
					y := table_parent_object.object.item_row_position (widget)
					width := table_parent_object.object.item_column_span (widget)
					height := table_parent_object.object.item_row_span (widget)
				end
				fixed ?= an_object.parent_object.object
				if fixed /= Void then
						-- If the object is parented in a fixed, store relevent information
						-- which enables us to restore the position.
					widget ?= an_object.object
					x := widget.x_position
					y := widget.y_position
					width := widget.width
					height := widget.height
				end
				original_position := parent_object.children.index_of (an_object, 1)
				parent_object.remove_child (an_object)	
				
				create store
				create load
				create element.make_root ("item", create {XM_NAMESPACE}.make ("", ""))
				add_attribute_to_element (element, "type", "xsi", an_object.type)
				
				store.output_attributes (an_object, element, create {GB_GENERATION_SETTINGS})
					-- Generate an XML representation of `an_object' in `element'.
					
					-- We must now remove `an_object' from `objects' as it will be replaced with
					-- the new version. If we leave it there, then we will have two objects with the
					-- same id. When we reset an object, the old object is never used again, it is completely
					-- replaced with the new. This is not an undoable command, as it will always be silent to
					-- the user.
					-- We do this after we generate using `output_attributes' as some widget types may
					-- need the object contained within `objects'
				objects.prune_all (an_object)
					-- Call `delete' as the object must be deleted before being re-created. This performs
					-- any necessary processing on `an_object', ensuring that the state of the system
					-- is ok post re-creation.
				an_object.delete
					
				new_object := load.retrieve_new_object (element, parent_object, original_position)
					-- construct `new_object' from `element.
				
					
				if not is_instance_of (new_object, dynamic_type_from_string (gb_primitive_object_class_name)) then
						-- Only transfer object contents if the object is not a primitive and
						-- may therefore hold other widgets. Although some primitives hold items, the
						-- size is not affected by the items, and `reset_object' will not be called.
					move_object_contents (new_object, an_object, False)
				end
				
					
				if table_parent_object /= Void then
						-- We must now position `an_object' if it was contained in a table.
					widget ?= new_object.object
					table_parent_object.object.set_item_position_and_span (widget, x, y, width, height)
					widget ?= new_object.display_object
					table ?= table_parent_object.display_object.child
					table.set_item_position_and_span (widget, x, y, width, height)
				end
				
				if fixed /= Void then
						-- We must now position `an_object' if it was contained in a fixed.
					widget ?= new_object.object
					fixed.set_item_position (widget, x, y)
					fixed.set_item_size (widget, width.max (widget.minimum_width), height.max (widget.minimum_height))
					container_object ?= parent_object
					fixed ?= container_object.display_object.child
					widget ?= new_object.display_object
					fixed.set_item_position (widget, x, y)
					fixed.set_item_size (widget, width.max (widget.minimum_width), height.max (widget.minimum_height))
				end
				
					-- We now perform any deferred building that is required.
				Deferred_builder.build
				
				restore_layout_constructor
			else
					-- We must handle windows as a special case. Store the contents.
				old_window ?= titled_window_object.object
				old_builder_window ?= titled_window_object.display_object.child
				old_window_selector_item ?= titled_window_object.window_selector_item
				old_window_menu_bar ?= titled_window_object.object.menu_bar
				new_window ?= titled_window_object.display_object.child
				old_builder_menu_bar := new_window.menu_bar
				if titled_window_object.is_full then
						-- If the window does have an `item' then we store it
						-- for later restoration.
					old_contents := titled_window_object.object.item	
					old_builder_contents := titled_window_object.display_object.child.item
				end

				create store
				create load
				create element.make_root ("item", create {XM_NAMESPACE}.make ("", ""))
				add_attribute_to_element (element, "type", "xsi", an_object.type)
				store.output_attributes (an_object, element, create {GB_GENERATION_SETTINGS})
				
				titled_window_object.update_objects
				load.rebuild_window (titled_window_object, element)
				
				new_window := titled_window_object.object
				new_builder_window ?= titled_window_object.display_object.child
				
				old_window.wipe_out
				old_builder_window.wipe_out
				
				if old_contents /= Void then
						-- Restore contents of windows, if not Void.
					check
						old_builder_contents_also_not_void: old_builder_contents /= Void
					end
					new_window.extend (old_contents)
					new_builder_window.extend (old_builder_contents)
				end
				
				new_window.set_position (old_window.x_position, old_window.y_position)
				new_window.set_size (old_window.width.max (new_window.minimum_width), old_window.height.max (new_window.minimum_height))
				if old_window.is_displayed then
						-- Executing the show command twice, prevents us from 
						-- having to know about the different states for displaying
						-- the window. The command already knows about it, we simply
						-- hide, and then show, and the command handles everything for us.
					Command_handler.Show_hide_display_window_command.execute
					Command_handler.Show_hide_display_window_command.execute
				end
					-- Now handle menu bars as a special case.
				if old_window_menu_bar /= Void then
					old_window_menu_bar.parent.remove_menu_bar
					new_window.set_menu_bar (old_window_menu_bar)
				end
				
				old_window.destroy
				
				titled_window_object.set_window_selector_item (old_window_selector_item)
				
				new_builder_window.set_position (old_builder_window.x_position, old_builder_window.y_position)
				new_builder_window.set_size (old_builder_window.width.max (new_builder_window.minimum_width), old_builder_window.height.max (new_builder_window.minimum_height))
				if old_builder_window.is_displayed then
						-- Executing the show command twice, prevents us from 
						-- having to know about the different states for displaying
						-- the window. The command already knows about it, we simply
						-- hide, and then show, and the command handles everything for us.
					Command_handler.Show_hide_builder_window_command.execute
					Command_handler.Show_hide_builder_window_command.execute
				end
						-- Now handle menu bars as a special case.
					if old_builder_menu_bar /= Void then
						old_builder_menu_bar.parent.remove_menu_bar
						new_builder_window.set_menu_bar (old_builder_menu_bar)
					end
				
				old_builder_window.destroy
			end
			if locked_in_here then
				parent_window (Layout_constructor).unlock_update
			end
		end
		
		
feature {GB_TITLED_WINDOW_OBJECT, GB_XML_OBJECT_BUILDER} -- Implementation
		
	add_object_to_objects (an_object: GB_OBJECT) is
			-- Add `an_object' to `objects'.
		require
			not_already_included: not objects.has (an_object)
		do		
			objects.extend (an_object)
		end
		
feature {GB_COMMAND_DELETE_OBJECT, GB_COMMAND_DELETE_WINDOW_OBJECT} -- Implementation

	update_object_editors_for_delete (deleted_object, parent_object: GB_OBJECT) is
			-- For every item in `editors', update to reflect removal of `deleted_object' from `parent_object'.
		local
			editor: GB_OBJECT_EDITOR
			window_parent: EV_WINDOW
			editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
		do
			editors := all_editors
			from
				editors.start
			until
				editors.off
			loop
				editor := editors.item
					-- Update the editor if `Current' or a child of `Current'
					-- is contained.
				if editor.object /= Void and then (object_contained_in_object (deleted_object, editor.object) or
					deleted_object = editor.object) then
						-- If we are the docked object editor, then just empty it.
						-- If not, we destroy the editor and the containing window.
					if editor = docked_object_editor then
						editor.make_empty
					else
						window_parent := parent_window (editor)
						check
							floating_editor_is_in_window: window_parent /= Void
						end
						editor.destroy
						window_parent.destroy
						floating_object_editors.prune (editor)
					end
				end

					-- We only update any editors that reference containers.
					-- Note that we could check to see which attributes of which objects
					-- really were affected, thus minimizing, rebuilding. Not done
					-- and probably not necessary.
				if not editor.is_destroyed and then editor.object /= Void and then
					type_conforms_to (dynamic_type_from_string (editor.object.type), dynamic_type_from_string (Ev_container_string)) then
					editor.update_current_object
				end	
				editors.forth
			end
		end
		
	update_for_delete (object_id: INTEGER) is
				-- Perform any necessary processing on object referenced
				-- by id `object_id' and all children contained,
				-- for a deletion event. I.e. unmerge radio connection.
			local
				all_objects: ARRAYED_LIST [GB_OBJECT]
				counter: INTEGER
			do
				create all_objects.make (10)
				deep_object_from_id (object_id).all_children_recursive (all_objects)
				all_objects.extend (deep_object_from_id (object_id))
				from
					counter := 1
				until
					counter > all_objects.count
				loop
					(all_objects @ counter).delete
					counter := counter + 1
				end
			end
		
feature {NONE} -- Implementation

	object_contained_in_object_result: Boolean
		-- Result of last call to `object_contained_in_object'.

feature -- Access

	objects: ARRAYED_LIST [GB_OBJECT]
		-- All objects currently in system.
		-- Mutually exclusive with `deleted_objects'.
		
	deleted_objects: ARRAYED_LIST [GB_OBJECT]
		-- All objects that have been deleted in
		-- this session of the application.
		-- Mutually exclusivve with `objects'.
		
	root_window_object: GB_TITLED_WINDOW_OBJECT
		-- The object representing the window that will be launched by the application.

end -- class GB_OBJECT_HANDLER
