indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_ARCHIVE_COMPARISON_CMD

inherit
	EB_METRIC_COMMAND

	SHARED_XML_ROUTINES
		export
			{NONE} all
		end

	EV_KEY_CONSTANTS
		export
			{NONE} all
		end
	
	TRANSFER_MANAGER_BUILDER
	
	PROJECT_CONTEXT
		export
			{NONE} all
		end
	
	EB_CONSTANTS
		export
			{NONE} all
		end
	
	EB_FILE_DIALOG_CONSTANTS
		export
			{NONE} all
		end
		
	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_sorter
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
				Result := "Compare measures to archive."
		end

	description: STRING is
			-- Description for this command.
		do
			Result := "Archive comparison"
		end

	name: STRING is "Comparison"
			-- Name of the command. Used to store the command in the
			-- preferences.

feature -- Initialization

	build_archive_dialog is
			-- Build `archive_dialog' to create, update or compare to an archive.
		local
			hb: EV_HORIZONTAL_BOX
			vb1, vb2: EV_VERTICAL_BOX
			frame: EV_FRAME
			label: EV_LABEL
			ok_button, button: EV_BUTTON
		do
			create archive_dialog
			archive_dialog.set_title ("Archive setting")
			archive_dialog.set_icon_pixmap (pixmaps.icon_dialog_window)

			create vb1
				vb1.set_padding (5)
				vb1.set_border_width (5)
				create frame.make_with_text ("Set reference archive")
					create vb2
					vb2.set_border_width (5)
					vb2.set_padding (5)

						create hb

							create label.make_with_text ("Compare current archive to:")
							label.align_text_left
							hb.extend (label)
							hb.disable_item_expand (label)

							hb.extend (create {EV_CELL})

							create button.make_with_text_and_action ("Browse...", agent browse_archive)
							layout_constants.set_default_size_for_button (button)
							hb.extend (button)
							hb.disable_item_expand (button)

						vb2.extend (hb)
						vb2.disable_item_expand (hb)

						create hb
						hb.set_padding (5)
							create label.make_with_text ("File or URL:")
							label.align_text_left
							hb.extend (label)
							hb.disable_item_expand (label)

							create browse_archive_field
						hb.extend (browse_archive_field)
						vb2.extend (hb)
						vb2.disable_item_expand (hb)
								
						create label.make_with_text ("Display comparison in terms of:")
						label.align_text_left
						vb2.extend (label)
						vb2.disable_item_expand (label)

						create hb
						hb.set_padding (5)
							create label.make_with_text ("Ratio of current measure to archive")
							hb.extend (label)
							hb.disable_item_expand (label)
							
							hb.extend (create {EV_CELL})

							create button.make_with_text_and_action ("Set", agent validate_url ("default"))
							layout_constants.set_default_size_for_button (button)
							hb.extend (button)
							hb.disable_item_expand (button)
						vb2.extend (hb)
						vb2.disable_item_expand (hb)


						create hb
						hb.set_padding (5)
							create label.make_with_text ("Difference of current measure to archive")
							hb.extend (label)
							hb.disable_item_expand (label)
									
							hb.extend (create {EV_CELL})

							create button.make_with_text_and_action ("Set", agent validate_url ("difference"))
							layout_constants.set_default_size_for_button (button)
							hb.extend (button)
							hb.disable_item_expand (button)
						vb2.extend (hb)
						vb2.disable_item_expand (hb)

						create hb
						hb.set_padding (5)
							create label.make_with_text ("Archive value")
							hb.extend (label)
							hb.disable_item_expand (label)
									
							hb.extend (create {EV_CELL})

							create button.make_with_text_and_action ("Set", agent validate_url ("value"))
							layout_constants.set_default_size_for_button (button)
							hb.extend (button)
							hb.disable_item_expand (button)
						vb2.extend (hb)
						vb2.disable_item_expand (hb)
					frame.extend (vb2)
				vb1.extend (frame)
				vb1.disable_item_expand (frame)

				create frame.make_with_text ("Create/replace archive")
					create vb2
					vb2.set_border_width (5)
					vb2.set_padding (5)

						create hb
						hb.set_padding (5)
								
							create label.make_with_text ("Create new archive for current system:")
							label.align_text_left
							hb.extend (label)
							hb.disable_item_expand (label)

							hb.extend (create {EV_CELL})

							create button.make_with_text_and_action ("Browse...", agent new_archive)
							button.set_minimum_size (50, 22)
							layout_constants.set_default_size_for_button (button)
							hb.extend (button)
							hb.disable_item_expand (button)

						vb2.extend (hb)
						vb2.disable_item_expand (hb)

						create hb
						hb.set_padding (5)
							create label.make_with_text ("Current archive:")
							label.align_text_left
							hb.extend (label)
							hb.disable_item_expand (label)

							create new_archive_field
							new_archive_field.disable_edit
							hb.extend (new_archive_field)
						vb2.extend (hb)
						vb2.disable_item_expand (hb)
					frame.extend (vb2)
				vb1.extend (frame)
				vb1.disable_item_expand (frame)

				create frame.make_with_text ("Update archive")
					create vb2
					vb2.set_border_width (5)
					vb2.set_padding (5)

						create hb

							create label.make_with_text ("Update current system archive:")
							label.align_text_left
							hb.extend (label)
							hb.disable_item_expand (label)

							hb.extend (create {EV_CELL})

							create button.make_with_text_and_action ("Browse...", agent update_archive)
							button.set_minimum_size (50, 22)
							layout_constants.set_default_size_for_button (button)
							hb.extend (button)
							hb.disable_item_expand (button)

						vb2.extend (hb)
						vb2.disable_item_expand (hb)

						create hb
						hb.set_padding (5)
							create label.make_with_text ("Current archive:")
							label.align_text_left
							hb.extend (label)
							hb.disable_item_expand (label)

							create update_archive_field
							update_archive_field.disable_edit
							hb.extend (update_archive_field)
						vb2.extend (hb)
						vb2.disable_item_expand (hb)
					frame.extend (vb2)
				vb1.extend (frame)
				vb1.disable_item_expand (frame)

			create hb
				create ok_button.make_with_text_and_action ("Close", agent ok_action)
				ok_button.set_minimum_width (60)
				layout_constants.set_default_size_for_button (ok_button)
				hb.extend (create {EV_CELL})
				hb.extend (ok_button)
				hb.disable_item_expand (ok_button)
				hb.extend (create {EV_CELL})

			vb1.extend (hb)
			vb1.disable_item_expand (hb)

			archive_dialog.extend (vb1)
			archive_dialog.set_default_push_button (ok_button)
			archive_dialog.set_default_cancel_button (ok_button)
		end

feature -- Access

	archive_dialog: EV_DIALOG
		-- Dialog to create, update or compare to an archive.
			
	default_ratio: EV_RADIO_BUTTON
		-- Display comparison as ratio of system value to archived one.

	difference_ratio: EV_RADIO_BUTTON
		-- Display comparison as ratio of difference between system and archives values to archived value.

	archive_value: EV_RADIO_BUTTON
		-- Display archived value.

	new_archive_field: EV_TEXT_FIELD
		-- Field to display path of the created archive.

	update_archive_field: EV_TEXT_FIELD
		-- Field to display path of the updated archive.

	browse_archive_field: EV_TEXT_FIELD
		-- Field to display path of the selected archive for comparison .

	open_dialog: EB_FILE_OPEN_DIALOG
		-- Dialog to load archive.

	save_dialog: EB_FILE_SAVE_DIALOG
		-- Dialog to save new archive.

	archived_root_element: XM_ELEMENT
		-- XML element written in archive file.

	archived_file: PLAIN_TEXT_FILE
		-- Loaded archive file for comparison.
		
feature -- Action

	new_archive is
			-- Open dialog to create new archive file.
		local
			current_directory: STRING
			ee: EXECUTION_ENVIRONMENT
		do
			create save_dialog.make_with_preference (preferences.dialog_data.last_saved_metric_new_archive_directory_preference)
			set_dialog_filters_and_add_all (save_dialog, <<xml_files_filter>>)
			create ee
			current_directory := ee.current_working_directory
			save_dialog.save_actions.extend (agent confirm_new_archive (current_directory))
			save_dialog.show_modal_to_window (archive_dialog)
		end

	confirm_new_archive (current_directory: STRING) is
			-- Confirm creation of new archive
		require
			correct_directory: current_directory /= Void
		local
			array: ARRAY [PROCEDURE [ANY, TUPLE]]
		do
			create array.make (1, 1)
			array.put (agent on_new_archive (current_directory), 1)
			create confirm_dialog.make_with_text_and_actions (
				"Archive creation can take some time.%NContinue?", array)
			confirm_dialog.show_modal_to_window (archive_dialog)
		end

	on_new_archive (current_directory: STRING) is
			-- Launch metric calculation for all non scope ratio metrics over
			-- `System_scope'. Save measures in the created file.
		require
			correct_directory: current_directory /= Void
		local
			file: PLAIN_TEXT_FILE
			file_name: STRING
			ee: EXECUTION_ENVIRONMENT
			retried: BOOLEAN
			error_dialog: EB_INFORMATION_DIALOG
			x_pos, y_pos: INTEGER
		do
			create ee
			ee.change_working_directory (current_directory)
			overwrite := False
			x_pos := archive_dialog.x_position + 50
			y_pos := archive_dialog.y_position + 50
			file_name := save_dialog.file_name
			if not retried then
				if file_name /= Void and then not file_name.is_empty then
					new_archive_field.set_text (file_name)
					create file.make (file_name)
					if file.exists then
						create confirm_dialog.make_with_text_and_actions ("Selected file already exists.%NOverwrite?", actions_array)
						confirm_dialog.show_modal_to_window (archive_dialog)
					end
					if not file.exists or overwrite then
						create file.make_open_write (file_name)
						fill_archive (file)
						file.close
					end
				end
			end
		rescue
			retried := True
			create error_dialog.make_with_text ("Unable to create file:"
									+ file_name)
			error_dialog.set_position (x_pos, y_pos)
			error_dialog.show_modal_to_window (archive_dialog)
			retry
		end

	update_archive is
			-- Open dialog to update archive file.
		local
			current_directory: STRING
			ee: EXECUTION_ENVIRONMENT
		do
			create open_dialog.make_with_preference (preferences.dialog_data.last_opened_metric_update_archive_directory_preference)
			set_dialog_filters_and_add_all (open_dialog, <<xml_files_filter>>)
			create ee
			current_directory := ee.current_working_directory
			open_dialog.open_actions.extend (agent confirm_update_archive (current_directory))
			open_dialog.show_modal_to_window (archive_dialog)
		end

	confirm_update_archive (current_directory: STRING) is
			-- Confirm creation of new archive
		require
			correct_directory: current_directory /= Void
		local
			array: ARRAY [PROCEDURE [ANY, TUPLE]]
		do
			create array.make (1, 1)
			array.put (agent on_update_archive (current_directory), 1)
			create confirm_dialog.make_with_text_and_actions (
				"Archive creation can take some time.%NContinue?", array)
			confirm_dialog.show_modal_to_window (archive_dialog)
		end

	on_update_archive (current_directory: STRING) is
			-- Launch metric calculation for all non scope ratio metrics over
			-- `System_scope'. Overwrite updated file.
		require
			correct_directory: current_directory /= Void
		local
			file: PLAIN_TEXT_FILE
			file_name: STRING
			root_name, system_name: STRING
			right_file, retried: BOOLEAN
			l_deserialized_document: XM_DOCUMENT
			error_dialog: EB_INFORMATION_DIALOG
			x_pos, y_pos: INTEGER
			ee: EXECUTION_ENVIRONMENT
		do
			create ee
			ee.change_working_directory (current_directory)
			overwrite := False
			x_pos := archive_dialog.x_position + 50
			y_pos := archive_dialog.y_position + 50
			file_name := open_dialog.file_name
			if not retried then
				if file_name /= Void and then not file_name.is_empty then
					l_deserialized_document := Xml_routines.deserialize_document (file_name)
					if l_deserialized_document /= Void then
						if l_deserialized_document.root_element.has_attribute_by_name ("System") then
							system_name := l_deserialized_document.root_element.attribute_by_name ("System").value						
						end

						right_file := (root_name /= Void and then equal (root_name, "ARCHIVE")) and
									(system_name /= Void and then equal (system_name, tool.System.name))
						if right_file then
							create confirm_dialog.make_with_text_and_actions (
											"System name in selected file%N%
											%is the same as current system name.%N%
											%However, it could be just a homonym.%N%
											%continue overwritting?", actions_array)
						else
							create confirm_dialog.make_with_text_and_actions (
											"Selected file is not the%N%
											%current system's archive.%N%
											%Overwrite?", actions_array)
						end
						confirm_dialog.show_modal_to_window (archive_dialog)
						if overwrite then
							update_archive_field.set_text (file_name)
							create file.make (file_name)
							file.open_write
							fill_archive (file)
							file.close
						end
					else
						create error_dialog.make_with_text ("File does not exist.%N%
													%Please check location.")
						error_dialog.set_position (x_pos, y_pos)
						error_dialog.show_modal_to_window (archive_dialog)
					end
				end
			end
		rescue
			retried := True
			create error_dialog.make_with_text ("Unable to read file:"
									+ file_name)
			error_dialog.set_position (x_pos, y_pos)
			error_dialog.show_modal_to_window (archive_dialog)
			retry
		end

	browse_archive is
			-- Open dialog to select archive file forcomparison with surrent system.
		local
			current_directory: STRING
			ee: EXECUTION_ENVIRONMENT
		do
			create open_dialog.make_with_preference (preferences.dialog_data.last_opened_metric_browse_archive_directory_preference)
			set_dialog_filters_and_add_all (open_dialog, <<xml_files_filter>>)
			create ee
			current_directory := ee.current_working_directory
			open_dialog.open_actions.extend (agent on_browse_archive (current_directory))
			open_dialog.show_modal_to_window (archive_dialog)
		end

	on_browse_archive (current_directory: STRING) is
			-- Display archive path and compare.
		require
			correct_directory: current_directory /= Void
		local
			ee: EXECUTION_ENVIRONMENT
			file_name: STRING
		do
			create ee
			ee.change_working_directory (current_directory)
			file_name := open_dialog.file_name
			browse_archive_field.set_text (file_name)
		end
	
	archive_syntax (root_element: XM_ELEMENT): BOOLEAN is
			-- Is `root_element' the XML representation of an archive file?
		require
			element_not_void: root_element /= Void
		do
			Result := (root_element.name /= Void and then equal (root_element.name, "ARCHIVE")) and
					root_element.has (Xml_routines.element_by_name (root_element, "METRIC_DEFINITIONS")) and
					root_element.has (Xml_routines.element_by_name (root_element, "RECORDED_MEASURES")) and
					(root_element.has_attribute_by_name ("System") and then root_element.attribute_by_name ("System").value /= Void)
		end

	handle_archive (file_name: STRING) is
			-- Glance through archive `file_name' and compare saved resiults of
			-- current system to the archived ones. Comparison is displayed in
			-- `tool.multi_column_list' regarding selected radio button.
		require
			existing_file_name: file_name /= Void and then not file_name.is_empty
		local
			root_name, system_name, archived_result: STRING
			right_syntax, retried: BOOLEAN
			l_deserialized_document: XM_DOCUMENT
			error_dialog: EB_INFORMATION_DIALOG
			root_element, current_measure_xml, metric_definitions: XM_ELEMENT
			row: EV_MULTI_COLUMN_LIST_ROW
			a_metric: EB_METRIC
			current_measure: DOUBLE
			x_pos, y_pos, i: INTEGER
		do
			x_pos := archive_dialog.x_position + 50
			y_pos := archive_dialog.y_position + 50
			if not retried then
				if file_name /= Void and then not file_name.is_empty then
					l_deserialized_document := Xml_routines.deserialize_document (file_name)
					if l_deserialized_document /= Void then
						root_element := l_deserialized_document.root_element
						root_name := root_element.name
						if root_element.has_attribute_by_name ("System") then
							system_name := root_element.attribute_by_name ("System").value
						end
		--				right_syntax := (root_name /= Void and then equal (root_name, "ARCHIVE")) and
		--						root_element.has (Xml_routines.element_by_name (root_element, "METRIC_DEFINITIONS")) and
		--						root_element.has (Xml_routines.element_by_name (root_element, "RECORDED_MEASURES")) and
		--						system_name /= Void
						right_syntax := archive_syntax (root_element)

						if right_syntax then
							import := False
							tool.set_default_archive (False)
							create archived_file.make (file_name)
							archived_root_element := root_element
							metric_definitions := Xml_routines.element_by_name (archived_root_element, "METRIC_DEFINITIONS")
							if not metric_definitions.is_empty then
								create confirm_dialog.make_with_text_and_actions ("Import saved metrics of archive:%N"
											+ file_name + "?", import_actions_array)
								confirm_dialog.show_modal_to_window (archive_dialog)
								if import then
									import_metrics (file_name)
								end
							end
							from
								tool.multi_column_list.start
								i := 1
							until
								tool.multi_column_list.after
							loop
								row := tool.multi_column_list.item
								a_metric := tool.metric (row.i_th (4))
								current_measure_xml ?= tool.file_manager.measure_header.item (i)
								check current_measure_xml /= Void end
								current_measure := Xml_routines.xml_double (current_measure_xml, "RESULT")
								archived_result := retrieve_archived_result (a_metric, archived_file, root_element, archive_mode, current_measure)
								row.put_i_th (archived_result, 6)
								tool.multi_column_list.forth
								i := i + 1
							end
							tool.multi_column_list.set_column_title ("Comparison to: " + system_name, 6)
						end
					end
				end
			end
		rescue
			retried := True
			create error_dialog.make_with_text ("Unable to read file:" + file_name)
			error_dialog.set_position (x_pos, y_pos)
			error_dialog.show_modal_to_window (archive_dialog)
			retry
		end
		
	
	validate_url (str: STRING) is
			-- Try to load remote file when connexion succeeded. Make comparison regarding
			-- `archive_mode'.
		require
			existing_mode: equal (str, "default") or equal (str, "difference") or equal (str, "value")
		local
			url_address, http, ftp, file: STRING
			f: PLAIN_TEXT_FILE
			x_pos, y_pos: INTEGER
		do
			archive_mode := str
			tool.set_archive_mode (archive_mode)
			overwrite := False
			x_pos := archive_dialog.x_position + 50
			y_pos := archive_dialog.y_position + 50
			url_address := browse_archive_field.text
			if url_address /= Void and then not url_address.is_empty then
				http := url_address.substring (1, 7) 
				ftp := url_address.substring (1, 6)
				file := url_address.substring (1, 7)
				if equal (file, "file://") then
					handle_archive (url_address.substring (8, url_address.count))
				elseif equal (ftp, "ftp://") or equal (http, "http://") then
					transfer_and_compare (url_address)
				else
					create f.make (url_address)
					if f.exists then
						handle_archive (url_address)
					else
						transfer_and_compare (url_address)
					end				
				end
			end
	end

	transfer_and_compare (url_address: STRING) is
			-- Transfer remote file to a concrete one on disk. Make comparison regarding
			-- `archive_mode'.
		require
			url_not_empty: url_address /= Void and then not url_address.is_empty
		local
			file_name: FILE_NAME
			target_file: STRING
			directory: DIRECTORY
			file: PLAIN_TEXT_FILE
			error_dialog: EB_INFORMATION_DIALOG
		do
			create file_name.make_from_string (project_directory_name)
			create directory.make ("Metrics")
			if not directory.exists then
				directory.create_dir
			end
			file_name.set_subdirectory ("Metrics")
			file_name.extend (tool.System.name + "_transfered_archive")
			file_name.add_extension ("xml")
			
			create file.make (file_name)
			if file.exists then
				create confirm_dialog.make_with_text_and_actions ("Remote file will be loaded in:%N" + file_name +
								"%NThis file already exists. Overwrite?", actions_array)
				confirm_dialog.show_modal_to_window (archive_dialog)
			end
			if not file.exists or overwrite then
				target_file := "file://" + file_name
				transfer_manager_builder.set_timeout (10)
				transfer_manager_builder.wipe_out
				transfer_manager_builder.add_transaction (url_address, target_file)
				if not transfer_manager_builder.last_added_source_correct then
					create error_dialog.make_with_text ("Unable to read remote file.%NPlease check URL:%N" + url_address)
					error_dialog.show_modal_to_window (archive_dialog)
				elseif not transfer_manager_builder.last_added_target_correct then
					create error_dialog.make_with_text ("Unable to load remote file in:%N" + file_name +
											"Please make sure file does not exist or is writable.")
					error_dialog.show_modal_to_window (archive_dialog)
				else
					transfer_manager_builder.build_manager
					tool.development_window.window.set_pointer_style (tool.development_window.Wait_cursor)
					transfer_manager_builder.transfer
					tool.development_window.window.set_pointer_style (tool.development_window.Standard_cursor)
					if transfer_manager_builder.transfer_succeeded then
						handle_archive (file_name)
					else
						create error_dialog.make_with_text ("Unable to transfer remote file.%NReason: "
																+ transfer_manager_builder.error_reason)
						error_dialog.show_modal_to_window (archive_dialog)
					end
				end
			end
		end

	ok_action is
			-- Action to be performed when clicking on `ok_button'.
		do
			archive_dialog.hide
		end

	archive_mode: STRING
			-- Way to display arhive comparison.

	fill_archive (f: PLAIN_TEXT_FILE) is
			-- Launch metric calculation for all non scope ratio metrics over
			-- `System_scope'. Save measures in `f'.
		require
			concrete_file: f /= Void
		local
			archive_header: XM_DOCUMENT
			node, metric_header, measure_header, xml_element: XM_ELEMENT
			metric_list: ARRAYED_LIST [EB_METRIC]
			metric_result: DOUBLE
			scope: EB_METRIC_SCOPE
			a_metric: EB_METRIC_COMPOSITE
			retried: BOOLEAN
			l_namespace: XM_NAMESPACE
		do
			if not retried then
				create l_namespace.make_default
				create archive_header.make_with_root_named ("ARCHIVE", l_namespace)
				node := archive_header.root_element
				node.add_attribute ("System", l_namespace, tool.System.name)
				metric_header := tool.file_manager.metric_header
				node.put_last (metric_header)
				create measure_header.make (node, "RECORDED_MEASURES", l_namespace)
				scope := tool.scope (interface_names.metric_this_system)
				scope.set_system_i (tool.System)
				metric_list := tool.metrics
				from
					metric_list.start
				until
					metric_list.after
				loop
					a_metric ?= metric_list.item
					if a_metric = Void or else not a_metric.is_scope_ratio then
						create xml_element.make (node, "MEASURE", l_namespace)
						xml_element.add_attribute ("Metric", l_namespace, metric_list.item.name)
						metric_result := tool.calculate.calculate_metric (metric_list.item, scope)
						xml_element.add_attribute ("Result", l_namespace, metric_result.out)
						measure_header.put_last (xml_element)
					end
					metric_list.forth
				end
				node.put_last (measure_header)
				Xml_routines.save_xml_document (f.name, archive_header)
				tool.progress_dialog.hide
			end
		rescue
			retried := True
			tool.progress_dialog.hide
			tool.progress_dialog.enable_cancel
			tool.development_window.window.set_pointer_style (tool.development_window.Standard_cursor)
			retry
		end

