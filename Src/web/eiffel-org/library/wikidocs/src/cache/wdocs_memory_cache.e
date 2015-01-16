note
	description: "Summary description for {WDOCS_MEMORY_CACHE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WDOCS_MEMORY_CACHE [G -> ANY]

inherit
	WDOCS_CACHE [G]

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
			create Result.make_now
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

end
