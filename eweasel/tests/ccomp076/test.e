class
	TEST

create
	make

feature

	make is
		do
			if Current /= cpp_macro (Current) then
				print ("Not OK%N")
			end
			if Current /= c_macro (Current) then
				print ("Not OK%N")
			end
			if Current /= cpp_ext (Current) then
				print ("Not OK%N")
			end
			if Current /= c_ext (Current) then
				print ("Not OK%N")
			end
		end

	cpp_ext (a_obj: ANY): ANY is
		external
			"C++ inline use %"eif_eiffel.h%""
		alias
			"return eif_access($a_obj);"
		end

	c_ext (a_obj: ANY): ANY is
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"return eif_access($a_obj);"
		end

	cpp_macro (a_obj: ANY): ANY is
		external
			"C++ macro use %"eif_eiffel.h%""
		alias
			"eif_access"
		end

	c_macro (a_obj: ANY): ANY is
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"eif_access"
		end

end
