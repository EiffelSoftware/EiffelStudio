
class MERGE_HOLE 

inherit

	PIXMAPS
		export
			{NONE} all
		end;

	ICON_HOLE
		redefine
			stone
		end


creation

	make

feature {NONE}

	make (func: FUNC_EDITOR) is
		do
			associated_function := func;
			set_label ("Merge");
		end;

	stone: STONE;

	
feature {NONE}

	function: FUNCTION;

	associated_function: FUNC_EDITOR;
			-- Function associated with current hole

	process_stone is
		do
			set_function;
			if
				not (function = Void) and 
				not (associated_function.edited_function = function)
			then
				associated_function.edited_function.merge (function);
			end
		end; -- process_stone

	set_function is
		do	
		end; -- set_function

end
