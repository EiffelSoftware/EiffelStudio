
class CMD_EDITOR_MGR 

inherit

	EDITOR_MGR
		redefine
			editor_type
		end

creation

	make

feature {NONE}

	editor_type: CMD_EDITOR;
	
end 
