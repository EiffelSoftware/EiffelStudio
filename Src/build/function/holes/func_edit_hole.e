 
deferred class FUNC_EDIT_HOLE 

inherit

	HOLE
		select
			init_toolkit
		end
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

-- samik	focus_label: FOCUS_LABEL is
-- samik		do			
-- samik			Result := function_editor.focus_label
-- samik		end;
	
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

	set_widget_default is 
		deferred
		end;

	full_symbol: PIXMAP is
		deferred
		end;

feature 

	set_empty_symbol is
		do
			if pixmap /= symbol then
				set_symbol (symbol)
			end
		end;

	set_full_symbol is
		do
			if pixmap /= full_symbol then
				set_symbol (full_symbol)
			end
		end

end
