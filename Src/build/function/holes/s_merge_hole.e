
class S_MERGE_HOLE 

inherit

	MERGE_HOLE
		redefine
			associated_function,
			process_state
		end

creation

	make
		
feature {NONE}

	function: BUILD_STATE;

	associated_function: STATE_EDITOR;
			-- Function associated with current hole

	stone_type: INTEGER is
		do
			Result := Stone_types.state_type
		end;

	process_state (dropped: STATE_STONE) is
		do
			if associated_function.edited_function /= dropped.data then
				associated_function.edited_function.merge (dropped.data)
			end
		end;

end
