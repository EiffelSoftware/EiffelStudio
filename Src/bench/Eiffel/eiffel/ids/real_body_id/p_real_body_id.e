-- Precompiled real body ids.

class P_REAL_BODY_ID

inherit

	P_COMPILER_ID;
	REAL_BODY_ID
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

	generated_id (f: INDENT_FILE) is
			-- Generate textual representation of real body id
			-- in generated C code
		local
			statement, buff: STRING
		do
			if Compilation_modes.is_precompiling then
				buff := Real_body_id_offset_buffer;
				eif011 ($buff, compilation_id);
				!! statement.make (15);
				statement.append (buff);
				statement.extend ('+');
				statement.append_integer (internal_id - 1)
				f.putstring (statement)
			else
				f.putint (id - 1)
			end
		end

feature {NONE} -- Implementation
 
	counter: REAL_BODY_ID_SUBCOUNTER is
			-- Counter associated with the id
		do
			Result := Real_body_id_counter.item (compilation_id)
		end

end -- class P_REAL_BODY_ID
