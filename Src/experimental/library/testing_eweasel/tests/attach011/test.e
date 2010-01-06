class TEST

create
	make

feature -- Initialization

	make
		do
			io.put_boolean (test)
			io.new_line
		end

feature -- Status report

	test: BOOLEAN
		local
			l_void: ANY
		do
			if
				{l_s1: !STRING_8} l_void and then
				{l_s2: !STRING_8} l_s1.out
			then
				Result := True
			end
		end

end