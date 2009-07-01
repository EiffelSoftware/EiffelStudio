note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_LOAD_CALLBACKS

inherit
	XM_STATE_LOAD_CALLBACKS
		redefine
			initialize,
			reset
		end

create
	make

feature {NONE} -- Initialization

	initialize
			-- <Precursor>
		do
			create currrent_parameters.make_default
			create current_value_stack.make_default
		end

feature -- Access

	frozen parameters: DS_LINEAR [XRPC_VALUE]
			-- List of parameters, if any.
		require
			not_has_error: not has_error
			has_parameters: has_parameters
		do
			Result := currrent_parameters
		ensure
			result_attached: attached Result
		end

	frozen value: XRPC_VALUE
		require
			not_has_error: not has_error
			not_has_parameters: not has_parameters
		do
			Result := current_value
		ensure
			result_attached: attached Result
		end

feature {NONE} -- Access

	frozen currrent_parameters: DS_ARRAYED_LIST [XRPC_VALUE]
			-- Mutable list of parameter values.

	frozen current_value: XRPC_VALUE
			-- Current value, for complex values.
		require
			not_current_transition_stack_is_empty: not current_value_stack.is_empty
		local
			l_result: detachable XRPC_VALUE
		do
			l_result := current_value_stack.item
			check l_result_attached: attached l_result end
			Result := l_result
		ensure
			result_attached: attached Result
		end

	current_value_stack: DS_LINKED_STACK [XRPC_VALUE]
			-- Stack of processed values, allowing for a object tree to be created for complex types.

feature -- Status report

	has_parameters: BOOLEAN
			-- Indicates if there are parameters

feature {NONE} -- Status report

	is_strict: BOOLEAN = True
			-- <Precursor>

feature {NONE} -- Basic operations

	reset
			-- <Precursor>
		do
			current_value_stack.wipe_out
			currrent_parameters.wipe_out
			has_parameters := False
			Precursor
		ensure then
			not_has_parameters: not has_parameters
			current_value_stack_is_empty: current_value_stack.is_empty
			currrent_parameters_is_empyt: currrent_parameters.is_empty
		end

