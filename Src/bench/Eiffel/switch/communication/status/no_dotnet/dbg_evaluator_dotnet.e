indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_EVALUATOR_DOTNET

inherit

	DBG_EVALUATOR_IMP

create
	make

feature -- Access

	last_once_available: BOOLEAN is False
	last_once_failed: BOOLEAN is False

	effective_evaluate_function (a_addr: STRING; a_target: DUMP_VALUE; f, realf: FEATURE_I; ctype: CLASS_TYPE; params: LIST [DUMP_VALUE]) is
		do
		end
	effective_evaluate_once (f: FEATURE_I) is
		do
		end

	parameters_push (dmp: DUMP_VALUE) is
			-- (export status {DBG_EVALUATOR})
		do
		end
	parameters_push_and_metamorphose (dmp: DUMP_VALUE) is
		do
		end

	associated_reference_basic_class_type (cl: CLASS_C): CLASS_TYPE is
			-- Associated _REF classtype for type `cl'
			-- (export status {DBG_EVALUATOR})
		do
		end

	dump_value_at_address (addr: STRING): DUMP_VALUE is
		do
		end

	current_object_from_callstack (cse: EIFFEL_CALL_STACK_ELEMENT): DUMP_VALUE is
		do
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
