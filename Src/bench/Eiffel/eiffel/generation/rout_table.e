-- Representation of a table of routine pointer for the final Eiffel
-- executable

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
			setup, consistent, copy, is_equal
		end

	SHARED_BODY_ID
		undefine
			setup, consistent, copy, is_equal
		end

	SHARED_DECLARATIONS
		undefine
			setup, consistent, copy, is_equal
		end

creation
	make

feature 

	is_routine_table: BOOLEAN is True;
			-- Is the table a routine table ?

	is_polymorphic (type_id: INTEGER): BOOLEAN is
			-- Is the table polymorphic from entry indexed by `type_id' to
			-- the maximum entry id ?
		local
			first_body_id: BODY_ID;
			second_type_id: INTEGER;
			entry: ROUT_ENTRY;
			cl_type: CLASS_TYPE;
			first_class_topo_id: INTEGER
			found, is_deferred: BOOLEAN;
			i, nb, old_position: INTEGER
			local_copy: ROUT_TABLE
			save_value: BOOLEAN
			system_i: SYSTEM_I
		do
			old_position := position
			system_i := System

				-- Go to the entry of type id greater or equal than `type_id':
				-- note than deferred feature have no entries in the tables
			goto_used (type_id);
			i := position

				-- We never compute the value for this entry, so we need to do it
			from
				local_copy := Current
				nb := max_position
				is_deferred := True;
				cl_type := system_i.class_type_of_id (type_id);
				first_class_topo_id := cl_type.associated_class.topological_id;
			until
				Result or else i > nb
			loop
				entry := local_copy.array_item (i);
				second_type_id := entry.type_id;
				if second_type_id = type_id then
					is_deferred := False
				end;
				cl_type := system_i.class_type_of_id (second_type_id);
				if cl_type.associated_class.conformance_table.item (first_class_topo_id) then
					if entry.used then
						if found then
							Result := not equal (entry.body_id, first_body_id)
						else
							found := True;
							first_body_id := entry.body_id;
						end;
					end;
				end;
				i := i + 1
			end;

			if not Result then
				Result := is_deferred and then found
			end;

			position := old_position
		end;

	generate (buffer: GENERATION_BUFFER) is
			-- Generation of the routine table in buffer "erout*.c".
		local
			entry: ROUT_ENTRY;
			i, nb, index: INTEGER;
			routine_name: STRING;
			empty_function_ptr_string: STRING
			function_ptr_cast_string: STRING
			local_copy: ROUT_TABLE
		do
			from
				empty_function_ptr_string := "(char *(*)()) 0,%N"
				function_ptr_cast_string := "(char *(*)()) "
				buffer.putstring ("char *(*");
				buffer.putstring (rout_id.table_name);
				buffer.putstring ("[])() = {%N");
				local_copy := Current
				i := min_used;
				nb := max_used;
				goto_used (i);
				index := position
			until
				i > nb
			loop
				entry := local_copy.array_item (index);
				if i = entry.type_id then
					if entry.used then
						routine_name := entry.routine_name;
						buffer.putstring (function_ptr_cast_string);
						buffer.putstring (routine_name);
						buffer.putstring (",%N");
			
							-- Remember external routine declaration
						Extern_declarations.add_routine (entry.type.c_type, clone (routine_name));
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

	generate_dispose_table (real_rout_id: ROUTINE_ID; buffer: GENERATION_BUFFER) is
			-- Generation of the dispose table in buffer "erout*.c".
		local
			entry: ROUT_ENTRY;
			i, nb, index: INTEGER;
			r_name: STRING;
			empty_function_ptr_string: STRING
			function_ptr_cast_string: STRING
			local_copy: ROUT_TABLE
		do
			empty_function_ptr_string := "(char *(*)()) 0,%N"
			function_ptr_cast_string := "(char *(*)()) "

			if System.has_separate then
				buffer.putstring ("extern void sep_obj_dispose(char *);%N");
			end;

			from
				local_copy := Current
				buffer.putstring ("char *(*");
				buffer.putstring (real_rout_id.table_name);
				buffer.putstring ("[])() = {%N");
				index := 1;
				i := 1
				nb := System.type_id_counter.value;
			until
				i > nb
			loop
				entry := local_copy.array_item (index);
				if index <= max_position and then i = entry.type_id then
					r_name := entry.routine_name;
					buffer.putstring (function_ptr_cast_string);
					buffer.putstring (r_name);
					buffer.putstring (",%N");

							-- Remember external declaration
					Extern_declarations.add_routine (entry.type.c_type, clone (r_name));
					index := index + 1
				else
					buffer.putstring (empty_function_ptr_string);
				end
				i := i + 1;
			end;

			if System.has_separate then
				buffer.putstring ("(char *(*)()) sep_obj_dispose%N");
			end;
			buffer.putstring ("};%N%N");
		end

	feature_name (type_id: INTEGER): STRING is
			-- Feature name of the first used feature available
			-- in a static type greater than `type_id'.
		do
			goto_used (type_id);
			if position <= max_position then
				Result := item.routine_name
			else
				Result := "((void (*)()) RTNR)"
			end;
		end;

	is_implemented (type_id: INTEGER): BOOLEAN is
			-- Is the feature implemented
			-- in a static type greater than `type_id'.
		do
			goto_used (type_id);
			Result := position <= max_position 
		end

	workbench_c_type: STRING is "struct ca_info";
			-- Associated C item structure name

end
