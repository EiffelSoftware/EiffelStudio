deferred class
	PROXIABLE_DATA

inherit
	DATA

	PROXIABLE
		redefine
			proxy,
			new_proxy
		end

feature

	proxy: like new_proxy
		do
			check False then end
		end

	new_proxy: PROXY_PROXIABLE_DATA
		deferred
		end

end
