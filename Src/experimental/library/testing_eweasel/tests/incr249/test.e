class TEST
create
	make

feature

	make is
			-- Initialization
		local
			l_int: INTERNAL
			l_dtype: INTEGER
			l_path: PATH_NAME
		do
			create l_int
			l_dtype := l_int.field_static_type_of_type (1, l_int.dynamic_type (Current))
			io.put_string (l_int.type_name_of_type (l_dtype))
			io.put_new_line

			l_path := Void
		end


	entity: $TYPE is
		do
		end

	based_entity: LINKED_LIST [like entity]

end
