indexing
	description: "Manager to handle customized formatters"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CUSTOMIZED_FORMATTER_MANAGER

inherit
	EB_SHARED_METRIC_MANAGER

	SHARED_WORKBENCH

	PROJECT_CONTEXT

	SHARED_EIFFEL_PROJECT

	EC_EIFFEL_LAYOUT

	EB_CUSTOMIZED_FORMATTER_UTILITY

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize Current.
		do
			on_project_loaded_agent := agent on_project_loaded
			eiffel_project.manager.load_agents.extend (on_project_loaded_agent)

		end

feature -- Access

	formatter_change_actions: ACTION_SEQUENCE [TUPLE] is
			-- Actions to be performed when customized formatters are (possibly) changed
			-- This maybe because modification through customized formatter setup procedure or
			-- through metric definition change.
		do
			if formatter_change_actions_internal = Void then
				create formatter_change_actions_internal
			end
			Result := formatter_change_actions_internal
		ensure
			result_attached: Result /= Void
		end

	formatters (a_tool_name: STRING; a_manager: EB_STONABLE): LIST [EB_CUSTOMIZED_FORMATTER] is
			-- Loaded customized formatters whose default tool is `a_tool_name'
			-- Always create new formatter instances from `formatter_descriptors'.
		local
			l_formatters: LINKED_LIST [EB_CUSTOMIZED_FORMATTER]
			l_fmt_desp: EB_CUSTOMIZED_FORMATTER_DESP
			l_desp: like formatter_descriptors
			l_cursor: CURSOR
		do
			l_desp := formatter_descriptors
			l_cursor := l_desp.cursor
			create l_formatters.make
			from
				l_desp.start
			until
				l_desp.after
			loop
				l_fmt_desp := l_desp.item
				if l_fmt_desp.has_tool (a_tool_name) then
					l_formatters.extend (l_fmt_desp.new_formatter (a_tool_name, a_manager))
				end
				l_desp.forth
			end
			l_desp.go_to (l_cursor)
			Result := l_formatters
		ensure
			result_attached: Result /= Void
		end

	last_error: EB_METRIC_ERROR
			-- Last recorded error

	formatter_descriptors: LIST [EB_CUSTOMIZED_FORMATTER_DESP] is
			-- List of formatter descriptors loaded by `descriptors_from_file'
		do
			if formatter_descriptors_internal = Void then
				create {LINKED_LIST [EB_CUSTOMIZED_FORMATTER_DESP]} formatter_descriptors_internal.make
			end
			Result := formatter_descriptors_internal
		end

	global_formatter_descriptors: LIST [EB_CUSTOMIZED_FORMATTER_DESP] is
			-- Global formatter descriptors
		do
			Result := satisfied_descriptors (formatter_descriptors, agent is_formatter_global_scope)
		ensure
			result_attached: Result /= Void
		end

	target_formatter_descriptors: LIST [EB_CUSTOMIZED_FORMATTER_DESP] is
			-- Target formatter descriptors
		do
			Result := satisfied_descriptors (formatter_descriptors, agent is_formatter_target_scope)
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_loaded: BOOLEAN
			-- has customized formatter information been loaded?

	is_file_readable: BOOLEAN
			-- Is file readable when the last time `parse_file' is called?

	is_changed: BOOLEAN
			-- Is definition of any customized formatters changed?
			-- If True, we should store formatter definitions back to files.

	has_error: BOOLEAN is
			-- Did any error occur?
		do
			Result := last_error /= Void
		end

	has_formatters: BOOLEAN is
			-- Is there any customized formatter loaded?
		do
			Result := not formatter_descriptors.is_empty
		end

	has_target_descriptors (a_descriptors: LIST [EB_CUSTOMIZED_FORMATTER_DESP]): BOOLEAN is
			-- Does `a_descriptors' contain target descriptors?
		require
			a_descriptors_attached: a_descriptors /= Void
			a_descriptors_valid: not a_descriptors.has (Void)
		do
			Result := a_descriptors.there_exists (agent is_formatter_target_scope)
		end

	has_global_descriptors (a_descriptors: LIST [EB_CUSTOMIZED_FORMATTER_DESP]): BOOLEAN is
			-- Does `a_descriptors' contain global descriptors?
		require
			a_descriptors_attached: a_descriptors /= Void
			a_descriptors_valid: not a_descriptors.has (Void)
		do
			Result := a_descriptors.there_exists (agent is_formatter_global_scope)
		end

