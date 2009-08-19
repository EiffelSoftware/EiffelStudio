note
	description: "[
		Contains settings that are read from execution arguments.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
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
			create config_filename.make_empty
			create unmanaged.make_empty
		ensure
			debug_level_attached: debug_level /= Void
			config_filename_attached: config_filename /= Void
			unmanaged_attached: unmanaged /= Void
		end

feature -- Access

	debug_level: SETTABLE_INTEGER

	config_filename: SETTABLE_STRING assign set_config_filename

	unmanaged:  SETTABLE_BOOLEAN assign set_unmanaged
			-- Specifies

feature -- Status report

	print_configuration: STRING
			-- Renders the configuration to a string
		do
			Result := "%N---------------- Server Arguments ----------------"
			Result.append ( "%N-Debug Level '" + debug_level.out + "'" +
					  "%N-Unmanaged  '" + unmanaged.out + "'")
			Result.append ("%N--------------------------------------------------")
		ensure
			Result_attached: Result /= Void
		end

feature  -- Status setting

	set_debug_level  (a_debug_level: like debug_level)
			-- Sets debug_level.
		require
			a_debug_level_attached: a_debug_level /= Void
		do
			debug_level  := a_debug_level
		ensure
			debug_level_set: debug_level  = a_debug_level
		end

	set_config_filename (a_config_filename: like config_filename)
			-- Sets config_filename.
		require
			a_config_filename_attached: a_config_filename /= Void
		do
			config_filename  := a_config_filename
		ensure
			config_filename_set: config_filename  = a_config_filename
		end

	set_unmanaged (a_unmanaged: like unmanaged)
			-- Sets unmanaged.
		require
			a_unmanaged_attached: a_unmanaged /= Void
		do
			unmanaged := a_unmanaged
		ensure
			unmanaged_set: unmanaged = a_unmanaged
		end

invariant
	debug_level_attached: debug_level /= Void
	config_filename_attached: config_filename /= Void
	unmanaged_attached: unmanaged /= Void
end

