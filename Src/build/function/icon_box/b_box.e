

class B_BOX 

inherit

	FUNCTION_BOX [BEHAVIOR]
		rename
			make as function_make
		redefine
			new_icon, associated_editor, create_new_icon
		end;

	FUNCTION_BOX [BEHAVIOR]
		redefine
			new_icon, associated_editor, create_new_icon, make
		select
			make
		end

creation

	make
	
feature 

	make (a_name: STRING; a_parent: COMPOSITE; ed: like associated_editor) is
		do
			page_size := 5;
			function_make (a_name, a_parent, ed);
		end;

        
feature {NONE}

	create_new_icon is
                do
                        !!new_icon.make (associated_editor);
                end;

	associated_editor: STATE_EDITOR;

	new_icon: FUNC_BEH_IS;

end
