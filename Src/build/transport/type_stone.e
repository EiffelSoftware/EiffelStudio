
--=========================== class TYPE_STONE ======================
--
-- Author: Deramat
-- Last revision: 03/30/92
--
-- General notion of stone containing information about an Eiffel type.
--
--===================================================================

deferred class TYPE_STONE 

inherit

	STONE
		redefine
			data
		end
	
feature 

	data: TYPE_DATA is
		deferred
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.type_stone_type
		end;

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			hole.process_type (Current)
		end;

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.type_cursor
		end;

end
