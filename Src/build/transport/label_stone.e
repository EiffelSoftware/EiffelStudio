
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

	CURSORS
		rename
			label_cursor as stone_cursor
		export
			{NONE} all
		end;

	STONE
		redefine
			original_stone
		end
	
feature 

	original_stone: CMD_LABEL is
		deferred
		end;

end -- class LABEL_STONE
