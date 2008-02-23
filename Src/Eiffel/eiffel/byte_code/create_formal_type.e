indexing
	description: "Creation of a formal generic parameter."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_FORMAL_TYPE

inherit
	CREATE_TYPE
		redefine
			generate, generate_type_id, generate_gen_type_conversion,
			generate_cid, type_to_create, make_byte_code,
			analyze, generate_il, type, is_explicit
		end

create
	make

feature -- Access

	type: FORMAL_A
			-- Current type of creation.

feature -- C code generation

	analyze is
		do
				-- Current is always used to generate the correct generic parameter.
			context.mark_current_used
		end

	generate is
			-- Generate creation type
		local
			buffer: GENERATION_BUFFER
		do
			buffer := context.buffer
			buffer.put_string ("RTLNSMART(")
			generate_type_id (buffer, context.final_mode, 0)
			buffer.put_character (')')
		end

	generate_type_id (buffer: GENERATION_BUFFER; final_mode : BOOLEAN; a_level: NATURAL) is
			-- Generate formal creation type id
		do
			buffer.put_string ("RTGPTID(")
			buffer.put_integer (context.context_class_type.type.generated_id (final_mode, Void))
			buffer.put_character (',')
			context.current_register.print_register
			buffer.put_character (',')
			buffer.put_integer (type.position)
			buffer.put_character (')')
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for a formal creation type.
		local
			formal: FORMAL_A
			target_type: TYPE_A
		do
				-- Compute actual type of Current formal.
			formal ?= type
			formal.generate_gen_type_il (il_generator, True)

				-- Evaluate the type and create a corresponding object type.
			il_generator.generate_current_as_reference
			il_generator.create_type

			target_type := context.real_type (formal)
			if target_type.is_expanded then
					-- Load value of a value type object.
				il_generator.generate_unmetamorphose (target_type)
			end
			il_generator.generate_check_cast (Void, target_type)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a formal creation type.
		do
			ba.append (Bc_gen_param_create)
			ba.append_short_integer (context.context_class_type.type.generated_id (False, Void))
			ba.append_integer (type.position)
		end

feature -- Generic conformance

	is_explicit: BOOLEAN is
			-- Is Current type fixed at compile time?
		do
			Result := False
		end

	generate_gen_type_conversion (a_level: NATURAL) is
		do
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode : BOOLEAN) is
		do
				-- If we are here, it means that it is known that the type cannot have
				-- sublevel, thus the value of `0'. This is usually the case when describing
				-- an attribute type in eskelet.c
			generate_type_id (buffer, final_mode, 0)
			buffer.put_character (',')
		end

	type_to_create : CL_TYPE_A is
		do
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

end -- class CREATE_FORMAL_TYPE
