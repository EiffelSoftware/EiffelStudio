
class FUNC_COM_IS 

inherit


	COM_INST_IS
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
		end;

creation

	make
	
feature {NONE}

	associated_editor: BEHAVIOR_EDITOR;

feature 

	make (ed: like associated_editor) is
		do
			initialize (ed);	
			register
		end; -- Create

end
