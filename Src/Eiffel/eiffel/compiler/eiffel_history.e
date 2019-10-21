note
	description: "[
			Cache for storing polymorphic status of call to a certain feature
			with a routine id in the context of a class type id for final mode generation.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_HISTORY

inherit
	COMPILER_EXPORTER
	INTERNAL_COMPILER_STRING_EXPORTER
	SHARED_BYTE_CONTEXT
	SHARED_DECLARATIONS
	SHARED_GENERATION
	SHARED_SERVER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			create used.make (system.routine_id_counter.count)
			create used_for_types.make (system.routine_id_counter.count)
			create used_for_routines.make (system.routine_id_counter.count)
		end

feature -- Access


	poly_table (a_rout_id: INTEGER): POLY_TABLE [ENTRY]
			-- Routine table of id `a_rout_id'
		require
			a_rout_id_positive: a_rout_id > 0
			has_table: has_poly_table (a_rout_id)
		do
			Result := Tmp_poly_server.item (a_rout_id)
		ensure
			poly_table_not_void: Result /= Void
		end

	used: PACKED_BOOLEANS
	used_for_routines: PACKED_BOOLEANS
	used_for_types: PACKED_BOOLEANS
			-- Entries for finding out if a routine ID is used, and if it
			-- is for which reason (routine dispatch, type information).

feature -- Process

	start_degree_minus_3 (count: INTEGER)
			-- Create the data structures which are going to be used at degree -3.
		do
			create is_polymorphic_offset_table.make_filled (count)
			create is_polymorphic_body_table.make_filled (count)
			create min_id_table_for_offset.make_filled (0, 0, count)
			create min_id_table_for_body.make_filled (0, 0, count)
		end

feature -- Status

	has_poly_table (a_rout_id: INTEGER): BOOLEAN
			-- Do we have an entry for `a_rout_id'?
		require
			a_rout_id_positive: a_rout_id > 0
		do
			Result := tmp_poly_server.has (a_rout_id)
		end

	is_polymorphic_for_offset (rout_id: INTEGER; class_type: TYPE_A; a_context_type: CLASS_TYPE): INTEGER
			-- If the entry <`rout_id',`class_type'> is polymorphic to access an attribute, we return
			-- `min_used' if `used_requested', `min_type_id' otherwise.
			-- If the entry is not polymorphic we return `-1'.
			-- If the entry does not have a polymorphic table, we return `-2'
		require
			is_polymorphic_table_exists: attached is_polymorphic_offset_table
			positive_rout_id: rout_id > 0
		local
			bool_array: PACKED_BOOLEANS
			min_id: INTEGER
			class_type_id: INTEGER
			is_generic: BOOLEAN
		do
			if class_type.is_expanded then
					-- Call on an expanded type is not polymorphic.
				Result := -1
			else
					-- Get the array corresponding to the searched value
					-- if it is a valid `rout_id'.
					--
					-- Note: we check for voidness of `class_type.generics' as we cannot
					-- used the buffered information in that case which could exist
					-- for non-generic ancestor/descendants implementing `rout_id'.
					-- As for storing the information we could use the buffered information
					-- if the actuals were all expanded.
				is_generic := attached class_type.generics
				if not is_generic and then rout_id <= is_polymorphic_offset_table.upper then
					bool_array := is_polymorphic_offset_table [rout_id]
				end
				if attached bool_array then
						-- Compute minimum class type id for current `rout_id'.
					min_id := min_id_table_for_offset.item (rout_id)
						-- We already have computed something for this polymorphic
						-- table, we just need to search for the requested `class_type_id'
						-- to know if we can retrieve the value or if we had to compute it.
					class_type_id := class_type.type_id (a_context_type.type)
					if class_type_id >= min_id then
						Result := get_value (bool_array, class_type_id - min_id)
					else
						Result := is_feature_not_yet_computed
					end
					if Result = is_feature_not_yet_computed then
							-- The entry has not yet been computed
						if attached {ATTR_TABLE [ATTR_ENTRY]} tmp_poly_server.item (rout_id) as t then
							Result := t.polymorphic_status_for_offset (class_type, a_context_type)
							if Result /= -2 then
								if class_type_id >= min_id then
									put_value (bool_array, class_type_id - min_id, Result = 0)
								end
								if Result = 0 then
									Result := min_id
								end
							end
						else
							Result := -1
						end
					elseif Result = is_feature_polymorphic then
						Result := min_id
					else
						Result := -1
					end
				elseif attached {ATTR_TABLE [ATTR_ENTRY]} tmp_poly_server.item (rout_id) as t then
						-- First time, the information for <`rout_id',`class_type_id'> is requested
					Result := t.polymorphic_status_for_offset (class_type, a_context_type)
					if Result /= -2 then
							-- Store the polymorphic status of the searched entry.
							-- When we are handling with a ROUT_TABLE, we need to store
							-- the `min_used' id, otherwise its enough to store the
							-- `min_type_id'.
						min_id := t.min_type_id - 1
						min_id_table_for_offset.put (min_id, rout_id)
							-- We can only buffer when the target of the call is not generic.
							-- TODO: we could still buffer if all the actual generic parameters are expanded.
						if not is_generic then
								-- Create packed booleans array with bounds `2 * min_id'
								-- to `2 * entry.max_type_id'. `2' is because for each entry we store
								-- two informations: `is_computed' and then `is_polymorphic'.
							create bool_array.make (2 * (t.max_type_id - min_id))
								-- Store the value in the C array.
							class_type_id := class_type.type_id (a_context_type.type)
							if class_type_id >= min_id then
								put_value (bool_array, class_type_id - min_id, Result = 0)
							end
								-- Insert the new computed table in the array of computed tables.
							is_polymorphic_offset_table [rout_id] := bool_array
						end
							-- Return the result
						if Result = 0 then
							Result := min_id
						end
					end
				else
						-- Note: it might occur with object relative once.
					Result := -1
				end
			end
		end

	is_polymorphic_for_body (rout_id: INTEGER; class_type: TYPE_A; a_context_type: CLASS_TYPE): INTEGER
			-- If the entry <`rout_id',`class_type'> is polymorphic to access a routine, we return
			-- `min_used' if `used_requested', `min_type_id' otherwise.
			-- If the entry is not polymorphic we return `-1'.
			-- If the entry does not have a polymorphic table, we return `-2'
		require
			is_polymorphic_table_exists: attached is_polymorphic_body_table
			positive_rout_id: rout_id > 0
		local
			bool_array: PACKED_BOOLEANS
			min_id: INTEGER
			class_type_id: INTEGER
			is_generic: BOOLEAN
		do
			if class_type.is_expanded then
					-- Call on an expanded type is not polymorphic.
				Result := -1
			else
					-- Get the array corresponding to the searched value
					-- if it is a valid `rout_id'.
					--
					-- Note: we check for voidness of `class_type.generics' as we cannot
					-- used the buffered information in that case which could exist
					-- for non-generic ancestor/descendants implementing `rout_id'.
					-- As for storing the information we could use the buffered information
					-- if the actuals were all expanded.
				is_generic := attached class_type.generics
				if not is_generic and then rout_id <= is_polymorphic_body_table.upper then
					bool_array := is_polymorphic_body_table [rout_id]
				end
				if attached bool_array then
						-- Compute minimum class type id for current `rout_id'.
					min_id := min_id_table_for_body.item (rout_id)
						-- We already have computed something for this polymorphic
						-- table, we just need to search for the requested `class_type_id'
						-- to know if we can retrieve the value or if we had to compute it.
					class_type_id := class_type.type_id (a_context_type.type)
					if class_type_id >= min_id then
						Result := get_value (bool_array, class_type_id - min_id)
					else
						Result := is_feature_not_yet_computed
					end
					if Result = is_feature_not_yet_computed then
							-- The entry has not yet been computed
						if attached {ROUT_TABLE} tmp_poly_server.item (rout_id) as t then
							Result := t.polymorphic_status_for_body (class_type, a_context_type)
							if Result /= -2 then
								if class_type_id >= min_id then
									put_value (bool_array, class_type_id - min_id, Result = 0)
								end
								if Result = 0 then
									Result := min_id
								end
							end
						else
							Result := -1
						end
					elseif Result = is_feature_polymorphic then
						Result := min_id
					else
						Result := -1
					end
				elseif attached {ROUT_TABLE} tmp_poly_server.item (rout_id) as t then
						-- First time, the information for <`rout_id',`class_type_id'> is requested
					Result := t.polymorphic_status_for_body (class_type, a_context_type)
					if Result /= -2 then
							-- Store the polymorphic status of the searched entry.
							-- When we are handling with a ROUT_TABLE, we need to store
							-- the `min_used' id, otherwise its enough to store the
							-- `min_type_id'.
						min_id := t.min_used - 1
						min_id_table_for_body.put (min_id, rout_id)
							-- We can only buffer when the target of the call is not generic.
							-- TODO: we could still buffer if all the actual generic parameters are expanded.
						if not is_generic then
								-- Create packed booleans array with bounds `2 * min_id'
								-- to `2 * entry.max_type_id'. `2' is because for each entry we store
								-- two informations: `is_computed' and then `is_polymorphic'.
							create bool_array.make (2 * (t.max_type_id - min_id))
								-- Store the value in the C array.
							class_type_id := class_type.type_id (a_context_type.type)
							if class_type_id >= min_id then
								put_value (bool_array, class_type_id - min_id, Result = 0)
							end
								-- Insert the new computed table in the array of computed tables.
							is_polymorphic_body_table [rout_id] := bool_array
						end
							-- Return the result
						if Result = 0 then
							Result := min_id
						end
					end
				else
						-- Note: it might occur with object relative once.
					Result := -1
				end
			end
		end

