-- General notion of stone, i.e. element that may transported
-- and dropped into a hole.
-- Each stone carries data which has specific information about 
-- stone object.

deferred class STONE

inherit

	CONSTANTS;
	
feature 

	stone: STONE is
			-- Current stone.
			--| Convenient routine. Useful when
			--| merging stone and drag source together
		do
			Result := Current
		ensure
			result_is_current: Result = Current
		end;

feature {HOLE}

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		require
			valid_hole: hole /= Void
		deferred
		end;

	stone_type: INTEGER is
		deferred
		end;

feature 

	data: HELPABLE is
			-- Canonical representative of 
			-- current stone.
			-- For copy and multiple references 
			-- purposes.
		deferred
		end;

	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with 
			-- current stone during transport.
		deferred
		end;

end
