class
	E2B_TOOL_INSTANCE

inherit

	EBB_TOOL_INSTANCE

	EBB_SHARED_BLACKBOARD

create
	make

feature -- Status report

	is_running: BOOLEAN
			-- Is instance running?
		do
			Result := autoproof.is_running
		end

feature {EBB_TOOL_EXECUTION} -- Basic operations

	start
			-- Start instance.
		do
			create autoproof.make
			across input.individual_classes as c loop autoproof.add_class (c) end
			across input.individual_features as c loop autoproof.add_feature (c) end

			autoproof.add_notification (agent update_blackboard)
			autoproof.verify

			;(create {E2B_SHARED_CONTEXT}).status_notifier_agent_cell.put (agent set_status_message)
		end

	cancel
			-- Cancel instance.
		do
			autoproof.cancel
		end

	update_blackboard (a_result: E2B_RESULT)
		do
			blackboard.record_results
			across a_result.verification_results as c loop
				handle_verification_result (c)
			end
			blackboard.commit_results
		end

	handle_verification_result (a_verification_result: E2B_VERIFICATION_RESULT)
			-- Handle procedure result `a_procedure_result'.
		local
			l_result: E2B_BLACKBOARD_RESULT
			l_score: REAL
		do
			if attached {E2B_SUCCESSFUL_VERIFICATION} a_verification_result as l_success then
				if attached l_success.original_errors and then not l_success.original_errors.is_empty then
					l_score := {E2B_BLACKBOARD_SCORES}.successful_with_errors
				else
					l_score := {E2B_BLACKBOARD_SCORES}.successful
				end
			else
				l_score := {E2B_BLACKBOARD_SCORES}.failed
			end
			if a_verification_result.context_feature /= Void then
				create l_result.make (a_verification_result, configuration, l_score)
				blackboard.add_verification_result (l_result)
			end
		end

feature {NONE} -- Implementation

	autoproof: E2B_AUTOPROOF
			-- Verifier

;note
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
