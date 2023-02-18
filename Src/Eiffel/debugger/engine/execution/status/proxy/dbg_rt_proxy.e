note
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DBG_RT_PROXY

inherit
	REFACTORING_HELPER

feature -- Recycling

	recycle
			-- Recycle Current
		do
		end

feature {NONE} -- Implementation: Element change

	set_associated_application (a_app: like associated_application)
			-- Initialize Current with `a_app' and various cached values.
		do
			associated_application := a_app
			associated_status := a_app.status
			debugger_manager := a_app.debugger_manager
			dump_value_factory := debugger_manager.dump_value_factory
			compiler_data := debugger_manager.compiler_data
		end

feature {NONE} -- Implementation: Evaluation

	query_evaluation_on (fname: STRING_8; params: LIST [DUMP_VALUE]): detachable DUMP_VALUE
			-- method `{cl}.fname' evaluation on `edv'
			-- using `params' as argument if any
		deferred
		end

	command_evaluation_on (fname: STRING_8; params: LIST [DUMP_VALUE]): BOOLEAN
			-- Evaluation's result for `a_expr' in current context
			-- (note: Result = Void implies an error occurred)		
		deferred
		end

feature {NONE} -- Implementation: helper

	one_arg_resulting_string_evaluation (a_featname: STRING; a_value: DUMP_VALUE; min,max: INTEGER; a_error_handler: detachable DBG_ERROR_HANDLER): detachable STRING_32
		require
			a_value_attached: a_value /= Void
		local
			params: ARRAYED_LIST [DUMP_VALUE]
		do
			create params.make (1)
			params.extend (a_value)
			if
				attached query_evaluation_on (a_featname, params) as dv and then
				dv.has_formatted_output
			then
				if min >= max then
					Result := dv.string_representation
				else
					Result := dv.truncated_string_representation (min, max)
				end
			elseif attached a_error_handler then
				a_error_handler.notify_error_evaluation_report_to_support (Void)
			end
		end

	one_arg_resulting_integer_32_evaluation (a_featname: STRING; a_value: DUMP_VALUE; a_error_handler: detachable DBG_ERROR_HANDLER): INTEGER_32
		require
			a_value_attached: a_value /= Void
		local
			params: ARRAYED_LIST [DUMP_VALUE]
		do
			create params.make (1)
			params.extend (a_value)
			if
				attached query_evaluation_on (a_featname, params) as dv and then
				dv.is_valid_value and then
				dv.is_type_integer_32
			then
				Result := dv.as_dump_value_basic.value_integer_32
			else
				if a_error_handler /= Void then
					a_error_handler.notify_error_evaluation_report_to_support (Void)
				end
			end
		end

	two_args_resulting_boolean_evaluation (a_featname: STRING; a_value, a_other_value: DUMP_VALUE; a_error_handler: detachable DBG_ERROR_HANDLER): BOOLEAN
		require
			a_value_attached: a_value /= Void
			a_other_value_attached: a_other_value /= Void
		local
			params: ARRAYED_LIST [DUMP_VALUE]
		do
			create params.make (2)
			params.extend (a_value)
			params.extend (a_other_value)
			if
				attached query_evaluation_on (a_featname, params) as dv and then
				dv.is_valid_value and then
				dv.is_type_boolean
			then
				Result := dv.as_dump_value_basic.value_boolean
			else
				if a_error_handler /= Void then
					a_error_handler.notify_error_evaluation_report_to_support (Void)
				end
			end
		end

feature {NONE} -- Implementation

	debugger_manager: DEBUGGER_MANAGER
			-- Associated debugger manager

	dump_value_factory: DUMP_VALUE_FACTORY
			-- Dump value factory

	compiler_data: DEBUGGER_DATA_FROM_COMPILER
			-- Compiler data

	associated_application: APPLICATION_EXECUTION
			-- Associated application execution

	associated_status: APPLICATION_STATUS
			-- Associated application status

invariant
	associated_application_attached: associated_application /= Void
	associated_status_attached: associated_status /= Void
	debugger_manager_attached: debugger_manager /= Void
	compiler_data_attached: compiler_data /= Void
	dump_value_factory_attached: dump_value_factory /= Void

;note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
