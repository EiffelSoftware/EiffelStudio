
deferred class CMD_INST_STONE 

inherit

	CURSORS
		rename
			Command_instance_cursor as stone_cursor
		export
			{NONE} all
		end;

	STONE
		redefine
			original_stone
		
		end



-- *********************
-- Command type features
-- *********************

	
feature 

	eiffel_type: STRING is
		do
			Result := associated_command.eiffel_type
		end;

	associated_command: CMD is
			-- Command type associated
			-- with current instance
		deferred
		end;

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

-- *************************
-- Command instance features
-- *************************

	original_stone:	CMD_INSTANCE is
		deferred
		end;

	arguments: LINKED_LIST [ARG_INSTANCE] is
			-- Arguments of command
			-- associated with current stone.
		deferred
		end;	

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

end
