
class CON_EDITOR_MGR 

inherit

	EDITOR_MGR
		redefine
			editor_type
		end

creation

	make

feature {NONE}

	editor_type: CONTEXT_EDITOR;

end 
