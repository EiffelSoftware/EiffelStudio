
class CMD_CUT_ARGUMENT 

inherit

	CMD_CUT
		rename
			undo as old_undo,
			command_work as old_command_work,
			update as old_update
		redefine
			element, redo
		end

	CMD_CUT
		redefine
			element, command_work, undo, redo, update
		select
			command_work, undo, update, redo, name, is_template,
			work, failed, execute
		end

	SHARED_INSTANTIATOR

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
			parent_work,
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

	parent_work is
			-- Do not call update_history.
		do
			catalog_element := page.last
		end

feature -- Implementation

	c_name: STRING is
		do
			if create_new_command then
				Result := Command_names.cmd_cut_arg_and_create_cmd_name
			else
				Result := Command_names.cmd_cut_argument_cmd_name
			end
		end

	list: EB_LINKED_LIST [ARG] is
		do
			Result := edited_command.arguments
		end

    undo is
			-- If the user has created a new command, need to remove it
			-- from the command catalog, delete the file corresponding 
			-- to the new command and retarget the command editor.
        local
			cmd_instance: CMD_INSTANCE
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
				page.go_i_th (index)
				page.remove
				edited_command.remove_class
			else
	           old_undo
    	       from
        	       cmd_instance_list.start
            	   cmd_instance_arg_list.start
	           until
    	           cmd_instance_list.after
        	   loop
            	   cmd_instance_list.item.add_argument_at (index,
						cmd_instance_arg_list.item)
	               cmd_instance_arg_list.start
    	           cmd_instance_list.forth
        	   end
			end
        end

	redo is
			-- If a new command has been created, has to add again the 
			-- command to the command catalog, target the command tool
			-- if still open and generate the Eiffel file.
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
					--| Add the new command in the command catalog
				page.extend (edited_command)
				catalog_execute (page)
			else
				question_help_action
			end
		end

    command_work is
		require else
			element_set: element /= Void
			command_set: edited_command /= Void
        do
			if edited_command.instances.count > 1 then
				popup_question_box
			else
	            old_command_work
				update_all_instances
			end
		end

	update_all_instances is
			-- Update all instances of current command
        local
			args: EB_LINKED_LIST [ARG_INSTANCE]
		do
			if cmd_instance_list = Void then
				!! cmd_instance_arg_list.make
            	cmd_instance_list := edited_command.instances
            	from
                	cmd_instance_list.start
            	until
                	cmd_instance_list.after
            	loop
					args := cmd_instance_list.item.arguments
                	args.go_i_th (index)
					cmd_instance_arg_list.extend (args.item)
                	cmd_instance_list.forth
            	end
			end
            from
                cmd_instance_list.start
            until
                cmd_instance_list.after
            loop
                cmd_instance_list.item.remove_argument (index)
                cmd_instance_list.forth
            end
        end

	update is
		do
			old_update
			command_instantiator.update_command
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
		do
			create_new_command := True
			previous_instance := associated_command_tool.command_instance
				--| Create new command
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
			Result := edited_command.command_editor
		end 

	page: COMMAND_PAGE is
			-- Page of the command catalog where the newly created
			-- commands are added.
		do
			Result := command_catalog.user_defined_commands1
		end

feature -- Attributes

	element: ARG
			-- Formal argument that has been removed

feature {NONE} -- Attributes

	associated_command_tool: COMMAND_TOOL
			-- Associated command tool

	new_instance: CMD_INSTANCE
			-- Instance created in the command tool when creating a new command

	previous_instance: CMD_INSTANCE
			-- Instance that was previoulsy edited before creation of the new
			-- command

    cmd_instance_list: LINKED_LIST [CMD_INSTANCE]
			-- List of instance of `edited_command' that has been modified

    cmd_instance_arg_list: LINKED_LIST [ARG_INSTANCE]
			-- Argument removed corresponding to cmd_instance_list

	create_new_command: BOOLEAN
			-- Did the user choose to create a new command?

end
