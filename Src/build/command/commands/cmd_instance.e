
class CMD_INSTANCE 

inherit

	DATA;
	EDITABLE;
	WINDOWS;
	NAMABLE
		rename
			label as command_label
		redefine
			is_able_to_be_named
		end

creation

	session_init, storage_init

feature {NONE} -- Creation

	session_init (c: CMD) is
		local
			a: ARG_INSTANCE	;
			cmd: CMD_CREATE_INSTANCE
		do
			inst_identifier := c.instance_count;
			associated_command := c;
			init_arguments;
			!! cmd.make (Current, associated_command);
		end;

	storage_init (c: CMD; al: EB_LINKED_LIST [ARG_INSTANCE]) is
		do
			inst_identifier := c.instance_count;
			associated_command := c;
			arguments := al
		end;

	init_arguments is
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

feature {NONE} -- Namable

	command_label: STRING is
		local
			user_cmd: USER_CMD
		do
			user_cmd ?= associated_command;
			if user_cmd /= Void then
				Result := user_cmd.label;
			end;
		end;

	visual_name: STRING is
		local
			user_cmd: USER_CMD
		do
			user_cmd ?= associated_command;
			if user_cmd /= Void then
				Result := user_cmd.visual_name
			end
		end;

	is_able_to_be_named: BOOLEAN is
		local
			user_cmd: USER_CMD
		do
			user_cmd ?= associated_command;
			Result := user_cmd /= Void
		end;

	set_visual_name (a_name: STRING) is
		local
			user_cmd: USER_CMD
		do
			user_cmd ?= associated_command;
			if user_cmd /= Void then
				user_cmd.set_visual_name (a_name)
			end
		end;

feature {CMD_CUT_ARGUMENT}

	add_argument_at (i: INTEGER; arg: ARG_INSTANCE) is
			-- Add argument at end of instance
			--| Template command has already been updated
		require
			valid_count: associated_command.arguments.count - 1
							= arguments.count
		local
			a: ARG_INSTANCE;
			al: EB_LINKED_LIST [ARG];
		do
			if i = 1 and then arguments.empty then
				arguments.extend (arg)
			else
				arguments.go_i_th (i - 1);
				arguments.put_right (arg)
			end
		ensure
			valid_count: associated_command.arguments.count 
							= arguments.count 
		end;

feature {CMD_ADD_ARGUMENT, CMD_CUT_ARGUMENT}

	add_argument is
			-- Add argument at end of instance
			--| Template command has already been updated
		require
			valid_count: associated_command.arguments.count - 1
							= arguments.count 
		local
			a: ARG_INSTANCE;
			al: EB_LINKED_LIST [ARG];
		do
			al := associated_command.arguments;
			!!a.session_init (al.last);
			arguments.extend (a);
		ensure
			valid_count: associated_command.arguments.count 
							= arguments.count 
		end;

	remove_argument (i: INTEGER) is
			-- Add argument at end of instance
			--| Template command has already been updated
		require
			valid_i: i > 0 and then i <= arguments.count;
			valid_count: associated_command.arguments.count + 1
							= arguments.count 
		do
			arguments.go_i_th (i);
			arguments.remove;
		ensure
			valid_count: associated_command.arguments.count 
							= arguments.count 
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

feature -- Stone

	label: STRING is
		do
			!!Result.make (0);
			Result.append (associated_command.label);
			Result.append (".");
			Result.append_integer (inst_identifier);
		end;

	inst_identifier: INTEGER;

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

	eiffel_type_to_upper: STRING is
		do
			Result := associated_command.eiffel_type_to_upper
		end;

end
