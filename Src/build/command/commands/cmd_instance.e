
class CMD_INSTANCE 

inherit

	DATA
	EDITABLE
	WINDOWS
	NAMABLE
		rename
			label as command_label
		redefine
			is_able_to_be_named
		end

creation

	session_init, storage_init, special_session_init

feature {NONE} -- Creation

	session_init (c: CMD) is
		local
			cmd: CMD_CREATE_INSTANCE
		do
			inst_identifier := c.instance_count
			associated_command := c
			init_arguments
			!! cmd.make (Current, associated_command)
			create_observers 
			create_observed_commands
		end

	storage_init (c: CMD; al: EB_LINKED_LIST [ARG_INSTANCE]; ol: EB_LINKED_LIST [CMD_INSTANCE]) is
		require
			argument_list_not_void: al /= Void
			observers_not_void: ol /= Void
		do
			inst_identifier := c.instance_count
			associated_command := c
			arguments := al
			observers := ol
			create_observed_commands
		end

	special_session_init (c: CMD) is
			-- Do the same things as `session_init', but DO NOT
			-- record the operation in the history window. Is called
			-- only from CMD_ADD_ARGUMENT.
		do
			inst_identifier := c.instance_count
			associated_command := c
			init_arguments
			create_observers 
			create_observed_commands
		end

	create_observers is
			-- Create the observer list.
		do
			!! observers.make
		end

	create_observed_commands is
			-- Create the list of observed command.
		do
			!! observed_commands.make
		end

	init_arguments is
			-- Update the instance arguments with
			-- the associated command type arguments.
		local
			al: EB_LINKED_LIST [ARG]
			arg_inst: ARG_INSTANCE	
		do
			!! arguments.make
			from
				al := associated_command.arguments
				al.start
			until
				al.after
			loop
				!! arg_inst.session_init (al.item)
				arguments.extend (arg_inst)
				al.forth
			end
		end

feature -- Namable

	visual_name: STRING is
		local
			user_cmd: USER_CMD
		do
			user_cmd ?= associated_command
			if user_cmd /= Void then
				Result := user_cmd.visual_name
			end
		end

feature {NONE} -- Namable

	command_label: STRING is
		local
			user_cmd: USER_CMD
		do
			user_cmd ?= associated_command
			if user_cmd /= Void then
				Result := user_cmd.label
			end
		end

	is_able_to_be_named: BOOLEAN is
		local
			user_cmd: USER_CMD
		do
			user_cmd ?= associated_command
			Result := user_cmd /= Void
		end

	set_visual_name (a_name: STRING) is
		local
			user_cmd: USER_CMD
		do
			user_cmd ?= associated_command
			if user_cmd /= Void then
				user_cmd.set_visual_name (a_name)
			end
		end

feature {CMD_CUT_ARGUMENT}

	add_argument_at (i: INTEGER; arg: ARG_INSTANCE) is
			-- Add argument at end of instance
			--| Template command has already been updated
		require
			valid_count: associated_command.arguments.count - 1
							= arguments.count
		local
			a: ARG_INSTANCE
			al: EB_LINKED_LIST [ARG]
		do
			if i = 1 and then arguments.empty then
				arguments.extend (arg)
				if command_tool /= Void then
					command_tool.add_argument_icon (arg)
				end
			else
				arguments.go_i_th (i - 1)
				arguments.put_right (arg)
				if command_tool /= Void then
					command_tool.add_argument_at (arg, i)
				end
			end
		ensure
			valid_count: associated_command.arguments.count 
							= arguments.count 
		end

feature {CMD_ADD_ARGUMENT, CMD_CUT_ARGUMENT, CMD_UPDATE_PARENT}

	add_argument is
			-- Add argument at end of instance
			--| Template command has already been updated
		require
			valid_count: associated_command.arguments.count - 1
							= arguments.count 
		local
			a: ARG_INSTANCE
			al: EB_LINKED_LIST [ARG]
		do
			al := associated_command.arguments
			!! a.session_init (al.last)
			arguments.extend (a)
			if command_tool /= Void then
				command_tool.add_argument_icon (a)
			end
		ensure
			valid_count: associated_command.arguments.count 
							= arguments.count 
		end

	remove_argument (i: INTEGER) is
			-- Add argument at end of instance
			--| Template command has already been updated
		require
			valid_i: i > 0 and then i <= arguments.count
			valid_count: associated_command.arguments.count + 1
							= arguments.count 
		do
			arguments.go_i_th (i)
			arguments.remove
			if command_tool /= Void then
				command_tool.remove_argument_icon (i)
			end
		ensure
			valid_count: associated_command.arguments.count 
							= arguments.count 
		end

feature -- Editable

	create_editor is
		do
			if not edited then
				command_tool := window_mgr.command_tool
				command_tool.set_instance (Current)
			end		
			command_tool.display
		end

	help_file_name: STRING is
		do
			Result := Help_const.instance_help_fn
		end

feature -- Editing

	command_tool: COMMAND_TOOL
		-- Command instance editor in which `Current' is being edited.

	reset is
		do
			command_tool := Void
		end

	set_editor (ed: COMMAND_TOOL) is
		do
			command_tool := ed
			from
				observers.start
			until
				observers.after
			loop
				observers.item.add_observed_command (Current)
				observers.forth
			end
		end

	edited: BOOLEAN is 
		do
			Result := (command_tool /= Void)
		end

	save_arguments is
		local
			args: like arguments
		do
			from
				!!args.make	
				arguments.start
			until
				arguments.after
			loop
				args.put_right (arguments.item)
				arguments.item.reset
				arguments.forth
				args.forth
			end
			arguments := args
		end

	set_arguments (args: like arguments) is
		do
			arguments := args
		end

