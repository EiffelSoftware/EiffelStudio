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
			create config_filename.make_empty
			create assume_webapps_are_running.make_empty
		ensure
			debug_level_attached: debug_level /= Void
			clean_attached: clean /= Void
			config_filename_attached: config_filename /= Void
			assume_webapps_are_running_attached: assume_webapps_are_running /= Void
		end

feature -- Access

	debug_level: SETTABLE_INTEGER

	clean: SETTABLE_BOOLEAN assign set_clean
			-- Can be used to clean all webapps	

	config_filename: SETTABLE_STRING assign set_config_filename

	assume_webapps_are_running:  SETTABLE_BOOLEAN assign set_assume_webapps_are_running
			-- Specifies

feature -- Status report

	print_configuration: STRING
			-- Renders the configuration to a string
		do
			Result := "%N---------------- Server Arguments ----------------"
			Result.append ( "%N-Debug Level '" + debug_level.out + "'" +
					  "%N-Clean '" + clean.out + "'" +
					  "%N-Assume webapps are running  '" + assume_webapps_are_running.out + "'")
			Result.append ("%N--------------------------------------------------")
		ensure
			Result_attached: Result /= Void
		end

feature {XS_MAIN_SERVER} -- Status setting

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

	set_config_filename (a_config_filename: like config_filename)
			-- Sets config_filename.
		require
			a_config_filename_attached: a_config_filename /= Void
		do
			config_filename  := a_config_filename
		ensure
			config_filename_set: config_filename  = a_config_filename
		end

	set_assume_webapps_are_running (a_assume_webapps_are_running: like assume_webapps_are_running)
			-- Sets assume_webapps_are_running.
		require
			a_assume_webapps_are_running_attached: a_assume_webapps_are_running /= Void
		do
			assume_webapps_are_running := a_assume_webapps_are_running
		ensure
			assume_webapps_are_running_set: assume_webapps_are_running = a_assume_webapps_are_running
		end

invariant
	debug_level_attached: debug_level /= Void
	clean_attached: clean /= Void
	config_filename_attached: config_filename /= Void
	assume_webapps_are_running_attached: assume_webapps_are_running /= Void
end

