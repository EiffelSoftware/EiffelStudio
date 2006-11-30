class TEST

create 
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		local
			ae2: ARRAY [ENUM_16]
			e2: ENUM_16
			ae4: ARRAY [ENUM_32]
			e4: ENUM_32
			av1: ARRAY [VAL_1]
			v1: VAL_1
			av2: ARRAY [VAL_2]
			v2: VAL_2
			aa: ARRAY [A]
			a: A
		do
			create aa.make (1, 2)
			a := aa.item (1).default.default
			create ae2.make (1, 2)
			e2 := ae2.item (1).default.default
			create ae4.make (1, 2)
			e4 := ae4.item (1).default.default
			create av1.make (1, 2)
			v1 := av1.item (1).default.default
			create av2.make (1, 2)
			v2 := av2.item (1).default.default
			io.put_new_line
		end

end
