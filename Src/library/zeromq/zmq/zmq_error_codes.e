note
	description: "Summary description for {ZMQ_ERROR_CODES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ZMQ_ERROR_CODES

feature -- Access

	eagain: INTEGER
			-- Value of EAGAIN constant.
		external
			"C inline use <errno.h>"
		alias
			"return EAGAIN;"
		end

	eintr: INTEGER
			-- Value of EINTR constant.
		external
			"C inline use <errno.h>"
		alias
			"return EINTR;"
		end

	enotsock: INTEGER
			-- Value of ENOTSOCK constant.
		external
			"C inline use <errno.h>"
		alias
			"return ENOTSOCK;"
		end

end
