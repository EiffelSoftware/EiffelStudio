indexing

	description:

		"Equality tester for ET_CLASS. Compares by name."

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class AUT_CLASS_EQUALITY_TESTER

inherit

	KL_EQUALITY_TESTER [CLASS_C]
		redefine
			test
		end

create

	make

feature {NONE} -- Initialization

	make is
			-- Create new tester.
			-- `a_feature' of type `a_type'.
		do
		end

feature -- Status report

	test (v, u: CLASS_C): BOOLEAN is
		do
			if v = u then
				Result := True
			elseif v = Void then
				Result := False
			elseif u = Void then
				Result := False
			else
				Result := v.name_in_upper.is_equal (u.name_in_upper)
			end
		end

end
