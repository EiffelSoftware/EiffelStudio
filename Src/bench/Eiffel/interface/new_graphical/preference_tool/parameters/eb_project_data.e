indexing
	description	: "All shared attributes specific to the project."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROJECT_DATA

inherit
	SHARED_RESOURCES

feature -- Access

	raise_on_error: BOOLEAN is
		do
			Result := boolean_resource_value ("raise_on_error", True)
		end

	graphical_output_disabled: BOOLEAN is
		do
			Result := boolean_resource_value ("graphical_output_disabled", False)
		end

	parse_class_after_saving: BOOLEAN is
		obsolete "useless now..."
		do
			Result := boolean_resource_value ("parse_class_after_saving", True)
		end

end -- class EB_PROJECT_TOOL_DATA
