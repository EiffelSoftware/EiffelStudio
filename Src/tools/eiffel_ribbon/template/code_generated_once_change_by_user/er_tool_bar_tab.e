note
	description: "Summary description for {ER_TOOL_BAR_TAB}."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	ER_TOOL_BAR_TAB

inherit
	ER_TOOL_BAR_TAB_IMP

create
    {ER_TOOL_BAR} make_with_command_list

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
			create group.make_with_command_list (<<{ER_C_CONSTANTS}.Cmdgroup1.as_natural_32>>)

			create all_groups.make (1)
			all_groups.extend (group)
		end

feature -- Query

	group: ER_TOOL_BAR_GROUP
			--

	all_groups: ARRAYED_LIST [ER_TOOL_BAR_GROUP]
			--

feature {NONE}	--Action handling

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- <Precursor>
		local
		     l_command_position: INTEGER
		do
			if command_list.has (a_command_id) then
				print ("%NER_TOOL_BAR_TAB execute")
--			     l_command_position := command_list.i_th (a_command_id)
--			     when 1 then
--			              -- 1st always default command
--			          select_actions.call (Void)
--			     when 2 then
--			          other_actions.call (Void)
--			     else
--			         do_nothing
--			     end				
			end
		end

	update_property (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- <Precursor>
		do
			if command_list.has (a_command_id) then
				print ("%NER_TOOL_BAR_TAB update_property")
			end
		end

feature {NONE}	-- Implementation

	command_list: ARRAY [NATURAL_32]
			--
end
