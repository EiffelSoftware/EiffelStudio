indexing
	description: "An object which handles objects of type GB_OBJECT."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_OBJECT_HANDLER

inherit
	INTERNAL
		export
			{NONE} all
			{ANY} dynamic_type_from_string, is_instance_of, is_valid_type_string
		end

	GB_CONSTANTS
		export
			{NONE} all
			{ANY} gb_primitive_object_class_name, gb_parent_object_class_name
		end

	GB_SHARED_DEFERRED_BUILDER
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

	GB_XML_OBJECT_BUILDER
		rename
			new_object as builder_new_object
		export
			{NONE} all
		end

	ANY

create
	make_with_components

feature -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Initialize `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			reset_objects
			reset_deleted_objects
		ensure
			components_set: components = a_components
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
			position_valid: position >= 1 and position <= container.children.count + 1
		local
			all_editors_local: ARRAYED_LIST [GB_OBJECT_EDITOR]
			parent_object: GB_PARENT_OBJECT
		do
			parent_object ?= container
			check
				not_a_parent_type: parent_object /= Void
			end

				-- When we change the type of an object, we keep the
				-- original layout_item. This is why the layout item
				-- may not be void, and the other attributes may be.
			if new_object.layout_item = Void then
				new_object.create_layout_item
			end
			if new_object.object = Void then
				new_object.build_objects
			end
			parent_object.add_child_object (new_object, position)

				-- We must now update the object editors to take into account
				-- This information. Some representations of objects in the editor
				-- display information regarding their children, so a call to
				-- this function requires and update to the object editor.
			all_editors_local := components.object_editors.all_editors
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
			components.system_status.mark_as_dirty
		ensure
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
			new_object_is_parent_object_type: is_instance_of (new_object, dynamic_type_from_string (gb_parent_object_class_name))
			old_object_is_parent_object_type: is_instance_of (old_object, dynamic_type_from_string (gb_parent_object_class_name))
		local
			parent_object: GB_PARENT_OBJECT
			child_object: GB_OBJECT
			children: ARRAYED_LIST [GB_OBJECT]
		do
			children := old_object.children.twin
			parent_object ?= new_object
			check
				object_was_parent_object: parent_object /= Void
			end

			from
				children.start
			until
				children.off
			loop
				child_object := children.item
				old_object.remove_child (child_object)
				parent_object.add_child_object (child_object, parent_object.children.count + 1)
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

			local_all_editors := components.object_editors.all_editors
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
		require
			root_window_void: root_window_object = Void
		local
			window_object: GB_TITLED_WINDOW_OBJECT
			widget_selector_item: GB_WIDGET_SELECTOR_ITEM
		do
			window_object ?= build_object_from_string_and_assign_id ("EV_TITLED_WINDOW")
			check
				object_was_window: window_object /= Void
			end
			add_new_window (window_object)
			window_object.set_name (initial_main_window_name);
			create widget_selector_item.make_with_object (window_object, components)
			components.tools.widget_selector.add_alphabetically (window_object.widget_selector_item)
			window_object.widget_selector_item.enable_select
			window_object.set_as_root_window
		ensure
			root_window_set: root_window_object /= Void
		end

	add_root_window (a_type: STRING): GB_OBJECT is
			-- Add a new root item and return the newly created object.
			-- The only root item types that are currently supported
			-- are GB_TITLED_WINDOW_OBJECT and GB_DIALOG which is a descendent
			-- therefore, the result is always a window object.
			--| FIXME, this is a function with a side effect.
		local
			titled_window_object: GB_TITLED_WINDOW_OBJECT
			widget_selector_item: GB_WIDGET_SELECTOR_ITEM
		do
			Result := build_object_from_string (a_type)
			titled_window_object ?= Result
			if titled_window_object /= Void then
				add_new_window (titled_window_object)
			else
				add_new_object (Result)
			end
			create widget_selector_item.make_with_object (Result, components)
		ensure
			result_not_void: Result /= Void
		end

	add_new_window (window_object: GB_TITLED_WINDOW_OBJECT) is
			-- Perform necessary initialization for new window,
			-- `window_object'.
		require
			window_object_not_void: window_object /= Void
		local
			layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
			titled_window: EV_TITLED_WINDOW
			display_win: GB_DISPLAY_WINDOW
			object_built: BOOLEAN
			widget: EV_WIDGET
			menu_bar: EV_MENU_BAR
		do
			object_built := window_object.layout_item /= Void
			if not object_built then
				create layout_item.make (window_object, components)
			end
				-- We must only add the layout item if there is
				-- no window currently displayed.
			if components.tools.layout_constructor.is_empty then
				components.tools.layout_constructor.add_root_item (layout_item)
			end
			if not object_built then
				window_object.set_layout_item (layout_item)
				window_object.build_drop_actions_for_layout_item (window_object.layout_item)
			end
			create display_win.make_with_components (components)
			titled_window ?= display_win
			titled_window.set_size (Default_window_dimension, Default_window_dimension)
			if window_object.object /= Void then
				widget := window_object.object.item
				widget.parent.prune_all (widget)
				titled_window.extend (widget)
				menu_bar := window_object.object.menu_bar
				if menu_bar /= Void then
					menu_bar.parent.remove_menu_bar
					titled_window.set_menu_bar (menu_bar)
				end
			end

			window_object.set_object (titled_window)

			if window_object.display_object = Void then
				window_object.build_display_object
			end
		end

	add_new_object (an_object: GB_OBJECT) is
			-- Perform necessary initialization for new top level object,
			-- `an_object'.
		local
			layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
			titled_window: EV_TITLED_WINDOW
			display_win: GB_DISPLAY_WINDOW
			builder_win: GB_BUILDER_WINDOW
		do
			if an_object.layout_item = Void then
				create layout_item.make (an_object, components)
				an_object.set_layout_item (layout_item)
				an_object.build_drop_actions_for_layout_item (an_object.layout_item)
			end
				-- We must only add the layout item if there is
				-- no window currently displayed.
			if components.tools.layout_constructor.is_empty then
				components.tools.layout_constructor.add_root_item (an_object.layout_item)
			end

			create display_win.make_with_components (components)
			titled_window ?= display_win
			titled_window.set_size (Default_window_dimension, Default_window_dimension)
			if an_object.object = Void then
				an_object.create_object_from_type
				an_object.build_display_object
			end
			create display_win.make_with_components (components)
			insert_into_window (an_object.object, display_win)
			create builder_win.make_with_components (components)
			insert_into_window (an_object.display_object, builder_win)
		end

	remove_object (an_object: GB_OBJECT) is
			-- Remove `an_object' from `objects'.
		do
			objects.remove (an_object.id)
		ensure
			not_in_objects: not objects.has (an_object.id)
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
			notebook_object: GB_NOTEBOOK_OBJECT
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
					create dialog_object.make_with_type (text, components)
					Result ?= dialog_object
				elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_titled_window_string)) then
					create titled_window_object.make_with_type (text, components)
					Result ?= titled_window_object
				else
					create cell_object.make_with_type (text, components)
					Result ?= cell_object
				end
			elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_container_string)) then
				if type_conforms_to (current_type, dynamic_type_from_string (Ev_notebook_string)) then
					create notebook_object.make_with_type (text, components)
					Result ?= notebook_object
				elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_widget_list_string)) then
					create widget_list_object.make_with_type (text, components)
					Result ?= widget_list_object
				elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_table_string)) then
					create table_object.make_with_type (text, components)
					Result ?= table_object
				elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_split_area_string)) then
					create split_area_object.make_with_type (text, components)
					Result ?= split_area_object
				else
					check
						invalid_type_conformance: False
					end
				end
			elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_primitive_string)) then
				if type_conforms_to (current_type, dynamic_type_from_string (Ev_tool_bar_string)) then
					create tool_bar_object.make_with_type (text, components)
					Result := tool_bar_object
				elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_list_string)) then
					create list_object.make_with_type (text, components)
					Result := list_object
				elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_combo_box_string)) then
					create combo_box_object.make_with_type (text, components)
					Result := combo_box_object
				elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_tree_string)) then
					create tree_object.make_with_type (text, components)
					Result := tree_object
				else
					create primitive_object.make_with_type (text, components)
					Result ?= primitive_object
				end
			elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_menu_bar_string)) then
				create menu_bar_object.make_with_type (text, components)
				Result ?= menu_bar_object
			elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_menu_string)) then
				create menu_object.make_with_type (text, components)
				Result ?= menu_object
			elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_menu_item_string)) then
				create menu_item_object.make_with_type (text, components)
				Result ?= menu_item_object
			elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_item_string)) then
				if type_conforms_to (current_type, dynamic_type_from_string (Ev_tool_bar_item_string)) then
					create tool_bar_item_object.make_with_type (text, components)
					Result ?= tool_bar_item_object
				elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_list_item_string)) then
					create list_item_object.make_with_type (text, components)
					Result ?= list_item_object
				elseif type_conforms_to (current_type, dynamic_type_from_string (Ev_tree_item_string)) then
					create tree_item_object.make_with_type (text, components)
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
			reset_objects
			reset_deleted_objects
			components.tools.widget_selector.wipe_out
		ensure
			objects_is_empty: objects.is_empty
			deleted_objects_is_empty: deleted_objects.is_empty
			widget_selector_is_empty: components.tools.widget_selector.count = 0
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
				if objects.item_for_iteration.name.as_lower.is_equal (a_string) then
					Result := True
				end
				object_events := objects.item_for_iteration.events
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
			current_item: GB_OBJECT
		do
			create Result.make (objects.count)
			from
				objects.start
			until
				objects.off
			loop
				current_item := objects.item_for_iteration
				if not current_item.name.is_empty then
					Result.extend (current_item.name)
				end
				object_events := current_item.events
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
			current_window_object: GB_OBJECT
		do
			if not object_name.is_empty then
				string_is_object_name_result := False
				parent_object := an_object.top_level_parent_object
				recursive_do_all (parent_object, agent check_object_name (object_name, an_object, compare_original_object,  ?))
				Result := string_is_object_name_result
				if parent_object = an_object then
					-- `an_object' is a window as it has no parent, therefore, we must check that the name
					-- does not clash with that of any other titled windows.
					window_objects ?= components.tools.widget_selector.objects
					from
						window_objects.start
					until
						window_objects.off
					loop
						current_window_object := window_objects.item
							-- We ensure that if the object is a window, we do not compare
							-- it with itself.
						if current_window_object.name.as_lower.is_equal (object_name.as_lower) then
							if (not compare_original_object and then current_window_object /= an_object) or compare_original_object then
								Result := True
							end
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
			from
				objects.start
			until
				objects.off
			loop
				check_object_name (a_name, Void, True, objects.item_for_iteration)
				objects.forth
			end
			from
				objects.start
			until
				objects.off
			loop
				check_feature_name (a_name, Void, objects.item_for_iteration)
				objects.forth
			end
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
			-- All children objects contained in `objects'.
		local
			all_children_recursive: ARRAYED_LIST [GB_OBJECT]
			current_object: GB_OBJECT
		do
			objects.remove (an_object.id)
			deleted_objects.put (an_object, an_object.id)
			create all_children_recursive.make (40)
			an_object.all_children_recursive (all_children_recursive)
			from
				all_children_recursive.start
			until
				all_children_recursive.off
			loop
				current_object := all_children_recursive.item
				if not deleted_objects.has (current_object.id) then
					objects.remove (current_object.id)
					deleted_objects.put (current_object, current_object.id)
				end
				all_children_recursive.forth
			end
		ensure
			object_deleted: deleted_objects.has (an_object.id) and not objects.has (an_object.id)
		end

	mark_existing (an_object: GB_OBJECT) is
			-- Move `an_object' and all children at all levels in to
			-- `objects'.
		require
			an_object_not_void: an_object /= Void
			an_object_deleted: deleted_objects.has (an_object.id)
			-- All children objects contained in `deleted_objects'.
		local
			all_children_recursive: ARRAYED_LIST [GB_OBJECT]
			current_object: GB_OBJECT
		do
			deleted_objects.remove (an_object.id)
			objects.put (an_object, an_object.id)

			create all_children_recursive.make (40)
			an_object.all_children_recursive (all_children_recursive)
			from
				all_children_recursive.start
			until
				all_children_recursive.off
			loop
				current_object := all_children_recursive.item
				if not objects.has (current_object.id) then
					deleted_objects.remove (current_object.id)
					objects.put (current_object, current_object.id)
				end
				all_children_recursive.forth
			end
		ensure
			object_removed_from_deleted: objects.has (an_object.id) and not deleted_objects.has (an_object.id)
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
			local_objects: HASH_TABLE [GB_OBJECT, INTEGER]
		do
			local_objects ?= objects
			from
				local_objects.start
			until
				local_objects.off or
				Result /= Void
			loop
				if (local_objects.item_for_iteration).object = ev_any then
					Result := local_objects.item_for_iteration
				end
				local_objects.forth
			end
		end

	object_from_id (an_id: INTEGER): GB_OBJECT is
			-- `Result' is GB_OBJECT with id `an_id'.
			-- Only checks in `objects'.
		require
			valid_id: an_id >= 0
		do
			Result := objects.item (an_id)
		end

	deep_object_from_id (an_id: INTEGER): GB_OBJECT is
			-- `Result' is GB_OBJECT with id `an_id'.
			-- Checks in `objects' and `deleted_objects'.
		require
			valid_id: an_id >= 0
		do
			Result := objects.item (an_id)
			if Result = Void then
				Result := deleted_objects.item (an_id)
			end
		end

	add_default_names (some_objects: ARRAYED_LIST [GB_OBJECT]) is
			-- For all objects in `some_objects', add a default name, if
			-- they do not have a name assigned.
		local
			names: ARRAYED_LIST [STRING]
			an_object: GB_OBJECT
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
					names.extend (some_objects.item.name.twin)
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
						--Add the new name to `names' so that it is not used again.
					names.extend (an_object.name)
				end
				components.object_editors.rebuild_associated_editors (an_object.id)
				some_objects.forth
			end
				-- Update project so it may be saved.
			components.system_status.mark_as_dirty
		end

	reset_deleted_objects is
			-- Reset `deleted_objects' to it's default state.
		do
			--|FIXME should probably remove all deleted instance referers.
			create deleted_objects.make (100)
		end

	reset_objects is
			-- Reset `objects' to it's default state.
		do
			create objects.make (100)
		end

