deferred class DS_LINEAR [G]

inherit

	DS_TRAVERSABLE [G]
		redefine
			new_cursor
		end

feature

	new_cursor: DS_LINEAR_CURSOR [G]
		deferred
		end

	equality_tester: detachable TEST

end
