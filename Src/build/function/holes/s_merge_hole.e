
class S_MERGE_HOLE 

inherit

	MERGE_HOLE
		rename
			make as merge_make
		redefine
			associated_function,
			function,
			set_function
		end

creation

	make
	
feature 

	make (func: STATE_EDITOR) is
		do
			merge_make (func);
			set_symbol (State_pixmap)
		end;

	
feature {NONE}

	function: STATE;

	associated_function: STATE_EDITOR;
			-- Function associated with current hole

	set_function is
		do
			function ?= stone.original_stone
		end; -- set_function

end
