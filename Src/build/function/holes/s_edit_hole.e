
class S_EDIT_HOLE 

inherit

	FUNC_EDIT_HOLE
		export
			{ANY} all
		redefine
			stone, function_editor, 
			process_stone, compatible, set_widget_default
		end;
	STATE_STONE
		redefine
			transportable
		end;
	
creation

	make

feature {NONE}

	function_editor: STATE_EDITOR;

feature 

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
			
	original_stone: STATE;

	source: WIDGET is
		do
			Result := Current
		end;

	transportable: BOOLEAN is
		do
			Result := original_stone /= Void;
		end;

	identifier: INTEGER is
		do
			Result := original_stone.identifier
		end;

	labels: LINKED_LIST [CMD_LABEL] is
		do
			Result := original_stone.labels
		end;

	label: STRING is
		do
			Result := original_stone.label
		end;

	set_state_stone (state_stone: like original_stone) is
		do
			original_stone := state_stone.original_stone;
		end;

	reset is
		do
			original_stone := Void;
		end;

	update_name is
		do
		end;

feature {NONE}

	stone: STATE_STONE;
	
	compatible (s: STATE_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

	process_stone is
		local
			state: STATE
		do
			state := stone.original_stone;
			if
				state.edited
			then
				state.raise_editor
			else
				function_editor.set_edited_function (state);
			end
		end;

end

