indexing
	description: "[
		Deferred class for machine exception, operation exceptions and hardware exceptions
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MACHINE_EXCEPTION

inherit
	EXCEPTION
		undefine
			code,
			internal_meaning
		end

end
