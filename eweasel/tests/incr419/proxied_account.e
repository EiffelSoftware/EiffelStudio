class
	PROXIED_ACCOUNT [G -> NUMERIC]

inherit
	PROXIED
		redefine
			new_proxy
		end

feature

	new_proxy: PROXY_ACCOUNT [G]
		do
		end

end
