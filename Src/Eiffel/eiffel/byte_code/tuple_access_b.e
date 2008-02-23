indexing
	description: "Tuple access."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TUPLE_ACCESS_B

inherit
	ACCESS_B
		redefine
			read_only, assign_code, expanded_assign_code,
			is_fast_as_local, is_predefined,
			calls_special_features, is_unsafe, optimized_byte_node,
			size, pre_inlined_code, inlined_byte_code,
			analyze, generate_on, generate_access, enlarged,
			line_number, set_line_number
		end

	SHARED_TYPES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_tuple_type: like tuple_type; a_pos: like position) is
			-- New tuple access at position `a_pos' whose type is `a_type'.
		require
			a_tuple_type_not_void: a_tuple_type /= Void
			a_pos_positive: a_pos > 0
		do
			tuple_type := a_tuple_type
			position := a_pos
		ensure
			tuple_type_set: tuple_type = a_tuple_type
			position_set: position = a_pos
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_tuple_access_b (Current)
		end

feature -- Access

	read_only: BOOLEAN is False
			-- Is Result a read-only entity ?

	type: TYPE_A is
			-- Type of current tuple access.
		do
			if source /= Void then
				Result := void_type
			else
				Result := tuple_element_type
			end
		end

	tuple_type: TUPLE_TYPE_A
			-- Type of tuple on which access is done.

	tuple_element_type: TYPE_A is
			-- Type of element of tuple we are accessing.
		do
			Result := context.real_type (tuple_type.generics.item (position))
		end

	position: INTEGER
			-- Position in tuple we are accessing.

	is_predefined: BOOLEAN is True
			-- Predefined as results is store in a register.

	source: EXPR_B
			-- If Current is used for assignment into a tuple, then `source'
			-- is the source of the assignment.

	line_number: INTEGER
			-- Line number where construct begins in the Eiffel source.

feature -- Settings

	set_line_number (lnr : INTEGER) is
			-- Assign `lnr' to `line_number'.
		do
			line_number := lnr
		ensure then
			line_number_set: line_number = lnr
		end

	set_source (a_expr: like source) is
			-- Assign `a_expr' to `source'.
		require
			a_expr_not_void: a_expr /= Void
		do
			source := a_expr
		ensure
			source_set: source = a_expr
		end

feature -- Comparison

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			l_other: like Current
		do
			l_other ?= other
			Result := l_other /= Void
		end

feature -- IL code generation

	is_fast_as_local: BOOLEAN is True
			-- Is expression calculation as fast as loading a local?
			-- (This is not true for once functions, but there is not enough information to figure it out.)

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			if source /= Void then
				Result := source.calls_special_features (array_desc)
			end
		end

	is_unsafe: BOOLEAN is
		do
			if source /= Void then
				Result := source.is_unsafe
			end
		end

	optimized_byte_node: like Current is
		do
			Result := Current
			if source /= Void then
				source := source.optimized_byte_node
			end
		end

feature -- Byte code generation

	assign_code: CHARACTER is
			-- Assignment code
		once
			Result := {BYTE_CONST}.bc_rassign
		end

	expanded_assign_code: CHARACTER is
			-- Expanded assignment code
		once
			Result := {BYTE_CONST}.bc_rexp_assign
		end

feature -- Inlining

	size: INTEGER is
		do
			if source /= Void then
				Result := 1 + source.size
			else
				Result := 1
			end
		end

	pre_inlined_code: like Current is
		do
			Result := Current
			if source /= Void then
				source := source.pre_inlined_code
			end
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			if source /= Void then
				source := source.inlined_byte_code
			end
		end

feature -- C Code generation

	analyze is
			-- Analyze current byte code.
		do
			if source /= Void then
				source.analyze
			end
		end

	generate_on (a_register: REGISTRABLE) is
			-- Generate C code for access.
		local
			buf: like buffer
		do
			buf := buffer
			if source /= Void then
				generate_line_info
				generate_frozen_debugger_hook
				source.generate
				buf.put_string (once "eif_put_")
				buf.put_string (tuple_element_name)
				buf.put_string ("_item(")
				a_register.print_register
				buf.put_character (',')
				buf.put_integer (position)
				buf.put_character (',')
				source.print_register
				buf.put_character (')')
			else
				generate_internal (a_register)
			end
			buf.put_character (';')
			buf.put_new_line
		end

	generate_access is
		local
		do
			generate_internal (current_register)
		end

	generate_internal (a_register: REGISTRABLE) is
		local
			buf: like buffer
		do
			buf := buffer
			buf.put_string (once "eif_")
			buf.put_string (tuple_element_name)
			buf.put_string ("_item(")
			a_register.print_register
			buf.put_character (',')
			buf.put_integer (position)
			buf.put_character (')')
		end

	tuple_element_name: STRING is
			-- String representation of TUPLE element type.
		do
			inspect
				tuple_element_type.c_type.sk_value
			when {SK_CONST}.sk_bool then Result := once "boolean"
			when {SK_CONST}.sk_char then Result := once "character"
			when {SK_CONST}.sk_wchar then Result := once "wide_character"
			when {SK_CONST}.sk_real32 then Result := once "real_32"
			when {SK_CONST}.sk_real64 then Result := once "real_64"
			when {SK_CONST}.sk_uint8 then Result := once "natural_8"
			when {SK_CONST}.sk_uint16 then Result := once "natural_16"
			when {SK_CONST}.sk_uint32 then Result := once "natural_32"
			when {SK_CONST}.sk_uint64 then Result := once "natural_64"
			when {SK_CONST}.sk_int8 then Result := once "integer_8"
			when {SK_CONST}.sk_int16 then Result := once "integer_16"
			when {SK_CONST}.sk_int32 then Result := once "integer_32"
			when {SK_CONST}.sk_int64 then Result := once "integer_64"
			when {SK_CONST}.sk_pointer then Result := once "pointer"
			else
				Result := once "reference"
			end
		ensure
			tuple_element_name_not_void: Result /= Void
		end

	enlarged: like Current is
			-- Enlarges current.
		do
			Result := Current
			if source /= Void then
				source := source.enlarged
			end
		end

invariant
	tuple_type_not_void: tuple_type /= Void
	position_positive: position > 0

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

end
