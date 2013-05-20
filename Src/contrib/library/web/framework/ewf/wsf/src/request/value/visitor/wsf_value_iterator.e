note
	description: "[
			Iterator visitor on WSF_VALUE
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_VALUE_ITERATOR

inherit
	WSF_VALUE_VISITOR

feature -- Helper

	process_iterable_of_value (it: ITERABLE [WSF_VALUE])
		do
			across
				it as c
			loop
				c.item.process (Current)
			end
		end

feature -- Visitor

	process_table (v: WSF_TABLE)
		do
			process_iterable_of_value (v)
		end

	process_string (v: WSF_STRING)
		do
		end

	process_multiple_string (v: WSF_MULTIPLE_STRING)
		do
			process_iterable_of_value (v)
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
