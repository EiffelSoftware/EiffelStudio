indexing
	description: "Implementation interface of a pick and drop target."
	status: "See notice at end of class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PND_TARGET_I

inherit
	EV_ANY_I

	EV_CUSTOM_EVENT_HANDLER [EV_PND_TYPE]
		rename
			has_command as has_pnd_command,
			add_command as add_pnd_command,
			remove_all_commands as remove_pnd_commands,
			execute_command as execute_pnd_command
		redefine
			add_pnd_command,
			remove_pnd_commands
		end

feature -- Access

	add_pnd_command (type: EV_PND_TYPE; cmd: EV_COMMAND; args: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands to be executed when
			-- a data of type `type' is dropped into current target.
		require else
			exists: not destroyed
			valid_type: type /= Void
			valid_command: cmd /= Void
		local
			transporter: EV_PND_TRANSPORTER_IMP
		do
			create transporter
			if not transporter.targets.has (Current) then
				transporter.register (Current)
			end
			Precursor (type, cmd, args)
		end

	remove_pnd_commands (type: EV_PND_TYPE) is
			-- Remove the list of commands to be executed when
			-- a data of type `type' is dropped into current target.
		require else
			exists: not destroyed
			valid_type: type /= Void
		local
			transporter: EV_PND_TRANSPORTER_IMP
		do
			create transporter
			if transporter.targets.has (Current) then
				transporter.unregister (Current)
			end
			Precursor (type)
		end

	add_default_pnd_command (cmd: EV_COMMAND; args: EV_ARGUMENT) is
			-- Add 'cmd' to the list of commands,
			-- as the first element of the hashtable,
			-- to be executed when any data is dropped into current target.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		local
			zero_type: EV_PND_TYPE
		do
			create zero_type.make_with_id (0)
			add_pnd_command (zero_type, cmd, args)
		end

	remove_default_pnd_commands (type: EV_PND_TYPE) is
			-- Remove the list of commands to be executed when
			-- a data of type `type' is dropped into current target.
		require else
			exists: not destroyed
			valid_type: type /= Void
		local
			zero_type: EV_PND_TYPE
		do
			create zero_type.make_with_id (0)
			remove_pnd_commands (zero_type)
		end

feature {EV_PND_TRANSPORTER_I} -- Access

	accept (data_type: EV_PND_TYPE): BOOLEAN is
			-- Is Current accept this data type ?
		local
			zero_type: EV_PND_TYPE
		do
			if event_table /= Void then
				create zero_type.make_with_id (0)
				Result := has_pnd_command (zero_type)
				if not Result then
					Result := has_pnd_command (data_type)
				end
			else
				Result := False
			end
		end

	receive (data_type: EV_PND_TYPE; data: ANY; button_data: EV_BUTTON_EVENT_DATA) is
		local
			list: DYNAMIC_LIST [EV_INTERNAL_COMMAND]
			pnd_event_data: EV_PND_EVENT_DATA
			zero_type: EV_PND_TYPE
		do
			if event_table /= Void then
				pnd_event_data := get_pnd_data (data_type, data, button_data)
				create zero_type.make_with_id (0)
				if has_pnd_command (zero_type) then
					list := event_table.item (zero_type)
				elseif has_pnd_command (data_type) then
					list := event_table.item (data_type)
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
			-- Return Pick and drop event data from the given `button_data'.
		local
			targ: EV_PND_TARGET
		do

			targ ?= current.interface
			check
				target_exists: targ /= Void
			end

			create Result.make
			Result.implementation.set_data_type (data_type)
			Result.implementation.set_data (data)
			Result.implementation.set_target (targ)

			Result.implementation.set_all (button_data.widget, button_data.x,
				button_data.y, button_data.button, button_data.shift_key_pressed,
				button_data.control_key_pressed, button_data.first_button_pressed,
				button_data.second_button_pressed, button_data.third_button_pressed)
			Result.implementation.set_button (button_data.button)
			Result.implementation.set_absolute_x (button_data.absolute_x)
			Result.implementation.set_absolute_y (button_data.absolute_y)
		end

end -- class EV_PND_TARGET_I

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

