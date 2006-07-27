indexing
	description: "Metric manager to maintain all registered metrics in current application targer"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_MANAGER

inherit
	QL_OBSERVABLE

	QL_SHARED_UNIT

	SHARED_WORKBENCH

	PROJECT_CONTEXT

	EIFFEL_ENV

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize.
		do
			create {LINKED_LIST [EB_METRIC]} metrics.make
			create metrics_vadility.make (100)
		end

feature -- Setting

	clear_last_error is
			-- Clear `last_error'.
		do
			last_error := Void
		ensure
			last_error_cleared: last_error = Void and not has_error
		end

feature -- Validation

	check_validation (a_force: BOOLEAN) is
			-- Check validation status of metrics in `metrics'.
			-- If `a_force' is True, check even though some metric has already been checked.
		local
			l_cursor: CURSOR
		do
			l_cursor := metrics.cursor
			from
				metrics.start
			until
				metrics.after
			loop
				if a_force or not is_metric_vadility_checked (metrics.item.name) then
					check_validation_for_metric (metrics.item.name)
				end
				metrics.forth
			end
			metrics.go_to (l_cursor)
		end

	check_validation_for_metric (a_name: STRING) is
			-- Check validation for metric named `a_name'.
			-- Do not check name crash.
		require
			a_name_attached: a_name /= Void
			metric_exists: has_metric (a_name)
		local
			l_validator: EB_METRIC_VADILITY_VISITOR
		do
			create l_validator.make (Current)
			l_validator.process_metric (metric_with_name (a_name))
			metrics_vadility.force (l_validator.last_error, a_name)
		end

feature -- Status report

	has_error: BOOLEAN is
			-- Does parsing contain error?
		do
			Result := last_error /= Void
		end

	has_metric (a_name: STRING): BOOLEAN is
			-- Does `metrics' has metric named `a_name'?
		require
			a_name_attached: a_name /= Void
		local
			l_metrics: like metrics
			l_cursor: CURSOR
		do
			l_metrics := metrics
			l_cursor := l_metrics.cursor
			from
				l_metrics.start
			until
				l_metrics.after or Result
			loop
				Result := l_metrics.item.name.is_case_insensitive_equal (a_name)
				l_metrics.forth
			end
			l_metrics.go_to (l_cursor)
		end

	is_metric_valid (a_name: STRING): BOOLEAN is
			-- Is metric named `a_name' valid?
		require
			a_name_attached: a_name /= Void
			metric_exists: has_metric (a_name)
		do
			if not is_metric_vadility_checked (a_name) then
				check_validation_for_metric (a_name)
			end
			Result := metric_vadility (a_name) = Void
		end

	is_valid_order (a_order: INTEGER): BOOLEAN is
			-- Is `a_order' is valid sorting order?
			-- For information of sorting order, see `ascending_order', `descending_order' and `topological_order'.
		do
			Result := a_order = ascending_order or a_order = descending_order or a_order = topological_order
		end

	is_metric_loaded: BOOLEAN
			-- Have metrics in files been loaded?

	is_userdefined_metric_file_exist: BOOLEAN is
			-- Does user defined metric file exist?
		local
			l_file: RAW_FILE
		do
			create l_file.make (userdefined_metrics_file)
			Result := l_file.exists
		end

