

class META_CMD 

inherit

	EXTEND_TABLE [CMD_INSTANCE, STATE]
		rename
			make as extend_table_create,
			key_for_iteration as current_state
		export
			{NONE} all
		select
			twin
		end;

	CALLBACK_GENE
		rename
			twin as call_back_twin
		export
			{NONE} all
		end;

	COM_NAMER
		rename
			twin as call_back_twin
		export
			{NONE} all
		end


creation

	make

	
feature 

	eiffel_declaration: STRING is
		do
			!!Result.make (0);
			from
				start
			until
				offright
			loop
				namer.next;
				Result.append ("%T%T%T");
				Result.append (namer.value);
				Result.append (": ");
				Result.append (item (current_state).eiffel_type);
				Result.append (";%N");
				forth
			end
		end;

	eiffel_association: STRING is
		local
			meta_command_initialization: STRING;
		do
			!!Result.make (0);
			!!meta_command_initialization.make (0);
			from
				start
			until
				offright
			loop
				namer.next;

				Result.append ("%T%T%T!!");
				Result.append (namer.value);
				Result.append (".make");
				Result.append (item (current_state).eiffel_arguments);
				Result.append (";%N");

				meta_command_initialization.append ("%T%T%Tmeta_command.add (");
				meta_command_initialization.append (current_state.label);
				meta_command_initialization.append (", ");
				meta_command_initialization.append (namer.value);
				meta_command_initialization.append (");%N");

				forth
			end;
			Result.append ("%T%T%T!!meta_command.make;%N");
			Result.append (meta_command_initialization)
		end;

	make (c: CMD_INSTANCE) is
		do
			extend_table_create (5);
			update (c);
		end;

	update (c: CMD_INSTANCE) is
		do
			put (c, callback_generator.current_state)
		end;

end
