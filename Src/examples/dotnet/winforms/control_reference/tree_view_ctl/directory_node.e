indexing
	description: "Representation of a directory."
	date: "$Date$"
	revision: "$Revision$"
	
class
	DIRECTORY_NODE

inherit 
	WINFORMS_TREE_NODE
		rename
			make_from_text as make_from_node
		end

create
	make_from_text

feature {NONE} -- Initialization

	make_from_text (a_text: STRING) is
			-- Set `text' with `a_text'.
		require
			non_void_text: a_text /= Void
		do
			set_text (a_text)
		ensure
			text_set: a_text.is_equal (text)
		end
		
feature -- Access

	sub_directories_added: BOOLEAN
			-- subdirectories added?

feature -- Status Setting

	set_sub_directories_added (a_bool: BOOLEAN) is
			-- set `sub_directories_added' with `a_bool'.
		do
			sub_directories_added := a_bool
		ensure
			sub_directories_added_set: sub_directories_added = a_bool
		end
		
end -- class DIRECTORY_NODE
