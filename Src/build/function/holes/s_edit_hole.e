
class S_EDIT_HOLE 

inherit

	FUNC_EDIT_HOLE
		redefine
			function_editor,  process_state
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

	full_symbol: PIXMAP is
		do
			Result := Pixmaps.state_dot_pixmap
		end;


	create_focus_label is
		do			
			set_focus_string (Focus_labels.state_label)
		end;
	
	set_widget_default is
		do
			initialize_transport
		end;

feature
			
	data: BUILD_STATE is
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
			state: BUILD_STATE
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

