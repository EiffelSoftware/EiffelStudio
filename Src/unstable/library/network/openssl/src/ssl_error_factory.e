note
	description: "Summary description for {SSL_ERROR_FACTORY}."
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_ERROR_FACTORY

feature -- Errors

	retrieve_errors: detachable LIST [SSL_ERROR]
		local
			l_code: NATURAL_64
			l_result: LIST [SSL_ERROR]
		do
			from
				l_code := {SSL_ERROR_EXTERNALS}.c_err_get_error
			until
				l_code = 0
			loop
				if attached l_result then
					l_result.force (create {SSL_ERROR}.make (l_code))
				else
					create {ARRAYED_LIST [SSL_ERROR]} l_result.make (1)
					l_result.force (create {SSL_ERROR}.make (l_code))
				end
			end
			Result := l_result
		ensure
			is_class: class
		end

end
