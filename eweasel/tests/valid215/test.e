class
	TEST

create
	make

feature {NONE} -- Initialization

	make is
		local
			b: BOOLEAN
		do
			b := {TEST}.test = "string"
		end
	
feature -- Externals
	
	test: INTEGER
		external
			"C inline"
		alias
			"return 1"
		end

end