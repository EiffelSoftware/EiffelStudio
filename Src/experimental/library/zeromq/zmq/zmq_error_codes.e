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
		ensure
			is_class: class
		end

	efault: INTEGER
			-- Value of EFAULT constant.
		external
			"C inline use %"zmq.h%""
		alias
			"return EFAULT;"
		ensure
			is_class: class
		end

	eintr: INTEGER
			-- Value of EINTR constant.
		external
			"C inline use %"zmq.h%""
		alias
			"return EINTR;"
		ensure
			is_class: class
		end

	enotsock: INTEGER
			-- Value of ENOTSOCK constant.
		external
			"C inline use %"zmq.h%""
		alias
			"return ENOTSOCK;"
		ensure
			is_class: class
		end

	eterm: INTEGER
			-- Value of ETERM constant.
		external
			"C inline use %"zmq.h%""
		alias
			"return ETERM;"
		ensure
			is_class: class
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
