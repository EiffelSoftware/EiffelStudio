note
	description: "Factory in charge of creating new concurrent pool item."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONCURRENT_POOL_FACTORY [G -> CONCURRENT_POOL_ITEM]

feature -- Access

	update_item (a_item: separate G)
			-- Update `a_item' for optionally purpose.
		do
		end

	new_separate_item: separate G
			-- New separated object of type {G}.
		deferred
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
