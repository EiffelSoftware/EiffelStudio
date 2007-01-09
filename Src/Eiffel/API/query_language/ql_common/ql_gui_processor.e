indexing
	description: "Processor to make sure that GUI is active when Eiffel query language is evaluating"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_GUI_PROCESSOR

inherit
	EV_SHARED_APPLICATION

	SHARED_FLAGS

feature -- Setting

	set_process_gui_agent (a_agent: like process_gui_agent) is
			-- Set `process_gui_agent' with `a_agent'.
		require
			a_agent_attached: a_agent /= Void
			not_is_process_gui_enabled: not is_process_gui_enabled
		do
			process_gui_agent := a_agent
		ensure
			process_gui_agent_set: process_gui_agent = a_agent
		end

	set_evaluation_context (a_context: like evaluation_context) is
			-- Set `evaluation_context' with `a_context'.
		require
			not_is_process_gui_enabled: not is_process_gui_enabled
		do
			evaluation_context_internal := a_context
		ensure
			evaluation_context_set: evaluation_context = a_context
		end

	set_terminate_evaluation_agent (a_agent: like terminate_evaluation_agent) is
			-- Set `terminate_evaluation_agent' with `a_agent'.
		do
			terminate_evaluation_agent_internal := a_agent
		ensure
			terminate_evaluation_agent_set: terminate_evaluation_agent = a_agent
		end

feature -- Access

	process_gui_agent: PROCEDURE [ANY, TUPLE]
			-- Agent to keep GUI alive

	evaluation_context: QL_DOMAIN_GENERATOR is
			-- Evaluation context
		do
			if evaluation_context_internal = Void then
				Result := default_evaluation_context
			else
				Result := evaluation_context_internal
			end
		ensure
			result_attached: Result /= Void
		end

	terminate_evaluation_agent: PROCEDURE [ANY, TUPLE] is
			-- Agent to terminate current domain evaluation
		do
			if terminate_evaluation_agent_internal = Void then
				terminate_evaluation_agent_internal := agent terminate_domain_evaluation
			end
			Result := terminate_evaluation_agent_internal
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_process_gui_enabled: BOOLEAN
			-- Is GUI processing enabled?

feature -- Basic operations

	enable_process_gui is
			-- Enable process GUI.
		do
			original_interval := evaluation_context.interval
			evaluation_context.set_interval (tick_action_interval)
			evaluation_context.tick_actions.extend (process_gui_with_item_agent)
			is_process_gui_enabled := True
		ensure
			is_process_gui_enabled: is_process_gui_enabled
		end

	disable_process_gui is
			-- Disable process GUI.
		do
			evaluation_context.tick_actions.prune_all (process_gui_with_item_agent)
			evaluation_context.set_interval (original_interval)
			is_process_gui_enabled := False
		ensure
			not_is_process_gui_enabled: not is_process_gui_enabled
		end

feature{NONE} -- Implementation

	original_interval: NATURAL_64
			-- Original tick action interval

	tick_action_interval: NATURAL_64 is 20
			-- Internal which will be used to keep GUI alive

	default_evaluation_context: QL_TARGET_DOMAIN_GENERATOR is
			-- Domain generator
		do
			if default_evaluation_context_internal = Void then
				create default_evaluation_context_internal
			end
			Result := default_evaluation_context_internal
		ensure
			result_attached: Result /= Void
		end

	default_evaluation_context_internal: like default_evaluation_context
			-- Implementation of `default_evaluation_context'

	process_gui_with_item_agent: PROCEDURE [ANY, TUPLE [QL_ITEM]] is
			-- Agent to process gui
		do
			if process_gui_with_item_agent_internal = Void then
				process_gui_with_item_agent_internal := agent process_gui
			end
			Result := process_gui_with_item_agent_internal
		ensure
			result_attached: Result /= Void
		end

	process_gui_with_item_agent_internal: like process_gui_with_item_agent
			-- Implementation of `process_gui_with_item_agent'

	process_gui (a_item: QL_ITEM) is
			-- Process GUI.
		local
			l_process_gui_agent: like process_gui_agent
		do
			if is_exit_requested then
				terminate_evaluation_agent.call ([])
			else
				l_process_gui_agent := process_gui_agent
				if l_process_gui_agent /= Void then
					l_process_gui_agent.call ([])
				end
			end
		end

	evaluation_context_internal: like evaluation_context
			-- Implementation of `evaluation_context'

	terminate_evaluation_agent_internal: like terminate_evaluation_agent
			-- Implementation of `terminate_evaluation_agent'

	terminate_domain_evaluation is
			-- Terminate current domain evaluation.
		do
			evaluation_context.error_handler.insert_interrupt_error ("")
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
