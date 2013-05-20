note
	description: "[
			NULL Visitor implementation
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_VALUE_NULL_VISITOR

inherit
	WSF_VALUE_VISITOR

feature -- Visitor

	process_table (v: WSF_TABLE)
		do
		end

	process_string (v: WSF_STRING)
		do
		end

	process_multiple_string (v: WSF_MULTIPLE_STRING)
		do
		end

	process_any (v: WSF_ANY)
		do
		end

	process_uploaded_file (v: WSF_UPLOADED_FILE)
		do
		end

;note
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
