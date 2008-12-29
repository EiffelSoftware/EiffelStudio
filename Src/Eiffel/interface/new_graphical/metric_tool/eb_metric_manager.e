note
	description: "Metric manager to maintain all registered metrics in current application targer"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_MANAGER

inherit
	QL_SHARED_UNIT

	SHARED_WORKBENCH

	PROJECT_CONTEXT

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	SHARED_BENCH_NAMES

	EB_METRIC_ACTION_SEQUENCES

	SHARED_FLAGS

	EB_XML_DOCUMENT_HELPER [EB_METRIC]

	EB_METRIC_XML_CONSTANTS

create
	make

feature{NONE} -- Initialization

	make
			-- Initialize.
		do
			create {LINKED_LIST [EB_METRIC]} metrics.make
			create metrics_validity.make (100)
		end

feature -- Setting

	clear_last_error
			-- Clear `last_error'.
		do
			last_error := Void
		ensure
			last_error_cleared: last_error = Void and not has_error
		end

feature -- Validation

	check_validation (a_force: BOOLEAN)
			-- Check validation status of metrics in `metrics'.
			-- If `a_force' is True, check even though some metric has already been checked.
		local
			l_cursor: CURSOR
		do
			if a_force then
				metrics_validity.wipe_out
			end
			l_cursor := metrics.cursor
			from
				metrics.start
			until
				metrics.after
			loop
				if not is_metric_validity_checked (metrics.item.name) then
					check_validation_for_metric (metrics.item.name)
				end
				metrics.forth
			end
			metrics.go_to (l_cursor)
		end

	check_validation_for_metric (a_name: STRING)
			-- Check validation for metric named `a_name'.
			-- Do not check name crash.
		require
			a_name_attached: a_name /= Void
			metric_exists: has_metric (a_name)
		local
			l_validator: EB_METRIC_VALIDITY_VISITOR
			l_error_table: HASH_TABLE [EB_METRIC_ERROR, STRING]
			l_validity_table: like metrics_validity
		do
			create l_validator.make (Current)
			l_validator.check_metric_validity (metric_with_name_internal (a_name), False)
			l_error_table := l_validator.error_table
			l_validity_table := metrics_validity
			from
				l_error_table.start
			until
				l_error_table.after
			loop
				set_metric_validity (l_error_table.key_for_iteration, l_error_table.item_for_iteration)
				l_error_table.forth
			end
		end

feature{EB_METRIC_VALIDITY_VISITOR} -- Validity setting

	set_metric_validity (a_metric_name: STRING; a_validity: EB_METRIC_ERROR)
			-- Set validity of metric named `a_metric_name' with `a_validity'.
		require
			a_metric_name_attached: a_metric_name /= Void
			metric_exists: has_metric (a_metric_name)
		do
			metrics_validity.force (a_validity, a_metric_name)
		ensure
			metrc_validity_set: metric_validity (a_metric_name) = a_validity
		end

