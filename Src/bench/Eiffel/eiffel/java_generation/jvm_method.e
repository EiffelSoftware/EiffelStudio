indexing
	description: "method whos body will actually be generated to byte code.%
	%objects store not only meta data, but the actual byte code as well.%
   % which can retrieved via `emit' once the code generation is complete."
	date: "$Date$"
	revision: "$Revision$"

class
	JVM_METHOD

inherit
	
	JVM_WRITTEN_FEATURE
		redefine
			emit,
			make,
			close,
			close_attributes_count,
			set_parameters_from_type_id_list,
			set_return_type_by_id
		end
	
	SHARED_WORKBENCH
	MEMORY
	
create
	make

feature {NONE} -- Initialisation
	
	make (cp: CONSTANT_POOL) is
			-- create new method
		do
			Precursor (cp)
			create code.make
			code.set_constant_pool (cp)
			max_locals := 1
			create eiffel_locals_index.make (1, 0)
			create eiffel_locals_type_id.make (1, 0)
			create eiffel_locals_name.make (1, 0)
			if
				System.line_generation
			then
				create line_number_table.make_size (5 * Int_32_size)
				line_number_table.set_constant_pool (cp)
				
				create local_variable_table.make_size (Int_8_size * 10 * 2)
				local_variable_table.set_constant_pool (cp)
			end
		end
			
feature
	
	set_parameters_from_type_id_list (l: LINKED_LIST [PAIR [INTEGER, STRING]]) is
			-- Set method parameters from a list of pairs containing type 
			-- ids plus names
		local
			param_index: INTEGER			-- current index in parameters_index array
			slot_index: INTEGER				-- current slot index
		do
			Precursor (l)
			from
				l.start
				create parameters_index.make (1, l.count)
				param_index := 1
				slot_index := max_locals
			until
				l.off
			loop
				parameters_index.put (slot_index, param_index)
				param_index := param_index + 1
							-- depending on the size of the type we need to add more than
							-- one to the slot index.
							-- this is because i.e. a long takes 2 slots
				slot_index := slot_index + jvm_type_to_stack_size (eiffel_type_id_to_jvm_type_id (l.item.first))
				l.forth
			end
			set_max_locals (slot_index)
		end
	
	set_return_type_by_id (a_type_id: INTEGER) is
			-- Set return type from a type id
		do
			Precursor (a_type_id)
			return_index := max_locals
			set_max_locals (max_locals + jvm_type_to_stack_size (eiffel_type_id_to_jvm_type_id (a_type_id)))
			return_jvm_type_id := eiffel_type_id_to_jvm_type_id (a_type_id)
		end
			
			
feature
	
	emit (file: RAW_FILE) is
		do
			Precursor (file)
			pre_code_byte_code.emit (file)
			code.emit (file)
			post_code_byte_code.emit (file)
			if
				line_number_table_header /= Void
			then
				line_number_table_header.emit (file)
				line_number_table.emit (file)
			end
			if
				local_variable_table_header /= Void
			then
				local_variable_table_header.emit (file)
				local_variable_table.emit (file)
			end
		end
	
feature {NONE}			
	
	close_attributes_count is
		do
			create attributes_count_bc.make_size (Int_16_size)
			attributes_count_bc.append_uint_16_from_int (1) -- Attributes count (code)
		end
	
	close_line_number_table is
		require
			line_number_table_not_void: line_number_table /= Void
		do
			if
				line_entries > 0
			then
				-- Line Number Table
  				create line_number_table_header.make_size (8)
  				line_number_table_header.set_constant_pool (constant_pool)
  				line_number_table_header.constant_pool.put_utf8_constant ("LineNumberTable")
  				line_number_table_header.append_uint_16_from_int (line_number_table.constant_pool.last_cpe_index)
  				line_number_table_header.append_uint_32_from_int (line_entries * Int_32_size + Int_16_size)
  				line_number_table_header.append_uint_16_from_int (line_entries)
				
			end
		end
	
	close_local_variable_table is
		require
			local_variable_table_not_void: local_variable_table /= Void
		local
			i: INTEGER
			count: INTEGER
		do
			
			if
				not is_static
			then
				-- add "this" resp. `Current'
				local_variable_table.append_uint_16_from_int (0) -- scope start
				local_variable_table.append_uint_16_from_int (code.position) -- scope length
				local_variable_table.constant_pool.put_utf8_constant ("this")
				local_variable_table.append_uint_16_from_int (local_variable_table.constant_pool.last_cpe_index) -- name
				local_variable_table.constant_pool.put_utf8_constant (class_.qualified_name)
				local_variable_table.append_uint_16_from_int (local_variable_table.constant_pool.last_cpe_index) -- type
				local_variable_table.append_uint_16_from_int (0) -- slot
				count := count + 1
			end
				
						-- add method parameters (resp. feature arguments)
			if
				parameters_index /= Void
			then
				from
					i := parameters_index.lower
				until
					i > parameters_index.upper
				loop
					local_variable_table.append_uint_16_from_int (0) -- scope start
					local_variable_table.append_uint_16_from_int (code.position) -- scope length
					if
						parameter_names /= Void and then parameter_names.item (i) /= Void
					then
						local_variable_table.constant_pool.put_utf8_constant (parameter_names.item (i))
					else
						local_variable_table.constant_pool.put_utf8_constant ("param_" + i.out)
					end
					local_variable_table.append_uint_16_from_int (local_variable_table.constant_pool.last_cpe_index) -- name
					local_variable_table.constant_pool.put_utf8_constant (parameter_type_names.item (i))
					local_variable_table.append_uint_16_from_int (local_variable_table.constant_pool.last_cpe_index) -- type
					local_variable_table.append_uint_16_from_int (parameter_jvm_type_ids.item (i)) -- slot
					i := i + 1
					count := count + 1
				end
			end
			-- add return (resp. result) type if any
			if
				not return_type_name.is_equal ("V")
			then
				local_variable_table.append_uint_16_from_int (0) -- scope start
				local_variable_table.append_uint_16_from_int (code.position) -- scope length
				local_variable_table.constant_pool.put_utf8_constant ("Result")
				local_variable_table.append_uint_16_from_int (local_variable_table.constant_pool.last_cpe_index) -- name
				local_variable_table.constant_pool.put_utf8_constant (return_type_name)
				local_variable_table.append_uint_16_from_int (local_variable_table.constant_pool.last_cpe_index) -- type
				local_variable_table.append_uint_16_from_int (return_index) -- slot
				count := count + 1
			end
			
			-- add eiffel local variables
			from
				i := eiffel_locals_index.lower
			until
				i > eiffel_locals_index.upper
			loop
				
				-- in Eiffel the local variable scope is always from the 
				-- very beginning till the very end of a feature
				local_variable_table.append_uint_16_from_int (0) -- scope start
				local_variable_table.append_uint_16_from_int (code.position) -- scope length
				local_variable_table.constant_pool.put_utf8_constant (eiffel_locals_name.item (i))
				local_variable_table.append_uint_16_from_int (local_variable_table.constant_pool.last_cpe_index) -- name
				local_variable_table.constant_pool.put_utf8_constant (repository.item (eiffel_locals_type_id.item (i)).qualified_name)
				local_variable_table.append_uint_16_from_int (local_variable_table.constant_pool.last_cpe_index) -- type
				local_variable_table.append_uint_16_from_int (eiffel_locals_index.item (i)) -- slot
				i := i + 1
				count := count + 1
			end
			
			
			if
				count > 0
			then
				create local_variable_table_header.make_size (8)
				local_variable_table_header.set_constant_pool (constant_pool)
				local_variable_table_header.constant_pool.put_utf8_constant ("LocalVariableTable")
				local_variable_table_header.append_uint_16_from_int (local_variable_table_header.constant_pool.last_cpe_index)
				local_variable_table_header.append_uint_32_from_int (Int_16_size * 5 * count + Int_16_size) -- byte count
				local_variable_table_header.append_uint_16_from_int (count) -- local variable count
			end
		end

