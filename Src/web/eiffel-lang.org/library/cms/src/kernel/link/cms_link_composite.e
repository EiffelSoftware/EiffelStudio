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
		deferred
		end

	remove (lnk: CMS_LINK)
		deferred
		end

end
