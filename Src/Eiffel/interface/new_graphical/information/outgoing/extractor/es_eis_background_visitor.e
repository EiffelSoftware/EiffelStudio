indexing
	description: "EIS background system visitor."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_BACKGROUND_VISITOR

inherit
	CONF_ITERATOR
		redefine
			process_target,
			process_cluster,
			process_override,
			process_library,
			process_precompile
		end

	SHARED_WORKBENCH

	EV_SHARED_APPLICATION

	PROGRESS_OBSERVER_MANAGER

	ES_EIS_SHARED

create
	make

feature {NONE} -- Initialization

	make is
			-- Create.
		do
			create targets_done.make (5)
			create background_procedures.make
		end

feature -- Operation

	start
			-- Start background visiting.
		do
			make

				-- Remove the first item, possibly pending.
			if not background_procedures.is_empty then
				ev_application.remove_idle_action (background_procedures.first)
			end

				-- Setup background visiting
			if {lt_target: CONF_TARGET}universe.target then
				lt_target.process (Current)
				if background_procedures.count > 0 then
					on_progress_start (background_procedures.count)
				end
					-- Put the first procedure into idle actions
				if not background_procedures.is_empty then
					ev_application.do_once_on_idle (background_procedures.first)
				end
			end
		end

	stop
			-- Stop background visiting.
		do
			on_progress_stop
			background_procedures.wipe_out
		end

feature -- Query

	full_visited: BOOLEAN is
			-- Has the system been fully visited?
		do
			Result := background_procedures.is_empty
		end

feature -- Visit nodes

	process_target (a_target: CONF_TARGET) is
			-- Visit `a_target'.
		local
			l_conf_tuple: TUPLE [t_notable: CONF_NOTABLE; t_procedure: PROCEDURE [ANY, TUPLE]]
			l_procedure: PROCEDURE [ANY, TUPLE]
		do
			Precursor {CONF_ITERATOR} (a_target)
			create l_conf_tuple
			l_procedure := agent process_notable_only_conf (l_conf_tuple)
			l_conf_tuple.t_notable := a_target
			l_conf_tuple.t_procedure := l_procedure
			background_procedures.extend (l_procedure)
		end

	process_library (a_library: CONF_LIBRARY) is
			-- Visit `a_library'.
		do
			if a_library.library_target /= Void then
				retrieve_recursively (a_library.library_target)
			end
		end

	process_precompile (a_precompile: CONF_PRECOMPILE) is
			-- Visit `a_precompile'.
		do
			if a_precompile.library_target /= Void then
				retrieve_recursively (a_precompile.library_target)
			end
		end

	process_cluster (a_cluster: CONF_CLUSTER) is
			-- Visit `a_cluster'.
		do
			retrieve_from_group (a_cluster)
		end

	process_override (an_override: CONF_OVERRIDE) is
			-- Visit `an_override'.
		do
			retrieve_from_group (an_override)
		end

feature {NONE} -- Implementation

	targets_done: SEARCH_TABLE [UUID]
			-- Lookup for libraries we already handled.

	retrieve_recursively (a_target: CONF_TARGET) is
			-- Retrieve classes recursively from `a_target'.
		require
			a_target_not_void: a_target /= Void
		local
			l_uuid: UUID
		do
			l_uuid := a_target.system.uuid
			if not targets_done.has (l_uuid) then
				targets_done.force (l_uuid)
				a_target.process (Current)
			end
		end

	retrieve_from_group (a_group: CONF_GROUP) is
			-- Retrieve classes from `a_group'.
		require
			a_group_not_void: a_group /= Void
		local
			l_tuple: TUPLE [t_class: CONF_CLASS; t_procedure: PROCEDURE [ANY, TUPLE]]
			l_conf_tuple: TUPLE [t_notable: CONF_NOTABLE; t_procedure: PROCEDURE [ANY, TUPLE]]
			l_procedure: PROCEDURE [ANY, TUPLE]
		do
			create l_conf_tuple
			l_procedure := agent process_notable_only_conf (l_conf_tuple)
			l_conf_tuple.t_notable := a_group
			l_conf_tuple.t_procedure := l_procedure
			background_procedures.extend (l_procedure)

			if a_group.classes_set and then {lt_classes: ARRAYED_LIST [CONF_CLASS]}a_group.classes.linear_representation then
					-- Collect actions to be managed.
				from
					lt_classes.start
				until
					lt_classes.after
				loop
					if {lt_class: CONF_CLASS}lt_classes.item then
						create l_tuple
						l_procedure := agent process_class_internal (l_tuple)
						l_tuple.t_class := lt_class
						l_tuple.t_procedure := l_procedure
						background_procedures.extend (l_procedure)
					end
					lt_classes.forth
				end
			end
		end

feature {NONE} -- Implementation

	process_notable_only_conf (a_tuple: TUPLE [t_notable: CONF_NOTABLE; t_procedure: PROCEDURE [ANY, TUPLE]]) is
			-- Process configuration node of `a_target'
		require
			a_tuple_filed: a_tuple.t_notable /= Void and then a_tuple.t_procedure /= Void
		local
			l_extractor: ES_EIS_CONF_EXTRACTOR
		do
			if {lt_notable: CONF_NOTABLE}a_tuple.t_notable then
				create l_extractor.make (lt_notable)
			end
			background_procedures.prune_all (a_tuple.t_procedure)
			if is_value_valid (background_procedures.count) then
				on_progress_progress (background_procedures.count)
			end
			if not background_procedures.is_empty then
				if not ev_application.is_destroyed then
					ev_application.do_once_on_idle (background_procedures.first)
				end
			else
				if not ev_application.is_destroyed then
						-- Clean up useless entries
					ev_application.do_once_on_idle (agent storage.clean_up)
						-- Save the storage to file
					ev_application.do_once_on_idle (agent storage.save_to_file)
				end
				on_progress_finish
			end
		ensure
			background_procedures_not_has: not background_procedures.has (a_tuple.t_procedure)
		end

	process_class_internal (a_tuple: TUPLE [t_class: CONF_CLASS; t_procedure: PROCEDURE [ANY, TUPLE]]) is
			-- Process `a_tuple.t_class'.
			-- Remove `a_tuple.t_procedure' from `background_procedures' and
			-- Put next background procedure into idle actions.
		require
			a_tuple_filed: a_tuple.t_class /= Void and then a_tuple.t_procedure /= Void
		local
			l_extractor: ES_EIS_CLASS_EXTRACTOR
		do
			if {lt_class: CLASS_I}a_tuple.t_class then
				create l_extractor.make (lt_class)
			end
			background_procedures.prune_all (a_tuple.t_procedure)
			if is_value_valid (background_procedures.count) then
				on_progress_progress (background_procedures.count)
			end
			if not background_procedures.is_empty then
				if not ev_application.is_destroyed then
					ev_application.do_once_on_idle (background_procedures.first)
				end
			else
				if not ev_application.is_destroyed then
						-- Clean up useless entries
					ev_application.do_once_on_idle (agent storage.clean_up)
						-- Save the storage to file
					ev_application.do_once_on_idle (agent storage.save_to_file)
				end
				on_progress_finish
			end
		ensure
			background_procedures_not_has: not background_procedures.has (a_tuple.t_procedure)
		end

	background_procedures: !LINKED_LIST [PROCEDURE [ANY, TUPLE]];
			-- All managed background procedures.

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
