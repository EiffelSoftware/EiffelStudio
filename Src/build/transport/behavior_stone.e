--=========================== class BEHAVIOR_STONE ==================
--
-- Author: Deramat
-- Last revision: 03/30/92
--
-- General notion of stone containing information about a behavior.
--
--===================================================================

deferred class BEHAVIOR_STONE 

inherit

	STONE
		redefine
			data
		end
	
feature 

	data: BEHAVIOR is
		deferred
		end;

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.behavior_cursor
		end;

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			hole.process_behavior (Current)
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.behavior_type
		end;

end
