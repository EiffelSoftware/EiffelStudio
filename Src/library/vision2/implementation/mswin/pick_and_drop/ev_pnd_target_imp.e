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
			list: LINKED_LIST [EV_INTERNAL_COMMAND]
			transporter: EV_PND_TRANSPORTER_IMP
			com: EV_INTERNAL_COMMAND
		do
			create transporter
			if not transporter.targets.has (Current) then
				transporter.register (Current)
			end
			if pnd_commands_list = Void then
				create pnd_commands_list.make (1)
			end
			if pnd_commands_list.item (type) = Void then
				create list.make
				pnd_commands_list.force (list, type)
			end
			create com.make (cmd, args)
			(pnd_commands_list.item (type)).extend (com)
		end

	add_default_pnd_command (cmd: EV_COMMAND; args: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands,
			-- as the first element of the hashtable,
			-- to be executed when any data is dropped into current target.
		local
			list: LINKED_LIST [EV_INTERNAL_COMMAND]
			transporter: EV_PND_TRANSPORTER_IMP
			com: EV_INTERNAL_COMMAND
			zero_type: EV_PND_TYPE
		do
			create transporter
			if not transporter.targets.has (Current) then
				transporter.register (Current)
			end
			if pnd_commands_list = Void then
				create pnd_commands_list.make (1)
			end
			create zero_type.make_with_id (0)
			if pnd_commands_list.item (zero_type) = Void then
				create list.make
				pnd_commands_list.force (list, zero_type)
			end
			create com.make (cmd, args)
		end

feature {NONE} -- Access

	pnd_commands_list: HASH_TABLE [LINKED_LIST [EV_INTERNAL_COMMAND], EV_PND_TYPE]
			-- The list of the commands associated with the
			-- target and their arguments.

feature {EV_PND_TRANSPORTER_IMP} -- Access

	receive (data_type: EV_PND_TYPE; data: ANY; button_data: EV_BUTTON_EVENT_DATA) is
		local
			list: LINKED_LIST [EV_INTERNAL_COMMAND]
			pnd_event_data: EV_PND_EVENT_DATA
			zero_type: EV_PND_TYPE
		do
			if pnd_commands_list /= Void then
				pnd_event_data := get_pnd_data (data_type, data, button_data)
				create zero_type.make_with_id (0)
				if pnd_commands_list.item (zero_type) /= Void then
					list := pnd_commands_list.item (zero_type)
				elseif pnd_commands_list.item (data_type) /= Void then
					list := pnd_commands_list.item (data_type)
				end
				if list /= Void then
					from
						list.start
					until
						list.after
					loop
						list.item.execute (pnd_event_data)
						list.forth
					end
				end
			end
		end

	get_pnd_data (data_type: EV_PND_TYPE; data: ANY; button_data: EV_BUTTON_EVENT_DATA): EV_PND_EVENT_DATA is
		do
			create Result.make
			Result.implementation.set_data_type (data_type)
			Result.implementation.set_data (data)
			Result.implementation.set_all (button_data.widget, button_data.x,
				button_data.y, button_data.button, button_data.shift_key_pressed,
				button_data.control_key_pressed, button_data.first_button_pressed,
				button_data.second_button_pressed, button_data.third_button_pressed)
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

