
class CMD_ADD_ARGUMENT 

inherit

	CMD_ADD
		rename
			command_work as old_command_work
		redefine
			element, 
			undo, 
			redo, 
			worked_on
		end

	CMD_ADD
		redefine
			element, 
			undo, 
			command_work, 
			redo, 
			worked_on
		select
			redo, 
			undo, 
			command_work, 
			name,
			is_template,
			work,
			failed,
			execute
		end

	QUEST_POPUPER
		redefine
			question_help_action
		end

	CAT_ADD_COMMAND
		rename
			redo as catalog_redo,
			undo as catalog_undo,
			name as catalog_name,
			work as catalog_add_command_work,
			element as catalog_element,
			is_template as is_catalog_template,
			failed as catalog_failed,
			page as catalog_page,
			execute as catalog_execute
		redefine
			catalog_work,
			c_name
		end

creation

	make

feature -- Creation

	make (a_command_tool: COMMAND_TOOL) is
		do
			associated_command_tool := a_command_tool
		end

feature -- Feature from CAT_ADD_COMMAND

	catalog_work is
			-- Do not call update_history.
		do
			catalog_element := page.last
		end

feature {NONE}

	element: ARG

	c_name: STRING is
		do
			if create_new_command then
				Result := Command_names.cmd_add_arg_and_create_cmd_name
			else
				Result := Command_names.cmd_add_argument_cmd_name
			end
		end

	list: EB_LINKED_LIST [ARG] is
		do
			Result := edited_command.arguments
		end

	command_work is
		do
			if edited_command.instances.count > 1 then
				popup_question_box 
			else
				old_command_work
				update_instance
			end
		end

				 
	update_all_instances is
				-- Update all the instances of current command.
		local
			cmd_instance_list: LINKED_LIST [CMD_INSTANCE]
		do	
			cmd_instance_list := edited_command.instances
			from
				cmd_instance_list.start
			until
				cmd_instance_list.after
			loop
				cmd_instance_list.item.add_argument
				cmd_instance_list.forth
			end
		end

	update_instance is
				-- Update only the instance edited in the parent command
				-- tool of the command editor.
		require
			only_one_instance: edited_command.instances.count = 1
		do
			edited_command.instances.first.add_argument			
		end

	undo is
			-- If a new command has been created, need to remove it
			-- from the command catalog, delete the file corresponding 
			-- to the new command and retarget the command editor.
		local
			new_command: USER_CMD
			cmd_instance_list: LINKED_LIST [CMD_INSTANCE]
			a_command_editor: COMMAND_EDITOR
			old_index: INTEGER
		do
			if create_new_command then
				if associated_command_tool = Void 
					or else associated_command_tool.destroyed 
					or else not associated_command_tool.realized
					or else not associated_command_tool.shown
				then
					associated_command_tool := window_mgr.command_tool
--					window_mgr.display (associated_command_tool)
					associated_command_tool.display
				end
				associated_command_tool.set_instance (previous_instance)
				old_index := page.index
				page.go_i_th (index)
				page.remove
				if not page.after then
					page.go_i_th (old_index)
				end					
				edited_command.remove_class
			else
				Precursor
				cmd_instance_list := edited_command.instances
				from
					cmd_instance_list.start
				until
					cmd_instance_list.after
				loop
					cmd_instance_list.item.remove_argument (edited_command.arguments.count + 1)
					cmd_instance_list.forth
				end
			end
		end

	redo is
			-- If a new command has been created, has to add again the 
			-- command to the command catalog, target the command tool
			-- if still open and generate the Eiffel file.
		local
			a_command_editor: COMMAND_EDITOR
			old_command: USER_CMD
		do
			if create_new_command then
				if associated_command_tool = Void 
					or else associated_command_tool.destroyed 
					or else not associated_command_tool.realized
					or else not associated_command_tool.shown
				then
					associated_command_tool := window_mgr.command_tool
--					window_mgr.display (associated_command_tool)
					associated_command_tool.display
				end
				associated_command_tool.set_instance (new_instance)
				edited_command.save_to_disk
					--| Add new command in the context catalog
				page.extend (edited_command)
				catalog_execute (page)
			else
				question_help_action
			end
		end

	worked_on: STRING is
		do
			Result := {CMD_ADD} Precursor
		end

feature {NONE} -- Features of QUEST_POPUPER

	popup_question_box is
			-- Popup a dialog to ask if the user wants to
			--	* Create a new command ("New Command")
			--	* Modify the currently edited command ("Modify Current")
			--	* Cancel this operation ("Cancel")
			-- This dialog is displayed when adding or removing a formal
			-- argument.
		local
			a_question_box: QUESTION_BOX
		do
			!! a_question_box
			a_question_box.popup_with_labels (Current, "There are other instances of this command", 
					"What do you want to do?", "New Command", "Cancel", "Modify Current")
		end

	question_cancel_action is
			-- Action performed if cancel button is pressed.
		do
		end

	question_ok_action is
			-- Action performed if ok button is pressed.
			-- Correspond to "New Command".
		local
			new_command: USER_CMD
			a_command_editor: COMMAND_EDITOR
		do
			create_new_command := True
			a_command_editor := edited_command.command_editor
			previous_instance := a_command_editor.instance_of_command_tool
			associated_command_tool := a_command_editor.command_tool
			!! new_command.make
			new_command.set_internal_name ("")
			new_command.set_arguments (edited_command.arguments)
			new_command.set_eiffel_text (edited_command.eiffel_text)
			new_command.save_to_disk
			edited_command := new_command
			old_command_work
				--| Add new command in the command catalog
			page.extend (edited_command)
			catalog_execute (page)
			index := page.count 
				--| Create new instance and target the command tool
			!! new_instance.special_session_init (edited_command)
			associated_command_tool.set_instance (new_instance)
		end

	question_help_action is
			-- Action performed if help button is pressed.
			-- Correspond to "Modify Current".
		do
			old_command_work
			update_all_instances
		end

	popuper_parent: COMPOSITE is
		do
			Result := associated_command_tool
		end 

feature {NONE} -- QUEST_POPUPER

	create_new_command: BOOLEAN
			-- Did the user choose to create a new command?

	index: INTEGER
			-- Index of the new command created in the command catalog

	page: COMMAND_PAGE is
			-- Page of the command catalog where the newly created
			-- commands are added.
		do
			Result := command_catalog.current_page
		end

	new_instance: CMD_INSTANCE
			-- Instance created in the command tool when creating a new command

	previous_instance: CMD_INSTANCE
			-- Instance that was previoulsy edited before creation of the new
			-- command

	associated_command_tool: COMMAND_TOOL
			-- Command tool where the new command is edited

end
