deferred class DS_LINEAR_CURSOR [G]

inherit

	DS_CURSOR [G]
		redefine
			container
		end

feature

	container: DS_LINEAR [G]
		deferred
		end

end
