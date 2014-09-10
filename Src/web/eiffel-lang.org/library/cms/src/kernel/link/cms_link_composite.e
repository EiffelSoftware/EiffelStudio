note
	description: "Summary description for {CMS_LINK_COMPOSITE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_LINK_COMPOSITE

inherit
	ITERABLE [CMS_LINK]

feature -- Access	

	items: detachable LIST [CMS_LINK]
		deferred
		end

	extend (lnk: CMS_LINK)
		require
			not_the_same_link: lnk /= Current
		deferred
		end

	remove (lnk: CMS_LINK)
		deferred
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
