
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
			original_stone
		end
	
feature 

	identifier: INTEGER is
		deferred
		end;

	original_stone: STATE is
		deferred
		end;

	labels: LINKED_LIST [CMD_LABEL] is
		deferred
		end;

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.state_cursor
		end

end
