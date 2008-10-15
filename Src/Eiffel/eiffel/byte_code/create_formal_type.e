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
		export
			{FORMAL_A} make
		redefine
			generate, generate_type_id, generate_gen_type_conversion,
			generate_cid, generate_cid_init, generate_cid_array, type_to_create, make_byte_code,
			analyze, generate_il, type, is_explicit, make_type_byte_code
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
		local
			l_feat: TYPE_FEATURE_I
		do
			check
				context_class_is_generic: context.context_class_type.is_generic
			end
			l_feat := context.context_class_type.associated_class.formal_at_position (type.position)
			(create {CREATE_FEAT}.make (l_feat.feature_id, l_feat.rout_id_set.first)).generate_type_id (buffer, final_mode, a_level)
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
		local
			l_feat: TYPE_FEATURE_I
		do
			check
				context_class_is_generic: context.context_class_type.is_generic
			end
			l_feat := context.context_class_type.associated_class.formal_at_position (type.position)
			(create {CREATE_FEAT}.make (l_feat.feature_id, l_feat.rout_id_set.first)).make_byte_code (ba)
		end


	make_type_byte_code (ba: BYTE_ARRAY)
			-- <Precursor>
		local
			l_feat: TYPE_FEATURE_I
		do
			check
				context_class_is_generic: context.context_class_type.is_generic
			end
			l_feat := context.context_class_type.associated_class.formal_at_position (type.position)
			(create {CREATE_FEAT}.make (l_feat.feature_id, l_feat.rout_id_set.first)).make_type_byte_code (ba)
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
		local
			l_feat: TYPE_FEATURE_I
		do
			check
				context_class_is_generic: context.context_class_type.is_generic
			end
			l_feat := context.context_class_type.associated_class.formal_at_position (type.position)
			(create {CREATE_FEAT}.make (l_feat.feature_id, l_feat.rout_id_set.first)).generate_cid (buffer, final_mode)
		end

	generate_cid_init (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; idx_cnt: COUNTER; a_level: NATURAL_32) is
			-- <Precursor>
		local
			l_feat: TYPE_FEATURE_I
		do
			check
				context_class_is_generic: context.context_class_type.is_generic
			end
			l_feat := context.context_class_type.associated_class.formal_at_position (type.position)
			(create {CREATE_FEAT}.make (l_feat.feature_id, l_feat.rout_id_set.first)).generate_cid_init (buffer, final_mode, idx_cnt, a_level)
		end

	generate_cid_array (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; idx_cnt: COUNTER) is
			-- <Precursor>
		local
			l_feat: TYPE_FEATURE_I
		do
			check
				context_class_is_generic: context.context_class_type.is_generic
			end
			l_feat := context.context_class_type.associated_class.formal_at_position (type.position)
			(create {CREATE_FEAT}.make (l_feat.feature_id, l_feat.rout_id_set.first)).generate_cid_array (buffer, final_mode, idx_cnt)
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
