
--=========================== class STATE_STONE =====================
--
-- Author: Valente 
-- Last revision: 03/30/92
--
-- General notion of stone containing information about a label.
--
--===================================================================

deferred class LABEL_STONE  

inherit

	STONE
		redefine
			data
		end
	
feature 

	data: CMD_LABEL is
		deferred
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.label_type
		end;

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			hole.process_label (Current)
		end;

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.label_cursor
		end

end -- class LABEL_STONE
