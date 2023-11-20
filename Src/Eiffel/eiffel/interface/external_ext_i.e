note

	description: "Encapsulation of an external extension."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class EXTERNAL_EXT_I

inherit
	SHARED_INCLUDE
		export
			{NONE} Shared_include_queue
		redefine
			is_equal
		end

	SHARED_DECLARATIONS
		export
			{NONE} all
		redefine
			is_equal
		end

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
			{ANY} context
		redefine
			is_equal
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		redefine
			is_equal
		end

	INTERNAL_COMPILER_STRING_EXPORTER
		undefine
			is_equal
		end

feature -- Status report

	is_il: BOOLEAN
			-- Is current external an IL one?
		do
		end

	is_cpp: BOOLEAN
		do
		end

	is_macro: BOOLEAN
		do
		end

	is_dll: BOOLEAN
		do
		end

	is_struct: BOOLEAN
		do
		end

	is_inline: BOOLEAN
			-- Is current external an inlined one?
		do
		end

	is_built_in: BOOLEAN
			-- Is current external a built_in one?
		do
		end

	is_static: BOOLEAN
			-- Is current external callable statically, i.e. no need for current object?
		do
				-- Always true except for non-static built_in.
			Result := True
		end

	has_signature: BOOLEAN
		do
			Result := has_arg_list or has_return_type
		end

	has_arg_list: BOOLEAN
		do
			Result := argument_types /= Void
		end

	has_return_type: BOOLEAN
		do
			Result := return_type > 0
		end

	has_include_list: BOOLEAN
		do
			Result := header_files /= Void
		end

	need_encapsulation: BOOLEAN
			-- Does current external need to be accessed through its encapsulation.
		do
			Result := is_blocking_call and System.has_multithreaded
		end

feature -- Properties

	argument_types: ARRAY [INTEGER]
			-- Argument types. Values are indexes in NAMES_HEAP.

	return_type: INTEGER
			-- Return type index in NAMES_HEAP

	header_files: ARRAY [INTEGER]
			-- Header files. Values are indexes in NAMES_HEAP.

	alias_name_id: INTEGER
			-- Real name index in NAMES_HEAP of external feature

	is_blocking_call: BOOLEAN
			-- May current external call block execution? If so, in multithreaded
			-- mode we need to ensure that GC will not be blocked waiting for the
			-- blocking call to resume.

feature -- Properties / generic method

	is_generic_method: BOOLEAN
			-- Is Current associated with a generic method?
			-- FIXME: also keep the type information to generate the expected MethodSpec info
			-- when calling a generic method.

	generic_method_parameters_info: detachable CONSUMED_GENERIC_PARAMETERS_INFO
			-- Signature parameters types for the generic method.

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Convenience

	alias_name: STRING
			-- Associated name to `alias_name_id'.
		do
			Result := Names_heap.item (alias_name_id)
		end

feature -- Settings

	set_argument_types (a: like argument_types)
			-- Assign `a' to `argument_types'.
		do
			argument_types := a
		ensure
			argument_types_set: argument_types = a
		end

	set_header_files (h: like header_files)
			-- Assign `h' to `header_files'.
		do
			header_files := h
		ensure
			header_files_set: header_files = h
		end

	set_return_type (r: like return_type)
			-- Assign `r' to `return_type'.
		do
			return_type := r
		ensure
			return_type_set: return_type = r
		end

	set_alias_name_id (name_id: like alias_name_id)
			-- Set `alias_name_id' with `name_id'.
		require
			valid_name_id: name_id > 0
		do
			alias_name_id := name_id
		ensure
			alias_name_id_set: alias_name_id = name_id
		end

	set_is_blocking_call (v: like is_blocking_call)
			-- Assign `v' to `is_blocking_call'.
		do
			is_blocking_call := v
		ensure
			is_blocking_call_set: is_blocking_call = v
		end

	set_is_generic_method (v: like is_generic_method; args: like generic_method_parameters_info)
			-- Assign `v` to `is_generic_method`
		do
			is_generic_method := v
			generic_method_parameters_info := args
		ensure
			is_generic_method_set: is_generic_method = v
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
		do
			Result := same_type (other) and then same_as (other)
		end

	same_as (other: like Current): BOOLEAN
			-- Is Current the same as `other'?
		do
			Result := (return_type = other.return_type and
					array_is_equal (argument_types, other.argument_types) and
					array_is_equal (header_files, other.header_files) and
					is_blocking_call = other.is_blocking_call and
					alias_name_id = other.alias_name_id and
					is_static = other.is_static and
					is_cpp = other.is_cpp)
		end

feature {NONE} -- Comparison

	array_is_equal (a, o_a: ARRAY [INTEGER]): BOOLEAN
			-- Is `o_a' considered equal to `a'?
		local
			i, nb: INTEGER
		do
			if a = Void then
				Result := o_a = Void
			elseif o_a /= Void then
				nb := a.count
				if o_a.count = nb then
					from
						Result := True
						i := 1
					until
						not Result or else i > nb
					loop
						Result := a.item (i) = o_a.item (i)
						i := i + 1
					end
				end
			end
		end

	special_is_equal (a, o_a: SPECIAL [INTEGER]): BOOLEAN
			-- Is `o_a' considered equal to `a'?
		local
			i, nb: INTEGER
		do
			if a = Void then
				Result := o_a = Void
			elseif o_a /= Void then
				nb := a.count
				if o_a.count = nb then
					from
						Result := True
						i := 0
					until
						not Result or else i >= nb
					loop
						Result := a.item (i) = o_a.item (i)
						i := i + 1
					end
				end
			end
		end

