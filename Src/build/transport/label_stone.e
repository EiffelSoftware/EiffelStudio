
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
			original_stone
		end
	
feature 

	original_stone: CMD_LABEL is
		deferred
		end;

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.label_cursor
		end

end -- class LABEL_STONE
