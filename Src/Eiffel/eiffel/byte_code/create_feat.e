note
	description: "Creation of an object bounded to type of a feature during execution."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CREATE_FEAT

inherit
	CREATE_INFO
		redefine
			generate_cid, make_type_byte_code,
			generate_cid_array, generate_cid_init, is_explicit,
			generate
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

	INTERNAL_COMPILER_STRING_EXPORTER
		export
			{NONE} all
		end

create
	default_create, make

feature -- Initialization

	make (f_id, f_rout_id: INTEGER)
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

	set_info (f_id, r_id: INTEGER)
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

feature -- Update

	updated_info: CREATE_INFO
			-- <Precursor>
		local
			l_feat_id: like feature_id
		do
				-- Only recompute `feature_id' for `context.context_class_type' only when
				-- it is different from `context.class_type' as we know that Current was
				-- created for `context.class_type'.
			if context.class_type /= context.context_class_type then
				l_feat_id := context.context_class_type.associated_class.feature_of_rout_id (routine_id).feature_id
				if l_feat_id /= feature_id then
					create {CREATE_FEAT} Result.make (l_feat_id, routine_id)
				else
					Result := Current
				end
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
			-- We need Dftype(Current).
		local
			entry: POLY_TABLE [ENTRY]
			l_type: TYPE_A
		do
			if context.final_mode then
				entry := Eiffel_table.poly_table (routine_id)
				if not entry.has_one_type then
						-- We are in polymorphic case
					context.mark_current_used
					context.add_dftype_current
				else
					l_type := entry.first.type.deep_actual_type
					if attached {GEN_TYPE_A} l_type as l_gen_type then
						context.mark_current_used
						context.add_dftype_current
					elseif attached {FORMAL_A} l_type as l_formal then
						context.add_dftype_current
					end
				end
			else
				context.mark_current_used
			end
		end

	generate_type_id (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; a_level: NATURAL)
			-- Generate the creation type id of the feature.
		local
			table: POLY_TABLE [ENTRY]
			table_name: STRING
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

					buffer.put_string ("eif_final_id(")
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
				buffer.put_string ("RTWCT(")
				buffer.put_integer (routine_id)
				buffer.put_string ({C_CONST}.comma_space)
				context.generate_current_dtype
				buffer.put_string ({C_CONST}.comma_space)
				context.generate_current_dftype
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
			il_generator.generate_current_as_reference
			il_generator.create_type

			target_type := context.real_type (context.context_class_type.associated_class.anchored_features.item
				(routine_id).type)
			if target_type.is_expanded then
					-- Load value of a value type object.
				il_generator.generate_unmetamorphose (target_type)
			end

			il_generator.generate_check_cast (Void, target_type)
		end

	generate_il_type
			-- Generate IL code to load type of anchored creation type.
		do
				-- Generate call to feature that will give the type we want to create.
			il_generator.generate_type_feature_call (context.context_class_type.associated_class.anchored_features.item (routine_id))
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY)
			-- Generate byte code for an anchored creation type.
		do
			ba.append (Bc_clike)
			ba.append_integer (routine_id)
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

					buffer.put_string ("eif_final_id(")
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
				buffer.put_string ("RTWCT(")
				buffer.put_integer (routine_id)
				buffer.put_string ({C_CONST}.comma_space)
				context.generate_current_dtype
				buffer.put_string ({C_CONST}.comma_space)
				context.generate_current_dftype
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
				buffer.put_string ("] = RTWCT(")
				buffer.put_integer (routine_id)
				buffer.put_string ({C_CONST}.comma_space)
				context.generate_current_dtype
				buffer.put_string ({C_CONST}.comma_space)
				context.generate_current_dftype
				buffer.put_two_character (')', ';')
				dummy := idx_cnt.next
			end
		end

	make_type_byte_code (ba : BYTE_ARRAY)
			-- <Precursor>
		do
			ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.like_feature_type)
			ba.append_integer (routine_id)
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

end -- class CREATE_FEAT
