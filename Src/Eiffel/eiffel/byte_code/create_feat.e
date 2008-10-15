indexing
	description: "Creation of an object bounded to type of a feature during execution."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CREATE_FEAT

inherit
	CREATE_INFO
		redefine
			created_in, generate_cid, make_type_byte_code,
			generate_cid_array, generate_cid_init, is_explicit
		end

	SHARED_TABLE
		export
			{NONE} all
		end

	SHARED_DECLARATIONS
		export
			{NONE} all
		end

	SHARED_GENERATION
		export
			{NONE} all
		end

create
	default_create, make

feature -- Initialization

	make (f_id, f_rout_id: INTEGER) is
			-- Initialize Current with `f_id' and `f_name_id'
			-- in context of class `a_class_id'.
		require
			valid_f_id: f_id > 0
			valid_f_rout_id: f_rout_id > 0
		do
			feature_id := f_id
			routine_id := f_rout_id
		ensure
			feature_id_set: feature_id = f_id
			routine_id_set: routine_id = f_rout_id
		end

feature -- Settings

	set_info (f_id, r_id: INTEGER) is
			-- Set `feature_id' and `routine_id' with `f_id' and `r_id'.
		require
			valid_f_id: f_id > 0
			valid_r_id: r_id > 0
		do
			feature_id := f_id
			routine_id := r_id
		ensure
			feature_id_set: feature_id = f_id
			routine_id_set: routine_id = r_id
		end

feature -- Access

	feature_id: INTEGER
			-- Feature ID to create.

	routine_id: INTEGER
			-- Routine ID of feature.

feature -- C code generation

	analyze is
			-- We need Dftype(Current).
		local
			entry: POLY_TABLE [ENTRY]
		do
			if context.final_mode then
				entry := Eiffel_table.poly_table (routine_id)
				if not entry.has_one_type or else is_generic then
						-- We are in polymorphic case
					context.mark_current_used
					context.add_dftype_current
				end
			else
				context.mark_current_used
			end
		end

	generate_type_id (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; a_level: NATURAL) is
			-- Generate the creation type id of the feature.
		local
			table: POLY_TABLE [ENTRY]
			table_name: STRING
			rout_info: ROUT_INFO
			gen_type: GEN_TYPE_A
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
					gen_type ?= table.first.type

					if gen_type /= Void then
						buffer.put_string ("typres")
						buffer.put_natural_32 (a_level)
					elseif {l_formal: FORMAL_A} table.first.type then
						buffer.put_string ("eif_gen_param_id(INVALID_DTYPE, ")
						context.generate_current_dftype
						buffer.put_two_character (',', ' ')
						buffer.put_integer (l_formal.position)
						buffer.put_character (')')
					else
						buffer.put_type_id (table.first.feature_type_id)
					end
				else
						-- Attribute is polymorphic
					table_name := Encoder.type_table_name (routine_id)

					buffer.put_string ("RTFCID2(")
					buffer.put_integer (context.context_class_type.type.generated_id (context.final_mode, Void))
					buffer.put_character (',')
					buffer.put_string (table_name)
					buffer.put_character (',')
					buffer.put_string (table_name)
					buffer.put_string ("_gen_type")
					buffer.put_character (',')
					context.generate_current_dftype
					buffer.put_character (',')
					buffer.put_type_id (table.min_type_id)
					buffer.put_character (')')

						-- Side effect. This is not nice but
						-- unavoidable.
						-- Mark routine id used
					Eiffel_table.mark_used_for_type (routine_id)
						-- Remember extern declaration
					Extern_declarations.add_type_table (table_name)
				end
			else
				if
					Compilation_modes.is_precompiling or
					context.current_type.associated_class.is_precompiled
				then
					buffer.put_string ("RTWPCT(")
					buffer.put_static_type_id (context.class_type.static_type_id)
					buffer.put_string (gc_comma)
					rout_info := System.rout_info_table.item (routine_id)
					buffer.put_class_id (rout_info.origin)
					buffer.put_string (gc_comma)
					buffer.put_integer (rout_info.offset)
				else
					buffer.put_string ("RTWCT(")
					buffer.put_static_type_id (context.class_type.static_type_id)
					buffer.put_string (gc_comma)
					buffer.put_integer (feature_id)
				end

				buffer.put_string (gc_comma)
				context.Current_register.print_register
				buffer.put_character (')')
			end
		end

