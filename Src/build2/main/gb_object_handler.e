indexing
	description: "An object which handles objects of type GB_OBJECT."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_OBJECT_HANDLER
	
inherit
	INTERNAL
	
	GB_CONSTANTS
	
	GB_SHARED_OBJECT_EDITORS
	
	GB_SHARED_SYSTEM_STATUS
	
	GB_SHARED_COMMAND_HANDLER
	
	GB_XML_UTILITIES
	
	GB_SHARED_DEFERRED_BUILDER
	
	GB_LAYOUT_CONSTRUCTOR_STATE_HANDLER
	
	GB_WIDGET_UTILITIES
	
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
			node: GB_LAYOUT_CONSTRUCTOR_ITEM
			layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			cell_object ?= new_object
			container_object ?= new_object
			check
				new_object_is_cell_or_container: cell_object /= Void or container_object /= Void
			end
			
			layout_item := old_object.layout_item
			from
				layout_item.start
			until
				layout_item.off
			loop			
				node ?= layout_item.item
				child_object ?= node.object
				check
					child_object_not_void: child_object /= Void
				end
				if in_type_change then
					child_object.unparent_during_type_change
				else
					child_object.unparent
				end
				
				if cell_object /= Void then
					cell_object.add_child_object (child_object, 1)	
				else
					container_object.add_child_object (child_object, container_object.object.count + 1)
				end

				layout_item.forth
			end
		end
		
	replace_object_type (an_object: GB_OBJECT; a_type: STRING) is
			-- Replace `an_object' with a new object of type `selector_item'.
			-- Note that as EV_TABLE has no theoretical limit to the number of children
			-- it may contain, we enlarge the newly created table to hold the number of
			-- children in `an_object'. Its default size is 1x1.
		require
			an_object_not_void: an_object /= Void
			an_object_object_not_void: an_object.object /= Void
			an_object_display_item_not_void: an_object.display_object /= Void
			an_object_layout_item_not_void: an_object.layout_item /= Void
		do
			replace_object (an_object, build_object_from_string_and_assign_id (a_type))
		end
		
	replace_object (an_object, new_object: GB_OBJECT) is
			-- Replace `an_object' with `new_object'.
			-- We must transfer the children of the object, the display_object children
			-- and the layout_item children.
		require
			an_object_not_void: an_object /= Void
			an_object_object_not_void: an_object.object /= Void
			an_object_display_item_not_void: an_object.display_object /= Void
			an_object_layout_item_not_void: an_object.layout_item /= Void
			
		local
			layout_parent_item, old_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
			parent_object: GB_OBJECT
			original_position: INTEGER
			local_all_editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
			table_object: GB_TABLE_OBJECT
		do
				-- Retreive the parent of `an_object'
				-- we must do this before calling `remove_object_from_parent'.
			layout_parent_item ?= an_object.layout_item.parent
			
				-- Store the layout item as we need to use this in the new object.
				-- If we keep references to this layout item, when the type changes,
				-- we can still access the object.
			old_layout_item := an_object.layout_item

				--| Need to get original position.
			original_position := layout_parent_item.index_of (an_object.layout_item, 1)			
			
			parent_object ?= layout_parent_item.object
			check
				parent_object_not_void: parent_object /= Void
			end
			
				-- Remove `an_object' from its parent.
			an_object.unparent_during_type_change
			
			new_object.set_layout_item (old_layout_item)
			new_object.layout_item.set_text (new_object.short_type)
			
				-- Add new object to parent of old object.
			add_object (parent_object, new_object, original_position)			
			
			 -- Now, if we are a table, we must resize the table to fit all
			 -- the new contents.
			 table_object ?= new_object
			if table_object /= Void then
				table_object.resize_to_accomodate (an_object.layout_item.count)
			end
				
			
				-- Now we must swap the children over.	
				-- We only do this if `an_object' is a container or a cell.
				--| FIXME when we support replacing types of primitives with items, ie
				--| combo box to list and back, we need to modify this.
			if (is_instance_of (an_object, dynamic_type_from_string (gb_cell_object_class_name)) or
				(is_instance_of (an_object, dynamic_type_from_string (gb_container_object_class_name))) and
				(is_instance_of (new_object, dynamic_type_from_string (gb_cell_object_class_name)) or
				is_instance_of (new_object, dynamic_type_from_string (gb_container_object_class_name)))) then
					
				move_object_contents (new_object, an_object, True)	
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
		
	object_contained_in_object (parent_object, child_object: GB_OBJECT): BOOLEAN is
			-- Is `child_object' a child (recursively) of `parent_object'?
		require
			parent_not_void: parent_object /= Void
		local
			parent_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			object_contained_in_object_result := False
			parent_layout_item ?= parent_object.layout_item
			check
				parent_layout_item_not_void: parent_layout_item /= Void
			end
			parent_layout_item.recursive_do_all (agent is_child (child_object, ?))
			Result := object_contained_in_object_result
		end
		
	is_child (child_object: GB_OBJECT; an_item: EV_TREE_ITEM) is
			-- Is `child_object' a direct child of `an_item'?
		local
			current_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			current_item ?= an_item
			check
				current_item_not_void: current_item /= Void
			end
			if current_item.object = child_object then
				object_contained_in_object_result := True
			end
		end
		
	object_contained_in_object_result: Boolean
		-- Result of last call to `object_contained_in_object'.
		
	add_initial_window is
			-- Add a new window when there are no other contained.
		require
			window_selector_empty: window_selector.is_empty
		local
			window_object: GB_TITLED_WINDOW_OBJECT
		do
			window_object ?= build_object_from_string_and_assign_id ("EV_TITLED_WINDOW")
			check
				object_was_window: window_object /= Void
			end
			add_new_window (window_object)
			window_selector.set_item_for_prebuilt_window (window_object)
		end
		
	add_root_window: GB_TITLED_WINDOW_OBJECT is
			-- Add a new root window and return the newly created object.
			--| FIXME, this is a function with a side effect.
		do
			Result ?= build_object_from_string_and_assign_id ("EV_TITLED_WINDOW")
			add_new_window (Result)
			window_selector.set_item_for_prebuilt_window (Result)
		ensure
			result_not_void: Result /= Void
		end
		
		
	add_new_window (window_object: GB_TITLED_WINDOW_OBJECT) is
			-- Perform necessary initialzation for new window,
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
			window_object.set_object (titled_window)
			set_display_window (display_win)
			create builder_win
			set_builder_window (builder_win)
			window_object.set_display_object (builder_win)
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
				if type_conforms_to (current_type, dynamic_type_from_string (Ev_titled_window_string)) then
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
			-- state of the system. This relies on the fact that the
			-- first item in `objects' is the root window.
			-- This will almost certainly change at some point in the future.
		local
			window_object: GB_TITLED_WINDOW_OBJECT
			window_child: GB_OBJECT
			layout_item, temp_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			window_object ?= objects.first
			check
				window_found: window_object /= Void
			end
				-- A window may only have one child, but the layout item may have up to 2 items.
				-- One to represent the child, and one to represent a menu bar.
			if window_object.layout_item /= Void and then not window_object.layout_item.is_empty then
				layout_item ?= window_object.layout_item
				
				from
					layout_item.start
				until
					layout_item.off
				loop
					
					temp_layout_item ?= layout_item.item
						window_child ?= temp_layout_item.object
						check
							window_child_not_void: window_child /= Void
						end
						window_child.unparent
					layout_item.forth
				end
			end
			
				-- Update objects referenced by `window_object'.
			window_object.update_objects
			
				-- Because `window_object' exists throughout
				-- the execution of the application, we
				-- must clear the events. Otherwise, every time
				-- we close and then re-load a project, the
				-- events recorded for `window_object' are extended.
			window_object.events.wipe_out
			
				-- Wipe `deleted_objects'.
			deleted_objects.wipe_out
				-- Wipe out `objects' but restore the
			
			objects.wipe_out
			
			window_selector.wipe_out
		end
		
	string_is_object_name (object_name: STRING; an_object: GB_OBJECT): BOOLEAN is
		local
			current_name_lower, name_lower: STRING
			current_object: GB_OBJECT
		do
			if not object_name.is_empty then
				name_lower := object_name
				name_lower.to_lower
				from
					objects.start
				until
					objects.off or Result
				loop
					current_object := objects.item
						-- If `an_object' /= `Void' then do not check against `an_object' when found.
					if (an_object /= Void and then current_object /= an_object) or (an_object = Void) then
						current_name_lower := current_object.name
						current_name_lower.to_lower
						if current_name_lower.is_equal (name_lower) then
							Result := True
						end
					end
					objects.forth
				end
			end
		end
		
	string_is_feature_name (object_name: STRING; an_object: GB_OBJECT): BOOLEAN is
			-- Is `object_name' already used as a feature name for event connection?
		local
			object_events: ARRAYED_LIST [GB_ACTION_SEQUENCE_INFO]
			name_lower: STRING
			current_object: GB_OBJECT
		do
				-- Do nothing if `object_name' is empty.
			if not object_name.is_empty then
				name_lower := object_name
				name_lower.to_lower
				from
					objects.start
				until
					objects.off or Result
				loop
					current_object := objects.item
						-- Access events of `current_object' locally, for speed
					object_events := current_object.events
						-- No need to check further if `object_events' is empty.
						-- Note that we always check the events, even if `an_object' /= `Void'.
					if not object_events.is_empty then
						from
							object_events.start
						until
								-- No need to loop if already found.
							object_events.off or Result
						loop
							if name_lower.is_equal (object_events.item.feature_name) then
								Result := True
							end
							object_events.forth
						end
					end

					objects.forth
				end
			end
		end
	name_in_use (object_name: STRING; an_object: GB_OBJECT): BOOLEAN is
			-- Is a GB_OBJECT with name matching `object_name' contained
			-- in `objects' or `events' of all objects in `objects.
			-- Case insensitive search. Ignore `an_object' name
			-- if not `Void', but still check the events for `an_object'.
			-- Returns `False' if `object_name' is empty. This is because you are
			-- allowed to have as many "unnamed" objects as you wish.
		do
			Result := string_is_object_name (object_name, an_object) or
				string_is_feature_name (object_name, an_object)
		end
		
	
	existing_feature_matches (feature_name, type: STRING): BOOLEAN is
			-- Do all action sequences with feature named `feature_name' connected,
			-- have a type that is compatible (argument wise) with `type'.
		require
			feature_name_already_used: string_is_feature_name (feature_name, Void)
		local
			name_lower: STRING
			current_object: GB_OBJECT
			object_events: ARRAYED_LIST [GB_ACTION_SEQUENCE_INFO]
			action_sequence1, action_sequence2: GB_EV_ACTION_SEQUENCE
			first_types, second_types: STRING
		do
			Result := True
			name_lower := feature_name.as_lower
				from
					objects.start
				until
					objects.off or not Result
				loop
					current_object := objects.item
						-- Access events of `current_object' locally, for speed
					object_events := current_object.events
						-- Note that we always check the events, even if `an_object' /= `Void'.
					if not object_events.is_empty then
						from
							object_events.start
						until
								-- No need to loop if already found not to match.
							object_events.off or not Result
						loop
							if name_lower.is_equal (object_events.item.feature_name) then
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
									Result := False
								end
							end
							object_events.forth
						end
					end

					objects.forth
				end
		end
		
		
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
		local
			t: TUPLE [GB_OBJECT]
			layout_item, current_layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			create t.make
			t.put (an_object, 1)
			action.call (t)
			layout_item := an_object.layout_item
			from
				layout_item.start
			until
				layout_item.off
			loop
				current_layout_item ?= layout_item.item
				check
					current_layout_item_not_void: current_layout_item /= Void
				end
				recursive_do_all (current_layout_item.object, action)
				layout_item.forth
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
			element: XML_ELEMENT
			load: GB_XML_LOAD
			new_object: GB_OBJECT
			parent_object: GB_OBJECT
			table_parent_object: GB_TABLE_OBJECT
			original_position: INTEGER
			x, y, width, height: INTEGER
			fixed: EV_FIXED
			widget: EV_WIDGET
			table: EV_TABLE
			container_object: GB_CONTAINER_OBJECT
			titled_window_object: GB_TITLED_WINDOW_OBJECT
			old_contents: EV_WIDGET
			old_window: EV_TITLED_WINDOW
			new_window: EV_TITLED_WINDOW
			old_builder_window, new_builder_window: EV_TITLED_WINDOW
			old_builder_contents: EV_WIDGET
			locked_in_here: BOOLEAN
			old_window_selector_item: GB_WINDOW_SELECTOR_ITEM
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
				original_position := parent_object.layout_item.index_of (an_object.layout_item, 1)
				an_object.unparent	
				
				create store
				create load
				element := new_root_element ("item", "prefix")
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
				old_contents := titled_window_object.object.item
				old_window ?= titled_window_object.object				
				old_builder_contents := titled_window_object.display_object.child.item
				old_builder_window ?= titled_window_object.display_object.child
				old_window_selector_item ?= titled_window_object.window_selector_item

				create store
				create load
				element := new_root_element ("item", "prefix")
				add_attribute_to_element (element, "type", "xsi", an_object.type)
				store.output_attributes (an_object, element, create {GB_GENERATION_SETTINGS})
				
				titled_window_object.update_objects
				load.rebuild_window (titled_window_object, element)
				
				new_window := titled_window_object.object
				new_builder_window ?= titled_window_object.display_object.child
				
				old_window.wipe_out
				old_builder_window.wipe_out
				
				new_window.extend (old_contents)
				new_builder_window.extend (old_builder_contents)
				
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

feature -- Access

	objects: ARRAYED_LIST [GB_OBJECT]
		-- All objects currently in system.
		
	deleted_objects: ARRAYED_LIST [GB_OBJECT]
		-- All objects that have been deleted in
		-- this session of the application.		

end -- class GB_OBJECT_HANDLER
