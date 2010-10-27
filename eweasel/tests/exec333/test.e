class TEST

create
	make

feature

	make
		local
			l_str: TEST_HANDLER
			s: TRACING_SETTING
			i: INTEGER
			dtype, string_dtype: INTEGER
			str: STRING
		do
			str := "123"
			string_dtype := g ($str)
			create s
			s.enable_tracing
			create l_str
			l_str.activate

			from
				i := 1
			until
				i = 100
			loop
				str := f
				if str /= attr or str.count /= 4 then
					print ("We got a problem at iteration " + i.out + "%N")
				end
				str := "123"
				dtype := g ($str)
				if dtype /= string_dtype then
					print ("We got a problem at iteration " + i.out + " for externals.%N")
				end
				i := i + 1

			end

			s.disable_tracing
			l_str.deactivate

			print ("%NSuccess here%N")
		end

	attr: STRING

	f: STRING
		do
			Result := "$CONTENT"
			attr := Result
		end

	g (s: POINTER): INTEGER
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"return Dftype($s);"
		end

end
