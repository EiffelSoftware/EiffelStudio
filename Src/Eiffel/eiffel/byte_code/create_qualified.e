note
	description: "Information for qualified anchored creation type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_QUALIFIED

inherit
	CREATE_INFO
		redefine
			generate,
			generate_cid,
			generate_cid_array,
			generate_cid_init,
			is_explicit,
			make_type_byte_code
		end

	SHARED_TABLE
	SHARED_DECLARATIONS
	SHARED_GENERATION

create {QUALIFIED_ANCHORED_TYPE_A}
	default_create, make

create {CREATE_QUALIFIED}
	make_explicit

feature {QUALIFIED_ANCHORED_TYPE_A} -- Initialization

	make (t: QUALIFIED_ANCHORED_TYPE_A)
			-- Initialize Current using `t'.
		require
			t_attached: attached t
		local
			q: TYPE_A
			i: INTEGER
			n: INTEGER
			f: FEATURE_I
		do
			i := t.chain.lower
			q := t.qualifier
			f := q.associated_class.feature_of_name_id (t.chain [i])
			make_explicit (q.create_info, q, f)
			from
				n := t.chain.upper
			until
				i >= n
			loop
				i := i + 1
				q := f.type
				f := q.associated_class.feature_of_name_id (t.chain [i])
				make_explicit (twin, q, f)
			end
		end

feature {CREATE_QUALIFIED} -- Creation

	make_explicit (c: CREATE_INFO; q: TYPE_A; f: FEATURE_I)
		require
			c_attached: attached c
			q_attached: attached q
			f_attached: attached f
		do
			qualifier_creation := c
			qualifier := q
			feature_id := f.feature_id
			routine_id := f.rout_id_set.first
		end

feature {CREATE_QUALIFIED} -- Access

	qualifier_creation: CREATE_INFO
			-- Creation information of `qualifier'

	qualifier: TYPE_A
			-- First part of the qualified type

	feature_id: INTEGER
			-- Routine ID of the second part of the qualified type

	routine_id: INTEGER
			-- Routine ID of the second part of the qualified type

feature -- Update

	updated_info: CREATE_INFO
			-- <Precursor>
		local
			c: CREATE_INFO
			q: TYPE_A
		do
			c := qualifier_creation.updated_info
			q := context.descendant_type (qualifier)
			if c /= qualifier_creation or else q /= qualifier and then not qualifier.same_as (q) then
				create {CREATE_QUALIFIED} Result.make_explicit (q.create_info, q, q.associated_class.feature_of_rout_id (routine_id))
			else
				Result := Current
			end
		end

