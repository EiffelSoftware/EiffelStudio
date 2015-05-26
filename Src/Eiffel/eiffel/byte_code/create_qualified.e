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
			generate_gen_type_conversion,
			is_explicit,
			is_generic,
			make_type_byte_code
		end

	SHARED_DECLARATIONS
	SHARED_GENERATION
	SHARED_TABLE
	INTERNAL_COMPILER_STRING_EXPORTER

create {QUALIFIED_ANCHORED_TYPE_A}
	default_create, make

create {CREATE_QUALIFIED}
	make_explicit

feature {QUALIFIED_ANCHORED_TYPE_A} -- Initialization

	make (t: QUALIFIED_ANCHORED_TYPE_A; c: CLASS_C)
			-- Initialize Current using `t' written in `c'.
		require
			t_attached: attached t
		local
			q: TYPE_A
			f: FEATURE_I
			i: INTEGER
			n: INTEGER
		do
			i := t.chain.lower
			q := t.qualifier
			feature_finder.find (t.chain [i], q, c)
			check attached feature_finder.found_feature as f1 then
				f := f1
				make_explicit (q.create_info, q, feature_finder.found_site, f)
				from
					n := t.chain.upper
				until
					i >= n
				loop
					i := i + 1
					q := f.type.instantiated_in (q)
					feature_finder.find (t.chain [i], q, c)
					check attached feature_finder.found_feature as fn then
						f := fn
						make_explicit (twin, q, feature_finder.found_site, f)
					end
				end
			end
		end

