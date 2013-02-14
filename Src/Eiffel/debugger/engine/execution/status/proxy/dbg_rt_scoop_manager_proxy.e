note
	description: "Objects that represent the ISE_SCOOP_MANAGER..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_RT_SCOOP_MANAGER_PROXY

inherit

	DBG_RT_PROXY

create
	make

feature {NONE} -- Initialization

	make (a_value: ABSTRACT_REFERENCE_VALUE; a_app: APPLICATION_EXECUTION)
			-- Initialize `Current'.
		require
			a_value_attached: a_value /= Void
			a_app_attached: a_app /= Void
		do
			value := a_value
			dynamic_class := a_value.dynamic_class
			set_associated_application (a_app)

			if
				attached a_value.address as add and then
				not add.is_void
			then
				a_app.status.keep_object (add)
			end
		end

feature -- Access

	value: ABSTRACT_REFERENCE_VALUE
			-- Handle on the remote {RT_EXTENSION} object

	dynamic_class: CLASS_C
			-- Dynamic class

feature -- Remote invocation

	processor_id_from_object (a_add: DBG_ADDRESS; a_dtype: detachable CLASS_C): INTEGER
			-- Processor id from object at `a_add'
		do
			Result := one_arg_resulting_integer_32_evaluation ("processor_id_from_object", dump_value_factory.new_object_value (a_add, a_dtype, 0), Void)
			-- CHECKME: use 0 for scp_pid since we don't really care about the scoop pid here.
		end

feature {NONE} -- Implementation

	query_evaluation_on (fname: STRING_8; params: LIST [DUMP_VALUE]): detachable DUMP_VALUE
			-- method `{cl}.fname' evaluation on `edv'
			-- using `params' as argument if any
		do
			Result := associated_application.query_evaluation_on (value, Void, dynamic_class, fname, params)
		end

	command_evaluation_on (fname: STRING_8; params: LIST [DUMP_VALUE]): BOOLEAN
			-- Evaluation's result for `a_expr' in current context
			-- (note: Result = Void implies an error occurred)
		do
			Result := associated_application.command_evaluation_on (value, Void, dynamic_class, fname, params)
		end

invariant
	value_attached: value /= Void

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
