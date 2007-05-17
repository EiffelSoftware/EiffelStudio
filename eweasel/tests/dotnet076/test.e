class
	TEST

inherit
	BASE
		redefine
			a
		end

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
			print (({like Current}).to_cil.is_interface)
			print ("%N")
			print_properties ({BASE})
			print_properties ({TEST})
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

feature -- Tests


	a: STRING assign set_a
		indexing
			property: auto
		end
		
	b: ANY assign set_b
		indexing
			property: auto
		do
		end

end
