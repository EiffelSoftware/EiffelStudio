indexing
	description: "Command that popup a list of instances of the currently %
				% edited command."
	date: "$Date$"
	revision: "$Revision$"

class
	CMD_ED_POPUP_INST

inherit
	WINDOWS
		select
			init_toolkit
		end
	EB_BUTTON
	COMMAND

creation
	make

feature {NONE}

	command_editor: COMMAND_TOOL

	make (ed: COMMAND_TOOL; a_parent: COMPOSITE) is
		do
			command_editor := ed
			make_visible (a_parent)
			add_activate_action (Current, Void)
		end

	create_focus_label is
		do
			set_focus_string (Focus_labels.popup_instance_label)
		end

	symbol: PIXMAP is
		do
			Result := Pixmaps.popup_instances_pixmap
		end

feature {NONE}

	edit_list: CMD_ED_CHOICE_WND

	execute (arg: ANY) is
		local
			list: LINKED_LIST [CMD_INSTANCE]
			a_cmd: CMD
		do
			if command_editor.command_instance /= Void then
				a_cmd := command_editor.command_instance.associated_command
				list := a_cmd.instances
				!! edit_list.make_with_cmd (command_editor, command_editor.edited_command)
				edit_list.popup_with_list (list)
			end
		end

feature

    update_popup_position is
        do
            if edit_list /= Void and then not edit_list.destroyed then
                edit_list.update_position (real_x, real_y)
				edit_list.raise
            end
        end

end -- class CMD_ED_POPUP_INST