feature -- Code generation

	generate_header_files
			-- Generate header files for the extension.
		local
			i, nb: INTEGER
			l_list: INCLUDE_LIST
		do
			if has_include_list then
				from
					i := header_files.lower
					nb := header_files.upper
					l_list := shared_include_queue_list
				until
					i > nb
				loop
					l_list.extend (header_files [i])
					i := i + 1
				end
				shared_include_queue.put (l_list)
			end
		end

	generate_body (a_byte_code: EXT_BYTE_CODE; a_result: RESULT_B)
			-- Generate body of current externals with assignement to `a_result'.
		require
			a_byte_code_not_void: a_byte_code /= Void
			a_result_valid: not a_byte_code.result_type.is_void implies a_result /= Void
		deferred
		end

	generate_parameter_list (parameters: BYTE_LIST [EXPR_B]; nb: INTEGER; a_protect_argument_for_macros: BOOLEAN)
			-- Generate parameters for C extension call. Does not include opening
			-- and closing paranthesis.
		require
			parameters_valid: parameters /= Void implies parameters.count = nb
		local
			i, j: INTEGER
			has_cast: BOOLEAN
			arg_types: like argument_types
			buffer: GENERATION_BUFFER
			l_names_heap: like Names_heap
		do
			if parameters /= Void or nb > 0 then
				from
					buffer := Context.buffer
					if has_arg_list then
						has_cast := True
						arg_types := argument_types
						l_names_heap := Names_heap
						j := arg_types.lower
					end
					i := 1
				until
					i > nb
				loop
					if a_protect_argument_for_macros then
						buffer.put_character ('(')
					end
					if has_cast then
						buffer.put_character ('(')
						buffer.put_string (l_names_heap.item (arg_types.item (j)))
						buffer.put_character (')')
						buffer.put_character (' ')
						j := j + 1
					end
					generate_i_th_parameter (parameters, i)
					if a_protect_argument_for_macros then
						buffer.put_character (')')
					end
					i := i + 1
					if i <= nb then
						buffer.put_string ({C_CONST}.comma_space)
					end
				end
			end
		end

	generate_i_th_parameter (parameters: BYTE_LIST [EXPR_B]; i: INTEGER)
			-- Print associated register to `i'-th parameter of `parameters' if not Void,
			-- otherwise print `arg' appended by value of `i'.
		require
			i_positive: i > 0
		local
			l_buffer: GENERATION_BUFFER
		do
			if parameters /= Void then
				parameters.i_th (i).print_register
			else
				l_buffer := Context.buffer
				if context.is_argument_protected then
					l_buffer.put_character ('l')
				end
				l_buffer.put_string ("arg")
				l_buffer.put_integer (i)
			end
		end

note
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
