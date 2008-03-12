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
			is_attribute_table, is_routine_table, tmp_poly_table
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

create
	make

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
			first_real_body_index, first_body_index: INTEGER;
			second_type_id: INTEGER;
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

					-- Go to the entry of type id greater or equal than `type_id':
					-- note that deferred feature have no entries in the tables
				goto_used (type_id)
				i := position

					-- We never compute the value for this entry, so we need to do it
				from
				until
					Result or else i > nb
				loop
					entry := array_item (i)
					if entry.used then
						if system_i.class_type_of_id (entry.type_id).dynamic_conform_to (a_type, type_id, a_context_type.type) then
							if found then
								Result := entry.real_body_index /= first_real_body_index or
									entry.body_index /= first_body_index
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
					-- It is the case of a routine alone in its table. It is possibly a routine
					-- with one implementation which is an origin, or the implementation of a
					-- deferred routine.
				second_type_id := array_item (lower).type_id
				if type_id = second_type_id then
						-- Only one routine in table
					Result := False
				else
						-- Case of a deferred routine with possibly one implementation. We can
						-- only check if implementation is defined in a class type that conforms to
						-- `type_id'.
						-- FIXME: Manu 06/05/2003: If it does not then it is marked polymorphic
						-- although the code generation should consider it as a non-implemented
						-- deferred routine. However it does not matter because the generated
						-- code will not be called anyway.
					system_i := System
					if
						system_i.class_type_of_id (second_type_id).dynamic_conform_to (
							a_type, type_id, a_context_type.type)
					then
						Result := False
					else
							-- This is the case of a routine which has not implementation for
							-- `type_id'.
						Result := True
					end
				end
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
			entry: ENTRY
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
			l_routine_name: STRING;
			l_table_name: STRING
			l_suffix: STRING
		do
			if
				system.routine_id_counter.is_feature_routine_id (rout_id) and then
				system.seed_of_routine_id (rout_id).has_formal
			then
					-- Use generic wrapper of the feature.
				l_suffix := system.seed_of_routine_id (rout_id).generic_fingerprint
			end
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
						if l_suffix /= Void then
							l_routine_name.append_string (l_suffix)
						end
						generate_loop_initialization (buffer, l_table_name, l_routine_name,
							l_start, l_end)

							-- Remember external routine declaration
						Extern_declarations.add_routine (l_rout_entry.type.c_type, l_routine_name)
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
				if l_suffix /= Void then
					l_routine_name.append_string (l_suffix)
				end
				generate_loop_initialization (buffer, l_table_name, l_routine_name,
					l_start, l_end)

					-- Remember external routine declaration
				Extern_declarations.add_routine (l_rout_entry.type.c_type, l_routine_name)
			end

			buffer.exdent
			buffer.put_new_line
			buffer.put_string ("}")
			buffer.put_new_line
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