feature -- Element change

	mark_used (rout_id: INTEGER)
			-- Mark routine table of routine id `rout_id' used.
		require
			rout_id_not_void: rout_id /= 0
		do
			used.force (True, rout_id)
			used_for_routines.force (True, rout_id)
		end

	mark_used_for_type (rout_id: INTEGER)
			-- Mark routine table of routine id `rout_id' used for type description.
		require
			rout_id_not_void: rout_id /= 0
		do
			used.force (True, rout_id)
			used_for_types.force (True, rout_id)
		end

	wipe_out
			-- Wipe out the structure
		do
			min_id_table_for_offset := Void
			min_id_table_for_body := Void
			is_polymorphic_offset_table := Void
			is_polymorphic_body_table := Void
			used.clear_all
			used_for_routines.clear_all
			used_for_types.clear_all
		end

feature -- C code generation

	generate_offset (routine_id: like {ROUT_TABLE}.rout_id; register: REGISTRABLE; target_type: TYPE_A; context_type: CLASS_TYPE; buffer: GENERATION_BUFFER)
			-- Generate an expression that adds the offset of the attribute of routine ID `routine_id`
			-- called on the register `register`of the type `target_type` in the context `context_type` into `buffer`.
		local
			array_index: like is_polymorphic_for_offset
			table_name: like encoder.attribute_table_name
		do
			array_index := is_polymorphic_for_offset (routine_id, target_type, context_type)
			if array_index >= 0 then
					-- The access is polymorphic, which means the offset
					-- is not a constant and has to be computed.
				table_name := encoder.attribute_table_name (routine_id)
					-- Generate following dispatch:
					-- table [Actual_offset - base_offset]
				buffer.put_three_character (' ', '+', ' ')
				buffer.put_string (table_name)
				buffer.put_character ('[')
				if register.is_current then
					context.generate_current_dtype
				else
					buffer.put_string ({C_CONST}.dtype)
					buffer.put_character ('(')
					register.print_register
					buffer.put_character (')')
				end
				buffer.put_character ('-')
				buffer.put_integer (array_index)
				buffer.put_character (']')
					-- Mark attribute offset table used.
				mark_used (routine_id)
					-- Remember external attribute offset declaration.
				extern_declarations.add_attribute_table (table_name)
			elseif array_index = -2 then
					-- No instances of the type are created, leave the offset empty.
			elseif attached {ATTR_TABLE [ATTR_ENTRY]} tmp_poly_server.item (routine_id) as t then
					-- The offset is fixed for all conforming types, hardwire it.
				t.generate_attribute_offset (buffer, target_type, context_type)
			else
				check is_attribute_table: False end
			end
		end

