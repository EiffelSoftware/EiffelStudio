
class CMD_INSTANCE 

inherit

	DATA;
	EDITABLE;
	WINDOWS

creation

	session_init, storage_init

feature -- Creation

	session_init (c: CMD) is
		local
			a: ARG_INSTANCE	
		do
			inst_identifier := c.instance_count;
			associated_command := c;
			update_arguments
		end;

	storage_init (c: CMD; al: EB_LINKED_LIST [ARG_INSTANCE]) is
		do
			inst_identifier := c.instance_count;
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

	help_file_name: STRING is
		do
			Result := Help_const.instance_help_fn
		end;

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
				args.put_right (arguments.item);
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
				arguments.extend (a);
				al.forth
			end;
		end;

feature -- Stone

	label: STRING is
		do
			!!Result.make (0);
			Result.append (associated_command.label);
			Result.append (".");
			Result.append_integer (inst_identifier);
		end;

	inst_identifier: INTEGER;

	set_inst_identifier (n: INTEGER) is
		require
			n_not_void: n /= Void;
		do
			inst_identifier := n;
		end;
 
	symbol: PIXMAP is
		do
			Result := Pixmaps.command_i_icon_pixmap 
		end;

	data: CMD_INSTANCE is
		do
			Result := Current
		end;

	arguments: EB_LINKED_LIST [ARG_INSTANCE];

	eiffel_arguments: STRING is
			-- Eiffel text corresponding to
			-- Current command instantiation
		local
			old_pos: INTEGER
		do
			!!Result.make (0);
			if not arguments.empty then
				Result.append ("(");
				from
					old_pos := arguments.index;
					arguments.start
				until
					arguments.after
				loop
					if arguments.item.instantiated then
						Result.append (arguments.item.context_name);
					else
						Result.append ("Void")
					end;
					arguments.forth;
					if not arguments.after then
						Result.append (", ");
					end
				end;
				arguments.go_i_th (old_pos);
				Result.append (")");
			end
		end;

	complete: BOOLEAN is
			-- Are all arguments of current
			-- instance instantiated?
		do
			Result := True;
			from
				arguments.start
			until
				arguments.after or else not Result
			loop
				Result := arguments.item.instantiated;
				arguments.forth
			end;
		end;

feature -- Associated command

	associated_command: CMD;

	identifier: INTEGER is
			-- Unique identifier of associated
			-- command type
		do
			Result := associated_command.identifier
		end;

	labels: LINKED_LIST [CMD_LABEL] is
			-- Exit labels defined for
			-- associated command
		do
			Result := associated_command.labels
		end;

	eiffel_type: STRING is
		do
			Result := associated_command.eiffel_type
		end;

end
