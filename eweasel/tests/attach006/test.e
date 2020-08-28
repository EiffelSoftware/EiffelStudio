class TEST

create
	make

feature -- Initialization

	make
		do
		end

feature -- Access

	test: BILINEAR [attached STRING_8]

feature -- Element change

	set_test (a_test: like test)
		do
		end

feature {NONE} -- Basic operations

	process_test
		do
			if attached test as l_test then
			end
		end

end