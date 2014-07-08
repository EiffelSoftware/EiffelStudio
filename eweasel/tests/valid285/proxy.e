deferred class
	PROXY

feature

	item: detachable PROXIABLE
			-- The object proxied by current.
			--| The check attached is a work-around to be corrected with proper compiler handling
			--| of an empty attribute specifciation.

end
