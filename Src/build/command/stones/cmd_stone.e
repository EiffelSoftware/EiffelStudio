
--===================================================================
-- General notion of stone containing information about a command.
-- Each command is represented by an Eiffel class.
--===================================================================

deferred class CMD_STONE 

inherit

	STONE
		redefine
			original_stone
		end

feature 

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.command_cursor
		end;

	identifier: INTEGER is
			-- Unique identifier
		deferred
		end;

	original_stone:	CMD is
		deferred
		end;

	eiffel_type: STRING is
			-- Name of the class representing
			-- Current command
		deferred
		end;

	arguments: EB_LINKED_LIST [ARG] is
			-- Arguments of Current command
			-- (Currently restricted to contexts)
		deferred
		end;	

	labels: EB_LINKED_LIST [CMD_LABEL] is
			-- Exit labels of Current command
		deferred
		end;

	eiffel_text: STRING is
			-- Eiffel class text of Current
			-- command
		deferred
		end;

end
