
deferred class FUNC_EDIT_HOLE 

inherit

	HOLE;
	EB_BUTTON;
	REMOVABLE;
	DRAG_SOURCE

feature 

	remove_yourself is
		local
			wipe_out_command: FUNC_WIPE_OUT
		do
			!!wipe_out_command;
			wipe_out_command.execute (function_editor.edited_function)
		end;

	focus_label: FOCUS_LABEL is
		do			
			Result := function_editor.focus_label
		end;
	
feature {NONE}

	function_editor: FUNC_EDITOR;

	make (ed: like function_editor; a_parent: COMPOSITE) is
		do
			function_editor := ed;
			make_visible (a_parent);
			register;
			set_widget_default
		end;

	target: WIDGET is
		do
			Result := Current
		end;

	set_widget_default is do end;

	process_stone is do end;

end
