class
	TEST

inherit
	INTERNAL

create
	make

feature
	make
		local
			l_type: TYPE [detachable ANY]
			l_attached_none_type_id, l_detachable_none_type_id: INTEGER
			l_array: ARRAY [detachable NONE]
		do
			l_type := {NONE}
			io.put_string (l_type.name)
			io.put_new_line
			l_attached_none_type_id := l_type.type_id
			test_for_attached (l_type, l_type.type_id)

			l_type := {detachable NONE}
			io.put_string (l_type.name)
			io.put_new_line
			l_detachable_none_type_id := l_type.type_id
			test_for_detachable (l_type, l_type.type_id)

			l_type := {ARRAY [NONE]}
			io.put_string (l_type.name)
			io.put_new_line
			l_type := l_type.generic_parameter_type (1)
			assert ("Same attached ID", l_type.type_id = l_attached_none_type_id)
			test_for_attached (l_type, l_type.type_id)

			l_type := {ARRAY [detachable NONE]}
			io.put_string (l_type.name)
			io.put_new_line
			l_type := l_type.generic_parameter_type (1)
			assert ("Same detachable ID", l_type.type_id = l_detachable_none_type_id)
			test_for_detachable (l_type, l_type.type_id)

			assert ("Same attached ID", generic_dynamic_type (create {ARRAY [NONE]}.make_empty, 1) = l_attached_none_type_id)
			assert ("Same detachable ID", generic_dynamic_type (create {ARRAY [detachable NONE]}.make_empty, 1) = l_detachable_none_type_id)
		end

	assert (tag: STRING; b: BOOLEAN)
		do
			if not b then
				io.put_string (tag)
				io.put_new_line
			end
		end

	test_for_detachable (a_type: TYPE [detachable ANY]; a_type_id: INTEGER)
		do
			if is_attached_type (a_type_id) then
				io.put_string ("detachable NONE should not be attached.%N")
			end

			if not a_type.has_default then
				io.put_string ("detachable NONE has a default.%N")
			end

			if a_type.is_expanded then
				io.put_string ("detachable NONE is not expanded.%N")
			end

			if a_type_id /= detachable_type (a_type_id) then
				io.put_string ("The detachable version of detachable NONE is detachable NONE.%N")
			end

			if a_type_id = attached_type (a_type_id) then
				io.put_string ("The attached version of detachable NONE is not detachable NONE.%N")
			end
		end

	test_for_attached (a_type: TYPE [detachable ANY]; a_type_id: INTEGER)
		do
			if not is_attached_type (a_type_id) then
				io.put_string ("attached NONE should be attached.%N")
			end

			if a_type.has_default then
				io.put_string ("attached NONE has no default.%N")
			end

			if a_type.is_expanded then
				io.put_string ("attached NONE is not expanded.%N")
			end

			if a_type_id = detachable_type (a_type_id) then
				io.put_string ("The detachable version of attached NONE is detachable NONE.%N")
			end

			if a_type_id /= attached_type (a_type_id) then
				io.put_string ("The attached version of attached NONE is attached NONE.%N")
			end
		end

end