feature -- Status report

	has_error: BOOLEAN
			-- Does parsing contain error?
		do
			Result := last_error /= Void
		end

	has_metric (a_name: STRING): BOOLEAN
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
				Result := is_metric_name_equal (l_metrics.item.name, a_name)
				l_metrics.forth
			end
			l_metrics.go_to (l_cursor)
		end

	is_metric_valid (a_name: STRING): BOOLEAN
			-- Is metric named `a_name' valid?
		require
			a_name_attached: a_name /= Void
			metric_exists: has_metric (a_name)
		do
			if not is_metric_validity_checked (a_name) then
				check_validation_for_metric (a_name)
			end
			Result := metric_validity (a_name) = Void
		end

	is_metric_calculatable (a_name: STRING): BOOLEAN
			-- Is metric named `a_name' calculatable (i.e., metric exists and is valid)?
		require
			a_name_attached: a_name /= Void
		do
			Result := has_metric (a_name) and then is_metric_valid (a_name)
		end

	is_metric_loaded: BOOLEAN
			-- Have metrics in files been loaded?

	is_userdefined_metric_file_exist: BOOLEAN
			-- Does user defined metric file exist?
		local
			l_file: RAW_FILE
		do
			create l_file.make (userdefined_metrics_file)
			Result := l_file.exists
		end

	is_metric_name_equal (a_metric_name, b_metric_name: STRING): BOOLEAN
			-- Are `a_metric_name' and `b_metric_name' equal?
		require
			a_metric_name_attached: a_metric_name /= Void
			b_metric_name_attached: b_metric_name /= Void
		local
			l_a_name, l_b_name: STRING
		do
			l_a_name := a_metric_name.twin
			l_a_name.left_adjust
			l_a_name.right_adjust
			l_b_name := b_metric_name.twin
			l_b_name.left_adjust
			l_b_name.right_adjust
			Result := l_a_name.is_case_insensitive_equal (l_b_name)
		end

	is_eiffel_compiling: BOOLEAN
			-- Is eiffel compiling?

	is_metric_evaluating: BOOLEAN
			-- Is metric being evaluated?

	is_archive_calculating: BOOLEAN
			-- Is metric archive being calculated?

	is_project_loaded: BOOLEAN
			-- Is a project loaded?	

	is_history_recalculation_running: BOOLEAN
			-- Is metric history recalculation running?

	is_metric_name_valid (a_name: STRING): BOOLEAN
			-- Is `a_name' a valid metric name?
		do
			Result := a_name /= Void and then
					  (not a_name.is_empty) and then
					  a_name.item (1).is_graph and then
					  a_name.item (a_name.count).is_graph
		end

	has_archive_been_loaded: BOOLEAN
			-- Has archive history been loaded from `archive_history_file' into `archvie_history'?

	is_metric_validity_checked (a_name: STRING): BOOLEAN
			-- Is validity of metric named `a_name' checked?
		require
			a_name_attached: a_name /= Void
			metric_exists: has_metric (a_name)
		do
			Result := metrics_validity.has (a_name)
		end

feature -- Access

	userdefined_metrics_file: STRING
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

	archive_history_file: STRING
			-- File to store metric history
		require
			system_defined: workbench.system_defined and then workbench.is_already_compiled
		local
			l_file_name: FILE_NAME
		do
			create l_file_name.make_from_string (userdefined_metrics_path)
			l_file_name.set_file_name ("history.xml")
			Result := l_file_name.out
		ensure
			good_result: Result /= Void and then not Result.is_empty
		end

	userdefined_metrics_path: STRING
			-- File path where `userdefined_metric_file' is located, not including the trailing directory separator
		require
			system_defined: workbench.system_defined and then workbench.is_already_compiled
		local
			l_file_name: FILE_NAME
		do
			create l_file_name.make_from_string (project_location.data_path)
			l_file_name.extend ("metrics")
			Result :=  l_file_name.out
		ensure
			result_attached: Result /= Void
		end

	last_error: EB_METRIC_ERROR
			-- Last occurred error

	metrics: LIST [EB_METRIC]
			-- List of registered metrics

	metric_with_name (a_name: STRING): EB_METRIC
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
				if is_metric_name_equal (l_metrics.item.name, a_name) then
					Result := l_metrics.item
				else
					l_metrics.forth
				end
			end
			l_metrics.go_to (l_cursor)
		end

	ordered_metrics (a_metric_order_tester: FUNCTION [ANY, TUPLE [EB_METRIC, EB_METRIC], BOOLEAN]; a_flat: BOOLEAN): HASH_TABLE [LIST [EB_METRIC], QL_METRIC_UNIT]
			-- All metrics in order retrieved by `a_metric_order_tester'.
			-- If `a_flat' is True, DO NOT sort metrics according to unit, and all sorted metrics will be in a list with the key `no_unit'.
		require
			a_metric_order_tester_attached: a_metric_order_tester /= Void
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
			create l_agent_sorter.make (a_metric_order_tester)
			create l_sorter.make (l_agent_sorter)
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

	metric_validity (a_name: STRING): EB_METRIC_ERROR
			-- Validity status of metric named `a_name'
		require
			a_name_attached: a_name /= Void
			metric_exists: has_metric (a_name)
		do
			if not is_metric_validity_checked (a_name) then
				check_validation_for_metric (a_name)
			end
			Result := metrics_validity.item (a_name)
		end

	units: LIST [QL_METRIC_UNIT]
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

	next_metric_name_with_unit (a_unit: QL_METRIC_UNIT): STRING
			-- Next numbered metric name starting with "Unnamed" and with unit `a_unit'
		require
			a_unit_attached: a_unit /= Void
		do
			Result := next_metric_name ("Unnamed " + a_unit.name + " metric")
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	last_loaded_metric_archive: LIST [EB_METRIC_ARCHIVE_NODE]
			-- Last loaded metric archive by `load_metric_archive'

	uuid_generator: UUID_GENERATOR
			-- UUID generator
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	metrics_from_file (a_file_name: STRING): LIST [EB_METRIC]
			-- Metrics defined in file named `a_file_name'
			-- If error occurs when opening the file or loading metric definitions,
			-- result will be Void and the actual error will be in `last_error'.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			l_callback: EB_METRIC_LOAD_DEFINITION_CALLBACKS
			l_tuple: TUPLE [l_metrics: LIST [EB_METRIC]; l_error: EB_METRIC_ERROR]
		do
			clear_last_error
			create l_callback.make_with_factory (create{EB_LOAD_METRIC_DEFINITION_FACTORY})
			l_tuple := items_from_file (a_file_name, l_callback, agent (l_callback.metrics).linear_representation, agent l_callback.last_error, agent create_last_error (metric_names.err_file_not_readable (a_file_name)))
			if not has_error then
				last_error := l_tuple.l_error
				if not has_error then
					Result := l_tuple.l_metrics
				else
					Result := Void
					backup_file (a_file_name)
				end
			end
		end

	create_last_error (a_error_message: STRING_GENERAL)
			-- Create `last_error' to contain message `a_error_message'.
		require
			a_error_message_attached: a_error_message /= Void
		do
			create last_error.make (a_error_message)
		ensure
			has_error: has_error
		end

	archive_history: EB_METRIC_ARCHIVE
			-- Archive history

	on_compile_start_agent: PROCEDURE [ANY, TUPLE]
			-- Agent for `on_compile_start'
		do
			if on_compile_start_agent_internal = Void then
				on_compile_start_agent_internal := agent on_compile_start
			end
			Result := on_compile_start_agent_internal
		end

feature -- Metric management

	load_metrics
			-- Load predefined and user-defined metrics.
		local
			l_final_error: STRING_GENERAL
			l_err_loading_predefined: EB_METRIC_ERROR
			l_err_loading_userdefined: EB_METRIC_ERROR
		do
			if workbench.system_defined and then workbench.is_already_compiled then
				clear_last_error
				metrics.wipe_out
				metrics_validity.wipe_out
					-- Load predefined metrics.
				load_metric_definitions (eiffel_layout.predefined_metrics_file, True)
				l_err_loading_predefined := last_error

					-- Load user-defined metrics.
				clear_last_error
				load_metric_definitions (userdefined_metrics_file, False)
				l_err_loading_userdefined := last_error

					-- Setup final error message.
				if l_err_loading_predefined /= Void then
					l_final_error :=  metric_names.err_loading_predefined_metrics (l_err_loading_predefined.message_with_location.twin).twin
				end
				if l_err_loading_userdefined /= Void then
					if l_final_error /= Void then
						l_final_error.append ("%N")
						l_final_error.append (metric_names.err_loading_userdefined_metrics (l_err_loading_userdefined.message_with_location.twin))
					else
						l_final_error := metric_names.err_loading_userdefined_metrics (l_err_loading_userdefined.message_with_location.twin)
					end
				end
				if l_final_error /= Void then
					create last_error.make (l_final_error)
				end

				is_metric_loaded := True
				metric_loaded_actions.call (Void)
			end
		end

	load_metric_definitions (a_file_name: STRING; a_predefined: BOOLEAN)
			-- Load metric definitions in `a_file_name'.
			-- If some error occurs when parsing `a_file_name', no metric will be registered in `metrics'.
			-- If `a_predefined' is True, mark loaded metrics predefined.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			l_loaded_metrics: like metrics
			l_file: RAW_FILE
		do
			create l_file.make (a_file_name)
			if l_file.exists then
				if l_file.is_readable then
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
				else
					create last_error.make (metric_names.err_file_not_readable (a_file_name))
				end
			end
		end

	store_metric_definitions (a_file_name: STRING)
			-- Store non-predefined `metrics' in `a_file_name'.
			-- Note: Always create new file when store.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			l_userdefined_metrics: LINKED_LIST [EB_METRIC]
			l_xml_generator: EB_METRIC_XML_WRITER [EB_METRIC]
		do
			create l_xml_generator.make
			create l_userdefined_metrics.make
			metrics.do_if (agent l_userdefined_metrics.extend, agent (a_metric: EB_METRIC): BOOLEAN do Result := not a_metric.is_predefined end)
			store_xml (xml_document_for_items (n_metric, l_userdefined_metrics, agent l_xml_generator.xml_element), a_file_name, agent create_last_error (metric_names.err_file_not_writable (a_file_name)))
		end

	store_userdefined_metrics
			-- Store user-defined metrics.
		local
			l_folder: DIRECTORY
			l_retried: BOOLEAN
		do
			if not l_retried then
				workbench.create_data_directory
				create l_folder.make (userdefined_metrics_path)
				if not l_folder.exists then
					l_folder.create_dir
				end
				store_metric_definitions (userdefined_metrics_file)
			end
		rescue
			l_retried := True
			create last_error.make (metric_names.err_directory_creation_fail (userdefined_metrics_path))
			retry
		end

	insert_metric (a_metric: EB_METRIC; a_predefined: BOOLEAN)
			-- Insert `a_metric' in `metrics'.
			-- If `a_predefined' is True, mark `a_metric' as predefined.
		require
			a_metric_attached: a_metric /= Void
			a_metric_not_exist: not has_metric (a_metric.name)
		do
			register_metric (a_metric, a_predefined)
			check_validation (True)
		end

	remove_metric (a_name: STRING)
			-- Remove metric named `a_name'.
		require
			a_name_attached: a_name /= Void
			metric_exists:has_metric (a_name)
		local
			l_metrics: like metrics
			done: BOOLEAN
		do
			check
				metric_not_predefined: not metric_with_name_internal (a_name).is_predefined
			end
			l_metrics := metrics
			from
				l_metrics.start
			until
				l_metrics.after or done
			loop
				if is_metric_name_equal (l_metrics.item.name, a_name) then
					l_metrics.item.set_metric_manager (Void)
					l_metrics.remove
					done := True
				else
					l_metrics.forth
				end
			end
			check_validation (True)
		ensure
			metric_removed: not has_metric (a_name)
		end

	update_metric (a_name: STRING; a_metric: EB_METRIC)
			-- Update metric named `a_name' with `a_metric'.
		require
			a_name_attached: a_name /= Void
			metric_exists:has_metric (a_name)
			a_metric_attached: a_metric /= Void
			no_name_crash: not is_metric_name_equal (a_name, a_metric.name) implies not has_metric (a_metric.name)
		local
			l_renamer: EB_METRIC_RENAME_VISITOR
			l_should_rename: BOOLEAN
		do
			check
				metric_not_predefined: not metric_with_name_internal (a_name).is_predefined
			end
			remove_metric (a_name)
				-- Metric name changes.			
			l_should_rename := not is_metric_name_equal (a_name, a_metric.name)
			if l_should_rename then
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
			if l_should_rename then
				metric_renamed_actions.call ([a_name, a_metric.name])
			end
		end

	save_metric (a_metric: EB_METRIC; a_new: BOOLEAN; a_old_metric: EB_METRIC)
			-- Save `a_metric' into `metrics'.
			-- `a_new' is True indicates that `a_metric' is a newly created metric,
			-- and in this case, `a_old_metric' is the old metric.
		require
			a_metric_attached: a_metric /= Void
			a_new_valid: a_new implies a_old_metric = Void and
						 not a_new implies a_old_metric /= Void
			no_name_crash: a_new implies not has_metric (a_metric.name)
		do
			if a_new then
				metrics.extend (a_metric)
				a_metric.set_metric_manager (Current)
			else
				update_metric (a_old_metric.name, a_metric)
			end
		end

	load_archive_history
			-- Load archive history from `archive_history_file' into `archive_history'.
		local
			l_file_name: RAW_FILE
		do
			clear_last_error
			create archive_history.make
			create l_file_name.make (archive_history_file)
			if l_file_name.exists and then l_file_name.is_readable then
				archive_history.load_archive (archive_history_file)
				archive_history.mark_archive_as_old
				if archive_history.has_error then
					last_error := archive_history.last_error
					archive_history.clear_last_error
				end
			end
			set_has_archive_been_loaded (True)
		end

	store_archive_history
			-- Store `archive_history' in `archive_history_file'.
		require
			archive_history_loaded: has_archive_been_loaded
		local
			l_retried: BOOLEAN
			l_folder: DIRECTORY
		do
			if not l_retried then
				if archive_history.count > 0 then
					workbench.create_data_directory
					create l_folder.make (userdefined_metrics_path)
					if not l_folder.exists then
						l_folder.create_dir
					end
					clear_last_error
					archive_history.clear_last_error
					archive_history.store_archive (archive_history_file, agent archive_history.create_last_error (metric_names.err_file_not_writable (archive_history_file)))
					if archive_history.has_error then
						last_error := archive_history.last_error
					end
				end
			end
		rescue
			l_retried := True
			create last_error.make (metric_names.err_directory_creation_fail (userdefined_metrics_path))
			retry
		end

	terminate_evaluation
			-- Terminate every running evaluation including metric evaluation, archive evaluation and history recalculation.
		local
			l_generator: QL_TARGET_DOMAIN_GENERATOR
		do
			if is_metric_evaluating or is_archive_calculating or is_history_recalculation_running then
				create l_generator
				l_generator.error_handler.insert_interrupt_error ("")
			end
		end