feature {GB_XML_LOAD, GB_XML_OBJECT_BUILDER, GB_XML_IMPORT} -- Implementatation

	update_all_associated_objects is
			-- Update all objects in system after a load or import
			-- so that the instance referers are correctly built.
			-- If an import has just been executed, there is no need to update
			-- all `objects' but it is easier, and there is no problem with doing this
			-- as existing objects do nothing.
		do
			from
				objects.start
			until
				objects.off
			loop
				objects.item_for_iteration.update_object_as_instance_representation
				objects.forth
			end
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

feature {GB_EV_WIDGET_EDITOR_CONSTRUCTOR, GB_OBJECT} -- Implementation

	reset_object (an_object: GB_OBJECT) is
			-- Reset `an_object' by rebuilding. An XML representation
			-- of the object is built, and then a new object is generated from
			-- this XML. The new object replaces the old version with the same ID,
			-- and the contents are transferred across.
		require
			an_object_not_void: an_object /= Void
		local
			store: GB_XML_STORE
			element: XM_ELEMENT
			load: GB_XML_LOAD
			new_object, parent_object: GB_OBJECT
			original_position: INTEGER
			display_widget, builder_widget: EV_WIDGET
			titled_window_object: GB_TITLED_WINDOW_OBJECT
			new_display_window, old_display_window: GB_DISPLAY_WINDOW
			new_builder_window, old_builder_window: GB_BUILDER_WINDOW
			display_object: GB_DISPLAY_OBJECT
			locked_in_here, display_window_shown, builder_window_shown: BOOLEAN
			original_children: ARRAYED_LIST [GB_OBJECT]
			layout_constructor_state_handler: GB_LAYOUT_CONSTRUCTOR_STATE_HANDLER
		do
			if (application.locked_window = Void) then
				locked_in_here := True
				parent_window (components.tools.layout_constructor).lock_update
			end
			create layout_constructor_state_handler.make_with_components (components)
			layout_constructor_state_handler.store_layout_constructor
			parent_object := an_object.parent_object
			if parent_object /= Void then
				check
					parent_object_has_child: parent_object.children.has (an_object)
				end
				original_position := parent_object.children.index_of (an_object, 1)
			end

				-- Store original children, to ensure that the new object has the same children after the reset.
				-- This is performed as a check, so we cannot write this using "old" in the postcondition.
			original_children := an_object.children.twin

			create store.make_with_components (components)
			create load.make_with_components (components)
			create element.make_root (create {XM_DOCUMENT}.make, "item", create {XM_NAMESPACE}.make_default)
			add_attribute_to_element (element, "type", "xsi", an_object.type)

			store.output_attributes (an_object, element, create {GB_GENERATION_SETTINGS})
				-- Generate an XML representation of `an_object' in `element'.

				-- Call `delete' as the object must be deleted before being re-created. This performs
				-- any necessary processing on `an_object', ensuring that the state of the system
				-- is ok post re-creation.
			an_object.delete

				-- Build a new object from XML representation we made from `an_object'.
			new_object := build_object_from_string (element.attribute_by_name (type_string).value)

				-- Now build the representations of `new_object'. Note that windows are handled differently.
			titled_window_object ?= new_object
			if titled_window_object /= Void then
				add_new_window (titled_window_object)
			else
				new_object.create_object_from_type
				new_object.build_display_object
			end

				-- Set the layout item of `new_object' to the old object's layout item.
				-- This means that the layout item does not need to be unparented, it's reference
				-- is simply updated in both directions.
			new_object.set_layout_item (an_object.layout_item)

			if an_object.widget_selector_item /= Void then
					-- Set the widget selector item to the original widget selector item which
					-- simply remains in the widget selector, but it's `object' also gets updated
					-- to point to `new_object' from within `set_widget_selector_item'.
				new_object.set_widget_selector_item (an_object.widget_selector_item)
			end

			if an_object.is_instance_of_top_level_object then
					-- If the original object had an associated top level object, ensure that the new one also does.
				new_object.set_associated_top_level_object (deep_object_from_id (an_object.associated_top_level_object))
			end

				-- Assign the `id' of the old object to `new_object'.
			new_object.set_id (an_object.id)

				-- Set the `parent_object' of the new object.
			new_object.set_parent (an_object.parent_object)


				-- Now reparent the representations of the objects into the original
				-- widget structure that contained the representations for the original object, `an_object'.
				-- This is only performed if the original object was not a top level window or dialog.

			if titled_window_object = Void then
				display_widget ?= an_object.object
				builder_widget ?= new_object.object
				check
					objects_were_widgets: display_widget /= Void and builder_widget /= Void
				end
				reparent (display_widget, builder_widget)
				display_widget ?= an_object.display_object
				builder_widget ?= new_object.display_object
				reparent (display_widget, builder_widget)
				if is_instance_of (new_object, dynamic_type_from_string (gb_parent_object_class_name)) then
					move_object_contents (new_object, an_object, False)
				end

					-- As each object has a reference to it's children, we must replace all reference with
					-- `new_object' which is replacing `an_object'.
				if parent_object /= Void then
						-- Note that `parent_object' may be Void as although this section of code is
						-- only executed if we are not a window, EiffelBuild supports and widget at a top
						-- level, and in this case `parent_object' is Void'.
					parent_object.children.go_i_th (parent_object.children.index_of (an_object, 1))
					parent_object.children.remove
					parent_object.children.put_left (new_object)
				end
			else
				new_display_window ?= new_object.object
				display_object ?= new_object.display_object
				check
					object_was_display_object: display_object /= Void
				end
				new_builder_window ?= display_object.child
				old_display_window ?= an_object.object
				display_object ?= an_object.display_object
				check
					object_was_display_object: display_object /= Void
				end
				old_builder_window ?= display_object.child
				check
					objects_were_display_windows: new_display_window /= Void and old_display_window /= Void and
					new_builder_window /= Void and old_builder_window /= Void
				end

				components.tools.set_display_window (new_display_window)
				components.tools.set_builder_window (new_builder_window)

				move_object_contents (new_object, an_object, False)

					-- Now ensure that the new windows have the same size and position as the old one.
				new_display_window.set_position (old_display_window.x_position, old_display_window.y_position)
				new_builder_window.set_position (old_builder_window.x_position, old_builder_window.y_position)
				new_display_window.set_size (old_display_window.width.max (new_display_window.minimum_width), old_display_window.height.max (new_display_window.minimum_height))
				new_builder_window.set_size (old_builder_window.width.max (new_builder_window.minimum_width), old_builder_window.height.max (new_builder_window.minimum_height))

				display_window_shown := old_display_window.is_displayed
				builder_window_shown := old_builder_window.is_displayed

					-- Destroy the old windows.
				old_display_window.hide
				old_display_window.destroy
				old_builder_window.hide
				old_builder_window.destroy

					-- Force the new windows to be shown.
				if display_window_shown then
					new_display_window.show
				end
				if builder_window_shown then
					new_builder_window.show
				end
			end

			load.modify_from_xml (element, new_object)

				-- Now update all of the objects in `objects' so that the new objects replace the old.
				-- `objects' contains all obejcts in a hash table referenced by their respective id's so
				-- none of the id's should have changed, but the `object' contained needs to be the new version.
			check
				objects_have_same_id: an_object.id = new_object.id
			end

				-- Only the original object changes and must be updated in `objects'. All of the original children
				-- objects do not change. See implementation of `objects_equal' postcondition.
			remove_object (an_object)
			add_object_to_objects (new_object)

				-- Now ensure that the `instance_referers' are set in the new object.
				-- We simply copy all of the exsiting instance referers to the new object.
			from
				an_object.instance_referers.start
			until
				an_object.instance_referers.off
			loop
				new_object.instance_referers.put (an_object.instance_referers.item_for_iteration, an_object.instance_referers.item_for_iteration)
				an_object.instance_referers.forth
			end
				-- We now perform any deferred building that is required.
			Deferred_builder.build

			layout_constructor_state_handler.restore_layout_constructor

			if locked_in_here then
				parent_window (components.tools.layout_constructor).unlock_update
			end
			check
					-- As we cannot use `new_object' within the postcondition, we use a number of checks here.
				parent_correct: new_object.parent_object = an_object.parent_object
				parent_has_new_object: new_object.parent_object /= Void implies new_object.parent_object.children.has (new_object)
				object_children_equal: original_children.is_equal (new_object.children)
			end

				-- Now destroy `an_object' and all of its children as it is never used again
				-- as it has now been completely replaced with `new_object'.
			an_object.destroy_recursive
		ensure
			objects_equal: objects_updated_correctly ((old objects.twin), objects, an_object) and
				objects_updated_correctly ((old deleted_objects.twin), deleted_objects, an_object)
		end

