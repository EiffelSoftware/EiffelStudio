indexing
	description: "Actual type for NONE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NONE_A

inherit
	TYPE_A
		redefine
			is_none, dump, c_type, same_as, is_full_named_type, generated_id,
			generate_gen_type_il
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_none_a (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Properties

	is_none: BOOLEAN is True
			-- Is the current type a none type ?

	is_full_named_type: BOOLEAN is True
			-- Current is a full named type.

feature -- Access

	hash_code: INTEGER is
			-- Hash code for current type
		do
			Result := {SHARED_HASH_CODE}.none_code
		end

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		do
			Result := other.is_none
		end

	associated_class: CLASS_C is
		do
			-- No associated class
		end

feature -- Output

	dump: STRING is "NONE"
			-- Dumped trace

	ext_append_to (st: TEXT_FORMATTER; c: CLASS_C) is
		do
			st.add ({SHARED_TEXT_ITEMS}.ti_none_class)
		end

feature -- Generic conformance

	generated_id (final_mode: BOOLEAN; a_context_type: TYPE_A): NATURAL_16 is
			-- Id of a `like xxx'.
		do
			Result := {SHARED_GEN_CONF_LEVEL}.none_type
		end

feature -- IL code generation

	generate_gen_type_il (il_generator: IL_CODE_GENERATOR; use_info: BOOLEAN) is
			-- `use_info' is true iff we generate code for a
			-- creation instruction.
		do
			il_generator.generate_none_type_instance
		end

feature {COMPILER_EXPORTER}

	create_info: CREATE_TYPE is
			-- Byte code information for entity type creation
		do
			create Result.make (Current)
		end

	c_type: REFERENCE_I is
			-- Void C type
		do
			Result := reference_c_type
		end

	conform_to (other: TYPE_A): BOOLEAN is
			-- Does Current conform to `other'?
		local
			l_type: TYPE_A
		do
				-- If `other' is attached, then NONE does not conform to it.
				-- But it should not be `VOID_A' since VOID_A is only used as
				-- return type for procedure
			l_type := other.conformance_type
			Result := not l_type.is_expanded and not l_type.is_void and then not l_type.is_attached
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

end -- class NONE_A
