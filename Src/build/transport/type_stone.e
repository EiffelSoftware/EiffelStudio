
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

	CURSORS
		export
			{NONE} all
		end;

	STONE
		redefine
			original_stone
		end;

	HELPABLE
		export
			{NONE} all
		end
	
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
			Result := Type_cursor
		end;

	eiffel_type: STRING is
			-- Name of the class associated 
			-- with current stone
		deferred
		end;

end
