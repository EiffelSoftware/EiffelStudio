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
			container_object: GB_CONTAINER_OBJECT
			cell_object: GB_CELL_OBJECT
			tool_bar_object: GB_TOOL_BAR_OBJECT
			list_object: GB_LIST_OBJECT
			combo_box_object: GB_COMBO_BOX_OBJECT
			menu_bar_object: GB_MENU_BAR_OBJECT
			menu_object: GB_MENU_OBJECT
			all_editors_local: ARRAYED_LIST [GB_OBJECT_EDITOR]
			tree_object: GB_TREE_OBJECT
			tree_item_object: GB_TREE_ITEM_OBJECT
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
				if type_conforms_to (dynamic_type_from_string (new_object.type), dynamic_type_from_string ("EV_WIDGET")) then
					new_object.set_up_display_object_events (new_object.display_object, new_object.object)	
				end
			end
				--| FIXME there should be a class in the object inheritence structure
				--| which allows us to avoid all this.
			container_object ?= container
			cell_object ?= container
			tool_bar_object ?= container
			list_object ?= container
			combo_box_object ?= container
			menu_bar_object ?= container
			menu_object ?= container
			tree_object ?= container
			tree_item_object ?= container
			check
				unsupported_item_type: container_object /= Void or cell_object /= Void or tool_bar_object /= Void
				or list_object /= Void or combo_box_object /= Void or menu_bar_object /= Void or menu_object /= Void
				or tree_object /= Void or tree_item_object /= Void
			end
			if container_object /= Void then
				container_object.add_child_object (new_object, position)
			end
			if cell_object /= Void then
		--| FIXME only applies if not a window, as a window may
		--| have two items, one representing a menu, and the other
		--| representing the contents.
		--		check
		--			position_is_one: position = 1
		--		end
				cell_object.add_child_object (new_object)
			end
			
			if tool_bar_object /= Void then
				tool_bar_object.add_child_object (new_object, position)
			end
			
			if list_object /= Void then
				list_object.add_child_object (new_object, position)
			end
			
			if combo_box_object /= Void then
				combo_box_object.add_child_object (new_object, position)
			end
			
			if menu_bar_object /= Void then
				menu_bar_object.add_child_object (new_object, position)
			end
			
			if menu_object /= Void then
				menu_object.add_child_object (new_object, position)
			end
			
			if tree_object /= Void then
				tree_object.add_child_object (new_object, position)
			end
			
			if tree_item_object /= Void then
				tree_item_object.add_child_object (new_object, position)
			end
			
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

	move_object_contents (new_object, old_object: GB_OBJECT) is
			-- Take all children of `old_object', and their representations,
			-- and move into `new_object'.
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
				child_object.unparent_during_type_change
				
				if cell_object /= Void then
					cell_object.add_child_object (child_object)	
				else
					container_object.add_child_object (child_object, container_object.object.count + 1)--container_object.layout_item.count + 1)
				end

				layout_item.forth
			end
		end
		
	replace_object_type (an_object: GB_OBJECT; a_type: STRING) is
			-- Replace `an_object' with a new object of type `selector_item'.
		require
			an_object_not_void: an_object /= Void
			an_object_object_not_void: an_object.object /= Void
			an_object_display_item_not_void: an_object.display_object /= Void
			an_object_layout_item_not_void: an_object.layout_item /= Void
		do
			replace_object (an_object, build_object_from_string (a_type))
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
				
			
				-- Now we must swap the children over.	
				-- We only do this if `an_object' is a container or a cell.
				--| FIXME when we support replacing types of primitives with items, ie
				--| combo box to list and back, we need to modify this.
			if (is_instance_of (an_object, dynamic_type_from_string (gb_cell_object_class_name)) or
				(is_instance_of (an_object, dynamic_type_from_string (gb_container_object_class_name))) and
				(is_instance_of (new_object, dynamic_type_from_string (gb_cell_object_class_name)) or
				is_instance_of (new_object, dynamic_type_from_string (gb_container_object_class_name)))) then
					
				move_object_contents (new_object, an_object)	
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

	add_root_object (an_object: GB_CELL_OBJECT) is
			-- Add `an_object' to `objects'.
		do
			objects.extend (an_object)
		ensure
			added_to_objects: objects.has (an_object)
		end
		
	remove_object (an_object: GB_OBJECT) is
			-- Remove `an_object' from `objects'.
		do
			objects.prune_all (an_object)
		ensure
			not_in_objects: not objects.has (an_object)
		end

	build_object_from_string (a_text: STRING): GB_OBJECT is
			-- Generate `Result' from `text'.
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
			if type_conforms_to (current_type, dynamic_type_from_string ("EV_CELL")) then
				if type_conforms_to (current_type, dynamic_type_from_string ("EV_TITLED_WINDOW")) then
					create titled_window_object.make_with_type (text)
					Result ?= titled_window_object
				else
					create cell_object.make_with_type (text)
					Result ?= cell_object
				end
			elseif type_conforms_to (current_type, dynamic_type_from_string ("EV_CONTAINER")) then
				if type_conforms_to (current_type, dynamic_type_from_string ("EV_WIDGET_LIST")) then
					create widget_list_object.make_with_type (text)
					Result ?= widget_list_object
				elseif type_conforms_to (current_type, dynamic_type_from_string ("EV_TABLE")) then
					create table_object.make_with_type (text)
					Result ?= table_object
				elseif type_conforms_to (current_type, dynamic_type_from_string ("EV_SPLIT_AREA")) then
					create split_area_object.make_with_type (text)
					Result ?= split_area_object
				else
					check
						invalid_type_conformance: False
					end
				end
			elseif type_conforms_to (current_type, dynamic_type_from_string ("EV_PRIMITIVE")) then
				if type_conforms_to (current_type, dynamic_type_from_string ("EV_TOOL_BAR")) then
					create tool_bar_object.make_with_type (text)
					Result := tool_bar_object
				elseif type_conforms_to (current_type, dynamic_type_from_string ("EV_LIST")) then
					create list_object.make_with_type (text)
					Result := list_object
				elseif type_conforms_to (current_type, dynamic_type_from_string ("EV_COMBO_BOX")) then
					create combo_box_object.make_with_type (text)
					Result := combo_box_object
				elseif type_conforms_to (current_type, dynamic_type_from_string ("EV_TREE")) then
					create tree_object.make_with_type (text)
					Result := tree_object
				else
					create primitive_object.make_with_type (text)
					Result ?= primitive_object
				end
			elseif type_conforms_to (current_type, dynamic_type_from_string ("EV_MENU_BAR")) then
				create menu_bar_object.make_with_type (text)
				Result ?= menu_bar_object
			elseif type_conforms_to (current_type, dynamic_type_from_string ("EV_MENU")) then
				create menu_object.make_with_type (text)
				Result ?= menu_object
			elseif type_conforms_to (current_type, dynamic_type_from_string ("EV_MENU_ITEM")) then
				create menu_item_object.make_with_type (text)
				Result ?= menu_item_object
			elseif type_conforms_to (current_type, dynamic_type_from_string ("EV_ITEM")) then
				if type_conforms_to (current_type, dynamic_type_from_string ("EV_TOOL_BAR_ITEM")) then
					create tool_bar_item_object.make_with_type (text)
					Result ?= tool_bar_item_object
				elseif type_conforms_to (current_type, dynamic_type_from_string ("EV_LIST_ITEM")) then
					create list_item_object.make_with_type (text)
					Result ?= list_item_object
				elseif type_conforms_to (current_type, dynamic_type_from_string ("EV_TREE_ITEM")) then
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
			window_object: GB_CELL_OBJECT
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
		end
		
	named_object_exists (object_name: STRING; an_object: GB_OBJECT): BOOLEAN is
			-- Is a GB_OBJECT with name matching `object_name' contained
			-- in `objects'. Case insensitive search. Ignore `an_object'
			-- if not `Void'. Returns `False' if `object_name' is empty.
			-- This is because you are allowed to have as many "unnamed" objects
			-- as you wish.
		local
			current_name_lower, name_lower: STRING
		do
			if not object_name.is_empty then
				name_lower := object_name
				name_lower.to_lower
				from
					objects.start
				until
					objects.off or Result
				loop
					if an_object /= Void and then objects.item /= an_object then
						current_name_lower := objects.item.name
						current_name_lower.to_lower
						if current_name_lower.is_equal (name_lower) then
							Result := True
						end
					elseif an_object = Void then
						current_name_lower := objects.item.name
						current_name_lower.to_lower
						if current_name_lower.is_equal (name_lower) then
							Result := True
						end
					end
					objects.forth
				end
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
				if type_conforms_to (dynamic_type_from_string (new_object.type), dynamic_type_from_string ("EV_WIDGET")) then
					new_object.set_up_display_object_events (new_object.display_object, new_object.object)
				end
			end
		ensure
			new_object_layout_item_not_void: new_object.layout_item /= Void
			new_object_display_object_not_void: new_object.display_object /= Void
			new_object_object_not_void: new_object.object /= Void
		end
		
feature {GB_TITLED_WINDOW_OBJECT} -- Implementation
		
	add_object_to_objects (an_object: GB_OBJECT) is
			--
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
