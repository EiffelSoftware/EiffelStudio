class B_ATTRIBUTES

create
	default_values_for_attribute

feature

	integer_attribute: INTEGER
	natural_attribute: NATURAL
	real_attribute: REAL_64
	boolean_attribute: BOOLEAN
	any_attribute: ANY

	default_values_for_attribute
		note
			status: creator
		do
			check integer_attribute = 0 end
			check natural_attribute = 0 end
			check real_attribute = 0.0 end
			check boolean_attribute = False end
			check any_attribute = Void end
		end

	attribute_initialization
		do
			integer_attribute := 1
			natural_attribute := 2
			real_attribute := 3.4
			boolean_attribute := True
			any_attribute := Current

			check integer_attribute = 1 end
			check natural_attribute = 2 end
			check real_attribute = 3.4 end
			check boolean_attribute = True end
			check any_attribute = Current end
		end

	integer_attr2: INTEGER
	any_attr2: ANY

	attribute_assignment
		do
			integer_attribute := 1
			integer_attr2 := 2
			integer_attribute := integer_attr2
			check integer_attribute = 2 end
			any_attribute := Void
			any_attr2 := Current
			any_attribute := any_attr2
			check any_attribute = Current end
		end

	argument_assignment (a: INTEGER; b: ANY)
		require
			a = 3
			b = Current
		do
			integer_attribute := a
			check integer_attribute = 3 end
			any_attribute := b
			check any_attribute = Current end
		end

end
