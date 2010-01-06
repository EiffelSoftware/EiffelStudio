class A

inherit
	ANY
		redefine
			copy,
			is_equal
		end

feature -- Duplication

	copy (other: like Current) is
		do
			value := other.value + 1
			io.put_string (generating_type)
			io.put_string (" := ")
			io.put_string (other.generating_type)
			io.put_string (" (")
			io.put_integer (value)
			io.put_string (")")
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Make sure `copy' fulfills the postcondition.
		do
			Result := True
		end

feature {A} -- Data

	value: INTEGER
			-- Current value

end