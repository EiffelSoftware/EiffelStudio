indexing

	description:

		"Equality tester for ITP_VARIABLES"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


class AUT_VARIABLE_EQUALITY_TESTER

inherit

	KL_EQUALITY_TESTER [ITP_VARIABLE]
		redefine
			test
		end

	KL_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make is
			-- Create new tester.
			-- `a_feature' of type `a_type'.
		do
		end

feature -- Status report

	test (v, u: ITP_VARIABLE): BOOLEAN is
		do
			if v = u then
				Result := True
			elseif v = Void then
				Result := False
			elseif u = Void then
				Result := False
			else
				Result := v.index = u.index
			end
		end

end
