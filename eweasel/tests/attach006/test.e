class TEST

create
	make

feature -- Initialization

	make
		do
		end

feature -- Access

	test: BILINEAR [!STRING_8]

feature -- Element change

	set_test (a_test: like test)
		do
		end

feature {NONE} -- Basic operations

	process_test
		do
			if {l_test: !like test} test then
			end
		end

end