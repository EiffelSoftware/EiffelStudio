note
	description: "[
		Interface for objects that have one parameter
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XC_PARAMETER_CONTAINER


feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create parameter.make_empty
		ensure then
			parameter_attached: parameter /= Void
		end

feature -- Access

	parameter: SETTABLE_STRING

	parameter_description: STRING
			-- The name of the parameter
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Status Change

	set_parameter (a_parameter: STRING)
			-- Sets parameter.
		require
			a_parameter_attached: a_parameter /= Void
		do
			parameter := a_parameter
		ensure
			parameter_set: equal( parameter.value, a_parameter)
		end

invariant
	parameter_attached: parameter /= Void
end

