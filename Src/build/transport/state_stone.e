
--=========================== class STATE_STONE =====================
--
-- Author: Deramat
-- Last revision: 03/30/92
--
-- General notion of stone containing information about a state.
--
--===================================================================

deferred class STATE_STONE 

inherit

	STONE
		redefine
			data
		end
	
feature 

	data: BUILD_STATE is
		deferred
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.state_type
		end;

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			hole.process_state (Current)
		end;

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.state_cursor
		end;

end
