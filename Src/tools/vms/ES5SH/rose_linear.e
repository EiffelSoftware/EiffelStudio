note
	original_author: "Mark Howard"
	description: "linear with count and index"
	keywords: "linear,iterator,agent"

deferred class ROSE_LINEAR[G]

inherit
	LINEAR [G]
		rename
			search as ise_linear_search
		end

feature -- Access

--	cursor : ROSE_LINEAR_CURSOR is
--		-- New cursor for `Current'
--		do
--			create Result.make(index)
--		ensure
--			cursor_not_void: Result /= Void
--		end

	has_reference (a_value: G): BOOLEAN
			-- Is 'a_value' referenced in this linear?
		local
			l_save_index: INTEGER
		do
			l_save_index := index
			from
				start
			until
				Result or else off
			loop
				Result := item = a_value
				forth
			end
			go_i_th (l_save_index)
		end

	has_value (a_value: G): BOOLEAN
			-- Is 'a_value' present in this linear?
			-- Warning: uses 'deep_equal' !
		local
			l_save_index: INTEGER
		do
			l_save_index := index
			from
				start
			until
				Result or else off
			loop
				Result := deep_equal (item, a_value)
				forth
			end
			go_i_th (l_save_index)
		end

feature -- Basic operations

	go_i_th (a_index: INTEGER)
		deferred
		end

	index: INTEGER
		deferred
		end

	count: INTEGER
		deferred
		end

end -- class ROSE_LINEAR_ARRAY
