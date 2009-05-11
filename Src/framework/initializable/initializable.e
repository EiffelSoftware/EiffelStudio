note
	description: "[
		Provides an is_initialized feature to check 
		if the value has been set yet or not.
	]"
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INITIALIZABLE [G]

inherit
	ANY
	redefine
		out
	end

feature -- Creation

	make_empty
			-- Creates but does not initialize
		do
		end

feature -- Access

	value: G
		require
			is_initialized: is_initialized
		do
			Result := internal_value
		end

feature -- Element change

	set_value (a_value: G)
		do
			internal_value := a_value
			is_initialized := True
		end

feature -- Status report

	is_initialized: BOOLEAN

	out: STRING
			-- Calls out of internal_value
		do
			Result := value.out
		end

feature {NONE} -- Implementation

	internal_value: G

end

