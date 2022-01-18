note
	description: "Composite task of verifying Eiffel using the Boogie verifier."

deferred class
	E2B_VERIFY_TASK

inherit

	ROTA_TIMED_TASK_I
		export
			{ANY} cancel
		end

	E2B_SHARED_CONTEXT

feature -- Status report

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

feature -- Access

	notification_agents: LINKED_LIST [PROCEDURE [E2B_RESULT]]
			-- List of notification agents.

feature -- Element change

	reset_global_state
			-- Reset state for one run of AutoProof.
		do
			result_handlers.wipe_out
			autoproof_errors.wipe_out
			options.routines_to_inline.wipe_out
		end

	reset_local_state
			-- Reset state for one translation.
		do
			boogie_universe_cell.put (create {IV_UNIVERSE}.make)
			helper.reset
			translation_pool.reset
		end

	add_notification_agents (a_agents: LINKED_LIST [PROCEDURE [E2B_RESULT]])
			-- Set `notification_agents' to `a_agents'.
		do
			if notification_agents = Void then
				create notification_agents.make
			end
			notification_agents.append (a_agents)
		end

feature -- Basic operations

	notifiy_with_result (a_result: E2B_RESULT)
			-- Notify agents with result `a_result'.
		do
			if notification_agents /= Void then
				across notification_agents as i loop
					i.call ([a_result])
				end
			end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2010-2014 ETH Zurich",
		"Copyright (c) 2018 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
