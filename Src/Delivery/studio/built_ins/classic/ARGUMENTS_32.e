class
	ARGUMENTS_32

feature

	i_th_argument_string (i: INTEGER): IMMUTABLE_STRING_32
			-- Underlying string holding the argument at position `i'.
		local
			l_str: NATIVE_STRING
			l_ptr: POINTER
		do
			create l_str.make_empty (0)
			l_ptr := i_th_argument_pointer (i)
			if l_ptr /= default_pointer then
				l_str.set_shared_from_pointer (l_ptr)
				create Result.make_from_string (l_str.string)
			else
				create Result.make_empty
			end
		end


end
