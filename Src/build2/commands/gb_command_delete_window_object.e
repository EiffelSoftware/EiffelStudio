indexing
	description: "Objects that represent a command for the deletion of a window object."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_DELETE_WINDOW_OBJECT
	
inherit
	
	GB_SHARED_OBJECT_HANDLER
		export
			{NONE} all
		end
	
	GB_COMMAND
		export
			{NONE} all
		end
	
	GB_SHARED_HISTORY
		export
			{NONE} all
		end
	
	GB_SHARED_OBJECT_EDITORS
		export
			{NONE} all
		end
	
	GB_SHARED_COMMAND_HANDLER
		export
			{NONE} all
		end
	
	GB_WIDGET_UTILITIES
		export
			{NONE} all
		end
		
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
	
	INTERNAL
		export
			{NONE} all
		end
	
create	
	make
	
feature {NONE} -- Initialization

	make (window: GB_TITLED_WINDOW_OBJECT) is
			-- Create `Current' with `child' to be removed from `parent' at
			-- position `position'.
		require
			window_not_void: window /= Void
		local
			parent_item: EV_TREE_ITEM
		do
			parent_item ?= window.window_selector_item.parent
			if parent_item /= Void then
					-- If held in a directory, store the directory name.
				parent_directory := parent_item.text
			end
			original_id := window.id
		end
		

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			window_object: GB_TITLED_WINDOW_OBJECT
		do
			window_object ?= Object_handler.deep_object_from_id (original_id)
			check
				object_was_window: window_object /= Void
			end
			update_for_delete
			update_object_editors_for_delete (window_object, Void)
			window_object.layout_item.unparent
			window_object.window_selector_item.unparent
			object_handler.mark_as_deleted (window_object)
			
			if not history.command_list.has (Current) then
				history.add_command (Current)
			end
			command_handler.update
		end
		
	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		local
			window_object: GB_TITLED_WINDOW_OBJECT
			directory_item: GB_WINDOW_SELECTOR_DIRECTORY_ITEM
		do
			window_object ?= Object_handler.deep_object_from_id (original_id)
			check
				object_was_window: window_object /= Void
			end
			object_handler.mark_existing (window_object)
			if parent_directory /= Void then
					-- Only try to retrieve the directory item if there was one.
				directory_item := window_selector.directory_object_from_name (parent_directory)
			end
			if directory_item = Void then
				-- Now simply add as root.
				Window_selector.extend (window_object.window_selector_item)
			else
				-- Restore window into original directory.
				directory_item.extend (window_object.window_selector_item)
			end
			command_handler.update
		end
		
	textual_representation: STRING is
			-- Text representation of command exectuted.
		local
			window_name: STRING
			window_object: GB_TITLED_WINDOW_OBJECT
		do
			window_object ?= Object_handler.deep_object_from_id (original_id)
			check
				object_was_window: window_object /= Void
			end
			if not window_object.name.is_empty then
				window_name := window_object.name
			else
				window_name := window_object.short_type
			end
			Result := window_name + " removed from the project"
		end
	
feature {NONE} -- Implementation

	parent_directory: STRING
		-- Orignal directory containing object referenced by `original_id' before deletion.

	original_id: INTEGER
		-- id of object that was deleted.
	
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
				if object_handler.object_contained_in_object (deleted_object, editor.object) or
					deleted_object = editor.object then
						-- If we are the doced object editor, then just empty it.
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
		
	update_for_delete is
				-- Perfrom any necessary processing on `Current'
				-- and all children contained within for a deletion
				-- event.
			local
				all_objects: ARRAYED_LIST [GB_OBJECT]
				counter: INTEGER
			do
				create all_objects.make (10)
				object_handler.deep_object_from_id (original_id).all_children_recursive (all_objects)
				all_objects.extend (object_handler.deep_object_from_id (original_id))
				from
					counter := 1
				until
					counter > all_objects.count
				loop
					(all_objects @ counter).delete
					counter := counter + 1
				end
			end

end -- class GB_COMMAND_DELETE_WINDOW_OBJECT
