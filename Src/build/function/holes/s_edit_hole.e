
class S_EDIT_HOLE 

inherit

	FUNC_EDIT_HOLE
		redefine
			function_editor,  process_state,
			set_widget_default
		end;
	STATE_STONE
	
creation

	make

feature {NONE}

	function_editor: STATE_EDITOR;

	symbol: PIXMAP is
		do
			Result := Pixmaps.state_pixmap
		end;

	focus_string: STRING is
		do
			Result := Focus_labels.state_label
		end;

	set_widget_default is
		do
			initialize_transport
		end;

feature
			
	data: STATE is
		do
			Result := function_editor.edited_function
		end;

	source: WIDGET is
		do
			Result := Current
		end;

feature {NONE}

	process_state (dropped: STATE_STONE) is
		local
			state: STATE
		do
			state := dropped.data;
			if
				state.edited
			then
				state.raise_editor
			else
				function_editor.set_edited_function (state);
			end
		end;

end