feature {CREATE_QUALIFIED} -- Creation

	make_explicit (c: CREATE_INFO; q: TYPE_A; b: CL_TYPE_A; f: FEATURE_I)
			-- Create qualified anchored type descritor with the specified qualifier `c' of type `q' with base type `b' and feature `f'.
		require
			c_attached: attached c
			q_attached: attached q
			b_attached: attached b
			f_attached: attached f
		do
			qualifier_creation := c
			qualifier := q
			qualifier_base_type := b
			feature_id := f.feature_id
			routine_id := f.rout_id_set.first
		ensure
			qualifier_creation_set: qualifier_creation = c
			qualifier_set: qualifier = q
			qualifier_base_type_set: qualifier_base_type = b
			feature_id_set: feature_id = f.feature_id
			routine_id_set: routine_id = f.rout_id_set.first
		end

feature {CREATE_QUALIFIED} -- Access

	qualifier_creation: CREATE_INFO
			-- Creation information of `qualifier'.

	qualifier: TYPE_A
			-- First part of the qualified type.

	qualifier_base_type: CL_TYPE_A
			-- Base class type of `qualifier'.

	feature_id: INTEGER
			-- Routine ID of the second part of the qualified type.

	routine_id: INTEGER
			-- Routine ID of the second part of the qualified type.

feature {NONE} -- Convenience

	qualifier_class_type: CLASS_TYPE
			-- Class type of `qualifier' in current context.
		local
			c: CL_TYPE_A
			q: TYPE_A
		do
			c := Context.context_class_type.type
			q := context.real_type (qualifier)
			if q.has_associated_class_type (c) then
				Result := q.associated_class_type (c)
			else
				q := context.real_type (qualifier_base_type)
				check q.has_associated_class_type (c) then
					Result := q.associated_class_type (c)
				end
			end
		end

	qualifier_static_type_id: INTEGER
			-- Static type ID of `qualifier' class type.
		do
			Result := qualifier_class_type.static_type_id
		end

	is_precompiled: BOOLEAN
			-- Is code generated in precompilation mode?
		do
			Result := Compilation_modes.is_precompiling or else qualifier_base_type.base_class.is_precompiled
		end

feature -- Update

	updated_info: CREATE_INFO
			-- <Precursor>
		local
			c: CREATE_INFO
			q: TYPE_A
		do
			c := qualifier_creation.updated_info
			q := context.descendant_type (qualifier)
			if
				(c /= qualifier_creation or else q /= qualifier and then not qualifier.same_as (q)) and then
				attached {CL_TYPE_A} context.real_type (qualifier_base_type) as b
			then
				create {CREATE_QUALIFIED} Result.make_explicit (q.create_info, q, b, b.base_class.feature_of_rout_id (routine_id))
			else
				Result := Current
			end
		end

feature -- C code generation

	generate
			-- Generate creation type.
		local
			buffer: GENERATION_BUFFER
		do
			buffer := context.buffer
			buffer.put_string ("RTLNSMART(")
			generate_type_id (buffer, context.final_mode, 0)
			buffer.put_character (')')
		end

	analyze
			-- We may need Dftype(Current).
		do
			qualifier_creation.analyze
		end

	generate_type (buffer: GENERATION_BUFFER; final_mode: BOOLEAN; a_level: NATURAL)
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

					buffer.put_string ("eif_new_type(INVALID_DTYPE, 0)")
				elseif table.has_one_type then
						-- There is a table, but with only one type
					l_type := table.first.type.instantiated_in (qualifier).deep_actual_type

					if l_type.has_generics then
						buffer.put_string ("typres")
						buffer.put_natural_32 (a_level)
					elseif attached {FORMAL_A} l_type as l_formal then
						buffer.put_string ("eif_gen_param(")
						qualifier_creation.generate_type_id (buffer, final_mode, a_level + 1)
						buffer.put_two_character (',', ' ')
						buffer.put_integer (l_formal.position)
						buffer.put_character (')')
					else
						check has_no_formals: not l_type.has_formal_generic end
						buffer.put_string ("eif_new_type(")
						buffer.put_type_id (l_type.type_id (Void))
						buffer.put_two_character (',', ' ')
							-- Discard the upper bits as `eif_new_type' only accepts the lower part.
						buffer.put_natural_16 (l_type.annotation_flags & 0x00FF)
						buffer.put_character (')')
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
					qualifier_creation.generate_type_id (buffer, final_mode, a_level + 1)
					buffer.put_character (',')
					buffer.put_type_id (table.min_type_id)
					buffer.put_character (')')
				end
			else
				buffer.put_string ("RTWCTT(")
				buffer.put_integer (routine_id)
				buffer.put_string ({C_CONST}.comma_space)
				qualifier_creation.generate_type_id (buffer, final_mode, a_level + 1)
				buffer.put_character (')')
			end
		end

	real_feature_id: INTEGER
			-- Actual `feature_id' of the anchors.
		do
				-- When the base class of the qualified anchors is the same as the one we recorded
				-- during creation of the anchor, we can use the stored `feature_id'.
				-- Otherwise, we have to fetch it via the `routine_id'.
				-- This fixes eweasel test#anchor042 and test#anchor051.
			if not attached Context.real_type (qualifier).base_class as l_class or else l_class.class_id = context.current_type.class_id then
					-- Code is processed in the context where it is written
				Result := feature_id
			else
					-- Code is processed in the context different from the one where it is written
				Result := l_class.feature_of_rout_id (routine_id).feature_id
			end
		end

feature -- IL code generation

	generate_il
			-- Generate IL code for an anchored creation type.
		do
				-- Generate call to feature that will give the type we want to create.
			generate_il_type

				-- Evaluate the computed type and create a corresponding object type.
			qualifier_creation.generate_il
			il_generator.create_type

-- FIXME: The following code has been commented because it causes a crash since we
-- do not always have the proper context to evaluate the type of the anchors, especially
-- when swapping generics or reducing the number of generics. Since the code is just there to
-- make the code verifiable, we have commented it out. This fixes a few eweasel tests such
-- as test#anchor018, test#anchor050, test#anchor054, test#anchor056, test#anchor059, test#anchor063.
--
--				-- Save context
--			context.change_class_type_context (qualifier_class_type, qualifier_base_type, qualifier_class_type, qualifier_base_type)
--			target_type := context.real_type (qualifier_base_type.base_class.anchored_features.item (routine_id).type)
--				-- Restore context
--			context.restore_class_type_context

--			if target_type.is_expanded then
--					-- Load value of a value type object.
--				il_generator.generate_unmetamorphose (target_type)
--			end

--			il_generator.generate_check_cast (Void, target_type)
		end

	generate_il_type
			-- Generate IL code to load type of anchored creation type.
		local
			c: CL_TYPE_A
			l_old_type: CLASS_TYPE
			l_old_type_id: INTEGER
		do
				-- Create qualifier object.
			qualifier_creation.generate_il
			c := qualifier_class_type.type

				-- Save context
			l_old_type := il_generator.current_class_type
			l_old_type_id := il_generator.current_type_id
			il_generator.set_current_class_type (qualifier_class_type)
			il_generator.set_current_type_id (qualifier_class_type.static_type_id)
			context.change_class_type_context (qualifier_class_type, qualifier_base_type, qualifier_class_type, qualifier_base_type)

				-- Generate call to feature that will give the type we want to create.
			il_generator.generate_type_feature_call_on_type (c.base_class.anchored_features.item (routine_id), c)

				-- Restore context
			il_generator.set_current_class_type (l_old_type)
			il_generator.set_current_type_id (l_old_type_id)
			context.restore_class_type_context
		end

feature -- Genericity

	is_explicit: BOOLEAN
			-- Is Current type fixed at compile time?
		local
			table: POLY_TABLE [ENTRY]
		do
			if context.final_mode then
				table := Eiffel_table.poly_table (routine_id)
				Result := table.has_one_type and then
					table.first.type.instantiated_in (qualifier).deep_actual_type.is_explicit
			end
		end

	generate_gen_type_conversion (a_level: NATURAL)
			-- <Precursor>
		do
			if attached type_to_create then
					-- The type does not depend on the qualifier.
				Precursor (a_level)
			else
					-- The type is computed using qualifier.
				qualifier_creation.generate_gen_type_conversion (a_level + 1)
			end
		end

	generate_cid (buffer: GENERATION_BUFFER; final_mode: BOOLEAN)
			-- <Precursor>
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
					l_type := table.first.type.instantiated_in (qualifier).deep_actual_type

					if l_type.has_generics or l_type.is_formal then
						l_type.generate_cid (buffer, final_mode, False, context.context_class_type.type)
					else
						check has_no_formals: not l_type.has_formal_generic end
						buffer.put_type_id (l_type.type_id (Void))
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
				buffer.put_string ("RTWCTT(")
				buffer.put_integer (routine_id)
				buffer.put_string ({C_CONST}.comma_space)
				qualifier_creation.generate_type_id (buffer, final_mode, 0)
				buffer.put_character (')')
				buffer.put_character (',')
			end
		end

	generate_cid_array (buffer : GENERATION_BUFFER;
						final_mode : BOOLEAN; idx_cnt : COUNTER)
			-- <Precursor>
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
					l_type := table.first.type.instantiated_in (qualifier).deep_actual_type

					if l_type.has_generics or l_type.is_formal then
						l_type.generate_cid_array (buffer,
												final_mode, False, idx_cnt, context.context_class_type.type)
					else
						check has_no_formals: not l_type.has_formal_generic end
						buffer.put_type_id (l_type.type_id (Void))
						buffer.put_character (',')
						dummy := idx_cnt.next
					end
				else
					buffer.put_string ("0,0,")
					dummy := idx_cnt.next
				end
			else
				buffer.put_string ("0,0,")
				dummy := idx_cnt.next
			end
		end

	generate_cid_init (buffer : GENERATION_BUFFER;
					   final_mode : BOOLEAN; idx_cnt : COUNTER; a_level: NATURAL)
			-- <Precursor>
		local
			dummy: INTEGER
			table: POLY_TABLE [ENTRY]
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
					l_type := table.first.type.instantiated_in (qualifier).deep_actual_type
					if l_type.has_generics or else l_type.is_formal then
						l_type.generate_cid_init (buffer, final_mode, False, idx_cnt, context.context_class_type.type, a_level)
					else
						dummy := idx_cnt.next
					end
				else
					generate_entry_inititalization (buffer, final_mode, idx_cnt, a_level)
				end
			else
				generate_entry_inititalization (buffer, final_mode, idx_cnt, a_level)
			end
		end

	make_type_byte_code (ba : BYTE_ARRAY)
			-- <Precursor>
		do
			ba.append_natural_16 ({SHARED_GEN_CONF_LEVEL}.qualified_feature_type)
				-- Only one element in the chain.
			ba.append_natural_16 ({NATURAL_16} 1)
			qualifier.make_type_byte_code (ba, True, context.context_class_type.type)
				-- Note that we do not encode the INEGER_32 value into NATURAL_16 encoding
				-- that type arrays are usually made of.
			ba.append_integer_for_type_array (routine_id)
		end

	type_to_create: CL_TYPE_A
		local
			table : POLY_TABLE [ENTRY]
		do
			if context.final_mode then
				table := Eiffel_table.poly_table (routine_id)
				if table.has_one_type and then attached {CL_TYPE_A} table.first.type.instantiated_in (qualifier).deep_actual_type as r then
					Result := r
				end
			end
		end

	is_generic: BOOLEAN
			-- Is generated type generic?
		do
			Result := qualifier_creation.is_generic or else Precursor
		end

feature {NONE} -- Lookup

	feature_finder: TYPE_A_FEATURE_FINDER
			-- A facility to find a feature.
		once
			create Result
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

end
