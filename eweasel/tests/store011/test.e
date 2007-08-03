class
	TEST

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			a: ANY
		do
			object := ["sam", ["sim", "som"], "sum", -1]
				-- Uncomment the line below to recreate a 5.7 storable.
--			store
			retrieve
		end

feature {NONE} -- Implementation

	store is
		local
			l_file: RAW_FILE
		do
			create l_file.make_open_write ("data")
			l_file.independent_store (Current)
			l_file.close
		end

	retrieve is
		local
			a: like Current
			l_file: RAW_FILE
		do
			create l_file.make_open_read ("data")
			a ?= l_file.retrieved
			l_file.close
			if not is_deep_equal (a) then
				print ("Error%N")
			end
		end

	object: TUPLE [STRING, TUPLE [STRING, STRING], STRING, INTEGER]

end
