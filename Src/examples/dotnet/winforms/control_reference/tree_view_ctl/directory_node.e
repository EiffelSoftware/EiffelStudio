indexing
	description: "Representation of a directory."
	
class
	DIRECTORY_NODE

inherit 
	WINFORMS_TREE_NODE
		rename
			make_from_text as make_tree_node
		end

create
	make_from_text

feature {NONE} -- Initialization

	make_from_text (a_text: SYSTEM_STRING) is
		indexing
			description: "Entry point."
		do
			make_tree_node (a_text)
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