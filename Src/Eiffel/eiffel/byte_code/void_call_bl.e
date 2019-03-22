note
	description: "A finalized node for a call on void target."

class VOID_CALL_BL

inherit
	FEATURE_BL
		rename
			fill_from as make
		undefine
			has_one_signature,
			is_polymorphic
		redefine
			analyze_on,
			generate_end
		end

create
	make

feature -- Status report

	has_one_signature: BOOLEAN = True
			-- <Precursor>

	is_polymorphic: BOOLEAN = False
			-- <Precursor>

feature -- C code generation

	analyze_on (r: REGISTRABLE)
			-- <Precursor>
		do
			if attached parameters as arguments then
					-- Avoid using temporary registers for arguments.
				across
					arguments as a
				loop
					a.item.propagate (No_register)
				end
				arguments.analyze
				free_param_registers
			end
		end

	generate_end (gen_reg: REGISTRABLE; class_type: CL_TYPE_A)
			-- Generate final portion of C code.
		local
			buf: like buffer
			l_type_c: TYPE_C
		do
			buf := buffer
			buf.put_string ({C_CONST}.open_rtna_open)
				-- Generate arguments to take into account any side effects they can produce.
			generate_arguments (gen_reg, True)
			buf.put_character (')')
			l_type_c := real_type (type).c_type
				-- Generate a default value to make code compilable.
			if not l_type_c.is_void then
				buf.put_two_character (',', ' ')
				l_type_c.generate_default_value (buf)
			end
			buf.put_character (')')
		end

note
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
