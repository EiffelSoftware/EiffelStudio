
--=========================== class STATE_STONE =====================
--
-- Author: Deramat
-- Last revision: 03/30/92
--
-- General notion of stone containing information about a state.
--
--===================================================================

deferred class NEW_STATE_STONE 

inherit

	CURSORS
		rename
			State_cursor as stone_cursor
		export
			{NONE} all
		end;

	STONE
		redefine
			original_stone
		end
	
feature 

	original_stone: STATE is
		deferred
		end
end
