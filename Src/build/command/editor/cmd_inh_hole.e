

class CMD_INH_HOLE 

inherit

	ICON_HOLE
		rename
			button as source,
			identifier as oui_identifier,
			make_visible as icon_make_visible
		redefine
			stone, compatible
		end;

	ICON_HOLE
		rename
			button as source,
			identifier as oui_identifier
		redefine
			stone, compatible, make_visible
		select
			make_visible
		end;

	PIXMAPS;
	WINDOWS;

	CMD_STONE
		redefine
			transportable
		end;

	REMOVABLE
		export
			{NONE} all
		end;
creation

	make

feature 

	stone: CMD_STONE;

	compatible (s: CMD_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

	make (ed: CMD_EDITOR) is
		do
			command_editor := ed;
			set_symbol (Command_pixmap);
			set_label ("Parent");
		end;

	make_visible (a_parent: COMPOSITE) is
		do

			icon_make_visible (a_parent);
			io.putstring("");
			initialize_transport;
		end;

	reset is
		do
			if original_stone /= Void then
				set_symbol (Command_pixmap);
				set_label ("Parent");
				original_stone := Void;
			end;
		end;

	set_inherit_command (st: like original_stone) is
		require
			not_void_stone: not (st = Void);
		local
			parent_label: STRING;
		do
			original_stone := st.original_stone;
			if label = Void or else label.empty or else st.label.count >= label.count then
				parent.unmanage;
			end;
			!!parent_label.make (0);
			parent_label.append ("Parent: ");
			parent_label.append (st.label);
			set_symbol (st.symbol);
			set_label (parent_label);
			if not parent.managed then
				parent.manage;
			end;
			if realized and (not shown) then
				show
			end;
		end;
	
feature {NONE}



	original_stone: CMD;

	transportable: BOOLEAN is
		do
			Result := original_stone /= Void;
		end;


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

	command_editor: CMD_EDITOR;
	
	process_stone is
		do
			command_editor.set_parent (stone.original_stone)
		end;

	remove_yourself is
		do
			command_editor.remove_parent
		end;

	
end