feature {ANY} -- Basic Operations
	
	close is
		local
			end_method_code: INTEGER
			attributes_count: INTEGER
			code_byte_count: INTEGER
		do
			code.process_label_marks
			if
				code.position = 1
			then
				-- an empty feature needs a return at least.
				if
					return_jvm_type_id /= void_type
				then
					code.append_push_default_value (return_jvm_type_id)
				end
				code.append_return (return_jvm_type_id)
			end
			end_method_code := code.position - 1
			if
				local_variable_table /= Void
			then
				close_local_variable_table
			end
			if
				line_number_table /= Void
			then
				close_line_number_table
			end
			
			if
				line_number_table_header /= Void
			then
				attributes_count := attributes_count + 1
				code_byte_count := code_byte_count + line_number_table_header.position - 1 + line_number_table.position - 1
			end
			if
				local_variable_table_header /= Void
			then
				attributes_count := attributes_count + 1
				code_byte_count := code_byte_count + local_variable_table_header.position - 1 + local_variable_table.position - 1
			end
			
			constant_pool.put_utf8_constant ("Code")
			create pre_code_byte_code.make
			pre_code_byte_code.append_uint_16_from_int (constant_pool.last_cpe_index) -- "Code"
			code_byte_count := code_byte_count + code.position - 1 + Int_16_size*4 + Int_32_size
			pre_code_byte_code.append_uint_32_from_int (code_byte_count)
			pre_code_byte_code.append_uint_16_from_int (code.stack.max_jvm_count) -- Max stack
			pre_code_byte_code.append_uint_16_from_int (max_locals) -- Max locals
			pre_code_byte_code.append_uint_32_from_int (code.position - 1) -- Code count
																
			create post_code_byte_code.make
			post_code_byte_code.set_constant_pool (constant_pool)
			post_code_byte_code.append_uint_16_from_int (0) -- Handlers count
			
			
			post_code_byte_code.append_uint_16_from_int (attributes_count) -- Attributes count
			
			
			Precursor
		end
			
	add_eiffel_local_info (a_type_id: INTEGER; a_name: STRING) is
			-- adds an entry to eiffel_locals
		require
			valid_type_id: repository.has_by_id (a_type_id)
			valid_name: a_name /= Void and then not a_name.is_empty
		do
			eiffel_locals_index.force (max_locals, eiffel_locals_index.count + 1)
			eiffel_locals_type_id.force (a_type_id, eiffel_locals_type_id.count + 1)
			eiffel_locals_name.force (a_name, eiffel_locals_name.count + 1)
			max_locals := max_locals + jvm_type_to_stack_size (eiffel_type_id_to_jvm_type_id (a_type_id))
		end
			
