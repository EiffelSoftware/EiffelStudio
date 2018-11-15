note
	description: "Summary description for {SSL_ERROR_FACTORY}."
	date: "$Date$"
	revision: "$Revision$"

class
	SSL_ERROR_FACTORY

feature -- Errors

	errors: detachable LIST [SSL_ERROR]
			-- Last retrieved errors.
			-- Warning: call this once to get the latest errors.
		local
			l_code: NATURAL_64
		do
			from
				l_code := {SSL_ERROR_EXTERNALS}.c_err_get_error
			until
				l_code = 0
			loop
				if Result /= Void then
					Result.force (create {SSL_ERROR}.make (l_code))
				else
					create {ARRAYED_LIST [SSL_ERROR]} Result.make (1)
					Result.force (create {SSL_ERROR}.make (l_code))
				end
			end
		ensure
			is_class: class
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
