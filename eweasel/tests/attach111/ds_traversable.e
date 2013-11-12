deferred class DS_TRAVERSABLE [G]

feature

	new_cursor: DS_CURSOR [G]
		deferred
		end

feature {NONE}

	set_internal_cursor (c: like internal_cursor)
		deferred
		end

	internal_cursor: like new_cursor
		deferred
		end

end