feature -- Access

	predefined_metrics_file: STRING is
			-- File to store predefined metrics
		require
			system_defined: workbench.system_defined and then workbench.is_already_compiled
		local
			l_file_name: FILE_NAME
		do
			create l_file_name.make_from_string (eiffel_installation_dir_name)
			l_file_name.extend ("metrics")
			l_file_name.set_file_name ("predefined_metrics.xml")
			Result := l_file_name.out
		ensure
			good_result: Result /= Void and then not Result.is_empty
		end

	userdefined_metrics_file: STRING is
			-- File to store user-defined metrics
		require
			system_defined: workbench.system_defined and then workbench.is_already_compiled
		local
			l_file_name: FILE_NAME
		do
			create l_file_name.make_from_string (userdefined_metrics_path)
			l_file_name.set_file_name ("userdefined_metrics.xml")
			Result := l_file_name.out
		ensure
			good_result: Result /= Void and then not Result.is_empty
		end

	userdefined_metrics_path: STRING is
			-- File path where `userdefined_metric_file' is located, not including the trailing directory separator
		require
			system_defined: workbench.system_defined and then workbench.is_already_compiled
		local
			l_file_name: FILE_NAME
		do
			create l_file_name.make_from_string (project_location.path)
			l_file_name.extend ("metrics")
			Result :=  l_file_name.out
		ensure
			result_attached: Result /= Void
		end

	last_error: EB_METRIC_ERROR
			-- Last occurred error

	metrics: LIST [EB_METRIC]
			-- List of registered metrics

	metrics_with_unit (a_unit: QL_METRIC_UNIT): LIST [EB_METRIC] is
			-- List of registered metrics whose unit is `a_unit'
		local
			l_metrics: like metrics
			l_cursor: CURSOR
		do
			l_metrics := metrics.twin
			l_cursor := l_metrics.cursor
			from
				l_metrics.start
			until
				l_metrics.after
			loop
				if l_metrics.item.unit /= a_unit then
					l_metrics.remove
				else
					l_metrics.forth
				end
			end
			l_metrics.go_to (l_cursor)
		ensure
			result_attached: Result /= Void
		end

	metric_with_name (a_name: STRING): EB_METRIC is
			-- Metric whose name is `a_name'
			-- Void if no metric whose name is `a_name' in `metrics'.
		require
			a_name_attached: a_name /= Void
		local
			l_metrics: like metrics
			l_cursor: CURSOR
		do
			l_metrics := metrics
			l_cursor := l_metrics.cursor
			from
				l_metrics.start
			until
				l_metrics.after or Result /= Void
			loop
				if l_metrics.item.name.is_case_insensitive_equal (a_name) then
					Result := l_metrics.item
				else
					l_metrics.forth
				end
			end
			l_metrics.go_to (l_cursor)
		end

	ordered_metrics (a_order: INTEGER; a_flat: BOOLEAN): HASH_TABLE [LIST [EB_METRIC], QL_METRIC_UNIT] is
			-- All metrics in `a_order'
			-- If `a_flat' is True, DO NOT sort metrics according to unit, and all sorted metrics will be in a list with the key `no_unit'.
		require
			a_order_valid: is_valid_order (a_order)
		local
			l_ordered_metrics: HASH_TABLE [DS_ARRAYED_LIST [EB_METRIC], QL_METRIC_UNIT]
			l_metric_list: DS_ARRAYED_LIST [EB_METRIC]
			l_metrics: like metrics
			l_units: like units
			l_cursor: CURSOR
			l_sorter: DS_QUICK_SORTER [EB_METRIC]
			l_agent_sorter: AGENT_BASED_EQUALITY_TESTER [EB_METRIC]
			l_list: ARRAYED_LIST [EB_METRIC]
		do
			l_units := units
			l_metrics := metrics
			if a_flat then
				create l_metric_list.make (l_metrics.count)
			end
				-- Categorize metrics by unit.
			create l_ordered_metrics.make (11)
			from
				l_units.start
			until
				l_units.after
			loop
				l_ordered_metrics.put (create {DS_ARRAYED_LIST [EB_METRIC]}.make (10), l_units.item)
				l_units.forth
			end
			l_cursor := l_metrics.cursor
			from
				l_metrics.start
			until
				l_metrics.after
			loop
				if a_flat then
					l_metric_list.force_last (l_metrics.item)
				else
					check l_ordered_metrics.item (l_metrics.item.unit) /= Void end
					l_ordered_metrics.item (l_metrics.item.unit).force_last (l_metrics.item)
				end
				l_metrics.forth
			end
			l_metrics.go_to (l_cursor)

				-- Sort metrics in the same unit and store result.
			create {HASH_TABLE [ARRAYED_LIST [EB_METRIC], QL_METRIC_UNIT]} Result.make (l_ordered_metrics.count)
			create l_agent_sorter.make (agent metric_order_tester)
			create l_sorter.make (l_agent_sorter)
			current_sort_order := a_order
			if a_flat then
				l_sorter.sort (l_metric_list)
				create l_list.make_from_array (l_metric_list.to_array)
				Result.put (l_list, no_unit)
			else
				from
					l_ordered_metrics.start
				until
					l_ordered_metrics.after
				loop
					l_sorter.sort (l_ordered_metrics.item_for_iteration)
					create l_list.make_from_array (l_ordered_metrics.item_for_iteration.to_array)
					Result.put (l_list, l_ordered_metrics.key_for_iteration)
					l_ordered_metrics.forth
				end
			end
		ensure
			result_attached: Result /= Void
		end

	metric_vadility (a_name: STRING): EB_METRIC_ERROR is
			-- Vadility status of metric named `a_name'
		require
			a_name_attached: a_name /= Void
			metric_exists: has_metric (a_name)
		do
			if not is_metric_vadility_checked (a_name) then
				check_validation_for_metric (a_name)
			end
			Result := metrics_vadility.item (a_name)
		end

	units: LIST [QL_METRIC_UNIT] is
			-- List of all supported units
		once
			create {ARRAYED_LIST [QL_METRIC_UNIT]} Result.make (11)
			Result.extend (target_unit)
			Result.extend (group_unit)
			Result.extend (class_unit)
			Result.extend (generic_unit)
			Result.extend (feature_unit)
			Result.extend (argument_unit)
			Result.extend (local_unit)
			Result.extend (assertion_unit)
			Result.extend (line_unit)
			Result.extend (compilation_unit)
			Result.extend (ratio_unit)
		ensure
			result_attached: Result /= Void
		end

	next_metric_name (a_name_starter: STRING): STRING is
			-- Next numbered metric name with starter `a_name_starter'
			-- For example, if metric named "Unnamed metric#1" exists in `metrics',
			-- `next_metric_name' with starter "Unnamed metric" will return "Unnamed metric#2"
		require
			a_name_starter_attached: a_name_starter /= Void
			not_a_name_starter_is_empty: not a_name_starter.is_empty
		local
			l_metrics: like metrics
			l_starter_cnt: INTEGER
			l_item: EB_METRIC
			l_name: STRING
			l_str: STRING
			l_largest_index: INTEGER
			l_index_str: STRING
			l_index: INTEGER
		do
			l_metrics := metrics
			l_starter_cnt := a_name_starter.count + 1
			from
				l_largest_index := 1
				l_metrics.start
			until
				l_metrics.after
			loop
				l_item := l_metrics.item
				l_name := l_item.name
				if l_name.count > l_starter_cnt and then l_name.item (l_starter_cnt) = '#' then
					l_index_str := l_name.substring (l_starter_cnt + 1, l_name.count)
					if l_index_str.is_integer then
						l_index := l_index_str.to_integer
						if l_index >= l_largest_index then
							l_largest_index := l_index + 1
						end
					end
				end
				l_metrics.forth
			end
			create Result.make (l_starter_cnt + 5)
			Result.append (a_name_starter)
			Result.append_character ('#')
			Result.append (l_largest_index.out)
		ensure
			result_attached: Result /= Void
		end

