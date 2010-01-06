class
	TEST1

create
	make_from_tuple

convert
	make_from_tuple ({TUPLE [INTEGER, STRING]})

feature {NONE}

	make(a_value: like value; a_denomination: like denomination)
		require
			a_denomination_not_void: a_denomination /= Void
		do
			denomination := a_denomination
			value := a_value
		ensure
			denomination_set: denomination = a_denomination
			value_set: value =  a_value
		end

	make_from_tuple(a_tuple: TUPLE [value: INTEGER; denomination: STRING])
		require
			a_tuple_not_void: a_tuple /= Void
			a_tuple_denomination_not_void: a_tuple.denomination /= Void
		do
			make(a_tuple.value, a_tuple.denomination)
		ensure
			denomination_set: denomination = a_tuple.denomination
			value_set: value =  a_tuple.value
		end

feature -- Access

	denomination: STRING
	value: INTEGER

end
