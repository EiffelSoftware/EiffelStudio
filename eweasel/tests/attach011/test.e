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
				attached {attached STRING_8} l_void as l_s1 and then
				attached {attached STRING_8} l_s1.out as l_s2
			then
				Result := True
			end
		end

end