feature -- Access/Sorting order

	ascending_order: INTEGER is 1
			-- Ascending order

	descending_order: INTEGER is 2
			-- Descending order

	topological_order: INTEGER is 3
			-- Topological order, i.e., valid metrics come first in ascending order , and then invalid metrics in ascending order.

feature -- Metric management

	load_metrics is
			-- Load predefined and user-defined metrics.
		local
			l_file: RAW_FILE
			l_error: like last_error
		do
			if workbench.system_defined and then workbench.is_already_compiled then
				clear_last_error
				block
				metrics.wipe_out
				metrics_vadility.wipe_out
					-- Load predefined metrics.
				create l_file.make (predefined_metrics_file)
				if not l_file.exists then
					create {EB_METRIC_ERROR_FILE} l_error.make ("Could not open file", predefined_metrics_file)
				else
					load_metric_definitions (predefined_metrics_file, True)
					if last_error /= Void then
						l_error := last_error
					end
				end

					-- Load user-defined metrics.
				create l_file.make (userdefined_metrics_file)
				if l_file.exists then
					load_metric_definitions (userdefined_metrics_file, False)
				end
				if not has_error and then l_error /= Void then
					last_error := l_error
				end
				is_metric_loaded := True
				resume
				notify (Void)
			end
		end

	load_metric_definitions (a_file_name: STRING; a_predefined: BOOLEAN) is
			-- Load metric definitions in `a_file_name'.
			-- If some error occurs when parsing `a_file_name', no metric will be registered in `metrics'.
			-- If `a_predefined' is True, mark loaded metrics predefined.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			l_loaded_metrics: like metrics
		do
			block
			l_loaded_metrics := metrics_from_file (a_file_name)
			if not has_error then
					-- Check metric name crash.
					-- If some metric in `loaded_metrics' has the same name as a metric in `metrics',
					-- no metric will be registered in `metrics'. All metrics in `l_loaded_metrics' will be ignored.
				check_name_crash (l_loaded_metrics)

					-- Registered metrics in `l_loaded_metrics' into `metrics'
				if not has_error then
					l_loaded_metrics.do_all (agent register_metric (?, a_predefined))
				end
			end
			resume
			notify (last_error)
		end

	store_metric_definitions (a_file_name: STRING) is
			-- Store non-predefined `metrics' in `a_file_name'.
			-- Note: Always create new file when store.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			l_file: PLAIN_TEXT_FILE
			l_xml_generator: EB_METRIC_XML_WRITER
			l_retried: BOOLEAN
		do
			if not l_retried then
				clear_last_error
				create l_file.make_create_read_write (a_file_name)
				create l_xml_generator.make
				l_file.put_string ("<metric>%N")
				from
					metrics.start
				until
					metrics.after
				loop
					if not metrics.item.is_predefined then
						l_xml_generator.set_indent (1)
						l_xml_generator.clear_text
						l_xml_generator.process_metric (metrics.item)
						l_file.put_string (l_xml_generator.text)
					end
					metrics.forth
				end
				l_file.put_string ("</metric>%N")
				l_file.close
			end
		rescue
			create{EB_METRIC_ERROR_FILE} last_error.make ("Could not write file", a_file_name)
			l_retried := True
			retry
		end

	store_userdefined_metrics is
			-- Store user-defined metrics.
		local
			l_folder: DIRECTORY
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_folder.make (userdefined_metrics_path)
				if not l_folder.exists then
					l_folder.create_dir
				end
				store_metric_definitions (userdefined_metrics_file)
			end
		rescue
			l_retried := True
			create{EB_METRIC_ERROR_FILE} last_error.make ("Could not create directory", userdefined_metrics_path)
			retry
		end

	insert_metric (a_metric: EB_METRIC; a_predefined: BOOLEAN) is
			-- Insert `a_metric' in `metrics'.
			-- If `a_predefined' is True, mark `a_metric' as predefined.
		require
			a_metric_attached: a_metric /= Void
			a_metric_not_exist: not has_metric (a_metric.name)
		do
			block
			register_metric (a_metric, a_predefined)
			check_validation (True)
			resume
			notify (last_error)
		end

	remove_metric (a_name: STRING) is
			-- Remove metric named `a_name'.
		require
			a_name_attached: a_name /= Void
			metric_exists:has_metric (a_name)
			metric_not_predefined: not metric_with_name (a_name).is_predefined
		local
			l_metrics: like metrics
			done: BOOLEAN
		do
			block
			l_metrics := metrics
			from
				l_metrics.start
			until
				l_metrics.after or done
			loop
				if l_metrics.item.name.is_case_insensitive_equal (a_name) then
					l_metrics.item.set_metric_manager (Void)
					l_metrics.remove
					done := True
				else
					l_metrics.forth
				end
			end
			check_validation (True)
			resume
			notify (last_error)
		ensure
			metric_removed: not has_metric (a_name)
		end

	update_metric (a_name: STRING; a_metric: EB_METRIC) is
			-- Update metric named `a_name' with `a_metric'.
		require
			a_name_attached: a_name /= Void
			metric_exists:has_metric (a_name)
			a_metric_attached: a_metric /= Void
			metric_not_predefined: not metric_with_name (a_name).is_predefined
			no_name_crash: not a_name.is_case_insensitive_equal (a_metric.name) implies not has_metric (a_metric.name)
		local
			l_renamer: EB_METRIC_RENAME_VISITOR
		do
			block
			remove_metric (a_name)
				-- Metric name changes.
			if not a_name.is_case_insensitive_equal (a_metric.name) then
				create l_renamer.make (a_name, a_metric.name)
				from
					metrics.start
				until
					metrics.after
				loop
					if not metrics.item.is_predefined then
						l_renamer.process_metric (metrics.item)
					end
					metrics.forth
				end
			end
			insert_metric (a_metric, False)
			check_validation (True)
			resume
			notify (last_error)
		end

	save_metric (a_metric: EB_METRIC; a_new: BOOLEAN; a_old_metric: EB_METRIC) is
			-- Save `a_metric' into `metrics'.
			-- `a_new' is True indicates that `a_metric' is a newly created metric,
			-- and in this case, `a_old_metric' is the old metric.
		require
			a_metric_attached: a_metric /= Void
			a_new_valid: a_new implies a_old_metric = Void and
						 not a_new implies a_old_metric /= Void
			no_name_crash: a_new implies not has_metric (a_metric.name)
		do
			block
			if a_new then
				metrics.extend (a_metric)
				a_metric.set_metric_manager (Current)
			else
				update_metric (a_old_metric.name, a_metric)
			end
			resume
			notify (last_error)
		end

feature -- Metric archive

	load_metric_archive (a_file_name: STRING): LIST [EB_METRIC_ARCHIVE_NODE] is
			-- Load metric archive from file named `a_file_name'.
			-- Void if error occurs.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			l_callback: EB_METRIC_LOAD_ARCHIVE_CALLBACKS
		do
			clear_last_error
			create l_callback.make_with_factory (create{EB_LOAD_METRIC_DEFINITION_FACTORY})
			parse_file (a_file_name, l_callback)
			if not has_error then
				Result := l_callback.archive.twin
			end
		end

	store_metric_archive (a_file_name: STRING; a_archive: LIST [EB_METRIC_ARCHIVE_NODE]) is
			-- Store metric archive `a_archive' into file named `a_file_name'.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_archive_attached: a_archive /= Void
		local
			l_file: PLAIN_TEXT_FILE
			l_retried: BOOLEAN
			l_xml_generator: EB_METRIC_XML_WRITER
		do
			if not l_retried then
				clear_last_error

				create l_file.make_create_read_write (a_file_name)
				create l_xml_generator.make
				l_file.put_string ("<metric_archive>%N")
				l_xml_generator.set_indent (1)
				l_xml_generator.clear_text
				l_xml_generator.process_list (a_archive)
				l_file.put_string (l_xml_generator.text)
				l_file.put_string ("</metric_archive>%N")
				l_file.close
			end
		rescue
			l_retried := True
			create{EB_METRIC_ERROR_FILE} last_error.make ("Could not write file", a_file_name)
		end