feature -- Comparison

	retrieve_archived_result (a_metric: EB_METRIC; f: PLAIN_TEXT_FILE; root_element: XM_ELEMENT; mode: STRING; current_measure: DOUBLE): STRING is
			-- Return saved measure for `a_metric' in file `f'
		require
			metric_not_void: a_metric /= Void
			concrete_file: f /= Void
			root_not_void: root_element /= Void
			existing_mode: equal (mode, "default") or
						equal (mode, "difference") or
						equal (mode, "value")
		local
			basic_metric: EB_METRIC_BASIC
			measure_header, measure_element: XM_ELEMENT
			archived_result, displayed_result: DOUBLE
			retried: BOOLEAN
			metric_value: STRING
		do
			if not retried then
				basic_metric ?= a_metric
				if basic_metric /= Void or else 
					tool.calculate.has_metric (a_metric, f) then
					measure_header := Xml_routines.element_by_name (root_element, "RECORDED_MEASURES")
					from
						measure_header.start
					until
						measure_header.after or Result /= Void
					loop
						measure_element ?= measure_header.item_for_iteration
						metric_value := measure_element.attribute_by_name ("Metric").value
						archived_result := measure_element.attribute_by_name ("Result").value.to_double
						if
							measure_element /= Void and then
							equal (metric_value, a_metric.name)
						then
							if equal (mode, "default") then
								displayed_result := current_measure / archived_result
								Result := tool.fix_decimals_and_percentage (displayed_result, True)
							elseif equal (mode, "difference") then
								displayed_result := (current_measure - archived_result) / current_measure
								Result := tool.fix_decimals_and_percentage (displayed_result, True)
							elseif equal (mode, "value") then
								displayed_result := archived_result
								Result := tool.fix_decimals_and_percentage (displayed_result, False)
							end
						end
						measure_header.forth
					end
				end
				tool.progress_dialog.hide
				if Result = Void or else Result.is_empty then
					Result := "-"
				end
			end
		rescue
			retried := True
			tool.progress_dialog.hide
			tool.progress_dialog.enable_cancel
			tool.development_window.window.set_pointer_style (tool.development_window.Standard_cursor)
			retry
		end

