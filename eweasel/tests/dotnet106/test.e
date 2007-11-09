class
	TEST

create
	make

feature -- Initialization

make is
	local
		s: STRING
		e: MSCORE_APPLICATION_EXCEPTION
		b: BOOLEAN
	do
		s := "a"
		create e.make
		b := equal (s, e.message)
	end

end