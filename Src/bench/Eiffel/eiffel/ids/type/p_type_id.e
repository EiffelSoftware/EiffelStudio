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
			generated_id
		end

creation

	make

feature -- Access

	generated_id: STRING is
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
				!! Result.make (5);
				Result.append_integer (id - 1)
			end
		end

end -- class P_TYPE_ID
