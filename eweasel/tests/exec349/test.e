class
	TEST

inherit
	INTERNAL

create
	make

feature
	make
		do
			test1
			test2
		end

	test1
		local
			l_array: ARRAY [detachable NONE]
			l_gen_dtype: INTEGER
			l_gen_type: TYPE [detachable ANY]
		do
			create l_array.make_empty
			l_gen_type := ({ARRAY [detachable NONE]}).generic_parameter_type (1)
			l_gen_dtype := generic_dynamic_type (l_array, 1)

			if is_attached_type (l_gen_dtype) then
				io.put_string ("NONE should not be attached.%N")
			end

			if not l_gen_type.has_default then
				io.put_string ("NONE has a default.%N")
			end

			if l_gen_type.is_expanded then
				io.put_string ("NONE is not expanded.%N")
			end

			if l_gen_dtype /= detachable_type (l_gen_dtype) then
				io.put_string ("The detachable version of NONE is NONE.%N")
			end

			if l_gen_dtype /= attached_type (l_gen_dtype) then
				io.put_string ("The attached version of NONE is NONE.%N")
			end
		end

	test2
		local
			l_array: ARRAY [NONE]
			l_gen_dtype: INTEGER
			l_gen_type: TYPE [detachable ANY]
		do
			create l_array.make_empty
			l_gen_type := ({ARRAY [NONE]}).generic_parameter_type (1)
			l_gen_dtype := generic_dynamic_type (l_array, 1)

			if is_attached_type (l_gen_dtype) then
				io.put_string ("NONE should not be attached.%N")
			end

			if not l_gen_type.has_default then
				io.put_string ("NONE has a default.%N")
			end

			if l_gen_type.is_expanded then
				io.put_string ("NONE is not expanded.%N")
			end

			if l_gen_dtype /= detachable_type (l_gen_dtype) then
				io.put_string ("The detachable version of NONE is NONE.%N")
			end

			if l_gen_dtype /= attached_type (l_gen_dtype) then
				io.put_string ("The attached version of NONE is NONE.%N")
			end
		end

end
