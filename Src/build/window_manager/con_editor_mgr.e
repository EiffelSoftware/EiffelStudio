
class CON_EDITOR_MGR 

inherit

	EDITOR_MGR
		redefine
			editor_type, clear_editor
		end

creation

	make

feature {NONE}

	editor_type: CONTEXT_EDITOR_TOP_SHELL

	clear_editor (ed: like editor_type) is
		do
			ed.clear
		end

end 
