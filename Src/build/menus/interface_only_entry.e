indexing
	description: "Entry in a menu used to hide or show %
				% everything but the interface."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	INTERFACE_ONLY_ENTRY

inherit

	MAIN_PANEL_TOGGLE

	SHARED_CONTEXT

creation

	make

feature {NONE}

	context_catalog_state: BOOLEAN
			-- Is the menu entry `Context Catalog' armed?
	context_tree_state: BOOLEAN
			-- Is the menu entry `Context Tree' armed?
	history_window_state: BOOLEAN
			-- Is the menu entry `History Window' armed?
	editors_state: BOOLEAN
			-- Is the menu entry `Editors' armed?
	command_catalog_state: BOOLEAN
			-- Is the menu entry `Command Catalog' armed?
	application_editor_state: BOOLEAN
			-- Is the menu entry `Application Editor' armed?
	interface_state: BOOLEAN
			-- Is the menu entry `Interface' armed?
	class_importer_state: BOOLEAN
			-- Is the menu entry `Class importer' armed?

	toggle_pressed is
			-- Display or hide the interface.
		do
			if armed then
				show_interface_only
			else
				reinstate_toggles
			end
		end

	show_interface_only is
			-- Show only the interface. Need to made a backup of 
			-- value of the different entries before.
		do
			context_catalog_state := main_panel.context_catalog_entry.armed
			if context_catalog_state then
				main_panel.context_catalog_entry.disarm
			end
			context_tree_state := main_panel.context_tree_entry.armed
			if context_tree_state then
				main_panel.context_tree_entry.disarm
			end
			history_window_state := main_panel.history_window_entry.armed
			if history_window_state then
				main_panel.history_window_entry.disarm
			end
			editors_state := main_panel.editors_entry.armed
			if editors_state then
				main_panel.editors_entry.disarm
			end
			command_catalog_state := main_panel.command_catalog_entry.armed
			if command_catalog_state then
				main_panel.command_catalog_entry.disarm
			end
			application_editor_state := main_panel.application_editor_entry.armed
			if application_editor_state then
				main_panel.application_editor_entry.disarm
			end
			interface_state := main_panel.interface_entry.armed
			if not interface_state then
				main_panel.interface_entry.arm
			end
			class_importer_state := main_panel.class_importer_entry.armed
			if class_importer_state then
				main_panel.class_importer_entry.disarm
			end
		end

	reinstate_toggles is
		do
			if context_catalog_state and then
				not main_panel.context_catalog_entry.armed
			then
				main_panel.context_catalog_entry.arm
			end
			if context_tree_state and then
				not main_panel.context_tree_entry.armed
			then
				main_panel.context_tree_entry.arm
			end
			if history_window_state and then 
				not main_panel.history_window_entry.armed
			then
				main_panel.history_window_entry.arm
			end
			if editors_state and then 
				not main_panel.editors_entry.armed
			then
				main_panel.editors_entry.arm
			end
			if command_catalog_state and then
				not main_panel.command_catalog_entry.armed
			then
				main_panel.command_catalog_entry.arm
			end
			if application_editor_state and then
				not main_panel.application_editor_entry.armed
			then
				main_panel.application_editor_entry.arm
			end
			if not interface_state then
				main_panel.interface_entry.disarm
			end	
			if class_importer_state and then
				not main_panel.class_importer_entry.armed
			then
				main_panel.class_importer_entry.arm
			end
		end

end -- class INTERFACE_ONLY_ENTRY
