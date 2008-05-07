deferred class
	TEST2 [G, K]

feature

	make is
		do
			make_bad
		end
	
	make_bad is
		deferred
		end

	clear is
		do
			cache.wipe_out
		end

	cache: CACHE [K] is
		deferred
		end

end
