indexing
	description:
		"AST representation of an access (local, argument or feature). %
		%It is necessary the first call in a nested expression."
	date: "$Date$"
	revision: "$Revision$"

class
	ACCESS_ID_AS

inherit
	ACCESS_INV_AS
		redefine
			process
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_access_id_as (Current)
		end

end -- class ACCESS_ID_AS
