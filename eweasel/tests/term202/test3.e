deferred class
	TEST3 [G]

feature

	set_internal_cursor (c: like internal_cursor) is
		deferred
		ensure
			internal_cursor_set: internal_cursor = c
		end

	internal_cursor: like new_cursor is
		deferred
		end

	new_cursor: TEST2 [G] is
		deferred
		ensure
			cursor_not_void: Result /= Void
		end

end
