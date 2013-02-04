class A

inherit
	ANY
		rename
			default_create as make_0
		redefine
			is_equal
		end

create
	make_0, make_1

feature {NONE} -- Initialization

	make_1
			-- Set `value' to `1'.
		do
			value := 1
		ensure
			value_set: value = 1
		end

feature -- Access

	value: INTEGER_8
			-- Associated value.

	salt: INTEGER_8
			-- Value to distinguish objects.

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- <Precusor>
		do
			Result := value = other.value
		end

end