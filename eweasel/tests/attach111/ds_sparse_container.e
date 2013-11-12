deferred class DS_SPARSE_CONTAINER [G, K]

inherit

	DS_LINEAR [G]

feature {NONE}

	make
		do
			set_internal_cursor (new_cursor)
		end

feature

	new_cursor: DS_SPARSE_CONTAINER_CURSOR [G, K]
		do
			create Result.make (Current)
		end

feature {NONE}

	key_equality_tester: detachable TEST
		deferred
		end

feature {NONE}

	set_internal_cursor (c: like internal_cursor)
		do
			internal_cursor := c
		end

	internal_cursor: like new_cursor

end
