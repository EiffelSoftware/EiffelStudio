
class FUNC_BEH_IS 

inherit

	B_ICON_STONE
		-- added by samik
		undefine
			init_toolkit
		-- end of samik     
		end;
	FUNCTION_ELEMENT
		rename
			target as source 
		redefine
			associated_editor
		end

creation

	make

feature {NONE}

	associated_editor: STATE_EDITOR;

	make (ed: like associated_editor) is
		require
			not (ed = Void)
		do
			initialize (ed);
			register
		end;

end
