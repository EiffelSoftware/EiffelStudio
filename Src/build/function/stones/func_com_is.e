
class FUNC_COM_IS 

inherit

	COM_INST_IS
		rename
			make as com_inst_is_make
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
