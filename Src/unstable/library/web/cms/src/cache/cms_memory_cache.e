note
	description: "Cache relying on memory."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_MEMORY_CACHE [G -> ANY]

inherit
	CMS_CACHE [G]

feature {NONE} -- Initialization

	make
		do
			cache_date_time := current_date_time
		end


feature -- Status report

	exists: BOOLEAN
			-- Do associated cache memory exists?
		do
			Result := item /= Void
		end

feature -- Access

	cache_date_time: DATE_TIME

	current_date_time: DATE_TIME
			-- <Precursor>
		do
			create Result.make_now_utc
		end

	item: detachable G

feature -- Element change

	delete
			-- <Precursor>
		local
			l_default: detachable G
		do
			item := l_default
			cache_date_time := current_date_time
		end

	put (g: G)
			-- <Precursor>
		do
			item := g
			cache_date_time := current_date_time
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
