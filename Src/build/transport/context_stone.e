--=========================== class CONTEXT_STONE ===================
--
-- Author: Deramat
-- Last revision: 03/30/92
--
-- General notion of stone containing information about a context.
--
--===================================================================

deferred class CONTEXT_STONE 

inherit

	TYPE_STONE
		redefine
			stone_cursor, original_stone, initialize_transport
		end
	
feature {NONE}

	initialize_transport is
		do
			source.set_action ("!Shift<Btn1Down>", show_command, Current);
			source.set_action ("!Shift<Btn1Up>", show_command, Void);
			source.set_action ("!<Btn3Down>", transport_command, Current);			
			-- set create editor command as well
			source.set_action ("!Shift<Btn3Down>", name_command, Current);
		end;
	
feature 

	original_stone: CONTEXT is
		deferred
		end;

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.context_cursor
		end;

	entity_name: STRING is
			-- Eiffel entity name of context 
			-- associated withe current stone	
		deferred
		end;	

	eiffel_text: STRING is
			-- Eiffel class text of context 
			-- associated with current stone
		deferred
		end;

end
