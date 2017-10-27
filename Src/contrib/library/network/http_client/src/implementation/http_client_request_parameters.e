note
	description: "Summary description for {HTTP_CLIENT_REQUEST_PARAMETERS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTTP_CLIENT_REQUEST_PARAMETERS [G -> HTTP_CLIENT_REQUEST_PARAMETER]

inherit
	ITERABLE [G]

feature {NONE} -- Initialization

	make (nb: INTEGER)
		do
			create items.make (nb)
		end

feature -- Access

	is_empty: BOOLEAN
		do
			Result := items.is_empty
		end

	count: INTEGER
		do
			Result := items.count
		end

	has (a_parameter_name: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := across items as ic some a_parameter_name.same_string (ic.item.name)  end
		end

feature -- Element change

	extend, force (i: G)
		do
			items.force (i)
		end

feature -- Iteration

	new_cursor: ARRAYED_LIST_ITERATION_CURSOR [G]
			-- <Precursor>
		do
			Result := items.new_cursor
		end

feature {NONE} -- Implementation

	items: ARRAYED_LIST [G]

invariant
note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
