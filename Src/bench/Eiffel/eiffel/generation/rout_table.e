indexing
	description: "Representation of a table of routine pointer for the final Eiffel executable"
	date: "$Date$"
	revision: "$Revision$"

class ROUT_TABLE

inherit
	POLY_TABLE [ROUT_ENTRY]
		rename
			writer as Rout_generator
		redefine
			is_routine_table, tmp_poly_table
		end;

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

	is_routine_table: BOOLEAN is True;
			-- Is the table a routine table ?

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

	is_polymorphic (type_id: INTEGER): BOOLEAN is
			-- Is the table polymorphic from entry indexed by `type_id' to
			-- the maximum entry id ?
		local
			first_body_index: INTEGER;
			second_type_id: INTEGER;
			entry: ROUT_ENTRY;
			cl_type: CLASS_TYPE
			first_type: CLASS_TYPE
			found, is_deferred: BOOLEAN;
			i, nb, old_position: INTEGER
			system_i: SYSTEM_I
		do
			nb := max_position

			if nb > 1 then
				old_position := position
				system_i := System

					-- If it is not a poofter finalization
					-- we have a quicker algorithm handy.
				if not system_i.poofter_finalization then
						-- Go to the entry of type id greater or equal than `type_id':
						-- note that deferred feature have no entries in the tables
					goto_used (type_id)
					i := position
				else
					i := lower
				end

					-- We never compute the value for this entry, so we need to do it
				from
					is_deferred := True
					first_type := system_i.class_type_of_id (type_id)
				until
					Result or else i > nb
				loop
					entry := array_item (i)
					if entry.used then
						second_type_id := entry.type_id
						if second_type_id = type_id then
							is_deferred := False
						end
						cl_type := system_i.class_type_of_id (second_type_id)
						if cl_type.conform_to (first_type) then
							if found then
								Result := not (entry.body_index = first_body_index)
							else
								found := True
								first_body_index := entry.body_index
							end
						end
					end
					i := i + 1
				end

				if not Result then
					Result := is_deferred and then found
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
						system_i.class_type_of_id (second_type_id).conform_to (
						System_i.class_type_of_id (type_id))
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

	generate (buffer: GENERATION_BUFFER) is
			-- Generation of the routine table in buffer "erout*.c".
		local
			l_min_used: INTEGER
		do
			l_min_used := min_used
			goto_used (l_min_used)
			internal_generate (buffer, 0, final_table_size, l_min_used, max_used)
		end

	generate_full (real_rout_id: INTEGER; buffer: GENERATION_BUFFER) is
			-- Generation of the table in buffer "erout*.c" without optimizing the lower bound.
		local
			l_rout_id: INTEGER
			l_min_used: INTEGER
			l_table_name: STRING
		do	
			if max_position = 0 then
				l_table_name := Encoder.table_name (real_rout_id)
				buffer.putstring ("char *(*");
				buffer.putstring (l_table_name);
				buffer.putstring ("[")
				buffer.putint (system.type_id_counter.value)
				buffer.putstring ("])();");
				buffer.new_line
				buffer.putstring ("void ")
				buffer.putstring (l_table_name)
				buffer.putstring ("_init () {}")
				buffer.new_line
			else
				l_rout_id := rout_id
				rout_id := real_rout_id
				l_min_used := min_used
				goto_used (l_min_used)
					-- We do `l_min_used - 1' for the offset because in compiler
					-- IDs starts at 1, but at runtime they start at 0.
				internal_generate (buffer, l_min_used - 1, system.type_id_counter.value,
					l_min_used, max_used)
				rout_id := l_rout_id
			end
		end

	goto_implemented (type_id: INTEGER) is
			-- Go to first implemented feature available in
			-- a static type greater than `type_id'.
		require
			positive: type_id > 0
		local
			i, nb: INTEGER
			first_type, cl_type: CLASS_TYPE
			l_done: BOOLEAN
			entry: ENTRY
			system_i: like system
		do
			goto_used (type_id)
			system_i := System
			from
				i := position
				first_type := system_i.class_type_of_id (type_id)
				nb := max_position
			until
				i > nb or l_done
			loop
				entry := array_item (i)
				if entry.used then
					cl_type := system_i.class_type_of_id (entry.type_id)
					l_done := cl_type.conform_to (first_type)
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
		do
				-- We generate a compact table initialization, that is to say if two or more
				-- consecutives rows are identical we will generate a loop to fill the rows
			from
				buffer.putstring ("char *(*");
				l_table_name := Encoder.table_name (rout_id)
				buffer.putstring (l_table_name);
				buffer.putstring ("[")
				buffer.putint (a_table_size)
				buffer.putstring ("])();")
				buffer.new_line
				buffer.putstring ("void ")
				buffer.putstring (l_table_name)
				buffer.putstring ("_init () {")
				buffer.new_line
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
				generate_loop_initialization (buffer, l_table_name, l_routine_name,
					l_start, l_end)
		
					-- Remember external routine declaration
				Extern_declarations.add_routine (l_rout_entry.type.c_type, l_routine_name)
			end

			buffer.exdent
			buffer.putstring ("};")
			buffer.new_line
			buffer.new_line
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
			if a_lower = a_upper then
				buffer.putstring (a_table_name)
				buffer.putchar ('[')
				buffer.putint (a_lower)
				buffer.putstring ("] = ")
				buffer.putstring (function_ptr_cast_string);
				buffer.putstring (a_routine_name);
				buffer.putchar (';')
				buffer.new_line
			else
				buffer.putstring ("{long i; for (i = ")
				buffer.putint (a_lower)
				buffer.putstring ("; i < ")
				buffer.putint (a_upper + 1)
				buffer.putstring ("; i++) ")
				buffer.putstring (a_table_name)
				buffer.putstring ("[i] = ")
				buffer.putstring (function_ptr_cast_string);
				buffer.putstring (a_routine_name);
				buffer.putchar (';')
				buffer.putchar ('}')
				buffer.putchar (';')
				buffer.new_line
			end
		end

	function_ptr_cast_string: STRING is "(char *(*)()) "
			-- String representing cast to type of function pointer

end
