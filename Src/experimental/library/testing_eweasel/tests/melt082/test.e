class TEST
create
	make
feature
	
	make is
		local
			tuple: TUPLE [STRING]
			p: POINTER
			i: INTEGER
		do
			("$STRING").do_nothing
			p := do_something ($Current, i)
			if p /= $Current then
				print ("Not OK!%N")
				print ("Got " + p.out + " expected " + ($Current).out + "%N")
			end
		end

	my_attr: ANY

	do_something (a_pointer: POINTER; i: INTEGER): POINTER
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"return $a_pointer;"
		end

end
