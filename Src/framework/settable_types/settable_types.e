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
			create_internal_value
		ensure
			interal_value_attached: internal_value /= void
		end

feature -- Access

	value: G
		require
			is_set: is_set
		do
			Result := internal_value
		ensure
			Result_attached: Result /= Void
		end

feature -- Element change

	set_value (a_value: G)
		require
			a_value_attached: a_value /= Void
		do
			internal_value := a_value
			is_set := True
		ensure
			internal_value_set: internal_value = a_value
			is_set: is_set = True
		end

	create_internal_value
			-- Creates the internal_value
		deferred
		ensure
			interal_value_attached: internal_value /= void
		end

feature -- Status report

	is_set: BOOLEAN

	out: STRING
			-- Calls out of internal_value
		do
			Result := value.out
		ensure then
			Result_attached: Result /= Void
		end

feature {NONE} -- Implementation

	internal_value: G

invariant
		interal_value_attached: internal_value /= void
end

