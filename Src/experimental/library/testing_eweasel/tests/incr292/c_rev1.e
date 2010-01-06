class C

inherit
	A
	B
		rename
			name as old_name
		export
			{NONE} all
		end

feature
	name: STRING

end
