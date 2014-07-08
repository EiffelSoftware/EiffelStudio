note
	description: "Summary description for {PROXY_MODEL_ENTITY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROXY_ENTITY

inherit
	PROXY_PROXIABLE_DATA
		redefine
			item
		end

feature

	item: detachable ENTITY

end
