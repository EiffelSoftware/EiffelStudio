note
	description: "[
		Objects creating a simple readable expression from a request.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_SIMPLE_REQUEST_PRINTER

inherit
	AUT_REQUEST_PROCESSOR

	AUT_SHARED_TYPE_FORMATTER

	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create string.make (100)
			create expression_printer.make_string (string)
		end

feature -- Access

	last_string: STRING
			-- Last printed requested
		do
			Result := string
		end

feature {NONE} -- Access

	string: STRING
			-- String to which actual content is written to

	expression_printer: AUT_EXPRESSION_PRINTER
			-- Expression printer

feature {AUT_REQUEST} -- Visitors

	process_start_request (a_request: AUT_START_REQUEST)
			-- <Precursor>
		do
			wipe_out_string
			string.append ("start")
		end

	process_stop_request (a_request: AUT_STOP_REQUEST)
			-- <Precursor>
		do
			wipe_out_string
			string.append ("stop")
		end

	process_create_object_request (a_request: AUT_CREATE_OBJECT_REQUEST)
			-- <Precursor>
		do
			wipe_out_string
			string.append_string ("create {")
			string.append_string (type_name (a_request.target_type, a_request.creation_procedure))
			string.append_string ("} ")
			a_request.target.process (expression_printer)
			string.append_string (".")
			string.append_string (a_request.creation_procedure.feature_name)
			append_arguments (a_request)
		end

	process_invoke_feature_request (a_request: AUT_INVOKE_FEATURE_REQUEST)
			-- <Precursor>
		do
			wipe_out_string
			a_request.target.process (expression_printer)
			string.append_string (".")
			string.append_string (a_request.feature_name)
			append_arguments (a_request)
		end

	process_assign_expression_request (a_request: AUT_ASSIGN_EXPRESSION_REQUEST)
			-- <Precursor>
		do
			wipe_out_string
			a_request.receiver.process (expression_printer)
			string.append_string (" := ")
			a_request.expression.process (expression_printer)
		end

	process_type_request (a_request: AUT_TYPE_REQUEST)
			-- <Precursor>
		do
			wipe_out_string
			string.append_string ("type of ")
			a_request.variable.process (expression_printer)
		end

feature {NONE} -- Implementation

	wipe_out_string
			-- Clear content of `string'.
		do
			string.wipe_out
		ensure
			string_empty: string.is_empty
		end

	append_arguments (a_request: AUT_CALL_BASED_REQUEST)
			-- Append argument list to `string'.
			--
			-- `a_request': Call based request containing arguments.
		local
			l_arguments: detachable DS_LINEAR [ITP_EXPRESSION]
		do
			l_arguments := a_request.argument_list
			if l_arguments /= Void and then l_arguments.count > 0 then
				string.append_string (" (")
				from
					l_arguments.start
				until
					l_arguments.after
				loop
					l_arguments.item_for_iteration.process (expression_printer)
					l_arguments.forth
					if not l_arguments.after then
						string.append_string (", ")
					end
				end
				string.append_string (")")
			end
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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
