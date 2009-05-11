note
	description: "[
		Provides an is_set feature to check 
		if the value has been set yet or not.
	]"
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SETTABLE_TYPES [G]

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
			is_set: is_set
		do
			Result := internal_value
		end

feature -- Element change

	set_value (a_value: G)
		do
			internal_value := a_value
			is_set := True
		end

feature -- Status report

	is_set: BOOLEAN

	out: STRING
			-- Calls out of internal_value
		do
			Result := value.out
		end

feature {NONE} -- Implementation

	internal_value: G

end

