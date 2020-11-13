note
	description: "[
		The ecosystem's default implementation for the {CODE_ANALYZER_S} interface.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ANALYZER

inherit
	CODE_ANALYZER_S [STONE, CA_RULE_VIOLATION]

	DISPOSABLE_SAFE

	SHARED_EIFFEL_PROJECT

	ES_CODE_ANALYSIS_BENCH_HELPER

	ITERABLE [CA_RULE_VIOLATION]

	ACCESS_CONTROL_HELPER

create
	make

feature {NONE} -- Creation.

	make
			-- Initialize event service.
		do
				-- Initialize events.
			create put_event
			auto_dispose (put_event)
			create start_event
			auto_dispose (start_event)
			create finish_event
			auto_dispose (finish_event)
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			item := Void
		ensure then
			no_item: not attached item
			is_stopped: is_stopped
		end

feature -- Status report

	is_stopped: BOOLEAN
			-- <Precursor>
		do
			Result := not code_analyzer.is_running
		end

feature -- Access

	item: detachable STONE
			-- <Precursor>

	violations: ITERABLE [CA_RULE_VIOLATION]
			-- <Precursor>
		do
			Result := Current
		end

feature -- Validation

	is_value_valid (x: STONE): BOOLEAN
			-- Can `x` be analysed?
		do
			Result :=
				attached {CLASSC_STONE} x or else
				attached {CLUSTER_STONE} x or else
				attached {DATA_STONE} x as s and then attached {LIST [CONF_GROUP]} s.data or else
				attached {TARGET_STONE} x as s and then s.target = eiffel_universe.target
		end

feature -- Events: Connection point

	code_analyzer_connection: EVENT_CONNECTION_I [CODE_ANALYZER_OBSERVER [STONE, CA_RULE_VIOLATION], CODE_ANALYZER_S [STONE, CA_RULE_VIOLATION]]
			-- <Precursor>
		do
			Result := internal_connection
			if not attached Result then
				create {EVENT_CONNECTION [CODE_ANALYZER_OBSERVER [STONE, CA_RULE_VIOLATION], CODE_ANALYZER_S [STONE, CA_RULE_VIOLATION]]} Result.make (
					agent (o: CODE_ANALYZER_OBSERVER [STONE, CA_RULE_VIOLATION]):
						ARRAY [TUPLE
							[event: EVENT_TYPE [CODE_ANALYZER_S [STONE, CA_RULE_VIOLATION]];
							action: PROCEDURE [CODE_ANALYZER_S [STONE, CA_RULE_VIOLATION]]]]
						do
							Result :=
								<<
									[put_event, agent o.on_put],
									[start_event, agent o.on_start],
									[finish_event, agent o.on_finish]
								>>
						end)
				automation.auto_dispose (Result)
				internal_connection := Result
			end
		end

feature -- Events

	put_event: EVENT_TYPE [TUPLE [service: CODE_ANALYZER_S [STONE, CA_RULE_VIOLATION]; value: STONE]]
			-- <Precursor>

	start_event: EVENT_TYPE [TUPLE [service: CODE_ANALYZER_S [STONE, CA_RULE_VIOLATION]]]
			-- <Precursor>

	finish_event: EVENT_TYPE [TUPLE [service: CODE_ANALYZER_S [STONE, CA_RULE_VIOLATION]]]
			-- <Precursor>

feature -- Modification

	put (value: STONE)
			-- <Precursor>
		do
				-- Set new value to analyze
			item := value
				-- Clear results of last analysis.
			code_analyzer.clear_classes_to_analyze
			code_analyzer.rule_violations.wipe_out
				-- Setup new analysis scope.
			if attached {CLASSC_STONE} value as s then
				code_analyzer.add_class (s.class_i.config_class)
			elseif attached {TARGET_STONE} value as s then
				code_analyzer.add_whole_system
			elseif attached {CLUSTER_STONE} value as s then
				if s.is_cluster then
					code_analyzer.add_cluster (s.cluster_i)
				else
					code_analyzer.add_group (s.group)
				end
			elseif attached {DATA_STONE} value as s then
				if attached {LIST [CONF_GROUP]} s.data as g then
					from
						g.start
					until
						g.after
					loop
						if attached {CLUSTER_I} g.item_for_iteration as c then
							code_analyzer.add_cluster (c)
						end
						g.forth
					end
				end
			end
				-- Fire events.
			on_put (value)
		end

feature -- Basic operations

	start
			-- <Precursor>
		do
			process_under_control ("run", agent
					do
							-- Register start and termination event handlers.
						code_analyzer.add_start_action (agent on_start)
						code_analyzer.add_completed_action (agent on_finish)
							-- Perform analysis.
						code_analyzer.analyze
					end
				)
		end

feature {NONE} -- Events

	on_put (s: STONE)
			-- Called when a stone `s` is set for analysis..
			--
			-- `s`: The stone to analyze.
		require
			is_interface_usable: is_interface_usable
			stone_attached: attached s
			is_stone_valid: is_value_valid (s)
		do
			if put_event.is_interface_usable then
				put_event.publish (Current, s)
			end
		end

	on_start
			-- Called after code analysis starts.
		require
			is_interface_usable: is_interface_usable
		do
			if start_event.is_interface_usable then
				start_event.publish (Current)
			end
		end

	on_finish (exceptions: ITERABLE [TUPLE [detachable EXCEPTION, CLASS_C]])
			-- Called after code analysis finishes.
		require
			is_interface_usable: is_interface_usable
		do
			if finish_event.is_interface_usable then
				finish_event.publish (Current, exceptions)
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_connection: detachable like code_analyzer_connection
			-- Cached version of `code_analyzer_connection`.
			-- Note: Do not use directly!

feature {ITERABLE} -- Iteration

	new_cursor: ITERATION_CURSOR [CA_RULE_VIOLATION]
		do
			create {CODE_ANALYZER_VIOLATION_CURSOR} Result.make (code_analyzer.rule_violations)
		end

;note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
