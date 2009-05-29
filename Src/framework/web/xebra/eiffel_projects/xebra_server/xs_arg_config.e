note
	description: "[
		Contains settings that are read from execution arguments
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_ARG_CONFIG

create
	make_empty

feature {NONE} -- Initialization

	make_empty
			-- Initialization for `Current'.
		do
			create debug_level.make_empty
						create clean.make_empty
		ensure
			debug_level_attached: debug_level /= Void
			clean_attached: clean /= Void
		end

feature -- Access

	debug_level: SETTABLE_INTEGER

	clean: SETTABLE_BOOLEAN assign set_clean
			-- Can be used to clean all webapps		

feature -- Status report

	print_configuration: STRING
			-- Renders the configuration to a string
		do
			Result := "%N-Debug Level '" + debug_level.out + "'" +
					  "%N-Clean '" + clean.out + "'"
		ensure
			Result_attached: Result /= Void
		end

feature -- Status setting

	set_debug_level  (a_debug_level: like debug_level)
			-- Sets debug_level.
		require
			a_debug_level_attached: a_debug_level /= Void
		do
			debug_level  := a_debug_level
		ensure
			debug_level_set: debug_level  = a_debug_level
		end

	set_clean (a_clean: like clean)
			-- Sets clean.
		require
			a_clean_attached: a_clean /= Void
		do
			clean  := a_clean
		ensure
			clean_set: clean  = a_clean
		end

invariant
	debug_level_attached: debug_level /= Void
	clean_attached: clean /= Void
end

