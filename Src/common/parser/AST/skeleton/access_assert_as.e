indexing
	description:
		"AST representation of an access (argument or feature) in a %
		%precondition or a postcondition. It is necessary the first call %
		%in a nested expression."
	date: "$Date$"
	revision: "$Revision$"

class
	ACCESS_ASSERT_AS

inherit
	ACCESS_INV_AS
		redefine
			process
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_access_assert_as (Current)
		end

end -- class ACCESS_ASSERT_AS
