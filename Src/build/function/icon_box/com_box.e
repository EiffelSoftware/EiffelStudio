indexing
	description: "Box used in a behavior editor containing %
				% the command associated with a behavior. This %
				% should be used with an EV_BOX."

class COM_BOX 

inherit

	FUNCTION_BOX [CMD]
		rename
			make as function_make
		redefine
			new_icon, associated_editor, create_new_icon
		end;

	FUNCTION_BOX [CMD]
		redefine
			new_icon, associated_editor, create_new_icon, make
		select
			make
		end

creation

	make

	
feature {NONE}

	associated_editor: BEHAVIOR_EDITOR;

        create_new_icon is
                do
                        !!new_icon.make (associated_editor)
                end

	
feature 

	make (a_name: STRING; a_parent: COMPOSITE; ed: like associated_editor) is
		do
			page_size := 3
			function_make (a_name, a_parent, ed)
		end;

	
feature {NONE}

	new_icon: FUNC_COM_IS

end
