deferred class
	MY_LIST [G]

feature
	item: G
		deferred
		end

	extend (v: like item)
		deferred
		end

	start
		deferred
		end

	after: BOOLEAN
		deferred
		end

	forth
		deferred
		end

	append (other: MY_LIST [G])
		deferred
		end

	do_all (action: PROCEDURE [variant ANY, TUPLE [G]])
		do
			from
				start
			until
				after
			loop
				action.call ([item])
				forth
			end
		end
		
end
