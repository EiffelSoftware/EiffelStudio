note
	description: "Representation of a table of routine pointer for the final Eiffel executable"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ROUT_TABLE

inherit

	POLY_TABLE [ROUT_ENTRY]
		export
			{ANY} has
		redefine
			extend,
			is_routine_table,
			merge
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

	SHARED_TABLE
		undefine
			copy, is_equal
		end

	INTERNAL_COMPILER_STRING_EXPORTER
		undefine
			copy, is_equal
		end

create
	make

feature -- Insertion

	extend (v: ROUT_ENTRY)
			-- <Precursor>
		do
			Precursor {POLY_TABLE} (v)
				-- Update `pattern_id`.
			if pattern_id = -2 then
				pattern_id := v.pattern_id
			elseif pattern_id /= v.pattern_id then
				pattern_id := -1
			end
				-- Update `body_index`.
			if body_index /= body_index_various and then v.is_polymorphic then
				if body_index = body_index_unknown then
						-- There were no implementations registered yet.
					body_index :=
						if v.written_class.is_generic then
								-- If the seed is a generic class, there could be different generic derivations.
							body_index_various
						else
								-- Record the only implementation so far.
							v.body_index
						end
				elseif body_index /= v.body_index then
						-- There are different implementations.
					body_index := body_index_various
				end
			end
		end

	merge (other: like Current)
			-- <Precursor>
		do
			Precursor {POLY_TABLE} (other)
				-- Update `pattern_id`.
			if pattern_id = -2 then
				pattern_id := other.pattern_id
			elseif pattern_id /= other.pattern_id then
				pattern_id := - 1
			end
				-- Update `body_index`.
			if body_index /= body_index_various and then other.body_index /= body_index_unknown then
				if body_index = body_index_unknown then
					body_index := other.body_index
				elseif body_index /= other.body_index then
					body_index := body_index_various
				end
			end
		end

