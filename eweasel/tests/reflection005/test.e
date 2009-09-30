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
			dtype: INTEGER
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
					dtype := dynamic_type (a.item)
					io.put_string ("Attributes of type " + type_name_of_type (dtype) + ":")
					io.put_new_line
				until
					i > nb
				loop
					io.put_string (field_name_of_type (i, dtype) + ": ")
					io.put_string (type_name_of_type (field_static_type_of_type (i, dtype)))
					io.put_new_line
					i := i + 1
				end
				io.put_new_line
				a.forth
			end
		end

end
