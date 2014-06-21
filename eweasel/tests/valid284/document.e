deferred class DOCUMENT
inherit
	CHILD
		redefine
			new_proxy
		end

	PROXIABLE
		undefine
			proxy
		end

feature

	new_proxy: PROXY_DOCUMENT
		deferred
		end

end