feature -- Status report

	is_routine_table: BOOLEAN
			-- Is the table a routine table?
		do
			Result := True
		end

	is_implemented: BOOLEAN
			-- Is implemented
			-- in a static type greater than `type_id'.
		require
			--| goto_implemented (type_id) called before
		do
			Result := position <= max_position
		end

	feature_name: STRING
			-- Feature name of the first implemented feature available
			-- in a static type greater than `type_id' found by last
			-- call to `goto_implemented (type_id)'.
			-- ASCII compatible.
		require
			--| goto_implemented (type_id) called before
			is_implemented: is_implemented
		do
			Result := array_item (position).routine_name
		end

	new_entry (f: FEATURE_I; t: CLASS_TYPE; d: BOOLEAN; c: INTEGER): ENTRY
			-- <Precursor>
		do
			Result := f.new_rout_entry (t, d, c)
		end

	polymorphic_status_for_body (a_type: TYPE_A; a_context_type: CLASS_TYPE): INTEGER_8
			-- Polymorphic status is the table from entry indexed by `a_type` relative to `a_context_type`
			-- to the maximum entry id:
			-- 0 - polymorphic
			-- -1 - non-polymorphic with a suitable implementation
			-- -2 - non-polymorphic without any suitable implementation
		require
			a_type_not_void: a_type /= Void
			a_context_type_not_void: a_context_type /= Void
		local
			first_real_body_index, first_body_index, first_pattern_id: INTEGER;
			entry: ROUT_ENTRY
			i, nb, old_position: INTEGER
			system_i: SYSTEM_I
			type_id: INTEGER
			storage: like area
			context_type: CL_TYPE_A
		do
			Result := -2
			system_i := System
			inspect
				body_index
			when body_index_unknown then
				check Result = -2 end
			when body_index_various then
				nb := max_position
				old_position := position
				context_type := a_context_type.type
				type_id := a_type.type_id (context_type)
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
					Result = 0 or else i > nb
				loop
					entry := array_item (i)
					if
						entry.used and then
						system_i.class_type_of_id (entry.type_id).is_binding_of (a_type, type_id, context_type)
					then
						if entry.pattern_id /= first_pattern_id then
								-- If the pattern ID is does not match the one from the current type
								-- then the call has to be polymorphic. See eweasel test#ccomp040 and test#ccomp083.
							Result := 0
						elseif Result = -2 then
							Result := -1
							first_real_body_index := entry.real_body_index
							first_body_index := entry.body_index
						elseif
							entry.real_body_index /= first_real_body_index or else
							entry.body_index /= first_body_index
						then
							Result := 0
						end
					end
					i := i + 1
				end
				position := old_position
			else
					-- There is a single body index.
					-- Still, return -2 if there are no used conforming entries.
				if not attached system_i.remover as r then
						-- There was no dead code removal and the feature is not deferred.
					Result := -1
				elseif r.is_code_reachable (body_index) then
						-- The feature is reachable, check if there are conforming types of live classes.
					context_type := a_context_type.type
					type_id := a_type.type_id (context_type)
					from
						goto (type_id)
						storage := area
						i := position - lower + {like area}.lower
						nb := max_position
					until
						i >= nb
					loop
						entry := storage [i]
						if
							system_i.is_class_type_alive (entry.type_id) and then
							system_i.class_type_of_id (entry.type_id).is_binding_of (a_type, type_id, context_type)
						then
								-- There are used conforming entries in the table.
							Result := -1
							i := nb - 1
						end
						i := i + 1
					end
				end
			end
		ensure
			valid_result: Result = 0 or Result = -1 or Result = -2
			Result >= -1 implies used
		end

	is_inlinable (a_type: TYPE_A; a_context_type: CLASS_TYPE): BOOLEAN
			-- Even if a routine is not polymorphic, it is possible that a call
			-- cannot be inlined if the same body is used in two different descendants
			-- without relationship (See eweasel test#final087).
			-- We assume that `position' is the first implementation of the deferred routine
			-- in `a_type'.
		require
			a_type_not_void: a_type /= Void
			a_context_type_not_void: a_context_type /= Void
			valid_position: valid_index (position)
		local
			entry: ROUT_ENTRY;
			i, nb, old_position: INTEGER
			system_i: SYSTEM_I
			type_id: INTEGER
			l_parent_type, l_child_type: CLASS_TYPE
		do
				-- We assume True by default
			Result := True

			nb := max_position
			if nb > 1 then
				old_position := position
				type_id := a_type.type_id (a_context_type.type)
				system_i := System

					-- Go to the entry of type id equal to `type_id' to check if
					-- the original entry was deferred.
				goto (type_id)
				i := position
				if array_item (i).is_deferred then
						-- This is a deferred entry so we need to check
						-- that all descendant of the first implementation are in one single
						-- branch of inheritance. To do so we check that two consecutive
						-- types (`l_parent_type' and `l_child_type') conforming to `a_type'
						-- are conforming.
						-- We can do consecutive types because the table is sorted in topological order.
					from
							-- Restore the position to go to the first implemented routine.
						i := old_position
						l_parent_type := system_i.class_type_of_id (array_item (i).type_id)
							-- We have computed the first element, we go directly to the next one.
						i := i + 1
					until
						i > nb
					loop
						entry := array_item (i)
						if entry.used then
							l_child_type := system.class_type_of_id (entry.type_id)
								-- First check that the entry can be dynamically bound to `a_type`.
							if l_child_type.is_binding_of (a_type, type_id, a_context_type.type) then
									-- Then check that the entry can be dynamically bound to `l_parent_type`.
								if l_child_type.is_binding_of (l_parent_type.type, l_parent_type.type_id, Void) then
										-- Types are still suitable, continue the descent, and use `l_child_type` as the new parent.
									l_parent_type := l_child_type
								else
										-- No dynamic binding here.
										-- A call to a deferred routine that has only one implementation cannot be inlined.
									i := nb + 1
									Result := False
								end
							end
						end
						i := i + 1
					end
				end
				position := old_position
			end
		end

	used: BOOLEAN
			-- Is the table effectively used?
		local
			i, nb: INTEGER
		do
			from
				i := lower
				nb := max_position
			until
				Result or else i > nb
			loop
				Result := array_item(i).used
				i := i + 1
			end;
		end

feature -- Access

	body_index: like {FEATURE_I}.body_index
			-- A single body index used in the table, or `body_index_unknown`, or `body_index_various`.

	body_index_unknown: like body_index = 0
			-- A value of `body_index` indicating that there are no effective features in the table.

	body_index_various: like body_index = -1
			-- A value of `body_index` indicating that there are more than one effective features in the table.

	min_used: INTEGER
			-- Minimum used type id ?
		require
			not_empty: count > 0
			is_used: used
		local
			entry: ROUT_ENTRY
			i: INTEGER
		do
			from
				i := lower
			until
				Result > 0
			loop
				entry := array_item (i)
				if entry.used then
					Result := entry.type_id
				end
				i := i + 1
			end
		end

	max_used: INTEGER
			-- Minimum used type id ?
		require
			not_empty: count > 0
			is_used: used
		local
			entry: ROUT_ENTRY
			i: INTEGER
		do
			from
				i := max_position
			until
				Result > 0
			loop
				entry := array_item (i)
				if entry.used then
					Result := entry.type_id
				end
				i := i - 1
			end
		end

	context_item: ROUT_ENTRY
			-- The entry found by `goto`, `goto_used`, `goto_implemented`.
		do
			Result := array_item (context_position)
		end

feature -- Code generation

	generate_initialization (buf: GENERATION_BUFFER; header_buf: GENERATION_BUFFER)
			-- <Precursor>
		local
			l_table_name: STRING
		do
			l_table_name := encoder.routine_table_name (rout_id)
				-- Declare initialization routine for table
			header_buf.put_new_line
			header_buf.put_string ("extern void ")
			header_buf.put_string (l_table_name)
			header_buf.put_string ("_init(void);")
				-- Call the routine
			buf.put_new_line
			buf.put_string (l_table_name)
			buf.put_string ("_init();")
		end

	generate (writer: TABLE_GENERATOR)
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

	generate_full (real_rout_id: INTEGER; buffer: GENERATION_BUFFER)
			-- Generation of the table in buffer "erout*.c" without optimizing the lower bound.
		local
			l_rout_id: INTEGER
			l_min_used: INTEGER
			l_table_name: STRING
		do
			if max_position = 0 or not used then
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

	goto_implemented (a_type: TYPE_A; a_context_type: CLASS_TYPE)
			-- Go to first implemented feature available in
			-- a static type greater than `a_type.type_id (a_context_type.type)`.
			-- Set `context_position` to the entry of type ID `a_type.type_id (a_context_type.type)`.
		require
			a_type_not_void: a_type /= Void
			a_context_type_not_void: a_context_type /= Void
		local
			i, nb: INTEGER
			type_id: INTEGER
			l_done: BOOLEAN
			entry: ROUT_ENTRY
			system_i: like system
			context_cl_type: CL_TYPE_A
		do
			system_i := system
			context_cl_type := a_context_type.type
			type_id := a_type.type_id (context_cl_type)
			goto_used (type_id)
			i := position
			from
				nb := max_position
			until
				i > nb or l_done
			loop
				entry := array_item (i)
				if entry.used then
					l_done := system_i.class_type_of_id (entry.type_id).is_binding_of (a_type, type_id, context_cl_type)
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

	trampoline_name (e, c: ROUT_ENTRY): READABLE_STRING_8
			-- The name of a trampoline for the entry `e` when called in the context where `c` is expected.
		require
			has (e)
			has (c)
			e.pattern_id /= c.pattern_id
		do
			Result := trampoline_name_from_routine_name (e.routine_name, c.pattern_id)
		end

	generate_trampoline (type_id: INTEGER; trampoline_pattern_id: INTEGER; writer: TABLE_GENERATOR)
			-- Generate trampoline for type ID `type_id` with the signature corresponding to `trampoline_pattern_id`
			-- using the specified `writer` for output.
		local
			n: like feature_name
			e: ROUT_ENTRY
		do
			goto (type_id)
			e := item
			if e.pattern_id /= trampoline_pattern_id then
				n := e.routine_name
				generate_wrapper
					(writer.current_buffer,
					item,
					trampoline_pattern_id,
					item.pattern_id,
					trampoline_name_from_routine_name (n, trampoline_pattern_id),
					n)
			end
		end

feature {NONE} -- Naming

	trampoline_name_from_routine_name (n: READABLE_STRING_8; p: INTEGER): READABLE_STRING_8
			-- The name of a trampoline built from the given routine name `n`
			-- when called in the context where the pattern of ID `p` is expected.
		local
			s: STRING_8
		do
			create s.make_from_string (n)
			s.append_character ('_')
			s.append_integer (rout_id)
			s.append_character ('_')
			s.append_integer (p)
			Result := s
		end

feature -- Iteration

	goto_used (type_id: INTEGER)
			-- Move cursor to the first entry of type_id `type_id'
			-- associated to an used effective class (non-deferred).
			-- Set `context_position` to the entry of `type_id`.
		require
			positive: type_id > 0
		local
			i, nb: INTEGER
		do
			from
				i := binary_search (type_id)
				context_position := i
				nb := max_position
			until
				i = nb or else array_item (i).used
			loop
				i := i + 1
			end
			position := i
		end

	goto_used_from_position (a_pos: INTEGER)
			-- Move cursor to the first entry after position `a_pos'
			-- associated to an used effective class (non-deferred).
		require
			a_pos_positive: a_pos >= 0
			not_too_big: a_pos <= max_position
		local
			i, nb: INTEGER
		do
			from
				i := a_pos
				nb := max_position
			until
				array_item(i).used or else i = nb
			loop
				i := i + 1
			end
			position := i
		end

feature {POLY_TABLE} -- Special data

	tmp_poly_table: ARRAY [ROUT_ENTRY]
			-- Contain a copy of Current during a merge
		once
			create Result.make (1, Block_size)
		end

feature {NONE} -- Implementation

	internal_generate (buffer: GENERATION_BUFFER; an_offset, a_table_size, a_min, a_max: INTEGER)
			-- Generate current routine table starting from index `a_min' to `a_max'.
		require
			buffer_not_void: buffer /= Void
			a_min_positive: a_min > 0
			a_max_positive: a_max > 0
			a_max_greater_or_equal_than_a_min: a_max >= a_min
		local
			entry, l_rout_entry: ROUT_ENTRY
			i, j, nb, index: INTEGER
			l_start, l_end: INTEGER
			l_generate_entry: BOOLEAN
			l_routine_name, l_wrapped_name: READABLE_STRING_8
			l_table_name: STRING
			l_wrappers: SEARCH_TABLE [READABLE_STRING_8]
			l_seed_pattern_id, l_pattern_id: INTEGER
			l_seed: FEATURE_I
			l_c_pattern: C_PATTERN
			l_c_pattern_args: ARRAY [STRING]
		do
				-- We generate a compact table initialization, that is to say if two or more
				-- consecutives rows are identical we will generate a loop to fill the rows
			from
				buffer.put_new_line
				buffer.put_string (once "char *(*");
				l_table_name := Encoder.routine_table_name (rout_id)
				buffer.put_string (l_table_name);
				buffer.put_character ('[')
				buffer.put_integer (a_table_size)
				buffer.put_string (once "])();")
				buffer.put_new_line
				buffer.put_string (once "void ")
				buffer.put_string (l_table_name)
				buffer.put_string (once "_init () {")
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
				if has_one_signature then
					l_seed_pattern_id := pattern_id
					l_c_pattern := pattern_table.c_pattern_of_id (l_seed_pattern_id)
				else
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
						if l_seed_pattern_id = l_pattern_id then
								-- Remember external routine declaration
							extern_declarations.add_routine_with_signature (l_c_pattern.result_type.c_string, l_routine_name, l_c_pattern_args)
						else
								-- A wrapper needs to be used/generated.
							l_wrapped_name := trampoline_name_from_routine_name (l_routine_name, l_seed_pattern_id)
							if l_wrappers = Void then
								create l_wrappers.make (10)
							end
							if not l_wrappers.has (l_wrapped_name) then
									-- We need to generate a wrapper.
								generate_wrapper (wrapper_buffer, l_rout_entry, l_seed_pattern_id, l_pattern_id, l_wrapped_name, l_routine_name)
								l_wrappers.put (l_wrapped_name)
							end
							l_routine_name := l_wrapped_name
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
				if l_seed_pattern_id = l_pattern_id then
						-- Remember external routine declaration
					extern_declarations.add_routine_with_signature (l_c_pattern.result_type.c_string, l_routine_name, l_c_pattern_args)
				else
						-- A wrapper needs to be used/generated.
					l_wrapped_name := trampoline_name_from_routine_name (l_routine_name, l_seed_pattern_id)
					if l_wrappers = Void then
						create l_wrappers.make (10)
					end
					if not l_wrappers.has (l_wrapped_name) then
							-- We need to generate a wrapper.
						generate_wrapper (wrapper_buffer, l_rout_entry, l_seed_pattern_id, l_pattern_id, l_wrapped_name, l_routine_name)
						l_wrappers.put (l_wrapped_name)
					end
					l_routine_name := l_wrapped_name
				end
				generate_loop_initialization (buffer, l_table_name, l_routine_name, l_start, l_end)
			end
			buffer.exdent
			buffer.put_new_line
			buffer.put_character ('}')
				-- Add wrappers if any.
			buffer.put_buffer (wrapper_buffer)
			buffer.put_new_line
		end

	generate_wrapper (buffer: GENERATION_BUFFER; a_entry: ROUT_ENTRY; a_seed_pattern_id, a_pattern_id: INTEGER; a_wrapped_name, a_routine_name: READABLE_STRING_8)
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
			i, nb: INTEGER
			l_feat: FEATURE_I
			l_old_buffer: GENERATION_BUFFER
			is_extern: BOOLEAN
		do
			l_seed_c_pattern := pattern_table.c_pattern_of_id (a_seed_pattern_id)
			l_c_pattern := pattern_table.c_pattern_of_id (a_pattern_id)

				-- We first generate the signature using `l_seed_c_pattern'.
			l_result_string := l_seed_c_pattern.result_type.c_string
			l_arg_names := l_seed_c_pattern.argument_name_array
			l_arg_types := l_seed_c_pattern.argument_type_array
			if system.has_trampoline (a_entry, a_seed_pattern_id, rout_id) then
					-- Declare the function as visible to outer modules.
				extern_declarations.add_routine_with_signature (l_result_string, a_wrapped_name, l_arg_types)
				is_extern := True
					-- Remove the trampoline because it is going to be generated now.
				system.remove_trampoline (a_entry, a_seed_pattern_id, Current)
			else
					-- Declare the function as invisible to outer modules.
				extern_declarations.add_wrapper_with_signature (l_result_string, a_wrapped_name, l_arg_types)
			end
			extern_declarations.add_routine_with_signature (l_c_pattern.result_type.c_string, a_routine_name, l_c_pattern.argument_type_array)

			buffer.generate_function_signature (l_result_string, a_wrapped_name, is_extern, Void, l_arg_names, l_arg_types)
			buffer.generate_block_open
			l_seed_type := l_seed_c_pattern.result_type
			l_type := l_c_pattern.result_type
			if not l_seed_type.is_void then
				check actual_not_void: not l_type.is_void end
				if l_seed_type.same_as (l_type) then
					buffer.put_new_line
					buffer.put_string ({C_CONST}.return); buffer.put_character (' ')
				else
						-- The declaration are different, we need to adapt the return type.
						-- Currently we can only accept that the seed type is a reference
						-- and the current type a basic type but we could easily change
						-- that in the future if the language rules were to change.
					check
						different_types: l_seed_type.is_reference and not l_type.is_reference
					end
						-- In this case, we need to box the result type and for that we need
						-- to store the boxed result in `Result' and the actual result in `r'.
					buffer.put_gtcx
					buffer.put_new_line
					l_seed_type.generate (buffer)
					buffer.put_character (' ')
					buffer.put_string ({C_CONST}.result_name)
					buffer.put_character (';')
					buffer.put_new_line;
					buffer.put_string ("int l_eif_optimize_return = eif_optimize_return;")
					buffer.put_new_line;
					l_type.generate (buffer)
					buffer.put_character (' ')
					buffer.put_four_character ('r', ' ', '=', ' ')
					l_is_return_value_boxed := True
				end
			else
				buffer.put_new_line
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
					-- It is `i - 2' because they do not include Current and is zero-based indexing.
				l_seed_type := l_seed_c_pattern.argument_types.item (i - 2)
				l_type := l_c_pattern.argument_types.item (i - 2)
				if not l_seed_type.same_as (l_type) then
						-- The declaration are different, we need to adapt the argument.
						-- Currently we can only accept that the seed type is a reference
						-- and the current type a basic type but we could easily change
						-- that in the future if the language rules were to change.
					check
						different_types: l_seed_type.is_reference and not l_type.is_reference
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
				buffer.put_new_line
				buffer.put_string ("if (l_eif_optimize_return) {")
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
				if attached {BASIC_A} l_type_a as l_basic_type then
						-- Because `metamorphose' indirectly uses BYTE_CONTEXT.buffer we need to configure
						-- it to use `buffer' instead.
					l_old_buffer := context.buffer
					context.set_buffer (buffer)
					l_basic_type.metamorphose (
						create {NAMED_REGISTER}.make ("Result", l_seed_type),
						create {NAMED_REGISTER}.make ("r", l_type), buffer)
					context.set_buffer (l_old_buffer)
					buffer.put_character (';')
				else
					check False end
				end
				buffer.put_new_line
				buffer.put_string ("return Result;")
				buffer.exdent
				buffer.put_new_line
				buffer.put_character ('}')
			end
			buffer.generate_block_close
		end

	generate_loop_initialization (buffer: GENERATION_BUFFER; a_table_name, a_routine_name: READABLE_STRING_8; a_lower, a_upper: INTEGER)
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
				buffer.put_string (function_ptr_cast_string)
				buffer.put_string (a_routine_name)
				buffer.put_character (';')
			else
					-- FIXME: Manu: 03/23/2004: The following line should be used.
					-- Unfortunately, there is a bug in VC6++ which prevents the C
					-- compilation. Therefore we use a trick, we use a volatile version
					-- of `i'. It might be slightly slower but it is barely noticeable.
					-- So as soon as we do not need to support VC6++, then we can restore
					-- the next line.
--				buffer.put_string ("{volatile long i; for (i = ")
				buffer.put_string ("{long i; for (i = ")
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

	function_ptr_cast_string: STRING = "(char *(*)()) "
			-- String representing cast to type of function pointer

	write
			-- Generate table using writer.
		do
			generate (Rout_generator)
		end

	write_for_type
			-- <Precursor>
		do
			generate_type_table (rout_generator)
		end

	wrapper_buffer: GENERATION_BUFFER
			-- Buffer to generate a polymorphic wrapper.
		once
			create Result.make (500)
		ensure
			wrapper_buffer_not_void: Result /= Void
		end

note
	ca_ignore: "CA011", "CA011: too many arguments"
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
