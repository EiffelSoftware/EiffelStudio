
class S_EDIT_HOLE 

inherit

	FUNC_EDIT_HOLE
		rename
			make as func_edit_make,
			identifier as oui_identifier,
			button as source,
			make_visible as make_icon_visible
		export
			{ANY} all
		redefine
			stone, function_editor, 
			process_stone, compatible
		end;

	FUNC_EDIT_HOLE
		rename
			make as func_edit_make,
			identifier as oui_identifier,
			button as source
		export
			{ANY} all
		redefine
			stone, function_editor, 
			process_stone, compatible,
			make_visible
		select
			make_visible
		end;



	PIXMAPS
		export
			{NONE} all
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

	make (ed: STATE_EDITOR) is
		do
			func_edit_make (ed);
			set_symbol (State_pixmap)
		end;


	make_visible (a_parent: COMPOSITE) is
		do
			make_icon_visible (a_parent);
			initialize_transport
		end;
			
	original_stone: STATE;

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


	state_label: STRING is
		do
			Result := original_stone.label
		end;

	set_state_stone (state_stone: like original_stone) is
		do
			original_stone := state_stone.original_stone;
			set_label (state_label);
			set_symbol (state_d_pixmap);
		end;

	reset is
		do
			set_symbol (State_pixmap);
			set_label ("");
			original_stone := Void;
		end;

	update_name is
		do
			set_label (state_label)
		end;


	-- ** Hole definitions ** --

	
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

