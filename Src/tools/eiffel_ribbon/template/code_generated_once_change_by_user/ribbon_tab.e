note
	description: "Summary description for {ER_TOOL_BAR_TAB}."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	RIBBON_TAB_$INDEX

inherit
	RIBBON_TAB_IMP_$INDEX

create
	{RIBBON} make_with_command_list

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
			--
		do
$GROUP_CREATION
			create groups.make (1)
$GROUP_REGISTRY
		end

feature -- Query
$GROUP_DECLARATION

	groups: ARRAYED_LIST [ER_TOOL_BAR_GROUP]
			--

feature {NONE}	--Action handling

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- <Precursor>
		do
			if command_list.has (a_command_id) then
				print ("%NRIBBON_TAB execute")
			end
		end

	update_property (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- <Precursor>
		do
			if command_list.has (a_command_id) then
				print ("%NRIBBON_TAB update_property")
			end
		end

feature {NONE}	-- Implementation

	command_list: ARRAY [NATURAL_32]
			--
end
