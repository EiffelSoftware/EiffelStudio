deferred class A

feature

	f
		require
			precondition
		deferred
		ensure
			postcondition
			is_class: class
		end

	precondition: BOOLEAN = True

	postcondition: BOOLEAN = True

end