feature -- IL code generation

	generate_il is
			-- Generate IL code for an anchored creation type.
		local
			target_type: TYPE_A
		do
				-- Generate call to feature that will give the type we want to create.
			generate_il_type

				-- Evaluate the computed type and create a corresponding object type.
			il_generator.generate_current_as_reference
			il_generator.create_type

			target_type := context.real_type (context.class_type.associated_class.anchored_features.item
				(routine_id).type)
			if target_type.is_expanded then
					-- Load value of a value type object.
				il_generator.generate_unmetamorphose (target_type)
			end

			il_generator.generate_check_cast (Void, target_type)
		end

	generate_il_type is
			-- Generate IL code to load type of anchored creation type.
		do
				-- Generate call to feature that will give the type we want to create.
			il_generator.generate_type_feature_call (context.class_type.associated_class.anchored_features.item (routine_id))
		end

	created_in (other: CLASS_TYPE): TYPE_A is
			-- Resulting type of Current as if it was used to create object in `other'
		do
			Result := context.real_type_in (other.associated_class.feature_of_rout_id (routine_id).type, other.type)
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an anchored creation type.
		local
			rout_info: ROUT_INFO
		do
			if context.current_type.associated_class.is_precompiled then
				ba.append (Bc_pclike)
				ba.append_short_integer (context.class_type.static_type_id - 1)
				rout_info := System.rout_info_table.item (routine_id)
				ba.append_integer (rout_info.origin)
				ba.append_integer (rout_info.offset)
			else
				ba.append (Bc_clike)
				ba.append_short_integer (context.class_type.static_type_id - 1)
				ba.append_integer (feature_id)
			end
		end

feature -- Genericity

	is_explicit: BOOLEAN is
			-- Is Current type fixed at compile time?
		local
			table: POLY_TABLE [ENTRY]
		do
			if context.final_mode then
				table := Eiffel_table.poly_table (routine_id)
				Result := table.has_one_type
			else
				Result := False
			end
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode : BOOLEAN) is

		local
			table: POLY_TABLE [ENTRY]
			table_name: STRING
			rout_info: ROUT_INFO
			gen_type: GEN_TYPE_A
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
					gen_type ?= table.first.type

					if gen_type /= Void then
						gen_type.generate_cid (buffer, final_mode, True, context.context_class_type.type)
					elseif {l_formal: FORMAL_A} table.first.type then
						l_formal.generate_cid (buffer, final_mode, False, context.context_class_type.type)
					else
						buffer.put_type_id (table.first.feature_type_id)
						buffer.put_character (',')
					end
				else
						-- Attribute is polymorphic
					table_name := Encoder.type_table_name (routine_id)

					buffer.put_string ("RTFCID2(")
					buffer.put_integer (context.context_class_type.type.generated_id (context.final_mode, Void))
					buffer.put_character (',')
					buffer.put_string (table_name)
					buffer.put_character (',')
					buffer.put_string (table_name)
					buffer.put_string ("_gen_type")
					buffer.put_character (',')
					context.generate_current_dftype
					buffer.put_character (',')
					buffer.put_type_id (table.min_type_id)
					buffer.put_character (')')
					buffer.put_character (',')

						-- Side effect. This is not nice but
						-- unavoidable.
						-- Mark routine id used
					Eiffel_table.mark_used_for_type (routine_id)
						-- Remember extern declaration
					Extern_declarations.add_type_table (table_name)
				end
			else
				if
					Compilation_modes.is_precompiling or
					context.current_type.associated_class.is_precompiled
				then
					buffer.put_string ("RTWPCT(")
					buffer.put_static_type_id (context.class_type.static_type_id)
					buffer.put_string (gc_comma)
					rout_info := System.rout_info_table.item (routine_id)
					buffer.put_class_id (rout_info.origin)
					buffer.put_string (gc_comma)
					buffer.put_integer (rout_info.offset)
				else
					buffer.put_string ("RTWCT(")
					buffer.put_static_type_id (context.class_type.static_type_id)
					buffer.put_string (gc_comma)
					buffer.put_integer (feature_id)
				end

				buffer.put_string (gc_comma)
				context.Current_register.print_register
				buffer.put_character (')')
				buffer.put_character (',')
			end
		end

	generate_cid_array (buffer : GENERATION_BUFFER;
						final_mode : BOOLEAN; idx_cnt : COUNTER) is
		local
			dummy : INTEGER
			table: POLY_TABLE [ENTRY]
			gen_type: GEN_TYPE_A
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
					gen_type ?= table.first.type

					if gen_type /= Void then
						gen_type.generate_cid_array (buffer,
												final_mode, True, idx_cnt, context.context_class_type.type)
					elseif {l_formal: FORMAL_A} table.first.type then
						l_formal.generate_cid_array (buffer,
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
					   final_mode : BOOLEAN; idx_cnt : COUNTER; a_level: NATURAL) is
		local
			dummy: INTEGER
			table: POLY_TABLE [ENTRY]
			table_name: STRING
			rout_info: ROUT_INFO
			gen_type: GEN_TYPE_A
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
						-- There is a table, but with only one type
					gen_type ?= table.first.type

					if gen_type /= Void then
						gen_type.generate_cid_init (buffer, final_mode, True, idx_cnt, a_level)
					elseif {l_formal: FORMAL_A} table.first.type then
						l_formal.generate_cid_init (buffer, final_mode, False, idx_cnt, a_level)
					else
						dummy := idx_cnt.next
					end
				else
						-- Attribute is polymorphic
					table_name := Encoder.type_table_name (routine_id)
					buffer.put_new_line
					buffer.put_string ("typarr")
					buffer.put_natural_32 (a_level)
					buffer.put_character ('[')
					buffer.put_integer (idx_cnt.value)
					buffer.put_string ("] = RTFCID2(")
					buffer.put_integer (context.context_class_type.type.generated_id (context.final_mode, Void))
					buffer.put_character (',')
					buffer.put_string (table_name)
					buffer.put_character (',')
					buffer.put_string (table_name)
					buffer.put_string ("_gen_type")
					buffer.put_character (',')
					context.generate_current_dftype
					buffer.put_character (',')
					buffer.put_type_id (table.min_type_id)
					buffer.put_string (");")
					dummy := idx_cnt.next

						-- Side effect. This is not nice but
						-- unavoidable.
						-- Mark routine id used
					Eiffel_table.mark_used_for_type (routine_id)
						-- Remember extern declaration
					Extern_declarations.add_type_table (table_name)
				end
			else
				buffer.put_new_line
				buffer.put_string ("typarr")
				buffer.put_natural_32 (a_level)
				buffer.put_character ('[')
				buffer.put_integer (idx_cnt.value)
				if
					Compilation_modes.is_precompiling or
					context.current_type.associated_class.is_precompiled
				then
					buffer.put_string ("] = RTID(RTWPCT(")
					buffer.put_static_type_id (context.class_type.static_type_id)
					buffer.put_string (gc_comma)
					rout_info := System.rout_info_table.item (routine_id)
					buffer.put_class_id (rout_info.origin)
					buffer.put_string (gc_comma)
					buffer.put_integer (rout_info.offset)
				else
					buffer.put_string ("] = RTID(RTWCT(")
					buffer.put_static_type_id (context.class_type.static_type_id)
					buffer.put_string (gc_comma)
					buffer.put_integer (feature_id)
				end

				buffer.put_string (gc_comma)
				context.Current_register.print_register
				buffer.put_string ("));")
				dummy := idx_cnt.next
			end
		end

	make_type_byte_code (ba : BYTE_ARRAY) is

		local
			rout_info: ROUT_INFO
		do
			if context.current_type.associated_class.is_precompiled then
				ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.like_pfeature_type)
				ba.append_short_integer (context.class_type.static_type_id-1)
				rout_info := System.rout_info_table.item (routine_id)
				ba.append_integer (rout_info.origin)
				ba.append_integer (rout_info.offset)
			else
				ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.like_feature_type)
				ba.append_short_integer (context.class_type.static_type_id - 1)
				ba.append_integer (feature_id)
			end
		end

	type_to_create: CL_TYPE_A is

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

end -- class CREATE_FEAT
