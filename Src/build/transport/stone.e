--=========================== class STONE ==========================
--
-- Author: Deramat
-- Last revision: 03/30/92
--
-- General notion of stone, i.e. element that may transported
-- and dropped into a hole. 
-- Each stone caries at least a symbol (pixmap) and a label (plain text).
-- and usually more specific information about a given interface 
-- specification object.
-- The source of the stone, i.e. the widget which, when clicked on with
-- the right mouse button, initializes the transport must be defined in
-- descendants.
--
--===================================================================

deferred class STONE 

inherit

	STONE_PARENT
		redefine
			original_stone
		end
	
feature 

	original_stone: STONE is
			-- Canonical representative of 
			-- current stone.
			-- For copy and multiple references 
			-- purposes.
		deferred
		end;

end