feature -- C code generation

	generate
			-- Generate creation type
		local
			buffer: GENERATION_BUFFER
		do
			buffer := context.buffer
			buffer.put_string ("RTLNSMART(eif_non_attached_type(")
			generate_type_id (buffer, context.final_mode, 0)
			buffer.put_two_character (')', ')')
		end

	analyze
			-- We may need Dftype(Current).
		do
			qualifier_creation.analyze
		end

	generate_type_id (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; a_level: NATURAL)
			-- Generate the creation type id of the feature.
		local
			table: POLY_TABLE [ENTRY]
			table_name: STRING
			rout_info: ROUT_INFO
			l_type: TYPE_A
		do
			if final_mode then
				table := Eiffel_table.poly_table (routine_id)

				if table.is_deferred then
					-- Creation with `like feature' where
					-- feature is deferred and has no effective
					-- version anywhere.
					-- Create anything - cannot be called anyway

					buffer.put_integer (0)
				elseif table.has_one_type then
						-- There is a table, but with only one type
					l_type := table.first.type.deep_actual_type

					if l_type.has_generics then
						buffer.put_string ("typres")
						buffer.put_natural_32 (a_level)
					elseif attached {FORMAL_A} l_type as l_formal then
						buffer.put_string ("eif_gen_param_id(")
						qualifier_creation.generate_type_id (buffer, final_mode, a_level)
						buffer.put_two_character (',', ' ')
						buffer.put_integer (l_formal.position)
						buffer.put_character (')')
					else
						buffer.put_type_id (table.first.feature_type_id)
					end
				else
						-- Attribute is polymorphic
					table_name := Encoder.type_table_name (routine_id)
						-- Side effect. This is not nice but
						-- unavoidable.
						-- Mark routine id used
					Eiffel_table.mark_used_for_type (routine_id)
						-- Remember extern declaration
					Extern_declarations.add_type_table (table_name)

					buffer.put_string ("eif_final_id(")
					buffer.put_string (table_name)
					buffer.put_character (',')
					buffer.put_string (table_name)
					buffer.put_string ("_gen_type")
					buffer.put_character (',')
					qualifier_creation.generate_type_id (buffer, final_mode, a_level)
					buffer.put_character (',')
					buffer.put_type_id (table.min_type_id)
					buffer.put_character (')')
				end
			else
				if
					Compilation_modes.is_precompiling or
					qualifier.associated_class_type (context.context_class_type.type).is_precompiled
				then
					buffer.put_string ("RTWPCTT(")
					buffer.put_static_type_id (qualifier.static_type_id (context.context_class_type.type))
					buffer.put_string ({C_CONST}.comma_space)
					rout_info := System.rout_info_table.item (routine_id)
					buffer.put_class_id (rout_info.origin)
					buffer.put_string ({C_CONST}.comma_space)
					buffer.put_integer (rout_info.offset)
				else
					buffer.put_string ("RTWCTT(")
					buffer.put_static_type_id (qualifier.static_type_id (context.context_class_type.type))
					buffer.put_string ({C_CONST}.comma_space)
					buffer.put_integer (feature_id)
				end

				buffer.put_string ({C_CONST}.comma_space)
				qualifier_creation.generate_type_id (buffer, final_mode, a_level)
				buffer.put_character (')')
			end
		end

feature -- IL code generation

	generate_il
			-- Generate IL code for an anchored creation type.
		local
			target_type: TYPE_A
		do
				-- Generate call to feature that will give the type we want to create.
			generate_il_type

				-- Evaluate the computed type and create a corresponding object type.
			qualifier_creation.generate_il
			il_generator.create_type

			target_type := context.real_type (qualifier.associated_class.anchored_features.item
				(routine_id).type)
			if target_type.is_expanded then
					-- Load value of a value type object.
				il_generator.generate_unmetamorphose (target_type)
			end

			il_generator.generate_check_cast (Void, target_type)
		end

	generate_il_type
			-- Generate IL code to load type of anchored creation type.
		local
			c: CL_TYPE_A
		do
				-- Create qualifier object.
			qualifier_creation.generate_il
			c := qualifier.associated_class_type (context.context_class_type.type).type
				-- Generate call to feature that will give the type we want to create.
			il_generator.generate_type_feature_call_on_type (c.associated_class.anchored_features.item (routine_id), c)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY)
			-- Generate byte code for an anchored creation type.
		local
			rout_info: ROUT_INFO
		do
			if qualifier.associated_class_type (context.context_class_type.type).is_precompiled then
				ba.append (Bc_pqlike)
				qualifier_creation.make_byte_code (ba)
				ba.append_type_id (qualifier.static_type_id (context.context_class_type.type))
				rout_info := System.rout_info_table.item (routine_id)
				ba.append_integer (rout_info.origin)
				ba.append_integer (rout_info.offset)
			else
				ba.append (Bc_qlike)
				qualifier_creation.make_byte_code (ba)
				ba.append_type_id (qualifier.static_type_id (context.context_class_type.type))
				ba.append_integer (feature_id)
			end
		end

feature -- Genericity

	is_explicit: BOOLEAN
			-- Is Current type fixed at compile time?
		local
			table: POLY_TABLE [ENTRY]
		do
			if context.final_mode then
				table := Eiffel_table.poly_table (routine_id)
				Result := table.has_one_type and then table.first.type.deep_actual_type.is_explicit
			else
				Result := False
			end
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode : BOOLEAN)
		local
			table: POLY_TABLE [ENTRY]
			table_name: STRING
			rout_info: ROUT_INFO
			l_type: TYPE_A
		do
			if context.final_mode then
				table := Eiffel_table.poly_table (routine_id)

				if table.is_deferred then
						-- Creation with `like feature' where feature is
						-- deferred and has no effective version anywhere.
						-- Create anything - cannot be called anyway
					buffer.put_hex_natural_16 ({SHARED_GEN_CONF_LEVEL}.terminator_type)
					buffer.put_character (',')
					buffer.put_hex_natural_16 ({SHARED_GEN_CONF_LEVEL}.terminator_type)
					buffer.put_character (',')
				elseif table.has_one_type then
						-- There is a table, but with only one type
					l_type := table.first.type.deep_actual_type

					if l_type.has_generics or l_type.is_formal then
						l_type.generate_cid (buffer, final_mode, False, context.context_class_type.type)
					else
						buffer.put_type_id (table.first.feature_type_id)
						buffer.put_character (',')
					end
				else
						-- Attribute is polymorphic
					table_name := Encoder.type_table_name (routine_id)
						-- Side effect. This is not nice but
						-- unavoidable.
						-- Mark routine id used
					Eiffel_table.mark_used_for_type (routine_id)
						-- Remember extern declaration
					Extern_declarations.add_type_table (table_name)

					buffer.put_string ("eif_final_id(")
					buffer.put_string (table_name)
					buffer.put_character (',')
					buffer.put_string (table_name)
					buffer.put_string ("_gen_type")
					buffer.put_character (',')
					qualifier_creation.generate_type_id (buffer, final_mode, 0)
					buffer.put_character (',')
					buffer.put_type_id (table.min_type_id)
					buffer.put_character (')')
					buffer.put_character (',')
				end
			else
				if
					Compilation_modes.is_precompiling or
					qualifier.associated_class_type (context.context_class_type.type).is_precompiled
				then
					buffer.put_string ("RTWPCTT(")
					buffer.put_static_type_id (qualifier.static_type_id (context.context_class_type.type))
					buffer.put_string ({C_CONST}.comma_space)
					rout_info := System.rout_info_table.item (routine_id)
					buffer.put_class_id (rout_info.origin)
					buffer.put_string ({C_CONST}.comma_space)
					buffer.put_integer (rout_info.offset)
				else
					buffer.put_string ("RTWCTT(")
					buffer.put_static_type_id (qualifier.static_type_id (context.context_class_type.type))
					buffer.put_string ({C_CONST}.comma_space)
					buffer.put_integer (feature_id)
				end
				buffer.put_string ({C_CONST}.comma_space)
				qualifier_creation.generate_type_id (buffer, final_mode, 0)
				buffer.put_character (')')
				buffer.put_character (',')
			end
		end

	generate_cid_array (buffer : GENERATION_BUFFER;
						final_mode : BOOLEAN; idx_cnt : COUNTER)
		local
			dummy : INTEGER
			table: POLY_TABLE [ENTRY]
			l_type: TYPE_A
		do
			if context.final_mode then
				table := Eiffel_table.poly_table (routine_id)

				if table.is_deferred then
						-- Creation with `like feature' where feature is
						-- deferred and has no effective version anywhere.
						-- Create anything - cannot be called anyway
					buffer.put_hex_natural_16 ({SHARED_GEN_CONF_LEVEL}.terminator_type)
					buffer.put_character (',')
					buffer.put_hex_natural_16 ({SHARED_GEN_CONF_LEVEL}.terminator_type)
					buffer.put_character (',')
					dummy := idx_cnt.next
					dummy := idx_cnt.next
				elseif table.has_one_type then
						-- There is a table, but with only one type
					l_type := table.first.type.deep_actual_type

					if l_type.has_generics or l_type.is_formal then
						l_type.generate_cid_array (buffer,
												final_mode, False, idx_cnt, context.context_class_type.type)
					else
						buffer.put_type_id (table.first.feature_type_id)
						buffer.put_character (',')
						dummy := idx_cnt.next
					end
				else
					buffer.put_string ("0,")
					dummy := idx_cnt.next
				end
			else
				buffer.put_string ("0,")
				dummy := idx_cnt.next
			end
		end

	generate_cid_init (buffer : GENERATION_BUFFER;
					   final_mode : BOOLEAN; idx_cnt : COUNTER; a_level: NATURAL)
		local
			dummy: INTEGER
			table: POLY_TABLE [ENTRY]
			table_name: STRING
			rout_info: ROUT_INFO
			l_type: TYPE_A
		do
			if context.final_mode then
				table := Eiffel_table.poly_table (routine_id)

				if table.is_deferred then
						-- Creation with `like feature' where feature is
						-- deferred and has no effective version anywhere.
						-- Create anything - cannot be called anyway
					dummy := idx_cnt.next
					dummy := idx_cnt.next
				elseif table.has_one_type then
					l_type := table.first.type.deep_actual_type

					if l_type.has_generics or l_type.is_formal then
						l_type.generate_cid_init (buffer, final_mode, False, idx_cnt, context.context_class_type.type, a_level)
					else
						dummy := idx_cnt.next
					end
				else
						-- Attribute is polymorphic
					table_name := Encoder.type_table_name (routine_id)
						-- Side effect. This is not nice but
						-- unavoidable.
						-- Mark routine id used
					Eiffel_table.mark_used_for_type (routine_id)
						-- Remember extern declaration
					Extern_declarations.add_type_table (table_name)
					buffer.put_new_line
					buffer.put_string ("typarr")
					buffer.put_natural_32 (a_level)
					buffer.put_character ('[')
					buffer.put_integer (idx_cnt.value)
					buffer.put_string ("] = eif_final_id(")
					buffer.put_string (table_name)
					buffer.put_character (',')
					buffer.put_string (table_name)
					buffer.put_string ("_gen_type")
					buffer.put_character (',')
					qualifier_creation.generate_type_id (buffer, final_mode, a_level)
					buffer.put_character (',')
					buffer.put_type_id (table.min_type_id)
					buffer.put_string (");")
					dummy := idx_cnt.next
				end
			else
				buffer.put_new_line
				buffer.put_string ("typarr")
				buffer.put_natural_32 (a_level)
				buffer.put_character ('[')
				buffer.put_integer (idx_cnt.value)
				if
					Compilation_modes.is_precompiling or
					qualifier.associated_class_type (context.context_class_type.type).is_precompiled
				then
					buffer.put_string ("] = RTWPCTT(")
					buffer.put_static_type_id (qualifier.static_type_id (context.context_class_type.type))
					buffer.put_string ({C_CONST}.comma_space)
					rout_info := System.rout_info_table.item (routine_id)
					buffer.put_class_id (rout_info.origin)
					buffer.put_string ({C_CONST}.comma_space)
					buffer.put_integer (rout_info.offset)
				else
					buffer.put_string ("] = RTWCTT(")
					buffer.put_static_type_id (qualifier.static_type_id (context.context_class_type.type))
					buffer.put_string ({C_CONST}.comma_space)
					buffer.put_integer (feature_id)
				end
				buffer.put_string ({C_CONST}.comma_space)
				qualifier_creation.generate_type_id (buffer, final_mode, a_level)
				buffer.put_two_character (')', ';')
				dummy := idx_cnt.next
			end
		end

	make_type_byte_code (ba : BYTE_ARRAY)
		local
			rout_info: ROUT_INFO
		do
			if qualifier.associated_class_type (context.context_class_type.type).is_precompiled then
				ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.qualified_pfeature_type)
				qualifier_creation.make_type_byte_code (ba)
				ba.append_type_id (qualifier.static_type_id (context.context_class_type.type))
				rout_info := System.rout_info_table.item (routine_id)
				ba.append_integer (rout_info.origin)
				ba.append_integer (rout_info.offset)
			else
				ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.qualified_feature_type)
				qualifier_creation.make_type_byte_code (ba)
				ba.append_type_id (qualifier.static_type_id (context.context_class_type.type))
				ba.append_integer (feature_id)
			end
		end

	type_to_create: CL_TYPE_A
		local
			table : POLY_TABLE [ENTRY]
		do
			if context.final_mode then
				table := Eiffel_table.poly_table (routine_id)
				if table.has_one_type then
					Result ?= table.first.type.deep_actual_type
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
