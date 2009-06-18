note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XS_PARAMETER_COMMAND

inherit
	XC_COMMAND

feature -- Access

	parameter: SETTABLE_STRING

	parameter_description: STRING
			-- The name of the parameter
		deferred
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

feature -- Status report

feature -- Status setting

feature -- Basic operations

feature {NONE} -- Implementation

invariant

end

