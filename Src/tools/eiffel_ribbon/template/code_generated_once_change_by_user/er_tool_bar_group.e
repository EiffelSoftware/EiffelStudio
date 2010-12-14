note
	description: "Summary description for {ER_TOOL_BAR_GROUP}."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	ER_TOOL_BAR_GROUP_$INDEX

inherit
	ER_TOOL_BAR_GROUP_IMP_$INDEX

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
			--
		do
--		    Precursor
		    create button_1.make_with_command_list (<<{ER_C_CONSTANTS}.Cmdbutton1.as_natural_32>>) -- Just handles the default command
--		    create button2.make_with_command_list (<<3232, 4321>> Handles its default command plus another user chosen command

			create buttons.make (1)
			buttons.extend (button_1)
		end

feature -- Query

	button_1: ER_TOOL_BAR_BUTTON
			--

	buttons: ARRAYED_LIST [ER_TOOL_BAR_BUTTON]
			--

feature {NONE}	--Action handling

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- <Precursor>
		local
		     l_command_position: INTEGER
		do
			if command_list.has (a_command_id) then
				print ("%NER_TOOL_BAR_GROUP execute")
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
				print ("%NER_TOOL_BAR_GROUP update_property")
			end
		end

feature {NONE} -- Implementation

	command_list: ARRAY [NATURAL_32]
			--
end
