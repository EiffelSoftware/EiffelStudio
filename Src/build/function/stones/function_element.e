
-- For future purposes to set icon_stones in the 
-- function editors (didn't have enough time to
-- implement this).

deferred class FUNCTION_ELEMENT 

inherit

	HOLE
	
feature {NONE}

	associated_editor: FUNC_EDITOR;

	original_stone: STONE is
		deferred
		end;

	initialize (ed: like associated_editor) is
			-- Initialize function with `ed'.
		require
			not (ed = Void)
		do
			associated_editor := ed
		end;

	process_stone is
		do
		end; -- process_stone


end
