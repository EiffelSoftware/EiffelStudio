
class S_COMMAND_ELMT 

inherit

	SHARED_STORAGE_INFO

creation

	make

	
feature 

	make (other: CMD_INSTANCE) is
		local
			args: LIST [ARG_INSTANCE]
			obs: LIST [CMD_INSTANCE]
			s_obs: like Current
		do
			-- TODO: create it to be both an element used in a command
			-- and and argument
			identifier := other.identifier
			!! arguments.make
			from
				args := other.arguments
				args.start
			until
				args.after
			loop
				arguments.extend (args.item.identifier)
				args.forth
			end;
				--| Added for version 4.3.
			!! observers.make
			from
				obs := other.observers
				obs.start
			until
				obs.after
			loop
				!! s_obs.make (obs.item)
				observers.extend (s_obs)
				obs.forth
			end
		end;

	command: CMD_INSTANCE is
		local
			arg: ARG_INSTANCE
			arg_list: EB_LINKED_LIST [ARG_INSTANCE]
			cmd: CMD
			ct: CONTEXT_TYPE
			cs: CONTEXT
			inst_internal_name: STRING
			inst_id: INTEGER
			obs_list: EB_LINKED_LIST [CMD_INSTANCE]
		do
			if (identifier > 0) then
				cmd := command_table.item (identifier)
			else
				cmd := predefined_command_table.item (- identifier)
			end
			inst_id := instance_identifier
			if inst_id /= -1 then
					-- New version (3.3.2)
				inst_internal_name := clone (cmd.eiffel_type)
				inst_internal_name.append_integer (inst_id)
				inst_id := inst_internal_name.hash_code
				Result := command_instance_table.item (inst_id)
			end
			if Result = Void then
				!! arg_list.make
				from
					arguments.start		
				until
					arguments.after
				loop
					if arguments.item > 0 then
						cs := context_table.item (arguments.item)
						ct := cs.type
					else
						ct := context_type_table.item (- arguments.item)
						cs := Void
					end
					!!arg.storage_init (ct, cs)
					arg_list.extend (arg)
					arguments.forth
				end
					--| Added for version 4.3.
				!! obs_list.make
				from
					observers.start
				until
					observers.after
				loop
					obs_list.extend (observers.item.command)
					observers.forth
				end
					--| <Guillaume>
				
					--| </Guillaume>
				!! Result.storage_init (cmd, arg_list, obs_list)
				if inst_id /= -1 then
					-- New version (3.3.2)
					command_instance_table.put (Result, inst_id)
				end
			end
		end

	argument: ARG_INSTANCE is
			-- Return stored ARG_INSTANCE
		do
			--TODO: Have a look in S_ARG to see how to 
			-- rebuilt result
		end

feature {NONE}

	instance_identifier: INTEGER is
			-- Instance identifier
		do
			Result := -1
		end;

	identifier: INTEGER;
			-- Command identifier

	arguments: LINKED_LIST [INTEGER]

	observers: LINKED_LIST [like Current]
			-- List of observers

end
