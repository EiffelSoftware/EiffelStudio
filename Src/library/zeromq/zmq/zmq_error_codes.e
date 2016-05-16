note
	description: "Summary description for {ZMQ_ERROR_CODES}."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ZMQ_ERROR_CODES

feature -- Access

	eagain: INTEGER
			-- Value of EAGAIN constant.
		external
			"C inline use %"zmq.h%""
		alias
			"return EAGAIN;"
		end

	efault: INTEGER
			-- Value of EFAULT constant.
		external
			"C inline use %"zmq.h%""
		alias
			"return EFAULT;"
		end

	eintr: INTEGER
			-- Value of EINTR constant.
		external
			"C inline use %"zmq.h%""
		alias
			"return EINTR;"
		end

	enotsock: INTEGER
			-- Value of ENOTSOCK constant.
		external
			"C inline use %"zmq.h%""
		alias
			"return ENOTSOCK;"
		end

	eterm: INTEGER
			-- Value of ETERM constant.
		external
			"C inline use %"zmq.h%""
		alias
			"return ETERM;"
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
