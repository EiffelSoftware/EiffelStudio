indexing
	external_name: "ISE.Base.Box"

deferred class
	BOX [G]

inherit

	CONTAINER [G]

feature -- Status report

	full: BOOLEAN is
			-- Is structure filled to capacity?
		deferred
		end

end -- class BOX



