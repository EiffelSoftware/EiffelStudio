
class FUNC_BEH_IS 

inherit

	B_ICON_STONE
		rename
			make as b_icon_stone_make	
		end;
	FUNCTION_ELEMENT
		rename
			target as source 
		export
			{NONE} all
		redefine
			associated_editor
		end


creation

	make

	
feature {NONE}

	associated_editor: STATE_EDITOR;

feature 

	make (ed: like associated_editor) is
		require
			not (ed = Void)
		do
			initialize (ed);
			register
		end; -- Create

	
feature {NONE}

end
