indexing
	description: "Abstract representation of an interval for `inspect' clauses."
	date: "$Date$"
	revision: "$Revision$"

deferred class INTERVAL_VAL_B

inherit
	BYTE_NODE
	
	COMPARABLE
		undefine
			is_equal
		end

feature -- Error reporting

	display (st: STRUCTURED_TEXT) is
		require
			st_not_void: st /= Void
		deferred
		end

end
