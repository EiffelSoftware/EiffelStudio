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

	CURSORS
		rename
			Behavior_cursor as stone_cursor
		export
			{NONE} all
		end;

	STONE
		redefine
			original_stone
		end
	
feature 

	identifier: INTEGER is
		deferred
		end;

	original_stone: BEHAVIOR is
		deferred
		end;

	context: CONTEXT is
		deferred
		end;

	labels: LINKED_LIST [CMD_LABEL] is
		deferred
		end;
end
