note
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
			generate_cid, generate_cid_init, generate_cid_array, type_to_create,
			analyze, generate_il, type, is_explicit, make_type_byte_code,
			make_byte_code
		end

create
	make

feature -- Access

	type: FORMAL_A
			-- Current type of creation.

feature -- C code generation

	analyze
		do
			associated_create_feat.analyze
		end

	generate
			-- Generate creation type
		do
			associated_create_feat.generate
		end

	generate_type_id (buffer: GENERATION_BUFFER; final_mode : BOOLEAN; a_level: NATURAL)
			-- Generate formal creation type id
		do
			associated_create_feat.generate_type_id (buffer, final_mode, a_level)
		end

feature -- IL code generation

	generate_il
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

	make_byte_code (ba: BYTE_ARRAY)
			-- <Precursor>
		do
			make_type_byte_code (ba)
		end

	make_type_byte_code (ba: BYTE_ARRAY)
			-- <Precursor>
		do
			associated_create_feat.make_type_byte_code (ba)
		end

feature -- Generic conformance

	is_explicit: BOOLEAN
			-- Is Current type fixed at compile time?
		do
			Result := False
		end

	generate_gen_type_conversion (a_level: NATURAL)
			-- <Precursor>
		do
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode : BOOLEAN)
			-- <Precursor>
		do
			associated_create_feat.generate_cid (buffer, final_mode)
		end

	generate_cid_init (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; idx_cnt: COUNTER; a_level: NATURAL_32)
			-- <Precursor>
		do
			associated_create_feat.generate_cid_init (buffer, final_mode, idx_cnt, a_level)
		end

	generate_cid_array (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; idx_cnt: COUNTER)
			-- <Precursor>
		do
			associated_create_feat.generate_cid_array (buffer, final_mode, idx_cnt)
		end

	type_to_create : CL_TYPE_A
			-- <Precursor>
		do
		end

feature {NONE} -- Helper

	associated_create_feat: CREATE_FEAT
			-- Associated creation feature for formal.
		local
			l_feat: TYPE_FEATURE_I
		do
				-- We check `BYTE_CONTEXT.context_class_type' because Current has been solved for
				-- that context.
			check
				context_class_is_generic: context.context_class_type.is_generic
			end
			l_feat := context.context_class_type.associated_class.formal_at_position (type.position)
			create Result.make (l_feat.feature_id, l_feat.rout_id_set.first)
		ensure
			assocated_create_feat_not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