feature {GB_TITLED_WINDOW_OBJECT, GB_XML_OBJECT_BUILDER, GB_XML_LOAD, GB_XML_IMPORT, GB_COMMAND} -- Implementation

	add_object_to_objects (an_object: GB_OBJECT) is
			-- Add `an_object' to `objects'.
		require
			not_already_included: not objects.has (an_object.id)
		do
			objects.put (an_object, an_object.id)
		ensure
			contained: objects.has (an_object.id)
		end

feature {GB_COMMAND_DELETE_OBJECT, GB_COMMAND_DELETE_WINDOW_OBJECT, GB_COMMAND_ADD_WINDOW} -- Implementation

	update_object_editors_for_delete (deleted_object, parent_object: GB_OBJECT) is
			-- For every item in `editors', update to reflect removal of `deleted_object' from `parent_object'.
		local
			editor: GB_OBJECT_EDITOR
			window_parent: EV_WINDOW
			editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
		do
			editors := components.object_editors.all_editors
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
					if editor = components.object_editors.docked_object_editor then
						editor.make_empty
					else
						window_parent := parent_window (editor)
						check
							floating_editor_is_in_window: window_parent /= Void
						end
						editor.destroy
						window_parent.destroy
						components.object_editors.floating_object_editors.prune (editor)
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

	object_contained_in_object_result: BOOLEAN
		-- Result of last call to `object_contained_in_object'.

	objects_updated_correctly (old_objects, new_objects: like objects; an_object: GB_OBJECT): BOOLEAN is
			-- Are contents of `old_objects' and `new_objects' the same except for
			-- the item referenced by `an_object.id'. This is only used for the postcondition of `reset_object'.
			-- Only the `item' in `objects' that was reset may change. All other objects must remain identical
			-- and
		require
			old_objects_not_void: old_objects /= Void
			new_objects_not_void: new_objects /= Void
			an_object_not_void: an_object /= Void
		do
			Result := old_objects.count = new_objects.count
			from
				old_objects.start
				new_objects.start
			until
				old_objects.off
			loop
				if old_objects.key_for_iteration /= new_objects.key_for_iteration then
					Result := False
				end
				if an_object.id /= old_objects.key_for_iteration and old_objects.item_for_iteration /= new_objects.item_for_iteration then
					Result := False
				end
				old_objects.forth
				new_objects.forth
			end
		end

feature -- Access

	objects: HASH_TABLE [GB_OBJECT, INTEGER]
		-- All objects currently in system.
		-- Mutually exclusive with `deleted_objects'.

	deleted_objects: HASH_TABLE [GB_OBJECT, INTEGER]
		-- All objects that have been deleted in
		-- this session of the application.
		-- Mutually exclusive with `objects'.

	root_window_object: GB_TITLED_WINDOW_OBJECT;
		-- The object representing the window that will be launched by the application.

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


end -- class GB_OBJECT_HANDLER