feature -- Metric archive

	load_metric_archive (a_file_name: STRING)
			-- Load metric archive from file named `a_file_name'.
			-- Store result in `last_loaded_metric_archive'.
			-- Set `last_loaded_metric_archive' to Void if error occurs.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			l_archive: EB_METRIC_ARCHIVE
		do
			clear_last_error
			create l_archive.make
			l_archive.load_archive (a_file_name)
			last_error := l_archive.last_error
			if not has_error then
				last_loaded_metric_archive := l_archive.archive
			else
				last_loaded_metric_archive := Void
			end
		end

	store_metric_archive (a_file_name: STRING; a_archive: LIST [EB_METRIC_ARCHIVE_NODE])
			-- Store metric archive `a_archive' into file named `a_file_name'.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_archive_attached: a_archive /= Void
		local
			l_archive: EB_METRIC_ARCHIVE
		do
			clear_last_error
			create l_archive.make
			a_archive.do_all (agent l_archive.insert_archive_node)
			l_archive.store_archive (a_file_name, agent l_archive.create_last_error (metric_names.err_file_not_writable (a_file_name)))
			last_error := l_archive.last_error
		end

feature -- Setting

	set_is_eiffel_compiling (b: BOOLEAN)
			-- Set `is_eiffel_compiling' with `b'.
		do
			is_eiffel_compiling := b
		ensure
			is_eiffel_compiling_set: is_eiffel_compiling = b
		end

	set_is_archive_calculating (b: BOOLEAN)
			-- Set `is_archive_calculating' with `b'.
		do
			is_archive_calculating := b
		ensure
			is_archive_calculating_set: is_archive_calculating = b
		end

	set_is_metric_evaluating (b: BOOLEAN)
			-- Set `is_metric_evaluating' with `b'.
		do
			is_metric_evaluating := b
		ensure
			is_metric_evaluating_set: is_metric_evaluating = b
		end

	set_is_project_loaded (b: BOOLEAN)
			-- Set `is_project_loaded' with `b'.
		do
			is_project_loaded := b
		ensure
			is_project_loaded_set: is_project_loaded = b
		end

	set_is_history_recalculation_running (b: BOOLEAN)
			-- Set `is_history_recalculation_running' with `b'.
		do
			is_history_recalculation_running := b
		ensure
			is_history_recalculation_running_set: is_history_recalculation_running = b
		end

	set_has_archive_been_loaded (b: BOOLEAN)
			-- Set `has_archive_been_loaded' with `b'.
		do
			has_archive_been_loaded := b
		ensure
			has_archive_been_loaded_set: has_archive_been_loaded = b
		end

