deferred class
	PROXIABLE

feature

	proxy: like new_proxy
			-- Proxy for current.
		do
			check False then  end
		end

feature {NONE} -- Implementation

	proxy_cache: detachable like new_proxy
			-- Cached version of proxy for this object

	new_proxy: PROXY
			-- Returns a new proxy for current.
		deferred
		end

end
