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
			analyze,
			generate_access,
			generate_on,
			parameters,
			propagate,
			register,
			set_register,
			set_source,
			unanalyze,
			generate_workbench_separate_call_args,
			generate_finalized_separate_call_args
		end

create
	make

feature -- Access

	register: REGISTRABLE
			-- Where value of TUPLE access is saved.

	parameters: detachable BYTE_LIST [PARAMETER_B]
			-- Arguments used for separate call.

feature -- Settings

	set_source (s: like source)
		do
			Precursor (s)
			create parameters.make (1)
			parameters.extend (s)
		end

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
			if attached source as s then
				if context_type.is_separate then
					s.set_is_for_tuple_access (False)
				end
				s.analyze
			end
		end

	unanalyze
			-- <Precursor>
		do
			if attached source as s then
				s.unanalyze
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
			if attached source as s then
				if context.workbench_mode or system.check_for_catcall_at_runtime then
					l_target_type := real_type (tuple_element_type)
					if l_target_type.c_type.is_reference then
						if context_type.is_separate then
							s.set_is_for_tuple_access (True)
							context.generate_tuple_catcall_check (a_register, s, position)
							s.set_is_for_tuple_access (False)
						else
							context.generate_tuple_catcall_check (a_register, s, position)
						end
					end
				end
					-- Make sure to call RTCV to verify that TUPLE is not Void.				
				buf.put_new_line
				real_type (tuple_element_type).c_type.generate_tuple_put (buffer)
				buf.put_character ('(')
				a_register.print_checked_target_register
				buf.put_character (',')
				buf.put_integer (position)
				buf.put_character (',')
				if context_type.is_separate and then attached s.register as r then
						-- Avoid printing argument register.
					r.print_register
				else
					s.print_register
				end
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
			t: TYPE_C
		do
			buf := buffer
			t := real_type (tuple_element_type).c_type
			if t.is_reference then
					-- It's possible that the actual item is of a basic type, it should be boxed before use then.
					-- The check that  TUPLE is not Void is included in "eif_boxed_item" macro, so RTCV is not generated.
				buf.put_string ("eif_boxed_item(")
				a_register.print_register
			else
					-- Make sure to call RTCV to verify that TUPLE is not Void.
				t.generate_tuple_item (buf)
				buf.put_character ('(')
				a_register.print_checked_target_register
			end
			buf.put_character (',')
			buf.put_integer (position)
			buf.put_character (')')
		end

feature {NONE} -- Separate call

	generate_workbench_separate_call_args
			-- <Precursor>
		local
			buf: like buffer
		do
			buf := buffer
			buf.put_character ('-')
			buf.put_integer (position)
		end

	generate_finalized_separate_call_args (a_target: REGISTRABLE; a_has_result: BOOLEAN)
			-- <Precursor>
		local
			buf: like buffer
		do
			buf := buffer

				-- Generate the feature name.
			buf.put_string ({C_CONST}.null)

				-- Generate the pattern.
			buf.put_two_character (',', ' ')
			system.separate_patterns.put_tuple_access (Current)

				-- Generate the offset.
			buf.put_two_character (',', ' ')
			buf.put_integer (position)
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
