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
			generated_id, counter, class_array
		end;

	ENCODER
		export
			{NONE} all
		end

creation

	make

feature {COMPILER_EXPORTER} -- Access

	generated_id (f: INDENT_FILE) is
			-- Generate textual representation of class id
			-- in generated C code
		local
			statement, buff: STRING
		do
			if Compilation_modes.is_precompiling then
				buff := Offset_buffer;
				eif011 ($buff, compilation_id);
				!! statement.make (15);
				statement.append (buff);
				statement.extend ('+');
				statement.append_integer (internal_id)
				f.putstring (statement)
			else
				f.putint (id)
			end
		end

feature {NONE} -- Implementation

	counter: CLASS_SUBCOUNTER is
			-- Counter associated with the id
		do
			Result := Class_counter.item (compilation_id)
		end

	class_array: ARRAY [CLASS_C] is
			-- Classes compiled during compilation `compilation_id'
		do
			Result := System.classes.item (compilation_id)
		end

end -- class P_CLASS_ID
