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
			stone_cursor, data,
			process, stone_type
		end
		
feature 

	data: CONTEXT is
		deferred
		end;

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.context_cursor
		end;

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			hole.process_context (Current)
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.context_type
		end;

end
