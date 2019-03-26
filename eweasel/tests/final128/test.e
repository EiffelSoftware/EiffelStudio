class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			print (f)
		end

feature {NONE} -- Test

	f: A
			-- Use conversion to initialize result.
		do
			Result := "%NKO"
		end

end
