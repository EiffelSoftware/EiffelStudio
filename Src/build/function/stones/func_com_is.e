indexing
	description: "Icon stone representing a command that has been %
				% paired with an event in a behavior editor; %
				% used in an COM_BOX."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class FUNC_COM_IS 

inherit


	COM_INST_IS
		undefine
			init_toolkit
		redefine
			is_centered
		end

	FUNCTION_ELEMENT
		rename
			target as source
		redefine
			associated_editor
		end

creation

	make
	
feature {NONE}

	associated_editor: BEHAVIOR_EDITOR

feature 

	make (ed: like associated_editor) is
			-- Create.
		do
			initialize (ed);	
			register
		end

feature 

	is_centered: BOOLEAN is False

end
