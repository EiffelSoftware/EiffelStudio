note
	description: "Window used to receive NotifyIcon notification."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NOTIFY_WINDOW

inherit
	WEL_FRAME_WINDOW
		rename
			set_icon as set_window_icon
		redefine
			process_message
		end

create
	make

feature {NONE} -- Initialize

	make
			-- Initialize current.
		do
				-- Create message
			notify_uid := notify_uid_counter.item + 1
			notify_uid_counter.put (notify_uid)
			create notify_message_name.make ({STRING} "Notify_msg_" + notify_uid_counter.item.out)

				-- Create window
			create notify_icon_data.make
			make_top (Void)
			notify_message_id := {WEL_API}.register_window_message (notify_message_name.item)

			notify_icon_data.set_window (Current)
			notify_icon_data.set_uflags ({WEL_NIF_CONSTANTS}.nif_message)
			notify_icon_data.set_callback_message (notify_message_id)
		end

feature -- Access

	notify_icon_data: WEL_NOTIFY_ICON_DATA
			-- Structure used for notification.

	notify_message_name: WEL_STRING
			-- Name associated with `notify_message_id'.

	notify_message_id: INTEGER
			-- Message identifier used for notifying Current when mouse events occurs on the taskbar icon.

	notify_uid: INTEGER
			-- Identifier for notify icon.

	notify_icon_actions: ACTION_SEQUENCE [TUPLE [INTEGER]]
			-- Actions being called when context menu is requested.
		local
			l_actions: like internal_notify_icon_actions
		do
			l_actions := internal_notify_icon_actions
			if l_actions = Void then
				create l_actions
				internal_notify_icon_actions := l_actions
			end
			Result := l_actions
		end

feature -- Setting

	set_icon (a_icon: detachable WEL_ICON)
			-- Set `a_icon' to `notify_icon_data'.
		require
			a_icon_exists: a_icon /= Void implies a_icon.exists
		do
			if a_icon = Void then
				notify_icon_data.set_uflags (notify_icon_data.uflags &
					{WEL_NIF_CONSTANTS}.nif_icon.bit_not)
			else
				notify_icon_data.set_uflags (notify_icon_data.uflags | {WEL_NIF_CONSTANTS}.nif_icon)
			end
			notify_icon_data.set_icon (a_icon)
		ensure
			icon_set: notify_icon_data.icon = a_icon
		end

	set_tooltip (a_tooltip: READABLE_STRING_GENERAL)
			-- Set `a_tooltip' to `notify_icon_data'.
		require
			a_tooltip_not_void: a_tooltip /= Void
		do
			if a_tooltip = Void or else a_tooltip.is_empty then
				notify_icon_data.set_uflags (notify_icon_data.uflags & {WEL_NIF_CONSTANTS}.nif_tip.bit_not)
				notify_icon_data.set_tooltip_text (Void)
			else
				notify_icon_data.set_uflags ( notify_icon_data.uflags | {WEL_NIF_CONSTANTS}.nif_tip)
				notify_icon_data.set_tooltip_text (a_tooltip)
			end
		ensure
			tooltip_set: notify_icon_data.tooltip_text.string.same_string_general (a_tooltip)
		end

	add_notify_icon
			-- Add notify icon to taskbar.
		do
			notify_icon ({WEL_NIM_CONSTANTS}.nim_add, notify_icon_data)
		end

	update_notify_icon
			-- Update notify icon with recent changes made to `notify_icon_data'.
		do
			notify_icon ({WEL_NIM_CONSTANTS}.nim_modify, notify_icon_data)
		end

	remove_notify_icon
			-- Remove notify icon to taskbar.
		do
			notify_icon ({WEL_NIM_CONSTANTS}.nim_delete, notify_icon_data)
		end

feature {NONE} -- Messaging

	process_message (hwnd: POINTER; msg: INTEGER; wparam: POINTER; lparam: POINTER): POINTER
			-- Process message of Current window.
		local
			l_action: like internal_notify_icon_actions
		do
			if msg = notify_message_id then
				l_action := internal_notify_icon_actions
				if l_action /= Void then
					l_action.call ([lparam.to_integer_32])
				end
			else
				Result := Precursor {WEL_FRAME_WINDOW} (hwnd, msg, wparam, lparam)
			end
		end

	internal_notify_icon_actions: detachable ACTION_SEQUENCE [TUPLE [INTEGER]]
			-- Actions being called when context menu is requested.

	notify_uid_counter: CELL [INTEGER]
			-- Counter for generating identifier.
		once
			create Result.put (1)
		ensure
			notify_uid_counter_not_void: Result /= Void
		end

	notify_icon (a_message: INTEGER; a_notify_icon_data: WEL_NOTIFY_ICON_DATA)
			-- Sends a message to the taskbar's status area.
		require
			a_notify_icon_data_not_void: a_notify_icon_data /= Void
			a_notify_icon_data_exists: a_notify_icon_data.exists
		do
			{WEL_API}.shell_notify_icon (a_message, a_notify_icon_data.item).do_nothing
		end

invariant
	notify_icon_data_not_void: notify_icon_data /= Void
	notify_message_name_not_void: notify_message_name /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
