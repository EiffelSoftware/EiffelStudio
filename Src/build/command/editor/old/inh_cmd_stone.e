
class INH_CMD_STONE 

inherit

	ICON
		rename
			button as source,
			identifier as oui_identifier
		export
			{ANY} realized, label
		end;
	CMD_STONE
		
		export
			{NONE} all
		end;
	PIXMAPS
		export
			{NONE} all
		end;
	REMOVABLE
		export
			{NONE} all
		end


creation

	make

	
feature {NONE}

	remove_yourself is
		do
			associated_editor.remove_parent
		end;

	
feature 

	make (a_parent: COMPOSITE; ed: CMD_EDITOR) is
		do
			associated_editor := ed;
			set_symbol (Command_pixmap);
			set_label ("");
			make_visible (a_parent);
			initialize_transport
		end;

	
feature {NONE}

	associated_editor: CMD_EDITOR;

	
feature 

	reset is
		do
			if realized and shown then
				hide
			end;
			original_stone := Void
		end;

	set_inherit_command (st: like original_stone) is
		require
			not_void_stone: not (st = Void)
		do
			original_stone := st.original_stone;
			set_symbol (st.symbol);
			set_label (st.label);
			if realized and (not shown) then
				show
			end;
		end;
	
feature {NONE}

	original_stone: CMD;

	identifier: INTEGER is
		do 
			Result := original_stone.identifier
		end;

	eiffel_type: STRING is
		do
			Result := original_stone.eiffel_type
		end;

	arguments: EB_LINKED_LIST [ARG] is
		do
			Result := original_stone.arguments
		end;

	labels: EB_LINKED_LIST [CMD_LABEL] is
		do
			Result := original_stone.labels
		end;

	eiffel_text: STRING is
		do
			Result := original_stone.eiffel_text
		end;

end
