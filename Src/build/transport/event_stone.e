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
			data
		end;
	
feature {NONE}

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.event_cursor
		end
	
feature 

	data: EVENT is
		deferred
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.event_type
		end;

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			hole.process_event (Current)
		end;

end
