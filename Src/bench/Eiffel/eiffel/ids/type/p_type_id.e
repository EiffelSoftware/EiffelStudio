-- Precompiled static type ids.

class P_TYPE_ID

inherit

	P_COMPILER_ID;
	TYPE_ID
		rename
			make as make_id
		undefine
			compilation_id, is_precompiled
		redefine
			generated_id, generated_id_string, counter, prefix_name
		end

creation

	make

feature -- Access

	generated_id (buffer: GENERATION_BUFFER) is
			-- Generate textual representation of static type id
			-- in generated C code
		local
			statement, buff: STRING
		do
			if Compilation_modes.is_precompiling then
				buff := Type_offset_buffer;
				eif011 ($buff, compilation_id);
				!! statement.make (15);
				statement.append (buff);
				statement.extend ('+');
				statement.append_integer (internal_id - 1)
				buffer.putstring (statement)
			else
				buffer.putint (id - 1)
			end
		end

	generated_id_string: STRING is
			-- Textual representation of static type id
			-- used in generated C code
		local
			buff: STRING
		do
			if Compilation_modes.is_precompiling then
				buff := Type_offset_buffer;
				eif011 ($buff, compilation_id);
				!! Result.make (15);
				Result.append (buff);
				Result.extend ('+');
				Result.append_integer (internal_id - 1)
			else
				!! Result.make (5)
				Result.append_integer (id - 1)
			end
		end

feature {BODY_ID} -- Access
 
	prefix_name: STRING is
			-- Prefix for generated C function names
		do
			Result := counter.prefix_name
		end
 
feature {NONE} -- Implementation
 
	counter: TYPE_SUBCOUNTER is
			-- Counter associated with the id
		do
			Result := Static_type_id_counter.item (compilation_id)
		end

end -- class P_TYPE_ID