feature -- Cache

	is_polymorphic_offset_table: ARRAYED_LIST [detachable PACKED_BOOLEANS]
			-- Array of arrays which knows if a certain attribute id in a certain type id is polymorphic or not.
			--| They are created on the fly during the degree -5.

	is_polymorphic_body_table: ARRAYED_LIST [detachable PACKED_BOOLEANS]
			-- Array of arrays which knows if a certain routine id in a certain type id is polymorphic or not.
			--| They are created on the fly during the degree -5.

feature {NONE} -- Implementation

	min_id_table_for_offset: ARRAY [INTEGER]
			-- Array of INTEGER which contains for each `{ATTR_TABLE}` its `{ATTR_TABLE}.min_type_id`.

	min_id_table_for_body: ARRAY [INTEGER]
			-- Array of INTEGER which contains for each `{ROUT_TABLE}` its `{ROUT_TABLE}.min_used`.

	put_value (bool_array: PACKED_BOOLEANS; index: INTEGER; is_polymorphic: BOOLEAN)
			-- Mark feature call to routine represented by `bool_array' with
			-- `is_polymorphic' value for `index'.
		require
			bool_array_not_void: bool_array /= Void
			valid_index: index >= 0
		local
			i: INTEGER
		do
			i := 2 * index
			bool_array.force (True, i)
			bool_array.force (is_polymorphic, i + 1)
		ensure
			status_implies: is_polymorphic implies
				get_value (bool_array, index) = is_feature_polymorphic
			not_status_implies: not is_polymorphic implies
				get_value (bool_array, index) = is_feature_not_polymorphic
		end

	get_value (bool_array: PACKED_BOOLEANS; index: INTEGER): INTEGER
			-- Is feature call to routine represented by `bool_array' polymorphic
			-- for `index'?
		require
			bool_array_not_void: bool_array /= Void
			valid_index: index >= 0
		local
			i: INTEGER
		do
			i := 2 * index
				-- We already know that `index' is positive. If `index' has
				-- a greater value than the expected one, it means that we
				-- haven't yet computed the polymorphism status for a given
				-- CLASS_TYPE.
			if bool_array.valid_index (i + 1) then
				if bool_array.item (i) then
					if bool_array.item (i + 1) then
						Result := is_feature_polymorphic
					else
						Result := is_feature_not_polymorphic
					end
				else
					Result := is_feature_not_yet_computed
				end
			else
				Result := is_feature_not_yet_computed
			end
		ensure
			valid_result: Result = is_feature_polymorphic or
						Result = is_feature_not_polymorphic or
						Result = is_feature_not_yet_computed
		end

feature {NONE} -- Constants

	is_feature_polymorphic: INTEGER = 3
	is_feature_not_polymorphic: INTEGER = 2
	is_feature_not_yet_computed: INTEGER = -1

	default_size: INTEGER = 200
			-- Cache size

invariant
	used_not_void: used /= Void
	used_for_routines_not_void: used_for_routines /= Void
	used_for_types_not_void: used_for_types /= Void

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
