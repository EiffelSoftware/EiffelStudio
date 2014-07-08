deferred class
	PROXIABLE

feature

	proxy: like new_proxy
		do
			check False then  end
		end

	proxy_cache: detachable like new_proxy

	new_proxy: PROXY
		deferred
		end

end
