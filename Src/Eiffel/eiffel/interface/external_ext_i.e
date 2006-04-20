indexing

	description: "Encapsulation of an external extension."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
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
		
	SHARED_GENERATION
		export
			{NONE} all
		undefine
			is_equal
		end		

feature -- Status report

	is_il: BOOLEAN is
			-- Is current external an IL one?
		do
		end
		
	is_cpp: BOOLEAN is
		do
		end

	is_macro: BOOLEAN is
		do
		end

	is_dll: BOOLEAN is
		do
		end

	is_struct: BOOLEAN is
		do
		end

	is_inline: BOOLEAN is
			-- Is current external an inlined one?
		do
		end

	has_signature: BOOLEAN is
		do
			Result := has_arg_list or has_return_type
		end

	has_arg_list: BOOLEAN is
		do
			Result := argument_types /= Void
		end

	has_return_type: BOOLEAN is
		do
			Result := return_type > 0
		end

	has_include_list: BOOLEAN is
		do
			Result := header_files /= Void
		end

	need_encapsulation: BOOLEAN is
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

feature -- Convenience

	alias_name: STRING is
			-- Associated name to `alias_name_id'.
		do
			Result := Names_heap.item (alias_name_id)
		end

feature -- Settings

	set_argument_types (a: like argument_types) is
			-- Assign `a' to `argument_types'.
		do
			argument_types := a
		ensure
			argument_types_set: argument_types = a
		end

	set_header_files (h: like header_files) is
			-- Assign `h' to `header_files'.
		do
			header_files := h
		ensure
			header_files_set: header_files = h
		end

	set_return_type (r: like return_type) is
			-- Assign `r' to `return_type'.
		do
			return_type := r
		ensure
			return_type_set: return_type = r
		end

	set_alias_name_id (name_id: like alias_name_id) is
			-- Set `alias_name_id' with `name_id'.
		require
			valid_name_id: name_id > 0
		do
			alias_name_id := name_id
		ensure
			alias_name_id_set: alias_name_id = name_id
		end

	set_is_blocking_call (v: like is_blocking_call) is
			-- Assign `v' to `is_blocking_call'.
		do
			is_blocking_call := v
		ensure
			is_blocking_call_set: is_blocking_call = v
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			Result := same_type (other) and then
				return_type = other.return_type and then
				array_is_equal (argument_types, other.argument_types) and then
				array_is_equal (header_files, other.header_files)
		end

feature {NONE} -- Comparison

	array_is_equal (a, o_a: ARRAY [INTEGER]): BOOLEAN is
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
						Result := a.item (i) =  o_a.item (i)
						i := i + 1
					end
				end
			end
		end

feature -- Code generation

	generate_header_files is
			-- Generate header files for the extension.
		local
			i, nb: INTEGER
			queue: like shared_include_queue
		do
			if has_include_list then
				from
					i := header_files.lower
					nb := header_files.upper
					queue := shared_include_queue
				until
					i > nb
				loop
					queue.put (header_files @ i)
					i := i + 1
				end
			end
		end

	generate_body (a_byte_code: EXT_BYTE_CODE; a_result: RESULT_B) is
			-- Generate body of current externals with assignement to `a_result'.
		require
			a_byte_code_not_void: a_byte_code /= Void
			a_result_valid: not a_byte_code.result_type.is_void implies a_result /= Void
		deferred
		end

	generate_parameter_list (parameters: BYTE_LIST [EXPR_B]; nb: INTEGER) is
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
					if has_cast then
						buffer.put_character ('(')
						buffer.put_string (l_names_heap.item (arg_types.item (j)))
						buffer.put_character (')')
						buffer.put_character (' ')
						j := j + 1
					end
					generate_i_th_parameter (parameters, i)
					i := i + 1
					if i <= nb then
						buffer.put_string (gc_comma)
					end
				end
			end
		end

	generate_i_th_parameter (parameters: BYTE_LIST [EXPR_B]; i: INTEGER) is
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

end -- class EXTERNAL_EXT_I
