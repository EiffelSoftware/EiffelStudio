
class CMD_INSTANCE 

inherit

	CMD_INST_STONE;
	PIXMAPS
		export
			{NONE} all
		end;
	EDITABLE;
	WINDOWS

creation

	session_init, storage_init

feature -- Creation

	session_init (c: CMD) is
		local
			a: ARG_INSTANCE	
		do
			associated_command := c;
			update_arguments
		end;

	storage_init (c: CMD; al: EB_LINKED_LIST [ARG_INSTANCE]) is
		do
			associated_command := c;
			arguments := al
		end;

feature -- Editable

	create_editor is
		local
			ed: CMD_INST_EDITOR
		do
			if not edited then
				ed := window_mgr.cmd_inst_editor;
				ed.set_instance (Current);
			end;
			window_mgr.display (inst_editor);
		end

feature -- Editing

	inst_editor: CMD_INST_EDITOR;

	reset is
		do
			inst_editor := Void
		end;

	set_editor (ed: CMD_INST_EDITOR) is
		do
			inst_editor := ed
		end;

	edited: BOOLEAN is
		do
			Result := (inst_editor /= Void)
		end;

	save_arguments is
		local
			args: like arguments
		do
			from
				!!args.make;	
				arguments.start;
			until
				arguments.after
			loop
				args.add_right (arguments.item);
				arguments.item.reset;
				arguments.forth;
				args.forth
			end;
			arguments := args
		end;

	set_arguments (args: like arguments) is
		do
			arguments := args
		end;

	update_arguments is
			-- Update the instance arguments with
			-- the associated command type arguments.
		local
			al: EB_LINKED_LIST [ARG];
			a: ARG_INSTANCE	
		do
			!!arguments.make;
			from
				al := associated_command.arguments;
				al.start;
			until
				al.after
			loop
				!!a.session_init (al.item);
				arguments.add (a);
				al.forth
			end;
		end;

feature -- Stone

	label: STRING is
		do
			Result := associated_command.label
		end;
 
	symbol: PIXMAP is
		do
			Result := Command_instance_pixmap 
		end;

	source: WIDGET is do end;

	associated_command: CMD;

	original_stone: CMD_INSTANCE is
		do
			Result := Current
		end;

	arguments: EB_LINKED_LIST [ARG_INSTANCE];

end
