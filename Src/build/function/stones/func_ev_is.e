indexing
	description: "Icon stone representing an event that has been %
				% paired with a command in a behavior editor %
				% used in an EV_BOX."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class FUNC_EV_IS 

inherit

	EV_ICON_STONE
		undefine
			init_toolkit
		redefine
			is_centered
		end

	FUNCTION_ELEMENT
		rename
			target as source
		export
			{NONE} all
		redefine
			associated_editor
		end

	REMOVABLE

creation

	make

	
feature {NONE}

	associated_editor: BEHAVIOR_EDITOR

feature 

	make (ed: like associated_editor) is
		do
			initialize (ed)	
			register
		end -- Create

	
feature {NONE}

	remove_yourself is
		do
			associated_editor.edited_function.remove_element_line (data, True)
			App_editor.update_transitions_list (Void)
		end
 
feature

	is_centered: BOOLEAN is False

end
