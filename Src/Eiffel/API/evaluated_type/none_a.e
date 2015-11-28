note
	description: "Actual type for NONE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NONE_A

inherit
	DEANCHORED_TYPE_A
		redefine
			is_none, dump, c_type, same_as, is_full_named_type, generated_id,
			generate_gen_type_il
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR)
			-- Process current element.
		do
			v.process_none_a (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Properties

	is_none: BOOLEAN = True
			-- Is the current type a none type ?

	is_full_named_type: BOOLEAN = True
			-- Current is a full named type.

feature -- Access

	hash_code: INTEGER
			-- Hash code for current type
		do
			Result := {SHARED_GEN_CONF_LEVEL}.none_type
		end

	same_as (other: TYPE_A): BOOLEAN
			-- Is the current type the same as `other' ?
		do
			if other.is_valid then
				Result := other.is_none
			end
		end

	base_class: CLASS_C
		do
			-- No associated class
		end

feature -- Output

	dump: STRING = "NONE"
			-- Dumped trace

	ext_append_to (a_text_formatter: TEXT_FORMATTER; a_context_class: CLASS_C)
			-- <Precursor>
		do
			ext_append_marks (a_text_formatter)
			a_text_formatter.add ({SHARED_TEXT_ITEMS}.ti_none_class)
		end

feature -- Generic conformance

	generated_id (final_mode: BOOLEAN; a_context_type: TYPE_A): NATURAL_16
			-- Id of a `like xxx'.
		do
			Result := {SHARED_GEN_CONF_LEVEL}.none_type
		end

feature -- IL code generation

	generate_gen_type_il (il_generator: IL_CODE_GENERATOR; use_info: BOOLEAN)
			-- `use_info' is true iff we generate code for a
			-- creation instruction.
		do
			il_generator.generate_none_type_instance
		end

feature {COMPILER_EXPORTER}

	create_info: CREATE_TYPE
			-- Byte code information for entity type creation
		do
			create Result.make (Current)
		end

	c_type: REFERENCE_I
			-- Void C type
		do
			Result := reference_c_type
		end

feature {TYPE_A} -- Helpers

	internal_conform_to (a_context_class: CLASS_C; other: TYPE_A; a_in_generic: BOOLEAN): BOOLEAN
			-- <Precursor>
		local
			l_other_attachable_type: TYPE_A
		do
				-- Apply the same conformance rules as for a class type.
			l_other_attachable_type := other.conformance_type
			if
				not l_other_attachable_type.is_void and then
				(not l_other_attachable_type.is_expanded and then
				(l_other_attachable_type.is_formal implies l_other_attachable_type.is_reference) or else
				is_attached)
			then
				Result := True
				if a_context_class.lace_class.is_void_safe_conformance then
					Result :=
						is_attachable_to (l_other_attachable_type) and then
						(l_other_attachable_type.is_formal implies
							(l_other_attachable_type.has_detachable_mark or else is_implicitly_attached))
				end
				if Result then
					Result := is_processor_attachable_to (other)
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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

end -- class NONE_A
