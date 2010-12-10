note
	description: "Summary description for {ER_TOOL_BAR_BUTTON}."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	ER_TOOL_BAR_BUTTON

inherit
	ER_TOOL_BAR_BUTTON_IMP

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
			--
		do
			create select_actions
			create other_actions
		end

feature -- Access

	-- select_actions is a default command defined in parent.
	other_actions: EV_NOTIFY_ACTION_SEQUENCE

feature {RIBBON_TOOL_BAR}

	command_list: ARRAY [NATURAL_32]
			--

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- <Precursor>
		local
		     l_command_position: INTEGER
		do
			if command_list.has (a_command_id) then
--			     l_command_position := command_list.i_th (a_command_id)
				inspect
					a_command_id
				when {EIFFEL_C_CONSTANTS}.Cmdbutton1 then
					print ("%NER_TOOL_BAR_BUTTON Cmdbutton1")
				else

				end
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
		end

end
