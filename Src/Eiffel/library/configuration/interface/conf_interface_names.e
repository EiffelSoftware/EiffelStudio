indexing
	description: "Names and descriptions for configuration components."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_INTERFACE_NAMES

feature {NONE} -- System names and descriptions

	system_name_name: STRING is "Name"
	system_name_description: STRING is "Name of the system."
	system_description_name: STRING is "Description"
	system_description_description: STRING is "Description of the system."
	system_library_target_name: STRING is "Library target"
	system_library_target_description: STRING is "Target used if system is used as a library."
	system_uuid_name: STRING is "UUID"
	system_uuid_description: STRING is "Unique identifier for the system."
	system_targets_name: STRING is "Targets"
	system_targets_description: STRING is "Targets of the system."

end
