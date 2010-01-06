class
	TEST

inherit
	INTERNAL

create
	make

feature {NONE} -- Initialization

	make is
		local
			i, nb: INTEGER
			a: ARRAYED_LIST [ANY]
			l_obj_dtype, l_field_dtype: INTEGER
			l_field_type_name: STRING
		do
			create a.make (10)
			a.extend (create {A [detachable ANY, detachable ANY]}.make (create {ANY}))
			a.extend (create {A [detachable ANY, ANY]}.make (create {ANY}))
			a.extend (create {A [ANY, detachable ANY]}.make (create {ANY}))
			a.extend (create {A [ANY, ANY]}.make (create {ANY}))
			a.extend (create {A [INTEGER, ANY]}.make (1))
			a.extend (create {A [ANY, INTEGER]}.make (create {ANY}))
			a.extend (create {A [INTEGER, INTEGER]}.make (1))
			a.extend (create {A [C [STRING], ANY]}.make (create {C [STRING]}))
			a.extend (create {A [ANY, C [STRING]]}.make (create {ANY}))
			a.extend (create {A [C [STRING], C [STRING]]}.make (create {C [STRING]}))

			from
				a.start
			until
				a.after
			loop
				from
					i := 1
					nb := field_count (a.item)
					l_obj_dtype := dynamic_type (a.item)
					io.put_string ("Attributes of type " + type_name_of_type (l_obj_dtype) + ":")
					io.put_new_line
				until
					i > nb
				loop
					io.put_string (field_name_of_type (i, l_obj_dtype) + ": ")
					l_field_dtype := field_static_type_of_type (i, l_obj_dtype)
					l_field_type_name := type_name_of_type (l_field_dtype)
					io.put_string (l_field_type_name)
					io.put_new_line
					if dynamic_type_from_string (l_field_type_name) /= l_field_dtype then
						io.put_string ("Something is wrong, we  got " + l_field_dtype.out + " but expected "
							+ dynamic_type_from_string (l_field_type_name).out)
						io.put_new_line
					end
					i := i + 1
				end
				io.put_new_line
				a.forth
			end
		end

end
