
class INST_EDIT_HOLE 

inherit

	ICON_HOLE
		rename
			make_visible as icon_make_visible,
			identifier as hole_identifier,
			button as source
		redefine
			stone, compatible
		end;

	ICON_HOLE
		rename
			identifier as hole_identifier,
			button as source
		redefine
			stone, compatible, make_visible
		select
			make_visible
		end;


	PIXMAPS
		export
			{NONE} all
		end;

	CMD_INST_STONE;

	COMMAND;


creation

	make

	
feature {NONE}

	instance_editor: CMD_INST_EDITOR;
			-- Associated instance editor

	
feature 

	reset is 
		do
			set_label ("");
			set_symbol (Command_instance_pixmap);
			original_stone := Void;
		end;

	original_stone: CMD_INSTANCE;

	arguments: LINKED_LIST [ARG_INSTANCE] is
		do
			Result := original_stone.arguments;
		end;

	associated_command: CMD is
		do
			Result := original_stone.associated_command;
		end;

	make_visible (a_parent: COMPOSITE) is
		local
			Nothing: ANY
		do
			icon_make_visible (a_parent);
			add_activate_action (Current, Nothing);
			initialize_transport;
		end;

	stone: CMD_INST_STONE;

	compatible (s: CMD_INST_STONE): BOOLEAN is
		do
			stone ?= s;
			Result := stone /= Void;
		end;

	make (ed: CMD_INST_EDITOR) is
			-- Create the cmd_edit_hole with `ed' 
			-- as instance_editor.
		require
			not_void_ed: not (ed = Void)
		do
			instance_editor := ed;
			set_symbol (Command_instance_pixmap);
		end; -- Create


	set_instance (cmd: CMD_INSTANCE) is
		do
			original_stone := cmd.original_stone;
			if label = Void or else label.empty or else cmd.label.count >= label.count then
				parent.unmanage;
			end;
			set_label (cmd.label);
			set_symbol (cmd.symbol);
			if not parent.managed then
				parent.manage;
			end;
		end;
	
feature {NONE}

	process_stone is
		local
			inst: CMD_INSTANCE
		do
			inst := stone.original_stone;
			if inst.edited then
				inst.inst_editor.raise
			else
				instance_editor.set_instance (inst)
			end
		end; 

	execute (argument: ANY) is
		local
			inst: CMD_INSTANCE
		do
			if (original_stone /= Void) then
				!!inst.session_init (original_stone.associated_command);
				instance_editor.set_instance (inst)
			end 
		end;


end
