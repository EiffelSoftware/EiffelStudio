indexing
	description: "Box used in a behavior editor containing %
				% the event associated with a behavior. It %
				% should be used with a COM_BOX."

class EV_BOX 

inherit

	FUNCTION_BOX [EVENT]
		rename
			make as function_make
		redefine
			new_icon, associated_editor, create_new_icon
		end;

	FUNCTION_BOX [EVENT]
		redefine
			new_icon, associated_editor, create_new_icon, make
		select
			make
		end

creation

	make

        
feature {NONE}

	create_new_icon is
		do
			!! new_icon.make (associated_editor)
		end
	
feature 

	make (a_name: STRING; a_parent: COMPOSITE; ed: BEHAVIOR_EDITOR) is
		do
			page_size := 3
			function_make (a_name, a_parent, ed)
		end;

	
feature {NONE}

	associated_editor: BEHAVIOR_EDITOR

	new_icon: FUNC_EV_IS 

end