feature -- Actions

	on_project_loaded
			-- A new project has been loaded.
		do
			set_is_project_loaded (True)
			project_load_actions.call (Void)
		end

	on_project_unloaded
			-- Current project has been closed.
		do
			set_is_project_loaded (False)
			project_unload_actions.call (Void)
		end

	on_compile_start
			-- Action to be performed when Eiffel compilation starts
		do
			set_is_eiffel_compiling (True)
			compile_start_actions.call (VOid)
		end

	on_compile_stop
			-- Action to be performed when Eiffel compilation stops
		do
			set_is_eiffel_compiling (False)
			compile_stop_actions.call (Void)
		end

	on_metric_evaluation_starts (a_data: ANY)
			-- Action to be performed when metric evaluation starts
			-- `a_data' can be the metric tool panel from which metric evaluation starts.
		do
			set_is_metric_evaluating (True)
			metric_evaluation_start_actions.call ([a_data])
		end

	on_metric_evaluation_stops (a_data: ANY)
			-- Action to be performed when metric evaluation stops
			-- `a_data' can be the metric tool panel from which metric evaluation stops.
		do
			set_is_metric_evaluating (False)
			metric_evaluation_stop_actions.call ([a_data])
		end

	on_archive_calculation_starts (a_data: ANY)
			-- Action to be performed when metric archive calculation starts
			-- `a_data' can be the metric tool panel from which metric archive calculation starts.
		do
			set_is_archive_calculating (True)
			archive_calculation_start_actions.call ([a_data])
		end

	on_archive_calculation_stops (a_data: ANY)
			-- Action to be performed when metric archive calculation stops
			-- `a_data' can be the metric tool panel from which metric archive calculation stops.
		do
			set_is_archive_calculating (False)
			archive_calculation_stop_actions.call ([a_data])
		end

	on_history_recalculation_starts (a_data: ANY)
			-- Action to be performed when metric history recalculation starts
			-- `a_data' can be the metric tool panel from which metric history recalculation starts.
		do
			set_is_history_recalculation_running (True)
			history_recalculation_start_actions.call ([a_data])
		end

	on_history_recalculation_stops (a_data: ANY)
			-- Action to be performed when metric history recalculation stops
			-- `a_data' can be the metric tool panel from which metric history recalculation stops.
		do
			set_is_history_recalculation_running (False)
			history_recalculation_stop_actions.call ([a_data])
		end

feature{NONE} -- Implementation

	register_metric (a_metric: EB_METRIC; a_predefined: BOOLEAN)
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

feature{NONE} -- Implementation

	metrics_validity: HASH_TABLE [EB_METRIC_ERROR, STRING]
			-- Table of metric validity.
			-- Key is name of metric, value is the error message.
			-- Value is Void indicates that the metric is valid.

	check_name_crash (a_metric_list: like metrics)
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
					create last_error.make (metric_names.err_duplicated_metric_name (l_metric.name))
				end
				a_metric_list.forth
			end
		end

	next_metric_name (a_name_starter: STRING): STRING
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

	metric_with_name_internal (a_name: STRING): EB_METRIC
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
				if is_metric_name_equal (l_metrics.item.name, a_name) then
					Result := l_metrics.item
				else
					l_metrics.forth
				end
			end
			l_metrics.go_to (l_cursor)
		end

	on_compile_start_agent_internal: like on_compile_start_agent
			-- Implementation of `on_compile_start_agent'

invariant
	metrics_attached: metrics /= Void
	metrics_validity_attached: metrics_validity /= Void

note
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
