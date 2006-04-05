indexing
	description: "Intermediate representation of constructors used to solve overloading"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTRUCTOR_SOLVER

inherit
	COMPARABLE
	
	ARGUMENT_SOLVER
		rename
			arguments as solved_arguments
		undefine
			is_equal
		end
		
	NAME_FORMATTER
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (cons: CONSTRUCTOR_INFO) is
			-- Initialize from `cons'.
		require
			non_void_constructor: cons /= Void
		do
			internal_constructor := cons
			arguments := solved_arguments (cons)
			is_public := cons.is_public
		ensure
			internal_constructor_set: internal_constructor = cons
			is_public_set: is_public = cons.is_public
		end

feature -- Access

	name: STRING
			-- Eiffel name of constructor

	arguments: ARRAY [CONSUMED_ARGUMENT]
			-- Creation routine arguments

	is_public: BOOLEAN
			-- Is constructor public?

	consumed_constructor: CONSUMED_CONSTRUCTOR is
			-- Generate consumed constructor from `name' and `internal_constructor'.
		require
			name_set: name /= Void
		do
			create Result.make (name, arguments, is_public,
				referenced_type_from_type (internal_constructor.declaring_type))
		ensure
			non_void_constructor: Result /= Void
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Compare argument count.
		do
			Result := arguments.count < other.arguments.count
		end
		
feature {TYPE_CONSUMER} -- Element settings

	set_name (n: like name) is
			-- set `name' with `n'.
		require
			non_void_name: n /= Void
			valid_name: not n.is_empty
		do
			name := n
		ensure
			name_set: name = n
		end
		
feature {CONSTRUCTOR_SOLVER} -- Implementation

	internal_constructor: CONSTRUCTOR_INFO;
			-- Constructor info

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


end -- class CONSTRUCTOR_SOLVER
