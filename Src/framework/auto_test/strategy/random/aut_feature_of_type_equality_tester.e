indexing

	description:

		"Equality tester for AUT_FEATURE_OF_TYPE"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


class AUT_FEATURE_OF_TYPE_EQUALITY_TESTER

inherit

	KL_EQUALITY_TESTER [AUT_FEATURE_OF_TYPE]
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

	test (v, u: AUT_FEATURE_OF_TYPE): BOOLEAN is
		do
			if v = u then
				Result := True
			elseif v = Void then
				Result := False
			elseif u = Void then
				Result := False
			else
				Result := v.feature_ = u.feature_ and
							v.type = u.type
			end
		end

end
