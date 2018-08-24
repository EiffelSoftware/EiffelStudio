note
	model: bag

deferred class
	F_ST_CONTAINER [G]

feature	-- Access

	count: INTEGER
			-- Number of elements.
		deferred
		ensure
			Result = bag.count
		end

	is_empty: BOOLEAN
			-- Is the container empty?
		do
			Result := count = 0
		ensure
			definition: Result = bag.is_empty
		end

feature -- Element change

	wipe_out
			-- Empty container.
		require
			modify_model ("bag", Current)
		deferred
		ensure
			bag_effect: bag.is_empty
		end

feature -- Specification

	bag: MML_BAG [G]
			-- Bag of container's elements.
		note
			status: ghost
		attribute
		end

end
