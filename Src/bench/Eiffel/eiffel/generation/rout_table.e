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
			is_routine_table
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

feature 

	is_routine_table: BOOLEAN is True;
			-- Is the table a routine table ?

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

	generate (buffer: GENERATION_BUFFER) is
			-- Generation of the routine table in buffer "erout*.c".
		local
			entry: ROUT_ENTRY;
			i, nb, index: INTEGER;
			routine_name: STRING;
			empty_function_ptr_string: STRING
			function_ptr_cast_string: STRING
		do
			from
				empty_function_ptr_string := "(char *(*)()) 0,%N"
				function_ptr_cast_string := "(char *(*)()) "
				buffer.putstring ("char *(*");
				buffer.putstring (Encoder.table_name (rout_id));
				buffer.putstring ("[])() = {%N");
				i := min_used;
				nb := max_used;
				goto_used (i);
				index := position
			until
				i > nb
			loop
				entry := array_item (index);
				if i = entry.type_id then
					if entry.used then
						routine_name := entry.routine_name;
						buffer.putstring (function_ptr_cast_string);
						buffer.putstring (routine_name);
						buffer.putstring (",%N");
			
							-- Remember external routine declaration
						Extern_declarations.add_routine (entry.type.c_type, routine_name)
					else
						buffer.putstring (empty_function_ptr_string);
					end;
					index := index + 1
				else
					buffer.putstring (empty_function_ptr_string);
				end;
				i := i + 1;
			end;
			buffer.putstring ("};%N%N");
		end; -- generate

	generate_dispose_table (real_rout_id: INTEGER; buffer: GENERATION_BUFFER) is
			-- Generation of the dispose table in buffer "erout*.c".
		local
			entry: ROUT_ENTRY;
			i, nb, index: INTEGER;
			r_name: STRING;
			empty_function_ptr_string: STRING
			function_ptr_cast_string: STRING
		do
			empty_function_ptr_string := "(char *(*)()) 0,%N"
			function_ptr_cast_string := "(char *(*)()) "

			from
				buffer.putstring ("char *(*");
				buffer.putstring (Encoder.table_name (real_rout_id));
				buffer.putstring ("[])() = {%N");
				index := 1;
				i := 1
				nb := System.type_id_counter.value;
			until
				i > nb
			loop
				if index <= max_position then
					entry := array_item (index)
					if i = entry.type_id then
						r_name := entry.routine_name
						buffer.putstring (function_ptr_cast_string);
						buffer.putstring (r_name);
						buffer.putstring (",%N");
	
								-- Remember external declaration
						Extern_declarations.add_routine (entry.type.c_type, r_name);
						index := index + 1
					else
						buffer.putstring (empty_function_ptr_string);
					end
				else
					buffer.putstring (empty_function_ptr_string);
				end
				i := i + 1;
			end;

			buffer.putstring ("};%N%N");
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

end
