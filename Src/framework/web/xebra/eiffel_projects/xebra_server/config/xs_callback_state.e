note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"
deferred class
	XS_CALLBACK_STATE

feature -- Initialization

	make (a_config_callback: XS_XML_CONFIG_CALLBACK)
		do
			config_callback := a_config_callback
		end

feature -- Access

	config_callback: XS_XML_CONFIG_CALLBACK
			-- The parser callbacks on which the tags should be added
	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
			-- Handle strings on attribute
		require
			a_prefix_valid: a_prefix /= Void
			a_local_part_valid: a_local_part /= Void
			a_value_valid: a_value /= Void
		deferred
		end

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- <Precursor>
		deferred
		end

end
