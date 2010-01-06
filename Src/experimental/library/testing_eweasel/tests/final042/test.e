
class TEST
create
	make

feature {NONE} -- Creation

	make
		local
			keys: ARRAY [STRING]
			t2: like test2
			l_c: CHARACTER
		do
			t2.put (l_c)
			keys := environment.current_keys
		end

	test2: TEST2

	environment: HASH_TABLE [STRING, STRING]

end
