indexing
	description: "Objects that provide access to a GB_OBJECT_EDITOR"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_ACCESSIBLE_OBJECT_EDITOR

feature {NONE} -- Implementation

	docked_object_editor: GB_OBJECT_EDITOR is
			-- Tool for editing properties of widgets.
			-- Only one in system. This is contained in the main window.
			-- and is considered to be "docked".
		once
			Create Result
		end
		
	floating_object_editors: ARRAYED_LIST [GB_OBJECT_EDITOR] is
			-- Linked list of tools for editing properties of widgets.
			-- These are floating, and there is no limit on their number.
			-- These are considered to be "floating"
		once
			Create Result.make (0)
		end
		
	all_editors: ARRAYED_LIST [GB_OBJECT_EDITOR] is
			-- All object editors in system, floating and docked.
		do
			create Result.make_from_array (floating_object_editors)
			Result.force (docked_object_editor)
		end

	update_editors_for_property_change (vision2_object: EV_ANY; property_type: STRING; calling_object_editor: GB_OBJECT_EDITOR) is
			-- For all editors referencing `vision2_object', update `property_type' attribute_editor.
			-- `property_type' is "GB_EV_SENSITIVE", "GB_EV_BUTTON" etc etc.
			-- Note that `vision2_object' is the first of GB_EV_ANY `Objects' which should correspond
			-- to the `object' of a GB_OBJECT. Editors do not know about the GB_OBJECT, just the
			-- real vision2 objects they must manipulate.
		local
			local_all_editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
			local_item: GB_OBJECT_EDITOR
		do
			local_all_editors := all_editors
			from
				local_all_editors.start
			until
				local_all_editors.off
			loop
				local_item := local_all_editors.item
					-- We must only update the other editors referencing `vision2_object', not `calling_object_editor'.
					-- If `local_item' `object' is `Void' then the editor is empty, so there is nothing to do.
				if local_item /= calling_object_editor and then local_item.object /= Void and then local_item.object.object = vision2_object then
					local_all_editors.item.replace_object_editor_item (property_type)
				end
				local_all_editors.forth
			end
		end
		
	update_editors_for_name_change (vision2_object: EV_ANY; calling_object_editor: GB_OBJECT_EDITOR) is
			-- For all editors referencing `vision2_object', update `name'.
		local
			local_all_editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
			local_item: GB_OBJECT_EDITOR
		do
			local_all_editors := all_editors
			from
				local_all_editors.start
			until
				local_all_editors.off
			loop
				local_item := local_all_editors.item
					-- We must only update the other editors referencing `vision2_object', not `calling_object_editor'.
					-- If `local_item' `object' is `Void' then the editor is empty, so there is nothing to do.
				if local_item /= calling_object_editor and then local_item.object /= Void and then local_item.object.object = vision2_object then
					local_all_editors.item.update_name_field
				end
				local_all_editors.forth
			end
		end	
		
		
	new_object_editor_empty is
			-- Generate a new empty object editor.
		local
			window: EV_TITLED_WINDOW
			editor: GB_OBJECT_EDITOR
		do
			create window
			window.close_request_actions.extend (agent remove_editor (window))
			window.close_request_actions.extend (agent window.destroy)
			create editor
			window.extend (editor)
			floating_object_editors.extend (editor)
			window.show
		end
		
	new_object_editor (object: GB_OBJECT) is
			-- Generate a new object editor containing `object'.
		local
			window: EV_TITLED_WINDOW
			editor: GB_OBJECT_EDITOR
		do
			create window
			window.close_request_actions.extend (agent remove_editor (window))
			window.close_request_actions.extend (agent window.destroy)
			create editor
			window.extend (editor)
			floating_object_editors.extend (editor)
			editor.set_object (object)
			window.show
		end
		
feature {NONE}

	remove_editor (a_window: EV_WINDOW) is
			-- Remove object editor from `a_window'.
		local
			editor: GB_OBJECT_EDITOR
		do
			editor ?= a_window.item
			check
				editor /= Void
			end
			all_editors.prune (editor)
		end
		

end -- class GB_ACCESSIBLE_OBJECT_EDITOR
