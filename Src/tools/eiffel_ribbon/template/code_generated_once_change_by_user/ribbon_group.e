note
	description: "Summary description for RIBBON_GROUP."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	RIBBON_GROUP_$INDEX

inherit
	RIBBON_GROUP_IMP_$INDEX

create
    {ER_TOOL_BAR_TAB} make_with_command_list

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
$BUTTON_CREATION
			create buttons.make (1)
$BUTTON_REGISTRY
		end

feature -- Query

$BUTTON_DECLARATION

	buttons: ARRAYED_LIST [ER_TOOL_BAR_BUTTON]
			-- All buttons in current group

feature {NONE}	--Action handling

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- <Precursor>
		do
			if command_list.has (a_command_id) then
				print ("%NER_TOOL_BAR_GROUP execute")
			end

		end

	update_property (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- <Precursor>
		do
			if command_list.has (a_command_id) then
				print ("%NER_TOOL_BAR_GROUP update_property")
			end
		end

feature {NONE} -- Implementation

	command_list: ARRAY [NATURAL_32]
			-- Command ids handled by current
end