feature -- Setting

	load (a_error_agent: PROCEDURE [ANY, TUPLE]) is
			-- Load global and target scope formatters.
			-- `a_error_agent' is the agent invoked when error occurs during loading.
		do
			formatter_descriptors.wipe_out

			load_formatters (global_formatter_file, True, a_error_agent)
			load_formatters (target_formatter_file, False, a_error_agent)

			set_is_loaded (True)
			set_is_changed (False)
			formatter_change_actions.call (Void)
		ensure
			loaded: is_loaded
			not_changed: not is_changed
		end

	store is
			-- Store formatters in xml files.
		do
			store_descriptors (formatter_descriptors)
		end

	create_formatter_file_dir (a_path: FILE_NAME) is
			-- Create dir `a_path' if not exists.
		require
			a_path_attached: a_path /= Void
		local
			l_dir: DIRECTORY
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_dir.make (a_path)
				if not l_dir.exists then
					l_dir.create_dir
				end
			end
		rescue
			l_retried := True
			retry
		end

	store_descriptors (a_descriptors: LIST [EB_CUSTOMIZED_FORMATTER_DESP]) is
			-- Store `a_descriptors' in global or target scope xml files.
		require
			a_descriptors_attached: a_descriptors /= Void
			a_descriptors_valid: not a_descriptors.has (Void)
		do
			if has_global_descriptors (a_descriptors) then
				create_formatter_file_dir (global_formatter_file_path)
			end
			if has_target_descriptors (a_descriptors) then
				create_formatter_file_dir (target_formatter_file_path)
			end

			store_xml (xml_document_for_formatter (satisfied_descriptors (a_descriptors, agent is_formatter_global_scope)), global_formatter_file)
			store_xml (xml_document_for_formatter (satisfied_descriptors (a_descriptors, agent is_formatter_target_scope)), target_formatter_file)
		end

	clear_last_error is
			-- Clear `last_error'.
		do
			last_error := Void
		ensure
			not_has_error: not has_error
		end

	set_is_changed (b: BOOLEAN) is
			-- Set `is_changed' with `b'.
		do
			is_changed := b
		ensure
			is_changed_set: is_changed = b
		end

	set_is_loaded (b: BOOLEAN) is
			-- Set `is_loaded' with `b'.
		do
			is_loaded := b
		ensure
			is_loaded_set: is_loaded = b
		end

	set_is_file_readable (b: BOOLEAN) is
			-- Set `is_file_readable' with `b'.
		do
			is_file_readable := b
		ensure
			is_file_readable_set: is_file_readable = b
		end

	set_last_error (a_error: like last_error) is
			-- Set `last_error' with `a_error'.
		do
			last_error := a_error
		ensure
			last_error_set: last_error = a_error
		end

feature{NONE} -- Actions

	on_project_loaded is
			-- Action to be performed when project is loaded.
		do
		end

feature{NONE} -- Implementation

	load_formatters (a_file: STRING; a_global: BOOLEAN; a_error_agent: PROCEDURE [ANY, TUPLE]) is
			-- Load formatters contained in file `a_file' and mark loaded formatters as of global scope if `a_global' is True,
			-- otherwise as of target scope.
			-- If error occurs, call `a_error_agent'.
		require
			a_file_attached: a_file /= Void
		local
			l_descriptors: like formatter_descriptors
			l_desp_tuple: like descriptors_from_file
		do
				-- Load global formatters.
			set_is_file_readable (True)
			l_desp_tuple := descriptors_from_file (a_file, agent set_is_file_readable (False))
			l_descriptors := l_desp_tuple.descriptors
			set_last_error (l_desp_tuple.error)
			if a_error_agent /= Void and then has_error then
				a_error_agent.call (Void)
				clear_last_error
			end
			mark_descriptors (l_descriptors, a_global)
			formatter_descriptors.append (l_descriptors)
		end

feature{NONE} -- Implementation/Data

	formatter_change_actions_internal: like formatter_change_actions
			-- Implementation of `formatter_change_actions'

	formatter_descriptors_internal: like formatter_descriptors
			-- Implementation of `formatter_descriptors'


	formatter_file_name: STRING is "formatters.xml"
			-- File name of formatter definition

	formatter_file_path (a_base_path: STRING): FILE_NAME is
			-- Path for formatter file based on `a_base_path'
		require
			a_base_path_attached: a_base_path /= Void
		do
			create Result.make_from_string (a_base_path)
			Result.extend ("formatters")
		ensure
			result_attached: Result /= Void
		end

	formatter_file (a_path: STRING): STRING is
			-- Formatter file name (with absolute path) whose relative path is `a_path' (`a_path' has the "formatters" sub-path part)
		require
			a_path_attached: a_path /= Void
		local
			l_file_name: FILE_NAME
		do
			create l_file_name.make_from_string (a_path)
			l_file_name.set_file_name (formatter_file_name)
			Result := l_file_name.out
		ensure
			result_attached: Result /= Void
		end

	on_project_loaded_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `on_project_loaded'

	global_formatter_file_path: FILE_NAME is
			-- Path to store global formatter file
		do
			Result := formatter_file_path (eiffel_home)
		ensure
			result_attached: Result /= Void
		end

	target_formatter_file_path: FILE_NAME is
			-- Path to store target formatter file
		require
			system_defined: workbench.system_defined and then workbench.is_already_compiled
		do
			Result := formatter_file_path (project_location.target_path)
		ensure
			result_attached: Result /= Void
		end

	global_formatter_file: STRING is
			-- File to store global customized formatters information
		do
			Result := formatter_file (global_formatter_file_path)
		end

	target_formatter_file: STRING is
			-- File to store target customized formatters information
		require
			system_defined: workbench.system_defined and then workbench.is_already_compiled
		do
			Result := formatter_file (target_formatter_file_path)
		end

invariant
	on_project_loaded_agent_attached: on_project_loaded_agent /= Void

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
