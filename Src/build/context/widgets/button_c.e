
deferred class BUTTON_C 

inherit

	LABEL_TEXT_C
		rename
			create_context as old_create_context
		redefine
			widget, default_commands_list
		end;

	LABEL_TEXT_C
		redefine
			create_context, widget, default_commands_list
		select
			create_context
		end

feature 

	widget: BUTTON;

	create_context (a_parent: COMPOSITE_C): like Current is
		local
			a_bar: BAR_C
		do
			a_bar ?= a_parent;
			if (a_bar = Void) then
				Result := old_create_context (a_parent)
			end;
		end;

	text: STRING is
		do
			Result := widget.text
		end;

	default_commands_list: LINKED_LIST [CMD] is
		local
			predefined_cmds: SHARED_PREDEF_COMS
		do
			Result := Precursor
			!! predefined_cmds
			Result.extend (predefined_cmds.new_cmd)
			Result.extend (predefined_cmds.open_cmd)
			Result.extend (predefined_cmds.save_cmd)
			Result.extend (predefined_cmds.popup_cmd)
			Result.extend (predefined_cmds.popdown_cmd)
			Result.extend (predefined_cmds.open_window_cmd)
			Result.extend (predefined_cmds.close_window_cmd)
			Result.extend (predefined_cmds.minimize_window_cmd)
			Result.extend (predefined_cmds.maximize_window_cmd)
			Result.extend (predefined_cmds.restore_window_cmd)
			Result.extend (predefined_cmds.reset_to_empty_cmd)
			Result.extend (predefined_cmds.reset_to_zero_cmd)
			Result.extend (predefined_cmds.clear_cmd)
		end

feature {NONE}

	forbid_recompute_size is
		do
			widget.forbid_recompute_size
		end;

	allow_recompute_size is
		do
			widget.allow_recompute_size
		end;

	widget_set_text (s: STRING) is
		do
			widget.set_text (s);
		end;

	widget_set_center_alignment is
		do
			widget.set_center_alignment
		end;
 
	widget_set_left_alignment is
		do
			widget.set_left_alignment
		end;

end
