expanded class TEST3

inherit
	ANY
		redefine
			is_equal
		end

create
	make, default_create

feature

	make (v: STRING) is
		do
			value := v
		end

	value: STRING

	is_equal (other: like Current): BOOLEAN is
		do
			Result := value.is_equal (other.value)
		end

end
