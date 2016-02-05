class
	CAT_ATTRIBUTE_CAN_BE_MADE_CONSTANT

create
	make_1,
	make_2,
	make_3

feature {NONE} -- Initialization

	make_1
		do
			some_integer := 5
			some_char := 'a'
			some_boolean := False
			some_real := 4.5
			some_string := "test"
		end

	make_2
		do
			some_integer := 5
			some_char := 'a'
			some_boolean := False
			some_real := 4.5
			some_string := "test"
		end

	make_3
		do
			some_integer := 5
			some_char := 'a'
			some_boolean := False
			some_real := 4.5
			some_string := "test"
		end

feature {NONE} -- Attributes

	some_integer: INTEGER

	some_char: CHARACTER

	some_boolean: BOOLEAN

	some_real: REAL

	some_string: STRING

end
