indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR_EXCEPTION

inherit
	ERROR

feature -- Access

	exception: EXCEPTION assign set_exception
			-- Associated exception

feature -- Element change

	set_exception (v: like exception)
		require
			v_attached: v /= Void
		do
			exception := v
		end

end