feature -- Overwritting

	overwrite: BOOLEAN
		-- Overwrite file?

	confirm_dialog: EV_CONFIRMATION_DIALOG
			-- Dialog to confirm file overwritting.

	actions_array: ARRAY [PROCEDURE [ANY, TUPLE]] is
			-- Actions to be performed for `confirm_dialog'.
		do
			create Result.make (1, 2)
			Result.put (agent overwrite_action, 1)
			Result.put (agent abort_overwrite_action, 2)
		ensure
			filled_array: Result @ 1 /= Void and Result @ 2 /= Void
		end

	overwrite_action is
			-- Action to be performed on clicking on `yes_button' in `confirm_dialog'.
		do
			overwrite := True
		end

	abort_overwrite_action is
			-- Action to be performed on clicking on `no_button' in `confirm_dialog'.
		do
			overwrite := False
		end

	key_enter_pressed (a_key: EV_KEY; a_button: EV_BUTTON) is
			-- On CR, call `a_button' associated action.
		do
			if a_key.code = Key_enter then
				a_button.select_actions.call (Void)
			end
		end

feature -- Metric importation

	import: BOOLEAN
		-- When comparing, import saved metrics of selected archive?

	import_action is
			-- Action to be performed on clicking on `yes_button' in `confirm_dialog'
			-- when asking for archive comparison.
		do
			import := True
		end

	abort_import_action is
			-- Action to be performed on clicking on `no_button' in `confirm_dialog'
			-- when asking for archive comparison.
		do
			import := False
		end

	import_actions_array: ARRAY [PROCEDURE [ANY, TUPLE]] is
			-- Actions to be performed for `confirm_dialog'.
		do
			create Result.make (1, 2)
			Result.put (agent import_action, 1)
			Result.put (agent abort_import_action, 2)
		ensure
			filled_array: Result @ 1 /= Void and Result @ 2 /= Void
		end
	
	import_metrics (file_name: STRING) is
			-- Import metrics of archive `file'.
		do
			tool.manage.ev_list.wipe_out
			tool.manage.fill_ev_list (tool.manage.ev_list)
			if tool.manage.import.importable_metric_list /= Void and tool.manage.import.current_metric_list /= Void then
				tool.manage.import.importable_metric_list.wipe_out
				tool.manage.import.current_metric_list.wipe_out
			end
			tool.manage.import.on_import (file_name, archive_dialog)
			tool.manage.save_action
		end
		
		
feature -- Action

	execute is
			-- Display archive_dialog and reset needed fields.
		local
			x_pos, y_pos: INTEGER
		do
			x_pos := tool.development_window.window.x_position + 200
			y_pos := tool.development_window.window.y_position + 40
			if archive_dialog = Void then
				build_archive_dialog
			end
			archive_dialog.set_position (x_pos, y_pos)
			new_archive_field.remove_text
			update_archive_field.remove_text
			browse_archive_field.remove_text
			archive_dialog.show_modal_to_window (tool.development_window.window)
			tool.multi_column_list.do_nothing
			tool.resize_column_list_to_content (tool.multi_column_list)
		end

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

end -- class EB_METRIC_ARCHIVE_COMPARISON_CMD
