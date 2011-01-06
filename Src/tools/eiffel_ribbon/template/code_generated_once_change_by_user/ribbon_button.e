note
	description: "Summary description for {ER_TOOL_BAR_BUTTON}."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	RIBBON_BUTTON_$INDEX

inherit
	RIBBON_BUTTON_IMP_$INDEX

create
    {ER_TOOL_BAR_GROUP} make_with_command_list

feature {NONE} -- Initialization

	make_with_command_list (a_list: ARRAY [NATURAL_32])
			-- Creation method
		require
			not_void: a_list /= void
		do
			command_list := a_list

			create_interface_objects
			register_observer
		ensure
			set: command_list = a_list
		end

	create_interface_objects
			-- Create objects
		do
			create select_actions
		end

feature {RIBBON}

	command_list: ARRAY [NATURAL_32]
			-- Command ids handled by current

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- <Precursor>
		do
			if command_list.has (a_command_id) then
				print ("%NRIBBON_BUTTON_$INDEX")
			end
		end

	update_property (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- <Precursor>
		do
		end

end
