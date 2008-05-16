indexing
	description: "Representation of a table of routine pointer for the final Eiffel executable"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ROUT_TABLE

inherit

	POLY_TABLE [ROUT_ENTRY]
		redefine
			is_attribute_table, is_routine_table, tmp_poly_table, extend, merge
		end

	SHARED_GENERATOR
		undefine
			copy, is_equal
		end

	SHARED_GENERATION
		undefine
			copy, is_equal
		end

	SHARED_BODY_ID
		undefine
			copy, is_equal
		end

	SHARED_DECLARATIONS
		undefine
			copy, is_equal
		end

	SHARED_INCLUDE
		undefine
			copy, is_equal
		end

	SHARED_PATTERN_TABLE
		undefine
			copy, is_equal
		end

	SHARED_BYTE_CONTEXT
		undefine
			copy, is_equal
		end

create
	make

feature -- Insertion

	extend (v: ROUT_ENTRY) is
			-- <Precursor>
		do
			Precursor {POLY_TABLE} (v)
				-- Now compute the new value of `pattern_id'.
			if pattern_id = -2 then
				pattern_id := v.pattern_id
			elseif pattern_id /= v.pattern_id then
				pattern_id := -1
			end
		end

	merge (other: like Current) is
			-- <Precursor>
		do
			Precursor {POLY_TABLE} (other)
				-- Now compute the new value of `pattern_id'.
			if pattern_id = -2 then
				pattern_id := other.pattern_id
			elseif pattern_id /= other.pattern_id then
				pattern_id := - 1
			end
		end

