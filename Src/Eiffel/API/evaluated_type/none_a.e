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
			Result := {SHARED_HASH_CODE}.none_code
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

	ext_append_to (st: TEXT_FORMATTER; c: CLASS_C)
		do
			if
				not has_attached_mark and then not has_detachable_mark and then
				not is_attached and then not is_implicitly_attached
			then
					-- There is no explicit attachment mark, let's put an assumed one.
				st.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_l_bracket)
				st.process_keyword_text ({SHARED_TEXT_ITEMS}.ti_detachable_keyword, Void)
				st.process_symbol_text ({SHARED_TEXT_ITEMS}.ti_r_bracket)
				st.add_space
			end
			ext_append_marks (st)
			st.add ({SHARED_TEXT_ITEMS}.ti_none_class)
		end

feature -- Generic conformance

	generated_id (final_mode: BOOLEAN; a_context_type: TYPE_A): NATURAL_16
			-- Id of a `like xxx'.
		do
			Result := {SHARED_GEN_CONF_LEVEL}.detachable_none_type
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
			create Result.make (as_attachment_mark_free)
		end

	c_type: REFERENCE_I
			-- Void C type
		do
			Result := reference_c_type
		end

	conform_to (a_context_class: CLASS_C; other: INHERITANCE_TYPE_A): BOOLEAN
			-- Does Current conform to `other'?
		do
				-- Apply the same conformance rules as for a class type.
			if
				attached {ANNOTATED_TYPE_A} other.conformance_type as other_attachable_type and then
				not other_attachable_type.is_expanded and then
				(other_attachable_type.is_formal implies other_attachable_type.is_reference)
			then
				Result := True
				if a_context_class.lace_class.is_void_safe_conformance then
					Result :=
						is_attachable_to (other_attachable_type) and then
						(other_attachable_type.is_formal implies
							(other_attachable_type.has_detachable_mark or else is_implicitly_attached))
				end
				if Result then
					Result := is_processor_attachable_to (other)
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