feature -- Stone

	label: STRING is
		do
			!! Result.make (0)
			Result.append (associated_command.label)
			Result.append (".")
			Result.append_integer (inst_identifier)
		end

	inst_identifier: INTEGER

	symbol: PIXMAP is
		do
			Result := Pixmaps.command_i_icon_pixmap 
		end

	data: CMD_INSTANCE is
		do
			Result := Current
		end

	arguments: EB_LINKED_LIST [ARG_INSTANCE]

	eiffel_arguments: STRING is
			-- Eiffel text corresponding to
			-- Current command instantiation
		local
			old_pos: INTEGER
		do
			!! Result.make (0)
			if not arguments.empty then
				Result.append ("(")
				from
					old_pos := arguments.index
					arguments.start
				until
					arguments.after
				loop
					if arguments.item.instantiated then
						Result.append (arguments.item.context_name)
					else
						Result.append ("Void")
					end
					arguments.forth
					if not arguments.after then
						Result.append (", ")
					end
				end
				arguments.go_i_th (old_pos)
				Result.append (")")
			end
		end

	complete: BOOLEAN is
			-- Are all arguments of current
			-- instance instantiated?
		do
			Result := True
			from
				arguments.start
			until
				arguments.after or else not Result
			loop
				Result := arguments.item.instantiated
				arguments.forth
			end
		end

feature -- Associated command

	associated_command: CMD

	identifier: INTEGER is
			-- Unique identifier of associated
			-- command type
		do
			Result := associated_command.identifier
		end

	labels: LINKED_LIST [CMD_LABEL] is
			-- Exit labels defined for
			-- associated command
		do
			Result := associated_command.labels
		end

	eiffel_type: STRING is
		do
			Result := associated_command.eiffel_type
		end

	eiffel_type_to_upper: STRING is
		do
			Result := associated_command.eiffel_type_to_upper
		end

feature -- Observers

	is_observer (inst: like Current): BOOLEAN is
			-- Is Current an observer of `inst' ?
		do
			if not observed_commands.empty then
				Result := observed_commands.has (inst)
				from
					observed_commands.start
				until
					observed_commands.after or Result
				loop
					Result := observed_commands.item.is_observer (inst)
					observed_commands.forth
				end
			end
		end
					
	
	observers: EB_LINKED_LIST [like Current]
			-- List of observers

	observed_commands: EB_LINKED_LIST [CMD_INSTANCE]
			-- List of command instance for which `Current' is
			-- an observer

	add_observed_command (a_command: CMD_INSTANCE) is
			-- Add a command instance for which `Current' is
			-- an observer.
		require
			command_not_void: a_command /= Void
		do
			observed_commands.extend (a_command)
		end

	remove_observed_command (a_command: CMD_INSTANCE) is
			-- Remove `a_command' from the list of command instance
			-- for which `Current' is an observer.
		require
			command_not_void: a_command /= Void
		do
			observed_commands.start
			observed_commands.prune (a_command)
		end

	add_observer (inst: like Current) is
			-- Add an observer.
		require
			valid_instance: inst /= Void
		do
			observers.extend (inst)
			inst.add_observed_command (Current)
			if command_tool /= Void and then command_tool.realized then
				command_tool.add_observer (inst)
			end
		end

	found: BOOLEAN
			-- Used in remove_observer

	remove_observer (inst: like Current) is
			-- Remove an observer.
		local
			i: INTEGER
			observer_inst: CMD_INSTANCE
		do
			from
				observers.start
				found := False
			until
				observers.after or found
			loop
				if observers.item = inst then
					found := True
				else
					observers.forth
				end
			end
			if found then
				inst.remove_observed_command (Current)
				if command_tool /= Void and then command_tool.realized then
					command_tool.remove_observer (inst)
				end
				observers.remove
			end
		end

	has_observer: BOOLEAN is
			-- Has this command instance observers?
		do
			Result := not observers.empty
		end

	set_observers (obs_list: like observers) is
			-- Set `observers' to `obs_list'.
		require
			list_not_void: obs_list /= Void
		do
			observers := obs_list
		end

end
