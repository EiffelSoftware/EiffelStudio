class TEST
inherit
	TEST1
		redefine
			g
		end
create
	make

feature

	make is
		do
			g
		end

	g is
		do
			Precursor
			io.put_string ("In {TEST}.g")
			io.put_new_line
		end

end
