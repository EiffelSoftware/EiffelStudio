
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
			original_stone
		end;
	HELPABLE
	
feature {NONE}

	help_file_name: STRING is
		do
			Result := eiffel_type
		end;
	
feature 

	identifier: INTEGER is
		deferred
		end;

	original_stone: TYPE_STONE is
		deferred
		end;

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.type_cursor
		end;

	eiffel_type: STRING is
			-- Name of the class associated 
			-- with current stone
		deferred
		end;

end
