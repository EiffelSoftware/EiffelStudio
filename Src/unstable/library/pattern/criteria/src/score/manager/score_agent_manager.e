note
	description: "Summary description for {SCORE_AGENT_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCORE_AGENT_MANAGER

inherit
	SCORE_MANAGER

create
	make

feature {NONE} -- Initialization

	make (a_all_criteria: like agent_all_criteria)
		do
			agent_all_criteria := a_all_criteria
		end

feature -- Agent

	agent_all_criteria: FUNCTION [like all_criteria]
	agent_remember_criteria: detachable PROCEDURE [TUPLE [name: detachable READABLE_STRING_GENERAL; criteria: READABLE_STRING_GENERAL]]
	agent_forget_criteria: detachable PROCEDURE [TUPLE [name: READABLE_STRING_GENERAL]]

	set_agent_all_criteria (agt: like agent_all_criteria)
		do
			agent_all_criteria := agt
		end

	set_agent_remember_criteria (agt: like agent_remember_criteria)
		do
			agent_remember_criteria := agt
		end

	set_agent_forget_criteria(agt: like agent_forget_criteria)
		do
			agent_forget_criteria := agt
		end

feature -- Access

	all_criteria: ITERABLE [TUPLE [name: detachable READABLE_STRING_GENERAL; criteria: READABLE_STRING_GENERAL]]
		do
			Result := agent_all_criteria.item (Void)
		end

	remember_criteria (a_name: detachable READABLE_STRING_GENERAL; a_criteria: READABLE_STRING_GENERAL)
		do
			if attached agent_remember_criteria as agt then
				agt.call ([a_name, a_criteria])
			end
		end

	forget_criteria (a_name: READABLE_STRING_GENERAL)
		do
			if attached agent_forget_criteria as agt then
				agt.call ([a_name])
			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
