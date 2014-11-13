note
	description: "[
				Abstraction to represent a links container in the CMS system.
			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_LINK_COMPOSITE

inherit
	ITERABLE [CMS_LINK]

feature -- Access	

	items: detachable LIST [CMS_LINK]
			-- Children links.
		deferred
		end

feature -- Element change		

	extend (lnk: CMS_LINK)
			-- Add `lnk' as a sub link.	
		deferred
		end

	remove (lnk: CMS_LINK)
			-- Remove link `lnk' from Current container.
		deferred
		end

feature -- status report

	is_empty: BOOLEAN
			-- Is container empty?
		do
			Result := not attached items as l_items or else l_items.is_empty
		end

	count: INTEGER
			-- Number of immediate sub links.
		do
			if attached items as l_items then
				Result := l_items.count
			end
		end

note
	copyright: "2011-2014, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
