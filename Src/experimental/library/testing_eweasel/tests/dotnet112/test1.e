class
	TEST1 [G]

inherit
	TEST2

create
	make

feature

	make is
		local
		do
		end

	subnode (a: SPECIAL [G]; a_name, a_type: STRING): STRING is
		do
			create Result.make_from_string (object_representation (Void, a_name, a_type, a.item (0).out))
		end


end

