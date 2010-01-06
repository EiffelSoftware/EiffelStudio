class TEST
create
	make

feature {NONE}

	make
		do
		end

	f (a_date: ANY):HASH_TABLE[TUPLE[DOUBLE,DOUBLE],STRING] is
			-- get all holdings by zone for analysis
		local
			a: ANY
		do
			a := agent g (Result, ?)
		end

	g (a_table: like f; a_record: STRING) is
		do
		end

end
