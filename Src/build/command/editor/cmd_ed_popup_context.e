indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class
	CMD_ED_POPUP_CONTEXT

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

	command_editor: COMMAND_TOOL;

	make (ed: COMMAND_TOOL; a_parent: COMPOSITE) is
		do
			command_editor := ed;
			make_visible (a_parent);
			add_activate_action (Current, Void)
		end;


	create_focus_label is
		do
			set_focus_string (Focus_labels.popup_context_label)
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.popup_context_pixmap;
		end;
			
feature {NONE}

	edit_list: CMD_POPUP_CONTEXT_WND

	execute (arg: ANY) is
		local
			list: LINKED_LIST [CONTEXT];
		do
			if command_editor.current_command /= Void then
				list := command_editor.current_command.contexts_with_instances
				!! edit_list.make (command_editor)
				edit_list.popup_with_list (list)
			end
		end;

feature

	update_popup_position is
		do
			if edit_list /= Void and then not edit_list.destroyed then
				edit_list.update_position (real_x, real_y);
				edit_list.raise;
			end
		end;


end -- class CMD_ED_POPUP_CONTEXT
