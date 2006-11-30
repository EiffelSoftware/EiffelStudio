deferred class PARENT

feature

	is_valid: BOOLEAN

	item: PARENT is
		deferred
		end

	test is
		deferred
		ensure
			item.is_valid
		end

end