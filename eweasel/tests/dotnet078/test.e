class
	TEST

inherit
	BASE

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
			print_properties ({BASE})
		end
		
feature {NONE} -- Implementation

	print_properties (a_type: SYSTEM_TYPE) is
			-- Prints properties
		require
			a_type_attached: a_type /= Void
		local
			l_props: NATIVE_ARRAY [PROPERTY_INFO]
			l_count, i: INTEGER
		do
			l_props := a_type.get_properties ({BINDING_FLAGS}.declared_only | {BINDING_FLAGS}.instance | {BINDING_FLAGS}.public)
			l_count := l_props.count
			from until i = l_count loop
				print (a_type.name)
				print ('.')
				print (l_props.item (i).name)
				print ("%N")
				i := i + 1
			end
		end

end
