indexing
	description: "Ancestor for basic types."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class BASIC_I

inherit
	CL_TYPE_I
		rename
			instantiated_description as description,
			reference_type as true_reference_type
		undefine
			description, type_a
		redefine
			is_basic, is_reference, c_type, is_consistent,
			generate_cecil_value, generic_il_type_name,
			true_reference_type, internal_generic_derivation
		end

	TYPE_C
		undefine
			is_bit, is_void, is_equal
		redefine
			generate_conversion_to_real_64,
			generate_conversion_to_real_32
		end

	SHARED_C_LEVEL
		undefine
			is_equal
		end

	BYTE_CONST
		undefine
			is_equal
		end

	SHARED_TYPES
		rename
			none_type as none_type_a
		export
			{NONE} all
		undefine
			is_equal
		end

feature -- Access

	c_type: TYPE_C is
			-- C type
		do
			Result := Current
		end

	reference_type: CL_TYPE_I is
			-- Assocated reference type of Current.
		deferred
		ensure
			reference_type_not_void: Result /= Void
		end

	true_reference_type: CL_TYPE_I is
			-- Corresponding reference type
		do
			create Result.make (class_id)
			if cr_info /= Void then
				Result.set_cr_info (cr_info)
			end
			Result.set_reference_mark
		end

	internal_generic_derivation (a_level: INTEGER): CL_TYPE_I is
			-- Precise generic derivation of current type.
			-- That is to say given a type, it gives the associated TYPE_I
			-- which can be used to search its associated CLASS_TYPE.
		do
			if a_level = 0 then
				create Result.make (class_id)
			else
				Result := Precursor (a_level)
			end
		end

	associated_reference_class_type: CLASS_TYPE is
			-- Reference class type of Current
		do
			Result := reference_type.associated_class_type
		ensure
			associated_reference_class_type_not_void: Result /= Void
		end

	generic_il_type_name: STRING is
			-- Associated name to for naming in generic derivation.
		do
			Result := base_class.name.twin
		end

feature -- Status report

	is_reference: BOOLEAN is False
			-- Type is not a reference.

	is_basic: BOOLEAN is True
			-- Type is a basic type.

	is_consistent: BOOLEAN is
			-- A Basic type is always in the system
		do
				-- Not a constant as TYPED_POINTER_I is using the version from GEN_TYPE_I
			Result := True
		end

feature -- Byte code generation

	metamorphose
		(reg, value: REGISTRABLE; buffer: GENERATION_BUFFER) is
			-- Generate the metamorphism from simple type to reference and
			-- put result in register `reg'. The value of the basic type is
			-- held in `value'.
		require
			valid_reg: reg /= Void
			valid_value: value /= Void
			valid_file: buffer /= Void
		local
			c: CREATE_TYPE
			buf: like buffer
			g: GEN_TYPE_I
		do
			buf := buffer
			create c.make (Current)
			if true_generics /= Void then
				g ?= Current
				buf.put_new_line
				buf.put_character ('{')
				buf.indent
				system.byte_context.generate_gen_type_conversion (g)
			end
			buf.put_new_line
			reg.print_register
			buf.put_string (" = ")
			c.generate
			buf.put_character (';')
			if true_generics /= Void then
				buf.exdent
				buf.put_new_line
				buf.put_character ('}')
			end
			buf.put_new_line
			buf.put_character ('*')
			generate_access_cast (buffer)
			reg.print_register
			buf.put_string (" = ")
			value.print_register
		end

feature -- C code generation

	generate_cecil_value (buffer: GENERATION_BUFFER) is
			-- Generate cecil value
		do
			generate_sk_value (buffer)
		end

	generate_default_value (buffer : GENERATION_BUFFER) is
			-- Generate default value associated to current basic type.
		require
			valid_buffer: buffer /= Void
		do
			buffer.put_character ('(')
			generate_cast (buffer)
			buffer.put_string ("0)")
		end

	make_default_byte_code (ba: BYTE_ARRAY) is
			-- Generate default value of basic type on stack.
		require
			valid_array: ba /= Void
		deferred
		end

	generate_conversion_to_real_64 (buffer: GENERATION_BUFFER) is
			-- Generate conversion to `REAL_64', needed because
			-- for some descendants, it is not enough to just to a cast to EIF_REAL_64.
		do
			buffer.put_string ("(EIF_REAL_64) (")
		end

	generate_conversion_to_real_32 (buffer: GENERATION_BUFFER) is
			-- Generate conversion to `REAL_32', needed because
			-- for some descendants, it is not enough to just to a cast to EIF_REAL_32.
		do
			buffer.put_string ("(EIF_REAL_32) (")
		end

invariant
	is_basic: is_basic
	is_expanded: is_expanded

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
