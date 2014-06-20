deferred class DOCUMENT
inherit
	PARENT
		redefine
			new_proxy
		end

feature

	new_proxy: PROXY_DOCUMENT
		deferred
		end

end
