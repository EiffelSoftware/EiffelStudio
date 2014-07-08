class
	PROXY_PROXIABLE_DATA

inherit
	OBJECT_PROXY
		redefine
			item
		end

feature

	item: detachable PROXIABLE_DATA

end
