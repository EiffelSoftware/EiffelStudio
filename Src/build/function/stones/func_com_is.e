
class FUNC_COM_IS 

inherit

	COM_INST_IS
		rename
			make as com_inst_is_make
		undefine
			init_toolkit
		end;

	FUNCTION_ELEMENT
		rename
			target as source
		export
			{NONE} all
		redefine
			associated_editor
		end;

	WINDOWS
		export
			{NONE} all
		end;

	PIXMAPS
		export
			{NONE} all
		end


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

	
feature {NONE}

end
