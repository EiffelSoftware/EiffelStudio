indexing
	description: "[
				Data structures of the most general kind,
				having the potential ability to become full,
				and characterized by their implementation properties.
			 ]"
	class_type: Interface
	external_name: "ISE.Base.Box"

deferred class
	BOX [G]

inherit

	CONTAINER [G]

feature -- Status report

	full: BOOLEAN is
		indexing
			description: "Is structure filled to capacity?"
		deferred
		end

end -- class BOX



