-- Precompiled class ids.

class P_CLASS_ID

inherit

	P_COMPILER_ID;

	CLASS_ID
		rename
			make as make_id
		undefine
			compilation_id, is_precompiled
		redefine
			generated_id
		end;

	ENCODER
		export
			{NONE} all
		end

creation

	make

feature {COMPILER_EXPORTER} -- Access

	generated_id: STRING is
			-- Textual representation of class id
			-- used in generated C code
		local
			buff: STRING
		do
			if Compilation_modes.is_precompiling then
				buff := Offset_buffer;
				eif011 ($buff, compilation_id);
				!! Result.make (15);
				Result.append (buff);
				Result.extend ('+');
				Result.append_integer (internal_id)
			else
				!! Result.make (5);
				Result.append_integer (id)
			end
		end

end -- class P_CLASS_ID
