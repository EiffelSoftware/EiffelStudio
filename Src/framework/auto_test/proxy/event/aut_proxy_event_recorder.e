note
	description: "[
		Objects that record request logs with their corresponding response.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_PROXY_EVENT_RECORDER

inherit
	AUT_PROXY_EVENT_OBSERVER

	AUT_REQUEST_PROCESSOR

	ERL_G_TYPE_ROUTINES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_system: like system)
			-- Initialize `Current'.
		do
			system := a_system
			create request_history.make (5000)
			create variable_table.make (system)
		end

feature -- Access

	request_history: DS_ARRAYED_LIST [AUT_REQUEST]
			-- Requests in the same order as reported
			--
			-- Note: requests contain their response

feature {NONE} -- Access

	last_request: detachable AUT_REQUEST
			-- Request last received through `report_request'

	last_response: detachable AUT_RESPONSE
			-- Response last received through `report_response'

	variable_table: AUT_VARIABLE_TABLE
		-- Table that maps variables to their types

	system: SYSTEM_I
			-- system

feature -- Basic operations

	report_request (a_producer: AUT_PROXY_EVENT_PRODUCER; a_request: AUT_REQUEST)
			-- <Precursor>
		do
			if attached last_request as l_request then
				process_request (l_request)
			end
			last_request := a_request
		end

	report_response (a_producer: AUT_PROXY_EVENT_PRODUCER; a_response: AUT_RESPONSE)
			-- <Precursor>
		do
			last_response := a_response
			if attached last_request as l_request then
				process_request (l_request)
				last_request := Void
			else
				check response_without_request: False end
			end
			last_response := Void
		end

	cleanup
			-- Process last request still waiting for response if any.
		do
			if attached last_request as l_request then
				process_request (l_request)
			end
		end

feature {NONE} -- Basic operations

	process_request (a_request: AUT_REQUEST)
			-- Add response to given request and append it to `request_history'.
		do
			request_history.force_last (a_request)
			a_request.process (Current)
		end

feature {NONE} -- Implementation

	process_create_object_request (a_request: AUT_CREATE_OBJECT_REQUEST)
			-- <Precursor>
		local
			l_last_response: AUT_RESPONSE
			l_response_stream: KL_STRING_INPUT_STREAM
		do
			if a_request.response = Void then
				if attached last_response as l_response then
					l_last_response := l_response
					if l_last_response.is_normal and not l_last_response.is_exception then
						variable_table.define_variable (a_request.target, a_request.target_type)
					end
				else
					create {AUT_NORMAL_RESPONSE} l_last_response.make ("")
				end
				a_request.set_response (l_last_response)
			end
		end

	process_start_request (a_request: AUT_START_REQUEST)
			-- <Precursor>
		do
			check last_response = Void end
			a_request.set_response (create {AUT_NORMAL_RESPONSE}.make (""))
			variable_table.wipe_out
		end

	process_stop_request (a_request: AUT_STOP_REQUEST)
			-- <Precursor>
		local
			l_last_response: AUT_RESPONSE
		do
			if a_request.response = Void then
				if attached last_response as l_response then
					l_last_response := l_response
				else
					create {AUT_NORMAL_RESPONSE} l_last_response.make ("")
				end
				a_request.set_response (l_last_response)
			end
		end

	process_invoke_feature_request (a_request: AUT_INVOKE_FEATURE_REQUEST)
			-- <Precursor>
		local
			l_last_response: AUT_RESPONSE
			l_response_stream: KL_STRING_INPUT_STREAM
		do
			if a_request.target_type = Void then
				if variable_table.is_variable_defined (a_request.target) then
					a_request.set_target_type (variable_table.variable_type (a_request.target))
				end
			end
			if a_request.response = Void then
				if attached last_response as l_response then
					l_last_response := l_response
				else
					create {AUT_NORMAL_RESPONSE} l_last_response.make ("")
				end
				a_request.set_response (l_last_response)
			end
		end

	process_assign_expression_request (a_request: AUT_ASSIGN_EXPRESSION_REQUEST)
			-- <Precursor>
		local
			l_last_response: AUT_RESPONSE
			l_response_stream: KL_STRING_INPUT_STREAM
		do
			if a_request.response = Void then
				if attached last_response as l_response then
					l_last_response := l_response
				else
					create {AUT_NORMAL_RESPONSE} l_last_response.make ("")
				end
				a_request.set_response (l_last_response)
			end
		end

	process_type_request (a_request: AUT_TYPE_REQUEST)
			-- <Precursor>
		local
			l_last_response: AUT_RESPONSE
			l_response_stream: KL_STRING_INPUT_STREAM
		do
			if a_request.response = Void then
				if attached last_response as l_response then
					l_last_response := l_response
					if l_last_response.is_normal then
						if not l_last_response.is_exception then
							variable_table.define_variable (
								a_request.variable,
								base_type (l_last_response.text))
						end
					end
				else
					create {AUT_NORMAL_RESPONSE} l_last_response.make ("")
				end
				a_request.set_response (l_last_response)
			end
		end

invariant
	variable_table_not_void: variable_table /= Void
	request_history_not_void: request_history /= Void
	no_void_request_in_history: not request_history.has (Void)

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
