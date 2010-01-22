class TEST
inherit
	TEST1

create
	make

feature
	
	make
		do
			f
		end

	x, y: STRING
		attribute
		ensure then
			Result /= Void
		end

	z: STRING = "test"

	w: INTEGER = 10

end
