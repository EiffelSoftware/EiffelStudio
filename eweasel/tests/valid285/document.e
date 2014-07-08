deferred class DOCUMENT
inherit
	ENTITY
		redefine
			new_proxy
		end

feature

	new_proxy: PROXY_DOCUMENT
		deferred
		end

end
