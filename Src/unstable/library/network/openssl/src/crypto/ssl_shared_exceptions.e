note
	description: "Summary description for {SSL_SHARED_EXCEPTIONS}."
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_SHARED_EXCEPTIONS


feature -- Exception

	raise_exception (a_description: STRING_8)
		local
			l_exception: DEVELOPER_EXCEPTION
		do
			create l_exception
			l_exception.set_description (generator + ": " + a_description )
			l_exception.raise
		end

end
