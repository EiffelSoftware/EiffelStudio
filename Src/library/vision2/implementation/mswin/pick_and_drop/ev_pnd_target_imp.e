indexing
	description: "Ms-windows implementation of a pick and drop target."
	status: "See notice at end of class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PND_TARGET_IMP

inherit
	EV_PND_TARGET_I

feature -- Access

	add_pnd_command (type: EV_PND_TYPE; cmd: EV_COMMAND; args: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed when
			-- a data of type `type' is dropped into current target.
		local
			transporter: EV_PND_TRANSPORTER_IMP
			list_com: LINKED_LIST [EV_COMMAND]
			list_arg: LINKED_LIST [EV_ARGUMENT]
		do
			!! transporter
			if not transporter.targets.has (Current) then
				transporter.register (Current)
			end
			if pnd_commands_list = Void then
				!! pnd_commands_list.make (1)
				!! pnd_arguments_list.make (1)
			end
			if pnd_arguments_list.item (type) = Void then
				!! list_com.make
				!! list_arg.make
				pnd_commands_list.force (list_com, type)
				pnd_arguments_list.force (list_arg, type)
			end
			(pnd_commands_list.item (type)).extend (cmd)
			(pnd_arguments_list.item (type)).extend (args)
		end


	add_default_pnd_command (cmd: EV_COMMAND; args: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands,
			-- as the first element of the hashtable,
			-- to be executed when any data is dropped into current target.
		local
			transporter: EV_PND_TRANSPORTER_IMP
			zero_type: EV_PND_TYPE
			list_com: LINKED_LIST [EV_COMMAND]
			list_arg: LINKED_LIST [EV_ARGUMENT]
		do
			!! transporter
			if not transporter.targets.has (Current) then
				transporter.register (Current)
			end
			if pnd_commands_list = Void then
				!! pnd_commands_list.make (1)
				!! pnd_arguments_list.make (1)
			end
			!! zero_type.make_with_id (0)
			if pnd_arguments_list.item (zero_type) = Void then
				!! list_com.make
				!! list_arg.make
				pnd_commands_list.force (list_com, zero_type)
				pnd_arguments_list.force (list_arg, zero_type)
			end
			(pnd_commands_list.item (zero_type)).extend (cmd)
			(pnd_arguments_list.item (zero_type)).extend (args)
		end

feature {NONE} -- Access

	pnd_commands_list: HASH_TABLE [LINKED_LIST [EV_COMMAND], EV_PND_TYPE]
			-- The list of the commands associated with the target.

	pnd_arguments_list: HASH_TABLE [LINKED_LIST [EV_ARGUMENT], EV_PND_TYPE]
			-- The list of the arguments associated with these commands.

feature {EV_PND_TRANSPORTER_IMP} -- Access

	receive (data_type: EV_PND_TYPE; data: EV_PND_DATA; button_data: EV_BUTTON_EVENT_DATA) is
		local
			pnd_event_data: EV_PND_EVENT_DATA
			zero_type: EV_PND_TYPE
			list_com: LINKED_LIST [EV_COMMAND]
			list_arg: LINKED_LIST [EV_ARGUMENT]
		do
			if pnd_commands_list /= Void then
				pnd_event_data := get_pnd_data (data_type, data, button_data)
				!! zero_type.make_with_id (0)
				if pnd_commands_list.item (zero_type) /= Void then
					list_com := pnd_commands_list.item (zero_type)
					list_arg := pnd_arguments_list.item (zero_type)
				elseif pnd_commands_list.item (data_type) /= Void then
					list_com := pnd_commands_list.item (data_type)
					list_arg := pnd_arguments_list.item (data_type)
				end
				if list_com /= Void then
					from
						list_com.start
						list_arg.start
					until
						list_com.after
					loop
						list_com.item.execute (list_arg.item, pnd_event_data)
						list_com.forth
						list_arg.forth
					end
				end
			end
		end

	get_pnd_data (data_type: EV_PND_TYPE; data: EV_PND_DATA; button_data: EV_BUTTON_EVENT_DATA): EV_PND_EVENT_DATA is
		do
			!! Result.make
			Result.implementation.set_data_type (data_type)
			Result.implementation.set_data (data)
			Result.implementation.set_x (button_data.x)
			Result.implementation.set_y (button_data.y)
			Result.implementation.set_state (button_data.state)
			Result.implementation.set_button (button_data.button)
		end

end -- class EV_PND_TARGET_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

