note
	description: "Tuple access for C code generation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TUPLE_ACCESS_BL

inherit
	TUPLE_ACCESS_B
		redefine
			register, set_register,
			analyze, unanalyze, propagate,
			generate_on, generate_access
		end

create
	make

feature -- Access

	register: REGISTRABLE
			-- Where value of TUPLE access is saved.

feature -- Settings

	set_register (r: REGISTRABLE)
			-- <Precursor>
		do
			register := r
		ensure then
			register_set: register = r
		end

feature -- C Code generation

	analyze
			-- Analyze current byte code.
		do
			if source /= Void then
				source.analyze
			end
		end

	unanalyze
			-- <Precursor>
		do
			if source /= Void then
				source.unanalyze
			end
			set_register (Void)
		end

	propagate (r: REGISTRABLE)
			-- Propagate `r'
		do
			if not context.propagated then
				if r = No_register or r.c_type.same_class_type (c_type) then
					register := r
					context.set_propagated
				end
			end
		end

	generate_on (a_register: REGISTRABLE)
			-- Generate C code for access.
		local
			buf: like buffer
			l_target_type: TYPE_A
		do
			buf := buffer
			if source /= Void then
				generate_line_info
				generate_frozen_debugger_hook
				source.generate
				if context.workbench_mode or system.check_for_catcall_at_runtime then
					l_target_type := real_type (tuple_element_type)
					if l_target_type.c_type.is_pointer then
						context.generate_catcall_check (source, l_target_type, position, False)
					end
				end
					-- Make sure to call RTCV to verify that TUPLE is not Void.				
				buf.put_new_line
				buf.put_string (once "eif_put_")
				buf.put_string (tuple_element_name)
				buf.put_string ("_item(RTCV(")
				a_register.print_register
				buf.put_two_character (')', ',')
				buf.put_integer (position)
				buf.put_character (',')
				source.print_register
				buf.put_character (')')
			else
				generate_internal (a_register)
			end
		end

	generate_access
		do
			generate_internal (current_register)
		end

	generate_internal (a_register: REGISTRABLE)
		local
			buf: like buffer
		do
			buf := buffer
			if real_type (tuple_element_type).c_type.is_pointer then
					-- It's possible that the actual item is of a basic type, it should be boxed before use then.
					-- The check that  TUPLE is not Void is included in "eif_boxed_item" macro, so RTCV is not generated.
				buf.put_string ("eif_boxed_item(")
				a_register.print_register
			else
					-- Make sure to call RTCV to verify that TUPLE is not Void.
				buf.put_string (once "eif_")
				buf.put_string (tuple_element_name)
				buf.put_string ("_item(RTCV(")
				a_register.print_register
				buf.put_character (')')
			end
			buf.put_character (',')
			buf.put_integer (position)
			buf.put_character (')')
		end

	tuple_element_name: STRING
			-- String representation of TUPLE element type.
		do
			inspect
				real_type (tuple_element_type).c_type.sk_value
			when {SK_CONST}.sk_bool then Result := once "boolean"
			when {SK_CONST}.sk_char then Result := once "character_8"
			when {SK_CONST}.sk_wchar then Result := once "character_32"
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

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
