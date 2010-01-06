class
	TEST

create
	make

feature -- Initialization

	make is
		local
			p: PROCEDURE [ANY, TUPLE]
		do
--			p := agent f (1, ?)
			p := agent f
		end

	f (i1: STRING)
--	f (i1: INTEGER; i2: INTEGER)
		do

		end

end -- class ROOT_CLASS