feature -- Code generation statistics
			
	code: JVM_METHOD_BYTE_CODE
			-- this is the array, where the actual executable byte code 
			-- will be put it.
	
	max_locals: INTEGER
			-- maximal number of local variables used in this method
			-- NOTE: variables that take 2 words on the stack take two
			-- continous slots as well. So that a long at slot 3, in
			-- practice occupies slot 3 and 4
				
	set_max_locals (i: INTEGER) is
			-- set `max_locals'
		require
			positive: i >= 0
		do
			max_locals := i
		ensure
			set: max_locals = i
		end

	start_code_generation is
			-- call this feature when you are done with seting up the
			-- signature of the method and want to add actual code
		require
			signature_closed: is_signature_closed
			code_generation_has_not_started: not has_code_generation_started
		do
			has_code_generation_started := True
		end
			
	end_code_generation is
			-- call this feature when you are done with adding the code
		require
			code_generation_started: has_code_generation_started
		do
			has_code_generation_started := False
		end
			
	has_code_generation_started: BOOLEAN
			-- has `start_code_generation' been called?
			
			
	return_index: INTEGER
			-- index of (jvm) local variable slot where the result will
			-- be stored
			
	parameters_index: ARRAY [INTEGER]
			-- gives the jvm local variable slot for each feature
			-- parameter (feature argument)
	eiffel_locals_index: ARRAY [INTEGER]
			-- gives the jvm local variable slot for each eiffel local variable
			
	eiffel_locals_type_id: ARRAY [INTEGER]
			-- type ids for a eiffel local variable
	
	eiffel_locals_name: ARRAY [STRING]
			-- name of i-th eiffel local variable
	
feature -- Java Debug
	
	put_line_info (n: INTEGER) is
			-- assign the current `position' in `code' with the `n'-th 
			-- line number in `source_code_file_name'
		require
			has_source_code_file_name: class_.has_source_code_file_name
			n_positive: n > 0
		do
			line_number_table.append_uint_16_from_int (code.position - 1)
			line_number_table.append_uint_16_from_int (n)
			line_entries := line_entries + 1
		end
	
	line_entries: INTEGER
			-- the number of line entries in `line_number_table'
			
feature {NONE}
	pre_code_byte_code: JVM_BYTE_CODE
			-- header part before executable code
	
	post_code_byte_code: JVM_BYTE_CODE
			-- footer part after executable code
	
	line_number_table_header: JVM_BYTE_CODE
			-- byte code for attribute "LineNumberTable" (only the 
			-- header of the table), comes after `post_code_byte_code'
	
	line_number_table: JVM_BYTE_CODE
			-- byte code for attribute "LineNumberTable" (except it's header)
			-- this information tells the debugger what line in source 
			-- code starts at which bytecode index
	
	local_variable_table_header: JVM_BYTE_CODE
			-- byte code for attribute "LocalVariableTable" (only the 
			-- header of table), comes after `post_code_byte_code'
	
	local_variable_table: JVM_BYTE_CODE
			-- byte code for attribute "LocalVariableTable" (except it's header)
			-- this information tells the compiler what local variables 
			-- (the ones on the jvm, also called slots or registers) 
			-- correspond to what symbolic names (plus their types)
			
invariant
	not_is_field: not is_field
	not_is_field_setter: not is_field_setter
	closed_implies_pre_code_not_void: is_closed implies pre_code_byte_code /= Void
	closed_implies_post_code_not_void: is_closed implies post_code_byte_code /= Void
	code_not_void: code /= Void
	valid_jvm_return_type: valid_jvm_type (return_jvm_type_id)
	eiffel_locals_same_count1: eiffel_locals_index.count = eiffel_locals_type_id.count
	eiffel_locals_same_count1: eiffel_locals_index.count = eiffel_locals_name.count
	parameters_index_type_id_same_count: parameters_index /= Void and parameter_jvm_type_ids /= Void implies
	parameters_index.count = parameter_jvm_type_ids.count
	max_locals_positive: max_locals >= 0
end


