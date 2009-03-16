note
	description: "AST visitor to retrieve object test local variables."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	AST_DEBUGGER_OBJECT_TEST_LOCAL_VISITOR

inherit
	AST_ITERATOR
		redefine
			default_create,
			process_object_test_as
		end

feature {NONE} -- Initialization

	default_create
			-- <Precursor/>
		do
			Precursor
			create object_test_locals.make (10)
		end
feature -- Access

	get_object_test_locals (a_feature_as: FEATURE_AS)
			-- Get object_test_locals from `a_feature_as'
		do
			object_test_locals.wipe_out
			a_feature_as.process (Current)
		end

	object_test_locals: ARRAYED_LIST [TUPLE [name: ID_AS; type: TYPE_AS; exp: EXPR_AS]]
			-- recorded object test locals

feature {NONE} -- Locals

	process_object_test_as (l_as: OBJECT_TEST_AS)
			-- Process `l_as'.
		do
			if attached l_as.name as l_name then
				object_test_locals.force ([l_name, l_as.type, l_as.expression])
				debug
					print ("OT: " + l_name.name + "%N")
				end
			end
			Precursor (l_as)
		end

invariant
	object_test_locals_attached: object_test_locals /= Void

note
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

end
