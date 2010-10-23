class TEST

create
	make

feature

	make
		local
			l_str: TEST_HANDLER
			s: TRACING_SETTING
			i: INTEGER
			str: STRING
		do
			create s
			s.enable_tracing
			create l_str
			l_str.activate

			from
				i := 0
			until
				i = 100000
			loop
				str := f
				if str /= attr or str.count /= 4 then
					print ("We got a problem at iteration " + i.out + "%N")
				end
				i := i + 1

			end
		end

	attr: STRING

	f: STRING
		do
			Result := "1234"
			attr := Result
		end
end
