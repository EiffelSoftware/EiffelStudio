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
		local
			nothing: ANY
		do
			source.add_button_press_action (2, show_command, Current);
			source.add_button_release_action (2, show_command, Nothing);
			--source.add_button_press_action (3, transport_command, Current);
			--source.set_action ("<Btn1Up>(2)", transport_command, Current);
			source.add_button_click_action (3, transport_command, Current);
		end;
	
feature 

	original_stone: CONTEXT is
		deferred
		end;

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Context_cursor
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
