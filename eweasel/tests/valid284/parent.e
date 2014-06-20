deferred class PARENT
inherit

	PROXIABLE
		redefine
			proxy,
			new_proxy
		end

feature
	creation_objects_proxy_anchor: TUPLE
		do
			check False then end
		end

	proxy: like new_proxy

	new_proxy: PROXY_PARENT
		deferred
		end
end
