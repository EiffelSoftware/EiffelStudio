indexing
	description: "[
		Objects that find the location of the class name in an Eiffel code file.
		Implemented as an AST_VISITOR.
			]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NAME_CHANGE_VISITOR
	
inherit
	AST_VISITOR_IMP
		redefine
			process_class_as
		end
		
feature -- Access

	name_start_position: INTEGER
		-- Index of first character of class name.
	
	name_end_position: INTEGER
		-- Index of last character of class name.
		
	parent_start_position: INTEGER
		-- Index of first character of parent inheritance.
		
	parent_end_position: INTEGER
		-- Index of last character of parent inheritance.

feature {NONE} -- Basic operations

	process_class_as (l_as: CLASS_AS) is
			-- Process `l_as'.
		local
			parent_as: PARENT_AS
		do
			l_as.class_name.process (Current)
			name_start_position := l_as.click_ast.start_position
			name_end_position := l_as.click_ast.end_position
			
				-- This assumes that there is only one parent
			parent_as := l_as.parents.first
			parent_start_position := parent_as.start_position
			parent_end_position := parent_as.end_position
		end

end -- class NAME_CHANGE_VISITOR
