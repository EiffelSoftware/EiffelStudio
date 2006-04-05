indexing
	description: "[
		Objects that find the location of the class name in an Eiffel code file.
		Implemented as an AST_VISITOR.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NAME_CHANGE_VISITOR
	
inherit
	AST_NULL_VISITOR
		redefine
			process_class_as
		end
		
	GB_CONSTANTS
		
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
			parents: EIFFEL_LIST [PARENT_AS]
			inherited_class_name: STRING
		do
			l_as.class_name.process (Current)
			name_start_position := l_as.click_ast.start_position
			name_end_position := l_as.click_ast.end_position
			inherited_class_name := l_as.class_name + Class_implementation_extension
			parents := l_as.parents
				-- We must find the correct inherited class, so that if a user inherits
				-- from other classes, we will not change them.
			from
				parents.start
			until
				parents.off or parent_as /= Void
			loop
				if inherited_class_name.is_equal (parents.item.type.class_name) then
					parent_as := parents.item
				end
				parents.forth

			end
			if parent_as /= Void then
					-- `parent_as' will be Void if the class we are parsing is not
					-- the interface class.
				parent_start_position := parent_as.start_position
				parent_end_position := parent_as.end_position
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class NAME_CHANGE_VISITOR
