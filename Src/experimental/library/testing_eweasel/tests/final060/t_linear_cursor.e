deferred class
	T_LINEAR_CURSOR [G]

inherit
	T_CURSOR [G]
		redefine
			container
		end

feature

	container: T_LINEAR [G] is
		deferred
		end

	start is
		do
			container.do_nothing
		end

end
