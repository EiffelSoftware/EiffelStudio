class EXT_INCL_EXEC_UNIT

inherit
	EXT_EXECUTION_UNIT
		redefine
			generate_declaration
		end

	SHARED_EXEC_TABLE
		undefine
			is_equal
		end

creation
	make

feature -- Access

	include_list: ARRAY [STRING]
			-- List of header files used by Current external.

feature -- Setting

	set_include_list (headers: like include_list) is
			-- Assign `headers' to `include_list'.
		require
			headers_not_void: headers /= Void
		do
			include_list := headers
		ensure
			include_list_set: include_list = headers
		end

feature -- Generation

	generate_declaration (buffer: GENERATION_BUFFER) is
		local
			i, n: INTEGER
			include_set: LINKED_SET[STRING]
		do
				-- We don't have to generate the declaration
				-- extern toto(); but we need to include all
				-- the include files needed by the current feature
			from
				include_set := Execution_table.include_set
				i := include_list.lower
				n := include_list.upper
			until
				i > n
			loop
				include_set.extend (include_list.item (i))
				i := i + 1
			end
		end

end
