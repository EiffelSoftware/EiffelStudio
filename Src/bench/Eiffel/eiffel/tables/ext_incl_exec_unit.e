class EXT_INCL_EXEC_UNIT

inherit
	EXT_EXECUTION_UNIT
		redefine
			generate_declaration, make
		end

	SHARED_EXEC_TABLE
		undefine
			is_equal
		end

creation

	make

feature

	include_list: ARRAY [STRING]

	make (cl_type: CLASS_TYPE; f: EXTERNAL_I) is
			-- Initialization
		do
			{EXT_EXECUTION_UNIT} Precursor (cl_type, f);
			include_list := deep_clone (f.include_list)
		end

	generate_declaration (buffer: GENERATION_BUFFER) is
		local
			i, n: INTEGER;
			include_set: LINKED_SET[STRING]
		do
				-- We don't have to generate the declaration
				-- extern toto(); but we need to include all
				-- the include files needed by the current feature
			from
				include_set := Execution_table.include_set;
				i := include_list.lower
				n := include_list.upper
			until
				i > n
			loop
				include_set.extend (include_list.item (i));
				i := i + 1
			end
		end

end
