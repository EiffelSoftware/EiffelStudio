-- Precompiled real body indexes.

class P_REAL_BODY_INDEX

inherit

	P_COMPILER_ID;
	REAL_BODY_INDEX
		rename
			make as make_id
		undefine
			compilation_id, is_precompiled
		redefine
			generated_id, counter
		end;
	ENCODER
		export
			{NONE} all
		end

creation

	make

feature -- Access
 
	generated_id (buffer: GENERATION_BUFFER) is
			-- Generate textual representation of real body index
			-- in generated C code
		local
			statement, buff: STRING
		do
			if Compilation_modes.is_precompiling then
				buff := Real_body_index_offset_buffer;
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

feature {NONE} -- Implementation
 
	counter: REAL_BODY_INDEX_SUBCOUNTER is
			-- Counter associated with the id
		do
			Result := Real_body_index_counter.item (compilation_id)
		end

end -- class P_REAL_BODY_INDEX
