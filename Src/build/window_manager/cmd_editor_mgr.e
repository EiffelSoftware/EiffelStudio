
class CMD_EDITOR_MGR 

inherit

	EDITOR_MGR
		redefine
			editor_type, clear_editor
		end

creation

	make

feature {NONE}

	editor_type: CMD_EDITOR;

	clear_editor (ed: like editor_type) is
		do
			ed.clear
		end
	
end 
