class TEST1 

create
	make

feature

	make is
		do
			create test2
		end

	check_type (a_type: STRING) is
		local
			l_error_level: INTEGER
			l_type: TEST3
		do
			l_error_level := error_level
			if is_inherited then
				l_type := test2.evaluate (a_type, "")
				l_type := test2.solved (l_type, a_type)
				l_type := l_type.twin
			else
				l_type := test2.evaluate (a_type, "")
				l_type := test2.solved (l_type, a_type)
			end
		end

	test2: TEST2

	is_inherited: BOOLEAN

	error_level: INTEGER is
		do
			Result := error_level_cell.item
		end

	error_level_cell: CELL [INTEGER] is
		once
			create Result.put (0)
		end

end
