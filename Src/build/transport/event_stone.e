--=========================== class EVENT_STONE =====================
--
-- Author: Deramat
-- Last revision: 03/30/92
--
-- General notion of stone containing information about an event.
--
--===================================================================

deferred class EVENT_STONE 

inherit

	STONE
		redefine
			original_stone
		end;
	HELPABLE
	
feature {NONE}

	help_file_name: STRING is
		do
			Result := label
		end;

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.event_cursor
		end
	
feature 

	identifier: INTEGER is
		deferred
		end;

	eiffel_text: STRING is
		deferred
		end;

	original_stone: EVENT is
		deferred
		end;

end
