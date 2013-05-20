note
	description: "Summary description for {WSF_ERROR}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_ERROR

inherit
	ERROR

	HTTP_STATUS_CODE_MESSAGES

create
	make

feature {NONE} -- Initialization

	make (a_code: INTEGER)
		do
			code := a_code
			name := "HTTP Error"
			if attached http_status_code_message (a_code) as m then
				name := m
			end
		end

feature -- Access

	code: INTEGER

	name: STRING

	message: detachable STRING_32

feature -- Element change

	set_message (m: like message)
			-- Set `message' to `m'
		require
			m_attached: m /= Void
		do
			message := m
		end

feature -- Visitor

	process (a_visitor: ERROR_VISITOR)
			-- Process Current using `a_visitor'.
		do
			a_visitor.process_error (Current)
		end

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
