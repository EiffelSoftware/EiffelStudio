class CLUSTER_FILE_NAME

inherit

	EDITOR_WINDOW_COM
		rename
			make as editor_window_com_make
		export
			{ANY} all
		redefine
			editor_window
		end;
	ONCES;

creation

	make

feature {NONE}

	editor_window: GRAPH_CLUSTER_WINDOW;

	prompt: PROMPT_D;

	make (a_name: STRING; a_parent: COMPOSITE; ed: EDITOR_WINDOW) is
		require
			valid_ed: ed /= Void
		local
			act1, act2: INTEGER_REF
		do
			editor_window_com_make (a_name, a_parent, ed);
			!!prompt.make (Widget_names.cluster_dir_name_window, a_parent);
			prompt.allow_resize;
			prompt.set_title(Widget_names.cluster_dir_name_window);
			prompt.hide_apply_button;
			prompt.hide_help_button;
			!!act1;
			act1.set_item(ok_action);
			prompt.add_ok_action (Current, act1);
			!!act2;
			act2.set_item(cancel_action);
			prompt.add_cancel_action (Current, act2);
			prompt.set_default_position (False);
			prompt.set_ok_label (Widget_names.ok);
			prompt.set_cancel_label (Widget_names.cancel);
			prompt.realize;
		end;

	symbol: PIXMAP is
		once
			Result := Pixmaps.file_pixmap
		end;

	execute (arg: ANY) is
		local
			ltext: STRING
			int: INTEGER_REF;
			x1, y1: INTEGER;
			change_file_name: CHANGE_FILE_NAME_U
		do
			if arg = Void and then editor_window.entity /= Void then
				!! ltext.make (0);
				ltext.append (Widget_names.directory_for);
				ltext.append (editor_window.entity.name);
				prompt.set_selection_label(ltext);
				prompt.set_selection_text (editor_window.entity.file_name);
				x1 := editor_window.real_x + editor_window.width //2
						- prompt.width //2;
				y1 := editor_window.real_y;
				prompt.set_x_y (x1, y1);
				prompt.popup
			elseif prompt.is_popped_up then
				int ?= arg
				if int.item = ok_action then
					!! change_file_name.make (editor_window.entity, prompt.selection_text);
				end
				prompt.popdown;
			end
		end;

	help_key: STRING is
		do
			Result := Message_keys.cluster_file_name_k
		end;

	ok_action, cancel_action: INTEGER is unique

feature

	update is
		local
			ltext: STRING
		do
			if prompt.is_popped_up then
				!! ltext.make (0);
				ltext.append (Widget_names.directory_for);
				ltext.append (editor_window.entity.name);
				prompt.set_selection_label(ltext);
				prompt.set_selection_text (editor_window.entity.file_name);
			end
		end

end 
