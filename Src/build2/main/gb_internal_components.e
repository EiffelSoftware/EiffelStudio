indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_INTERNAL_COMPONENTS

inherit
	ANY
		redefine
			default_create
		end

	GB_CONSTANTS
		redefine
			default_create
		end

	GB_INTERFACE_CONSTANTS
		redefine
			default_create
		end

	GB_EIFFEL_ENV
		redefine
			default_create
		end

feature -- Access

	default_create is
			-- Create `Current'.
		do
			create digit_checker.make_with_components (Current)
			create events.make_with_components (Current)
			create status_bar.make_with_components (Current)
			create constants.make_with_components (Current)
			create system_status.make_with_components (Current)
			create history.make_with_components (Current)
			create clipboard.make_with_components (Current)
			create commands.make_with_components (Current)
			create tools.make_with_components (Current)
			create object_editors.make_with_components (Current)
			create xml_handler.make_with_components (Current)
			create object_handler.make_with_components (Current)
			create id_handler.make_with_components (Current)

				-- Now initialize the application wide action sequences
			application.pnd_motion_actions.extend (agent pick_and_drop_motion)
			application.pick_actions.extend (agent pick_and_drop_started)
			application.cancel_actions.extend (agent pick_and_drop_cancelled)
			application.drop_actions.extend (agent pick_and_drop_completed)
		end

	commands: GB_COMMAND_HANDLER

	tools: GB_TOOLS

	history: GB_GLOBAL_HISTORY

	object_editors: GB_OBJECT_EDITORS

	xml_handler: GB_XML_HANDLER

	system_status: GB_SYSTEM_STATUS

	clipboard: GB_CLIPBOARD

	object_handler: GB_OBJECT_HANDLER

	constants: GB_CONSTANTS_HANDLER

	id_handler: GB_ID

	events: GB_EVENTS

	status_bar: GB_STATUS_BAR

	digit_checker: GB_DIGIT_CHECKER

feature {NONE} -- Implementation

	pick_and_drop_motion (an_x, a_y: INTEGER; target: EV_ABSTRACT_PICK_AND_DROPABLE) is
			-- Respond to a global pick and drop motion.
		do
			status_bar.clear_status_during_transport (an_x, a_y, target)
		end

	pick_and_drop_started (pebble: ANY) is
			-- Respond to a pick and drop starting.
		require
			pebble_not_void: pebble /= Void
		do
			system_status.set_pick_and_drop_pebble (pebble)
			commands.update
		end

	pick_and_drop_cancelled (pebble: ANY) is
			-- Respond to the cancelling of a pick and drop.
		require
			pebble_not_void: pebble /= Void
		do
			digit_checker.end_processing
			system_status.remove_pick_and_drop_pebble
			status_bar.clear_status_after_transport (pebble)
			commands.update
		end

	pick_and_drop_completed (pebble: ANY) is
			-- Respond to the successful completion of a pick and drop.
		require
			pebble_not_void: pebble /= Void
		do
			digit_checker.end_processing
			system_status.remove_pick_and_drop_pebble
			commands.update
		end

invariant
	invariant_clause: True -- Your invariant here

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
