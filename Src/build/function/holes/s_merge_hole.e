
class S_MERGE_HOLE 

inherit

	MERGE_HOLE
		redefine
			associated_function,
			function,
			set_function
		end

creation

	make
		
feature {NONE}

	function: STATE;

	associated_function: STATE_EDITOR;
			-- Function associated with current hole

	set_function is
		do
			function ?= stone.original_stone
		end; -- set_function;

end