feature -- Status report

	is_routine_table: BOOLEAN is
			-- Is the table a routine table?
		do
			Result := True
		end

	is_attribute_table: BOOLEAN is
			-- Is the current table an attribute table ?
		do
				-- False here.
		end

	is_implemented: BOOLEAN is
			-- Is implemented
			-- in a static type greater than `type_id'.
		require
			--| goto_implemented (type_id) called before
		do
			Result := position <= max_position
		end

	feature_name: STRING is
			-- Feature name of the first implemented feature available
			-- in a static type greater than `type_id' found by last
			-- call to `goto_implemented (type_id)'.
		require
			--| goto_implemented (type_id) called before
			is_implemented: is_implemented
		do
			Result := array_item (position).routine_name
		end

	new_entry (f: FEATURE_I; c: INTEGER): ENTRY is
			-- New entry corresponding to `f' in class of class ID `c'
		do
			Result := f.new_rout_entry
			Result.set_class_id (c)
		end

	is_polymorphic (a_type: TYPE_A; a_context_type: CLASS_TYPE): BOOLEAN is
			-- Is the table polymorphic from entry indexed by `type_id' to
			-- the maximum entry id ?
		local
			first_real_body_index, first_body_index, first_pattern_id: INTEGER;
			entry: ROUT_ENTRY;
			found: BOOLEAN;
			i, nb, old_position: INTEGER
			system_i: SYSTEM_I
			type_id: INTEGER
		do
			nb := max_position
			type_id := a_type.type_id (a_context_type.type)

			if nb > 1 then
				old_position := position
				system_i := System

				from
						-- Go to the entry of type id equal to `type_id'
					goto (type_id)
					i := position
						-- Polymorphism implies also that they have the same `pattern_id'.
						-- See eweasel test#final052 for an example where it is important.
					first_pattern_id := array_item (i).pattern_id
					goto_used_from_position (i)
					i := position
				until
					Result or else i > nb
				loop
					entry := array_item (i)
					if entry.used then
						if system_i.class_type_of_id (entry.type_id).dynamic_conform_to (a_type, type_id, a_context_type.type) then
							if found then
								Result := entry.real_body_index /= first_real_body_index or
									entry.body_index /= first_body_index or
									entry.pattern_id /= first_pattern_id
							else
								found := True
								first_real_body_index := entry.real_body_index
								first_body_index := entry.body_index
							end
						end
					end
					i := i + 1
				end
				position := old_position
			else
					-- Only one entry, it is clearly non-polymorphic.
				Result := False
			end
		end

feature -- Code generation

	generate (writer: TABLE_GENERATOR) is
			-- Generation of the routine table in buffer "erout*.c".
		require
			writer_attached: writer /= Void
		local
			l_min_used: INTEGER
			final_table_size: INTEGER
		do
			final_table_size := max_used - min_used + 1
			writer.update_size (final_table_size)
			l_min_used := min_used
			goto (l_min_used)
			internal_generate (writer.current_buffer, 0, final_table_size, l_min_used, max_used)
		end

	generate_full (real_rout_id: INTEGER; buffer: GENERATION_BUFFER) is
			-- Generation of the table in buffer "erout*.c" without optimizing the lower bound.
		local
			l_rout_id: INTEGER
			l_min_used: INTEGER
			l_table_name: STRING
		do
			if max_position = 0 then
				l_table_name := Encoder.routine_table_name (real_rout_id)
				buffer.put_string ("char *(*");
				buffer.put_string (l_table_name);
				buffer.put_string ("[")
				buffer.put_integer (system.type_id_counter.value)
				buffer.put_string ("])();");
				buffer.put_new_line
				buffer.put_string ("void ")
				buffer.put_string (l_table_name)
				buffer.put_string ("_init () {}")
				buffer.put_new_line
			else
				l_rout_id := rout_id
				rout_id := real_rout_id
				l_min_used := min_used
				goto (l_min_used)
					-- We do `l_min_used - 1' for the offset because in compiler
					-- IDs starts at 1, but at runtime they start at 0.
				internal_generate (buffer, l_min_used - 1, system.type_id_counter.value,
					l_min_used, max_used)
				rout_id := l_rout_id
			end
		end

	goto_implemented (a_type: TYPE_A; a_context_type: CLASS_TYPE) is
			-- Go to first implemented feature available in
			-- a static type greater than `type_id'.
		require
			a_type_not_void: a_type /= Void
			a_context_type_not_void: a_context_type /= Void
		local
			i, nb: INTEGER
			type_id: INTEGER
			l_done: BOOLEAN
			entry: ROUT_ENTRY
			system_i: like system
		do
			system_i := system
			type_id := a_type.type_id (a_context_type.type)
			goto_used (type_id)
			i := position
			from
				nb := max_position
			until
				i > nb or l_done
			loop
				entry := array_item (i)
				if entry.used then
					l_done := system_i.class_type_of_id (entry.type_id).dynamic_conform_to (a_type, type_id, a_context_type.type)
				end
				i := i + 1
			end
			if l_done then
				position := i - 1
			else
				position := i
			end
		ensure
			is_implemented: position <= max_position implies is_implemented
		end

feature {POLY_TABLE} -- Special data

	tmp_poly_table: ARRAY [ROUT_ENTRY] is
			-- Contain a copy of Current during a merge
		once
			create Result.make (1, Block_size)
		end

feature {NONE} -- Implementation

	add_header_files (include_list: ARRAY [INTEGER]) is
			-- Add `include_list' in header files of the `erout' files.
		require
			include_list_not_void: include_list /= Void
		local
			queue: like shared_include_queue
			i, nb: INTEGER
		do
			from
				i := include_list.lower
				nb := include_list.upper
				queue := shared_include_queue
			until
				i > nb
			loop
				queue.put (include_list.item (i))
				i := i + 1
			end
		end

	internal_generate (buffer: GENERATION_BUFFER; an_offset, a_table_size, a_min, a_max: INTEGER) is
			-- Generate current routine table starting from index `a_min' to `a_max'.
		require
			buffer_not_void: buffer /= Void
			a_min_positive: a_min > 0
			a_max_positive: a_max > 0
			a_max_greater_or_equal_than_a_min: a_max >= a_min
		local
			entry, l_rout_entry: ROUT_ENTRY;
			i, j, nb, index: INTEGER;
			l_start, l_end: INTEGER
			l_generate_entry: BOOLEAN
			l_routine_name, l_wrapped_name: STRING;
			l_table_name: STRING
			l_wrappers: SEARCH_TABLE [STRING]
			l_seed_pattern_id, l_pattern_id: INTEGER
			l_seed: FEATURE_I
			l_c_pattern: C_PATTERN
			l_c_pattern_args: ARRAY [STRING]
		do
				-- We generate a compact table initialization, that is to say if two or more
				-- consecutives rows are identical we will generate a loop to fill the rows
			from
				buffer.put_new_line
				buffer.put_string ("char *(*");
				l_table_name := Encoder.routine_table_name (rout_id)
				buffer.put_string (l_table_name);
				buffer.put_string ("[")
				buffer.put_integer (a_table_size)
				buffer.put_string ("])();")
				buffer.put_new_line
				buffer.put_string ("void ")
				buffer.put_string (l_table_name)
				buffer.put_string ("_init () {")
				buffer.indent
				i := a_min;
				j := an_offset
				nb := a_max;
				index := position
					-- Compute the `pattern_id' for the current routine:
					-- If `pattern_id' is changing, we take the first one if it is not coming
					-- from a feature which has some formals, otherwise we create a pattern ID
					-- to cover all the possible cases.
					--| If we are handling a fake `rout_id' then the `pattern_id' should be the same for all entries.
				check
					consistent: not system.routine_id_counter.is_feature_routine_id (rout_id) implies has_one_signature
				end
				if not has_one_signature then
					l_seed := system.seed_of_routine_id (rout_id)
					if l_seed.has_formal then
							-- The most generic parameter we can get which can be used for the various kind
							-- of generic derivations of a generic class. For example, if you have A [G, H]
							-- but that in your system you only have instanced of A [ANY, INTEGER] and A [INTEGER, ANY]
							-- then to properly do the polymorphic accesses you need a common ancestor to both
							-- generic derivation. Since we cannot create the common ancestor, we simply take the
							-- PATTERN for the feature and immediately request its C_PATTERN which will give
							-- us the same data if we had A [ANY, ANY] in the universe.
						l_c_pattern := l_seed.pattern.c_pattern
						l_seed_pattern_id := pattern_table.c_pattern_id (l_c_pattern)
					else
						l_seed_pattern_id := array_item (lower).pattern_id
						l_c_pattern := pattern_table.c_pattern_of_id (l_seed_pattern_id)
					end
				else
					l_seed_pattern_id := pattern_id
					l_c_pattern := pattern_table.c_pattern_of_id (l_seed_pattern_id)
				end
				check
					l_seed_pattern_id_positive: l_seed_pattern_id > 0
				end
					-- Get the argument for the pattern.
				l_c_pattern_args := l_c_pattern.argument_type_array
				wrapper_buffer.clear_all
			until
				i > nb
			loop
				entry := array_item (index);
				if i = entry.type_id then
					if entry.used then
						if l_rout_entry = Void then
							l_rout_entry := entry
							l_start := j
							l_end := j
						else
							if l_rout_entry.same_as (entry) then
								l_end := j
							else
								l_generate_entry := True
							end
						end
					else
						l_generate_entry := True
						entry := Void
					end
					index := index + 1
				else
					l_generate_entry := True
					entry := Void
				end;
				if l_generate_entry then
					l_generate_entry := False
					if l_rout_entry /= Void then
						l_routine_name := l_rout_entry.routine_name
						l_pattern_id := l_rout_entry.pattern_id
						if l_seed_pattern_id /= l_pattern_id then
								-- A wrapper needs to be used/generated.
							l_wrapped_name := l_routine_name.twin
							l_wrapped_name.append_character ('_')
							l_wrapped_name.append_integer (rout_id)

							if l_wrappers = Void then
								create l_wrappers.make (10)
							end
							if not l_wrappers.has (l_wrapped_name) then
									-- We need to generate a wrapper.
								generate_wrapper (wrapper_buffer, l_rout_entry, l_seed_pattern_id, l_pattern_id, l_wrapped_name, l_routine_name)
								l_wrappers.put (l_wrapped_name)
							end
							l_routine_name := l_wrapped_name
						else
								-- Remember external routine declaration
							extern_declarations.add_routine_with_signature (l_c_pattern.result_type.c_string, l_routine_name, l_c_pattern_args)
						end
						generate_loop_initialization (buffer, l_table_name, l_routine_name, l_start, l_end)

							-- Prepare for next iteration.
						l_rout_entry := entry
						l_start := j
						l_end := j
					end
				end
				i := i + 1
				j := j + 1
			end;
			if l_rout_entry /= Void then
				l_routine_name := l_rout_entry.routine_name
				l_pattern_id := l_rout_entry.pattern_id
				if l_seed_pattern_id /= l_pattern_id then
						-- A wrapper needs to be used/generated.
					l_wrapped_name := l_routine_name.twin
					l_wrapped_name.append_character ('_')
					l_wrapped_name.append_integer (rout_id)

					if l_wrappers = Void then
						create l_wrappers.make (10)
					end
					if not l_wrappers.has (l_wrapped_name) then
							-- We need to generate a wrapper.
						generate_wrapper (wrapper_buffer, l_rout_entry, l_seed_pattern_id, l_pattern_id, l_wrapped_name, l_routine_name)
						l_wrappers.put (l_wrapped_name)
					end
					l_routine_name := l_wrapped_name
				else
						-- Remember external routine declaration
					extern_declarations.add_routine_with_signature (l_c_pattern.result_type.c_string, l_routine_name, l_c_pattern_args)
				end
				generate_loop_initialization (buffer, l_table_name, l_routine_name, l_start, l_end)
			end
			buffer.exdent
			buffer.put_new_line
			buffer.put_string ("}")
				-- Add wrappers if any.
			buffer.put_buffer (wrapper_buffer)
			buffer.put_new_line
		end

	generate_wrapper (buffer: GENERATION_BUFFER; a_entry: ROUT_ENTRY; a_seed_pattern_id, a_pattern_id: INTEGER; a_wrapped_name, a_routine_name: STRING) is
			-- Generate wrapper for `a_routine_name' called `a_wrapped_name' using signature information from `a_seed_pattern_id' and `a_pattern_id'.
		require
			buffer_not_void: buffer /= Void
			a_entry_not_void: a_entry /= Void
			a_seed_pattern_id_positive: a_seed_pattern_id > 0
			a_pattern_id_positive: a_pattern_id > 0
			a_wrapped_name_not_void: a_wrapped_name /= Void
			a_wrapped_name_not_empty: not a_wrapped_name.is_empty
			a_routine_name_not_void: a_routine_name /= Void
			a_routine_name_not_empty: not a_routine_name.is_empty
		local
			l_seed_c_pattern, l_c_pattern: C_PATTERN
			l_result_string: STRING
			l_arg_names, l_arg_types: ARRAY [STRING]
			l_seed_type, l_type: TYPE_C
			l_is_return_value_boxed: BOOLEAN
			l_type_a: TYPE_A
			l_basic_type: BASIC_A
			i, nb: INTEGER
			l_feat: FEATURE_I
			l_old_buffer: GENERATION_BUFFER
		do
			l_seed_c_pattern := pattern_table.c_pattern_of_id (a_seed_pattern_id)
			l_c_pattern := pattern_table.c_pattern_of_id (a_pattern_id)

				-- We first generate the signature using `l_seed_c_pattern'.
			l_result_string := l_seed_c_pattern.result_type.c_string
			l_arg_names := l_seed_c_pattern.argument_name_array
			l_arg_types := l_seed_c_pattern.argument_type_array
			extern_declarations.add_wrapper_with_signature (l_result_string, a_wrapped_name, l_arg_types)
			extern_declarations.add_routine_with_signature (l_c_pattern.result_type.c_string, a_routine_name, l_c_pattern.argument_type_array)

			buffer.generate_function_signature (l_result_string, a_wrapped_name, False, Void, l_arg_names, l_arg_types)
			buffer.generate_block_open
			buffer.put_new_line
			l_seed_type := l_seed_c_pattern.result_type
			l_type := l_c_pattern.result_type
			if not l_seed_type.is_void then
				check actual_not_void: not l_type.is_void end
				if l_seed_type.same_as (l_type) then
					buffer.put_string ("return ")
				else
						-- The declaration are different, we need to adapt the return type.
						-- Currently we can only accept that the seed type is a reference
						-- and the current type a basic type but we could easily change
						-- that in the future if the language rules were to change.
					check
						different_types: l_seed_type.is_pointer and not l_type.is_pointer
					end
						-- In this case, we need to box the result type and for that we need
						-- to store the boxed result in `Result' and the actual result in `r'.
					l_seed_type.generate (buffer)
					buffer.put_string ("Result;")
					buffer.put_new_line;
					l_type.generate (buffer)
					buffer.put_four_character ('r', ' ', '=', ' ')
					l_is_return_value_boxed := True
				end
			end
			buffer.put_string (a_routine_name)
			buffer.put_character ('(')
				-- Now generate the arguments.
			from
					-- First current
				buffer.put_string (l_arg_names.item (1))
				i := 2
				nb := l_arg_types.count
			until
				i > nb
			loop
				buffer.put_two_character (',', ' ')
					-- It is `i - 1' because they do not include Current.
				l_seed_type := l_seed_c_pattern.argument_types.item (i - 1)
				l_type := l_c_pattern.argument_types.item (i - 1)
				if not l_seed_type.same_as (l_type) then
						-- The declaration are different, we need to adapt the argument.
						-- Currently we can only accept that the seed type is a reference
						-- and the current type a basic type but we could easily change
						-- that in the future if the language rules were to change.
					check
						different_types: l_seed_type.is_pointer and not l_type.is_pointer
					end
						-- Unbox the value
					buffer.put_character ('*')
					l_type.generate_access_cast (buffer)
				end
				buffer.put_string (l_arg_names.item (i))
				i := i + 1
			end
			buffer.put_two_character (')', ';')
			if l_is_return_value_boxed then
					-- Generate boxing of result type with an optimization to not recreate
					-- an object all the time, only when necessary.
				l_seed_type := l_seed_c_pattern.result_type
				l_type := l_c_pattern.result_type
				buffer.generate_block_open
				buffer.put_gtcx
				buffer.put_new_line
				buffer.put_string ("if (eif_optimize_return) {")
				buffer.indent
				buffer.put_new_line
				buffer.put_string ("eif_optimize_return = 0;")
				buffer.put_new_line
				buffer.put_string ("eif_optimized_return_value.")
				l_type.generate_typed_field (buffer)
				buffer.put_string (" = r;")
				buffer.put_new_line
				buffer.put_string ("return (EIF_REFERENCE) &eif_optimized_return_value.")
				l_type.generate_typed_field (buffer)
				buffer.put_character (';')
				buffer.exdent
				buffer.put_new_line
				buffer.put_string ("} else {")
				buffer.indent
					-- Because `TYPE_C' do not carry much type information, we need to get it back
					-- from the FEATURE_I instance.
				l_feat := a_entry.access_class.feature_of_body_index (a_entry.body_index)
				check
					l_feat_not_void: l_feat /= Void
				end
					-- Instantiate the return type of the query into the context of the CLASS_TYPE
					-- to get the appropriate type.
				l_type_a := l_feat.type.instantiated_in (a_entry.access_class_type.type).actual_type
				if l_type_a.is_like_current then
					l_type_a := l_type_a.conformance_type
				end
				l_basic_type ?= l_type_a
				check is_basic_type: l_basic_type /= Void end
					-- Because `metamorphose' indirectly uses BYTE_CONTEXT.buffer we need to configure
					-- it to use `buffer' instead.
				l_old_buffer := context.buffer
				context.set_buffer (buffer)
				l_basic_type.metamorphose (
					create {NAMED_REGISTER}.make ("Result", l_seed_type),
					create {NAMED_REGISTER}.make ("r", l_type), buffer)
				context.set_buffer (l_old_buffer)
				buffer.put_character (';')
				buffer.put_new_line
				buffer.put_string ("return Result;")
				buffer.exdent
				buffer.put_new_line
				buffer.put_character ('}')
				buffer.generate_block_close
			end
			buffer.generate_block_close
		end

	generate_loop_initialization (buffer: GENERATION_BUFFER; a_table_name, a_routine_name: STRING; a_lower, a_upper: INTEGER) is
			-- Generate code to initialize current array with `a_routine_name'. Generate a
			-- loop if `a_lower' is different from `a_upper'.
		require
			buffer_not_void: buffer /= Void
			a_table_name_not_void: a_table_name /= Void
			a_routine_name_not_void: a_routine_name /= Void
			a_lower_non_negative: a_lower >= 0
			a_upper_non_negative: a_upper >= 0
			a_upper_greater_or_equal_than_a_lower: a_upper >= a_lower
		do
			buffer.put_new_line
			if a_lower = a_upper then
				buffer.put_string (a_table_name)
				buffer.put_character ('[')
				buffer.put_integer (a_lower)
				buffer.put_string ("] = ")
				buffer.put_string (function_ptr_cast_string);
				buffer.put_string (a_routine_name);
				buffer.put_character (';')
			else
					-- FIXME: Manu: 03/23/2004: The following line should be used.
					-- Unfortunately, there is a bug in VC6++ which prevents the C
					-- compilation. Therefore we use a trick, we use a volatile version
					-- of `i'. It might be slightly slower but it is barely noticeable.
					-- So as soon as we do not need to support VC6++, then we can restore
					-- the next line.
--				buffer.put_string ("{long i; for (i = ")
				buffer.put_string ("{volatile long i; for (i = ")
				buffer.put_integer (a_lower)
				buffer.put_string ("; i < ")
				buffer.put_integer (a_upper + 1)
				buffer.put_string ("; i++) ")
				buffer.put_string (a_table_name)
				buffer.put_string ("[i] = ")
				buffer.put_string (function_ptr_cast_string);
				buffer.put_string (a_routine_name);
				buffer.put_two_character (';', '}')
			end
		end

	function_ptr_cast_string: STRING is "(char *(*)()) ";
			-- String representing cast to type of function pointer

	write is
			-- Generate table using writer.
		do
			generate (Rout_generator)
		end

	write_for_type
			-- <Precursor>
		do
			generate_type_table (rout_generator)
		end

	wrapper_buffer: GENERATION_BUFFER is
			-- Buffer to generate a polymorphic wrapper.
		once
			create Result.make (500)
		ensure
			wrapper_buffer_not_void: Result /= Void
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

end