feature {NONE} -- Process

	process_tag_state (a_state: NATURAL_8)
			-- <Precursor>
		do
			inspect a_state
			when t_array then
					-- Create a new (mutable - as it needs items) array.
				process_value (create {XRPC_MUTABLE_ARRAY}.make_empty)
			when t_params then
					-- There is a parameter list.
				has_parameters := True
			when t_param then
					-- Just for sanity!
				check has_parameters: has_parameters end
			when t_struct then
					-- Extend the new item on the stack.
				check unsupported: False end
			else

			end
		end

	process_end_tag_state (a_state: NATURAL_8)
			-- <Precursor>
		local
			l_value: detachable XRPC_VALUE
		do
			inspect a_state
			when t_base64 then
				check unsupported: False end
			when t_boolean then
				create {XRPC_BOOLEAN} l_value.make_from_string (current_content)
				process_value (l_value)
			when t_date_time then
				check unsupported: False end
			when t_double then
				create {XRPC_DOUBLE} l_value.make_from_string (current_content)
				process_value (l_value)
			when t_i4 then
				create {XRPC_INTEGER} l_value.make_from_string (current_content)
				process_value (l_value)
			when t_string then
				create {XRPC_STRING} l_value.make_from_string (current_content)
				process_value (l_value)
			when t_array, t_struct then
					-- Pop the stack
				if current_value_stack.count > 1 then
						-- Not at the root (parameter) level so popping is ok.
					current_value_stack.remove
				end
			when t_param then
					-- End of parameter, add to list
				check has_single_value_only: current_value_stack.count = 1 end
				currrent_parameters.force_last (current_value)

					-- Pop the stack
				current_value_stack.remove
			else

			end
		end

	process_value (a_value: XRPC_VALUE)
			-- Processes a new value.
			--
			-- `a_value': The new value to process.
		require
			a_value_attached: attached a_value
			can_continue_parsing: can_continue_parsing
		local
			l_current_value: like current_value
		do
			if a_value.is_complex or current_value_stack.is_empty then
					-- Put a complex type on the stack or any value if it's empty.
					-- This is so when </param> is matched the value can be popped
					-- and added as a parameter.
				current_value_stack.put (a_value)
			else
				l_current_value := current_value
				if attached {XRPC_MUTABLE_ARRAY} l_current_value as l_array then
						-- Add the newly generated item to the array
					l_array.extend (a_value)
				elseif attached {XRPC_STRUCT} l_current_value as l_struct then
						-- Add the newly generated item to the struct
					check unsupported: False end
				else
					check unknown_type: False end
				end
			end
		end

feature {NONE} -- State transistions

	new_tag_state_transitions: DS_HASH_TABLE [DS_HASH_TABLE [NATURAL_8, STRING], NATURAL_8]
			-- <Precursor>
		local
			l_table: DS_HASH_TABLE [NATURAL_8, STRING]
		do
			create Result.make (8)

			create l_table.make (2)
			l_table.put (t_params, {XRPC_CONSTANTS}.params_name)
			l_table.put (t_value, {XRPC_CONSTANTS}.value_name)
			Result.put_last (l_table, t_none)

				-- params
				-- => param
			create l_table.make (1)
			l_table.put (t_param, {XRPC_CONSTANTS}.param_name)
			Result.put_last (l_table, t_params)

				-- param
				-- => value
			create l_table.make (1)
			l_table.put (t_value, {XRPC_CONSTANTS}.value_name)
			Result.put_last (l_table, t_param)

				-- value
				-- => array
				-- => boolean
				-- => base64
				-- => dateTime.iso8601
				-- => double
				-- => i4
				-- => int
				-- => string
				-- => struct
			create l_table.make (9)
			l_table.put (t_array, {XRPC_CONSTANTS}.array_name)
			l_table.put (t_boolean, {XRPC_CONSTANTS}.boolean_name)
			l_table.put (t_base64, {XRPC_CONSTANTS}.base64_name)
			l_table.put (t_date_time, {XRPC_CONSTANTS}.date_time_iso_name)
			l_table.put (t_double, {XRPC_CONSTANTS}.double_name)
			l_table.put (t_i4, {XRPC_CONSTANTS}.i4_name)
			l_table.put (t_int, {XRPC_CONSTANTS}.int_name)
			l_table.put (t_string, {XRPC_CONSTANTS}.string_name)
			l_table.put (t_struct, {XRPC_CONSTANTS}.struct_name)
			Result.put_last (l_table, t_value)

				-- array
				-- => data
			create l_table.make (1)
			l_table.put (t_data, {XRPC_CONSTANTS}.data_name)
			Result.put_last (l_table, t_array)

				-- data
				-- => value
			create l_table.make (1)
			l_table.put (t_value, {XRPC_CONSTANTS}.value_name)
			Result.put_last (l_table, t_data)

				-- struct
				-- => member
			create l_table.make (1)
			l_table.put (t_member, {XRPC_CONSTANTS}.member_name)
			Result.put_last (l_table, t_struct)

				-- member
				-- => name
				-- => value
			create l_table.make (2)
			l_table.put (t_name, {XRPC_CONSTANTS}.name_name)
			l_table.put (t_value, {XRPC_CONSTANTS}.value_name)
			Result.put_last (l_table, t_member)
		end

	new_attribute_states: detachable DS_HASH_TABLE [DS_HASH_TABLE [NATURAL_8, STRING], NATURAL_8]
			-- <Precursor>
		do
		end

feature {NONE} -- Constants: States

	t_array: NATURAL_8 = 0x1
	t_base64: NATURAL_8 = 0x2
	t_boolean: NATURAL_8 = 0x3
	t_data: NATURAL_8 = 0x4
	t_date_time: NATURAL_8 = 0x5
	t_double: NATURAL_8 = 0x6
	t_i4: NATURAL_8 = 0x8
	t_int: NATURAL_8 = 0x8
	t_member: NATURAL_8 = 0x9
	t_name: NATURAL_8 = 0xA
	t_param: NATURAL_8 = 0xB
	t_params: NATURAL_8 = 0xC
	t_string: NATURAL_8 = 0xD
	t_struct: NATURAL_8 = 0xE
	t_value: NATURAL_8 = 0xF

invariant
	current_value_stack_attached: attached current_value_stack
	currrent_parameters_attached: attached currrent_parameters
	t_i4_and_t_int_synonymous: t_i4 = t_int

;note
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