feature{NONE} -- Implementation

	parse_file (a_file: STRING; a_callback: EB_LOAD_METRIC_CALLBACKS) is
			-- Parse `a_file' using `a_callbacks'.
		require
			a_file_ok: a_file /= Void and then not a_file.is_empty
			a_callback_not_void: a_callback /= Void
		local
			l_file: KL_TEXT_INPUT_FILE
			l_test_file: PLAIN_TEXT_FILE
			l_parser: XM_PARSER
			l_ns_cb: XM_NAMESPACE_RESOLVER
		do
			create {XM_EIFFEL_PARSER} l_parser.make
			create l_ns_cb.set_next (a_callback)
			l_parser.set_callbacks (l_ns_cb)

			create l_file.make (a_file)
			create l_test_file.make (a_file)
			l_file.open_read
			if l_file.exists and then l_file.is_open_read then
				l_parser.parse_from_stream (l_file)
				l_file.close
				if a_callback.has_error then
					last_error := a_callback.last_error
				end
			else
				create {EB_METRIC_ERROR_FILE} last_error.make ("Could not open file", a_file)
			end
		end

	register_metric (a_metric: EB_METRIC; a_predefined: BOOLEAN) is
			-- Register `a_metric' in `metrics'.
			-- If `a_predefined' is True, mark `a_metric' as predefined metric (User can not edit or delete a predefined metric)
		require
			a_metric_attached: a_metric /= Void
			a_metric_not_exists: not has_metric (a_metric.name)
		do
			metrics.extend (a_metric)
			a_metric.set_metric_manager (Current)
			a_metric.set_is_predefined (a_predefined)
		ensure
			metric_registered: has_metric (a_metric.name) and a_metric.manager = Current and (a_predefined implies a_metric.is_predefined)
		end

	is_metric_vadility_checked (a_name: STRING): BOOLEAN is
			-- Is vadility of metric named `a_name' checked?
		require
			a_name_attached: a_name /= Void
			metric_exists: has_metric (a_name)
		do
			Result := metrics_vadility.has (a_name)
		end

	metrics_from_file (a_file_name: STRING): LIST [EB_METRIC] is
			-- Metrics defined in file named `a_file_name'
			-- If error occurs when opening the file or loading metric definitions,
			-- result will be Void and the actual error will be in `last_error'.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			l_callback: EB_METRIC_LOAD_DEFINITION_CALLBACKS
		do
			clear_last_error
			create l_callback.make_with_factory (create{EB_LOAD_METRIC_DEFINITION_FACTORY})
			parse_file (a_file_name, l_callback)
			if not has_error then
				Result := l_callback.metrics
			end
		end

feature{NONE} -- Implementation

	metrics_vadility: HASH_TABLE [EB_METRIC_ERROR, STRING]
			-- Table of metric vadility.
			-- Key is name of metric, value is the error message.
			-- Value is Void indicates that the metric is valid.

	metric_order_tester (a_metric, b_metric: EB_METRIC): BOOLEAN is
			-- Tester to decide the order of `a_metric' and `b_metric'.
		require
			a_metric_attached: a_metric /= Void
			b_metric_attached: b_metric /= Void
		local
			l_metric_a_valid: BOOLEAN
			l_metric_b_valid: BOOLEAN
		do
			if current_sort_order = topological_order then
				l_metric_a_valid := is_metric_valid (a_metric.name)
				l_metric_b_valid := is_metric_valid (b_metric.name)
				if l_metric_a_valid and then not l_metric_b_valid then
					Result := True
				elseif not l_metric_a_valid and then l_metric_b_valid then
				else
					Result := a_metric.name.as_lower < b_metric.name.as_lower
				end
			else
				if current_sort_order = ascending_order then
					Result := a_metric.name.as_lower < b_metric.name.as_lower
				else
					Result := a_metric.name.as_lower > b_metric.name.as_lower
				end
			end
		end

	current_sort_order: INTEGER
			-- Current sort order for metrics

	check_name_crash (a_metric_list: like metrics) is
			-- Check if there is a metric in `a_metric_list' which will cause name crash with metrics in `metrics'.
		require
			a_metric_list_attached: a_metric_list /= Void
		local
			l_metric: EB_METRIC
		do
			from
				a_metric_list.start
			until
				a_metric_list.after or has_error
			loop
				l_metric := a_metric_list.item
				check l_metric /= Void end
				if has_metric (l_metric.name) then
					create{EB_METRIC_ERROR_EXIST} last_error.make (l_metric.name)
				end
				a_metric_list.forth
			end
		end

invariant
	metrics_attached: metrics /= Void
	metrics_vadility_attached: metrics_vadility /= Void

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
