indexing
	description: "[
		Compliance checker report pane. Used to initialize checking and display a running report based on 
		user selected options.		
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_CHECK_REPORT_PANE

inherit
	EC_CHECK_REPORT_PANE_IMP
	
	EC_SHARED_PROJECT
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
		end
		
	EC_DIALOG_PROMPT_HELPER
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
		end	
		
	AR_SHARED_SUBSCRIBER
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
		end	
		
	REFACTORING_HELPER
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
		end
		
	EV_KEY_CONSTANTS
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
		end	
		
	EV_SHARED_APPLICATION
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
		end			

feature {NONE} -- Initialization

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			l_grid: like grid_output
			l_column: EV_GRID_COLUMN
			l_header: EV_GRID_HEADER
			l_grid_processor: EV_GRID_DEFAULT_UI_PROCESSOR
		do

			--| `grid_output'
			l_grid := grid_output
			l_grid.set_column_count_to (4)
			l_grid.enable_multiple_row_selection
			
			l_grid.set_row_height (20)
			
			l_column := l_grid.column (1)
			l_column.set_title (label_type_feature)
			
			l_column := l_grid.column (2)
			l_column.header_item.align_text_center
			l_column.set_title (label_eiffel_compliant)
			l_column.set_width (50)
			
			l_column := l_grid.column (3)
			l_column.header_item.align_text_center
			l_column.set_title (label_cls_compliant)
			l_column.set_width (50)
			
			l_column := l_grid.column (4)
			l_column.header_item.align_text_center
			l_column.set_title (label_marked)
			l_column.set_width (50)
			
			l_grid.enable_selection_key_handling
			l_grid.enable_column_separators
			l_grid.enable_row_separators
			l_grid.set_separator_color ((create {EV_STOCK_COLORS}).grey)
			
				-- Disable user resizing of header items
			from
				l_header := l_grid.header
				l_header.start
			until
				l_header.after
			loop
				l_header.item.disable_user_resize
				l_header.forth
			end
			
			l_grid.enable_tree
			l_grid.row_expand_actions.extend (agent on_grid_row_expanded)
			
			l_grid.resize_actions.extend (agent on_resize_grid_output)
			l_grid.virtual_size_changed_actions.extend (agent on_resize_grid_output (0, 0, ?, ?))
			
			create l_grid_processor.make (l_grid)
			
			btn_export.select_actions.extend (agent on_export_selected)
			btn_start_checking.select_actions.extend (agent on_check_selected)
			chk_show_all.select_actions.extend (agent on_show_all_selected)
		end

feature -- Access

	owner_window: EC_MAIN_WINDOW assign set_owner_window
			-- Owner window

feature -- Element change

	set_owner_window (an_owner_window: like owner_window) is
			-- Set `owner_window' to `an_owner_window'.
		require
			owner_window_not_set: owner_window = Void
		local
			l_accelerator: EV_ACCELERATOR
		do
			owner_window := an_owner_window
			
			create l_accelerator.make_with_key_combination (create {EV_KEY}.make_with_code (key_c), True, False, False)
			l_accelerator.actions.extend (agent on_copy_selected)
			an_owner_window.accelerators.extend (l_accelerator)
		ensure
			owner_window_assigned: owner_window = an_owner_window
		end

feature {NONE} -- Agent Handlers

	on_resize_grid_output (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Called when report output (`grid_output') is resized.
		do
			resize_first_column
		end
		
	on_perform_layout (a_item: EV_GRID_LABEL_ITEM; a_layout: EV_GRID_LABEL_ITEM_LAYOUT) is
			-- Called when report grid shows a check item in a cell.
		do
			if a_item.column.index > 1 then
				a_layout.set_pixmap_y (((a_item.height - a_item.pixmap.height - a_item.top_border - a_item.bottom_border) // 2) + a_item.top_border)	
				a_layout.set_pixmap_x (((a_item.width - a_item.pixmap.width - a_item.left_border - a_item.right_border) // 2) + a_item.left_border)	
			end
		end
		
	on_grid_row_expanded (a_row: EV_GRID_ROW) is
			-- Called when a row in `grid_output' has been expanded'
		require
			a_row_not_void: a_row /= Void
		local
			l_data: EC_REPORT_TYPE
			l_show_all: BOOLEAN
			l_show_cls: BOOLEAN
			l_add: BOOLEAN
			l_members: LIST [EC_REPORT_MEMBER]
			l_member: EC_REPORT_MEMBER
			l_checked_member: EC_CHECKED_MEMBER
		do
			if a_row.subrow_count = 0 then
				l_show_all := report_all
				if not l_show_all then
					l_show_cls := report_non_cls_compliant
				end
				
				l_data ?= a_row.data
				if l_data /= Void then	
					l_members := l_data.members
					from
						l_members.start
					until
						l_members.after
					loop
						l_member := l_members.item
						l_checked_member := l_member.member
						l_add := l_show_all
						if not l_add then
							if l_show_cls then
								l_add := not l_checked_member.is_compliant or not l_checked_member.is_eiffel_compliant
							else
								l_add := not l_checked_member.is_eiffel_compliant
							end				
						end
						if l_add then
							add_report_member_to_row (a_row, l_member)
						end
						l_members.forth
					end
				end
			end
		end
		
	on_export_selected is
			-- Called when user selects to export current report to file.
		require
			owner_window_not_void: owner_window /= Void
		local
			l_sfd: EV_FILE_SAVE_DIALOG
			l_exporter: EC_REPORT_EXPORTER
			l_file_name: STRING
			l_ext: STRING
		do
			create l_sfd.make_with_title (title_browse_export_file_name)
			l_sfd.filters.extend ([filter_xml_files, filter_name_xml_files])
			l_sfd.filters.extend ([filter_all_files, filter_name_all_files])
			l_sfd.show_modal_to_window (owner_window)
			l_file_name := l_sfd.file_name
			if l_file_name /= Void and then not l_file_name.is_empty then
				l_ext ?= l_sfd.filters.i_th (l_sfd.selected_filter_index).item (1)
				if not l_ext.is_equal ("*.*") then
					l_ext.prune_all_leading ('*')
					if l_file_name.count > l_ext.count then
						if not l_file_name.substring (l_file_name.count - (l_ext.count - 1), l_file_name.count).is_case_insensitive_equal (l_ext) then
							l_file_name.append (l_ext)
						end
					else
						l_file_name.append (l_ext)
					end
				end
				
				create l_exporter.make (report, report_non_cls_compliant, report_all)
				l_exporter.export_report (l_file_name)
				if not l_exporter.export_successful then
					show_error (error_export_failed, [l_exporter.last_error], owner_window)
				end
			end
		end
		
	on_check_selected is
			-- Called when user selects Check/Recheck/Cancel button (`btn_check')
		require
			owner_window_not_void: owner_window /= Void
		local
			l_assembly: ASSEMBLY
			l_file_name: STRING
			l_paths: LIST [STRING]
			l_cursor: CURSOR
			l_resolver: like checker_resolver
			retried: BOOLEAN
		do
			if not retried then
				if not is_checking then					
					l_file_name := project.assembly
					if not l_file_name.is_empty and then (create {RAW_FILE}.make (l_file_name)).exists then
							-- Add reference paths to resolver for loading assembly
						create l_resolver.make_with_name ("COMPLIANCE RESOLVER")
						l_resolver.add_resolve_path_from_file_name (project.assembly)
						l_paths := project.reference_paths
						if not l_paths.is_empty then
							l_cursor := l_paths.cursor
							from
								l_paths.start
							until
								l_paths.after
							loop
								l_resolver.add_resolve_path (l_paths.item)
								l_paths.forth
							end
							l_paths.go_to (l_cursor)
						end
						resolve_subscriber.subscribe ({APP_DOMAIN}.current_domain, l_resolver)
						checker_resolver := l_resolver
						
						l_assembly := {ASSEMBLY}.load_from (l_file_name)
						start_checking (l_assembly)
					else
						if not l_file_name.is_empty then
							show_error (error_could_not_find_assembly, [l_file_name], owner_window)	
						else
							show_error (error_assembly_not_specified, [], owner_window)	
						end
					end
				else
					stop_checking
				end				
			else
				if not is_checking then
					show_error (error_could_not_load_assembly, [l_file_name], owner_window)
				end
				checker_resolver := Void
			end
		rescue
			retried := True
			retry
		end
		
	on_show_all_selected is
			-- Called when user selects 'Show all' (`chk_show_all')
		require
			chk_show_all_not_void: chk_show_all /= Void
			chk_show_cls_compliant_not_void: chk_show_cls_compliant /= Void
		do
			if chk_show_all.is_selected then
				chk_show_cls_compliant.disable_sensitive
			else
				chk_show_cls_compliant.enable_sensitive
			end
		end

	on_copy_selected is
			-- Called when user presses CTRL+C
		require
			grid_output_not_void: grid_output /= Void
		local
			l_rows: ARRAYED_LIST [EV_GRID_ROW]
			l_row: EV_GRID_ROW
			l_member: EC_REPORT_MEMBER
			l_type: EC_REPORT_TYPE
			l_item_string: STRING
			l_clip: STRING
			l_subrow_count: INTEGER
			l_expanded: BOOLEAN
			i: INTEGER
		do
			create l_clip.make (256)
			l_rows := grid_output.selected_rows
			if not l_rows.is_empty then
				from
					l_rows.start
				until
					l_rows.after
				loop
					l_row := l_rows.item
					l_type ?= l_row.data
					if l_type /= Void then
						l_item_string := format_clip_type (l_type.type)
						check
							l_item_string_not_void: l_item_string /= Void
						end
						l_clip.append (l_item_string)
	
						if l_type /= Void then
								-- Add items to grid row and add members of type
							on_grid_row_expanded (l_row)
							l_expanded := l_row.is_expanded
							from
								l_subrow_count := l_row.subrow_count
								i := 1
							until
								i > l_subrow_count
							loop
								if (not l_expanded) or else l_row.subrow (i).is_selected then
										-- Only add if either parent row is collapsed or 
										-- expanded item is selected.
									l_member ?= l_row.subrow (i).data
									check
										l_member_not_void: l_member /= Void
									end
									if l_member /= Void then
										l_item_string := format_clip_member (l_member.member)
										l_clip.append_character ('%N')
										l_clip.append (l_item_string)
									end
								end
			
								i := i + 1
							end
						end
					end
					
					l_rows.forth
					if l_type /= Void and then not l_rows.after then
						l_clip.append_character ('%N')	
					end
				end
			end
			ev_application.clipboard.set_text (l_clip)
		end

feature {NONE} -- Compliance Checking

	is_checking: BOOLEAN
			-- Is project being checked for compliance?
			
	checker: EC_CHECK_WORKER
			-- Compliance checker worker thread
			
	checker_resolver: AR_RESOLVER
			-- Assembly checker resolver.
			
	start_checking (a_assembly: ASSEMBLY) is
			-- Starte checking
		require
			a_assembly_not_void: a_assembly /= Void
			not_is_checking: not is_checking
			checker_is_void: checker = Void
			owner_window_not_void: owner_window /= Void
		local
			l_btn: like btn_start_checking
			l_builder: EC_REPORT_BUILDER
		do
			clear_report
			
			report_all := chk_show_all.is_selected
			report_non_cls_compliant := chk_show_cls_compliant.is_selected
			
				-- Change check button usage
			l_btn := btn_start_checking
			old_check_pixmap := l_btn.pixmap
			l_btn.set_text (button_cancel)
			l_btn.remove_pixmap
			
				-- Disable export button
			btn_export.disable_sensitive
			chk_show_all.disable_sensitive
			chk_show_cls_compliant.disable_sensitive
			
				-- Disable check toolbar button
			owner_window.tbtn_check.disable_sensitive
			
			is_checking := True
			
			create sync_actions.make
			
				-- Create and launch worker thread		
			create l_builder.make (a_assembly)
			report := l_builder.report
			l_builder.type_report_added_actions.extend (agent on_type_report_added)
			l_builder.percentage_completed_changed_actions.extend (agent on_report_percentage_changed)
			l_builder.report_completed_actions.extend (agent on_report_completed)
			create checker.make (a_assembly, l_builder)
			checker.launch
						
		ensure
			is_checking: is_checking
			report_not_void: report /= Void
		end
		
	stop_checking is
			-- Stops current checking session
		require
			is_checking: is_checking
			checker_not_void: checker /= Void
			owner_window_not_void: owner_window /= Void
			grid_output_not_void: grid_output /= Void
			chk_show_cls_compliant_not_void: chk_show_cls_compliant /= Void
			btn_export_not_void: btn_export /= Void
		local
			l_btn: like btn_start_checking
			l_pixmap: like old_check_pixmap
		do
				-- Restore check button usage
			l_btn := btn_start_checking
			l_btn.set_text (button_recheck)
			l_pixmap := old_check_pixmap
			if l_pixmap /= Void then
				l_btn.set_pixmap (l_pixmap)	
			end
			
				-- Enable export button
			if grid_output.row_count > 0 then
				btn_export.enable_sensitive	
			end
			chk_show_all.enable_sensitive
			if not chk_show_all.is_selected then
				chk_show_cls_compliant.enable_sensitive	
			end
			
				-- Enable check toolbar button
			owner_window.tbtn_check.enable_sensitive
			
			is_checking := False
			
				-- Stop checker
			if not checker.should_stop then
				checker.stop_checking	
			end
			
			checker := Void
			old_check_pixmap := Void
		ensure
			not_is_checking: not is_checking
			checker_is_void: checker = Void
		end
		
	on_type_report_added (a_type: EC_REPORT_TYPE) is
			-- Called when a type report has been generated by a report builder
		require
			a_type_not_void: a_type /= Void
			sync_actions_attached: sync_actions /= Void
		do
			sync_actions.extend (agent on_type_report_added_idle (a_type))
		end
		
	on_type_report_added_idle (a_type: EC_REPORT_TYPE) is
			-- Thread-safe: Called when a type report has been generated by a report builder
		require
			a_type_not_void: a_type /= Void
		local
			l_add: BOOLEAN
			l_checked_type: EC_CHECKED_TYPE
			l_checked_ab_type: EC_CHECKED_ABSTRACT_TYPE
			l_show_cls: BOOLEAN
			l_members: LIST [EC_REPORT_MEMBER]
			l_member: EC_CHECKED_MEMBER
			l_cursor: CURSOR
		do
			ev_application.idle_actions.block
			
			l_checked_type := a_type.type
			l_show_cls := report_non_cls_compliant
			if report_all then
				l_add := True
			end
			if not l_add then
				if l_show_cls then
					l_add := not l_checked_type.is_compliant or not l_checked_type.is_eiffel_compliant
					if not l_add then
						l_checked_ab_type ?= l_checked_type
						if l_checked_ab_type /= Void then
							l_add := not l_checked_ab_type.is_compliant_interface or not l_checked_ab_type.is_eiffel_compliant_interface
						end
					end
				else
					l_add := not l_checked_type.is_eiffel_compliant
					if not l_add then
						l_checked_ab_type ?= l_checked_type
						if l_checked_ab_type /= Void then
							l_add := not l_checked_ab_type.is_eiffel_compliant_interface
						end
					end
				end				
			end
			if not l_add then
					-- Check members
				l_members := a_type.members
				l_cursor := l_members.cursor
				from
					l_members.start
				until
					l_members.after or l_add
				loop
					l_member := l_members.item.member
					if l_show_cls then
						l_add := not l_member.is_compliant or not l_member.is_eiffel_compliant
					else
						l_add := not l_member.is_eiffel_compliant
					end	
					l_members.forth
				end
				l_members.go_to (l_cursor)
			end

			if l_add then
				add_type_report_row (a_type)
			end
			
			ev_application.idle_actions.resume
		end

	on_report_percentage_changed (a_percent: NATURAL_8) is
			-- Called when `report' percent completion changes
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			a_precent_small_enough: a_percent <= 100
			sync_actions_attached: sync_actions /= Void
		do
			sync_actions.extend (agent on_report_percentage_changed_idle (a_percent))
		end
		
	on_report_percentage_changed_idle (a_percent: NATURAL_8) is
			-- Thread-safe: Called when `report' percent completion changes
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			a_precent_small_enough: a_percent <= 100
		do
			ev_application.idle_actions.block
			prg_check.set_value (a_percent)
			ev_application.idle_actions.resume
		end

	on_report_completed (a_complete: BOOLEAN) is
			-- Called when `report' has completed, called by worker thread.
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			sync_actions_attached: sync_actions /= Void
		do
			sync_actions.extend (agent on_report_completed_idle (a_complete))
		end
		
	on_report_completed_idle (a_complete: BOOLEAN) is
			-- Called when `report' has completed, called by the UI thread.
		require
			owner_window_not_void: owner_window /= Void
			grid_output_not_void: grid_output /= Void
		local
			l_actions: EV_NOTIFY_ACTION_SEQUENCE
			l_grid: like grid_output
			l_exception: NATIVE_EXCEPTION
			l_reflection_type_load_exception: REFLECTION_TYPE_LOAD_EXCEPTION
			l_file_not_found_exception: FILE_NOT_FOUND_EXCEPTION
		do
			l_actions := ev_application.idle_actions
			l_actions.block
			l_actions.wipe_out
			if is_checking then
				stop_checking
				l_grid := grid_output
				if a_complete then
					if l_grid.row_count > 0 then
						show_information (question_check_completed, [], owner_window)
					else	
						show_information (information_no_non_compliant_member, [], owner_window)
					end
				end
				l_grid.set_focus
				resolve_subscriber.unsubscribe ({APP_DOMAIN}.current_domain, checker_resolver)
				checker_resolver := Void
				sync_actions.dispose
				sync_actions := Void
			end
			if not a_complete then
					-- There was an error
				l_exception := {ISE_RUNTIME}.last_exception
				l_reflection_type_load_exception ?= l_exception
				if l_reflection_type_load_exception /= Void then
					l_file_not_found_exception ?= l_reflection_type_load_exception.loader_exceptions @ 0
				end
				if l_file_not_found_exception /= Void then
					show_error (error_could_not_load_assembly, [l_file_not_found_exception.file_name], owner_window)
				else
					show_error (error_report_generation_failed, [l_exception.message], owner_window)
				end
			end
			l_actions.resume
		end		

feature {NONE} -- Report Row Building
	
	add_type_report_row (a_report_type: EC_REPORT_TYPE) is
			-- Add a row for `a_checked_type'
			-- `a_report_type' id added as grid row data
		require
			a_report_type_not_void: a_report_type /= Void
			grid_output_not_void: grid_output /= Void
		local
			l_grid: like grid_output
			l_checked_type: EC_CHECKED_TYPE
			l_checked_abstact_type: EC_CHECKED_ABSTRACT_TYPE
			l_item: EV_GRID_LABEL_ITEM
			l_row: EV_GRID_ROW
			i: INTEGER
		do
			l_grid := grid_output
			i := l_grid.row_count + 1
			first_level_row_count := first_level_row_count + 1
			
			l_grid.lock_update
			l_grid.insert_new_row (i)
			l_row := l_grid.row (i)
			
			l_checked_type := a_report_type.type
			l_row.set_data (a_report_type)
			
			if (first_level_row_count \\ 2) = 0 then
				l_row.set_background_color (alt_row_background_color)
			else
				l_row.set_background_color (row_background_color)
			end
			l_row.ensure_expandable
			
			l_checked_abstact_type ?= l_checked_type
			
				-- Name
			create l_item.make_with_text (l_checked_type.type.full_name)
			l_item.set_tooltip (l_item.text)
			l_row.set_item (1, l_item)
			
				-- Is Eiffel-compliant
			create l_item
			if l_checked_type.is_eiffel_compliant then
				if l_checked_abstact_type = Void or else l_checked_abstact_type.is_eiffel_compliant_interface then
					l_item.set_pixmap (icon_check)
					l_item.set_tooltip (tooltip_type_is_eiffel_compliant)
				else
					l_item.set_pixmap (icon_caution)
					l_item.set_tooltip (tooltip_interface_illegally_compliant)
				end
			else
				l_item.set_pixmap (icon_cross)
				l_item.set_tooltip (l_checked_type.non_eiffel_compliant_reason)
			end
			l_item.set_layout_procedure (layout_agent)
			l_row.set_item (2, l_item)
			
				-- Is CLS-compliant
			create l_item
			if l_checked_type.is_compliant then
				if l_checked_abstact_type = Void or else l_checked_abstact_type.is_compliant_interface then
					l_item.set_pixmap (icon_check)
					l_item.set_tooltip (tooltip_type_is_cls_compliant)
				else
					l_item.set_pixmap (icon_caution)
					l_item.set_tooltip (tooltip_interface_illegally_compliant)
				end
			else
				l_item.set_pixmap (icon_cross)
				l_item.set_tooltip (l_checked_type.non_compliant_reason)
			end
			l_item.set_layout_procedure (layout_agent)
			l_row.set_item (3, l_item)
			
				-- Is marked compliant
			create l_item
			if l_checked_type.is_marked then
				l_item.set_pixmap (icon_check)	
				l_item.set_tooltip (tooltip_type_is_marked)
			else
				l_item.set_pixmap (icon_cross)
				l_item.set_tooltip (tooltip_type_is_not_marked)
			end
			l_item.set_layout_procedure (layout_agent)
			
			l_row.set_item (4, l_item)
			if l_row.index = 1 then
				l_row.enable_select
			end
			l_grid.unlock_update
		end
		
	add_report_member_to_row (a_row: EV_GRID_ROW; a_report_member: EC_REPORT_MEMBER) is
			-- Add a row for report `a_report_member'
		require
			a_row_not_void: a_row /= Void
			a_report_member_not_void: a_report_member /= Void
			grid_output_not_void: grid_output /= Void
		local
			l_grid: like grid_output		
			l_checked_member: EC_CHECKED_MEMBER
			l_row: EV_GRID_ROW
			l_item: EV_GRID_LABEL_ITEM
			i: INTEGER
		do	
			l_grid := grid_output
			l_row := a_row
			i := l_row.subrow_count + 1
			
			l_grid.lock_update
			
			l_row.insert_subrow (i)
			l_row := l_row.subrow (i)
			l_row.set_data (a_report_member)
			
			l_checked_member := a_report_member.member
			
				-- Add items to row
				-- Name
			create l_item.make_with_text (report_formatter.format_member (l_checked_member.member, False))
			l_item.set_tooltip (l_item.text)
			l_row.set_item (1, l_item)
			
				-- Is Eiffel-compliant
			create l_item
			if l_checked_member.is_eiffel_compliant then
				l_item.set_pixmap (icon_check)
				l_item.set_tooltip (tooltip_member_is_eiffel_compliant)
			else
				l_item.set_pixmap (icon_cross)
				l_item.set_tooltip (l_checked_member.non_eiffel_compliant_reason)
			end
			l_item.set_layout_procedure (layout_agent)
			l_row.set_item (2, l_item)
			
				-- Is CLS-compliant
			create l_item
			if l_checked_member.is_compliant then
				l_item.set_pixmap (icon_check)	
				l_item.set_tooltip (tooltip_member_is_cls_compliant)
			else
				l_item.set_pixmap (icon_cross)
				l_item.set_tooltip (l_checked_member.non_compliant_reason)
			end
			l_item.set_layout_procedure (layout_agent)
			l_row.set_item (3, l_item)
			
				-- Is marked compliant
			create l_item
			if l_checked_member.is_marked then
				l_item.set_pixmap (icon_check)	
				l_item.set_tooltip (tooltip_member_is_marked)
			else
				l_item.set_pixmap (icon_cross)
				l_item.set_tooltip (tooltip_member_is_not_marked)
			end
			l_item.set_layout_procedure (layout_agent)
			l_row.set_item (4, l_item)
			
			l_grid.unlock_update
		end		

	row_background_color: EV_COLOR is
			-- Alternative row background color.
		once
			create Result.make_with_8_bit_rgb (230, 230, 255)
		ensure
			result_not_void: Result /= Void
		end	
		
	alt_row_background_color: EV_COLOR is
			-- Alternative row background color.
		once
			create Result.make_with_8_bit_rgb (248, 248, 248)
		ensure
			result_not_void: Result /= Void
		end	
		
	bad_row_background_color: EV_COLOR is
			-- Alternative row background color.
		once
			create Result.make_with_8_bit_rgb (230, 0, 0)
		ensure
			result_not_void: Result /= Void
		end	
		
	bad_alt_row_background_color: EV_COLOR is
			-- Alternative row background color.
		once
			create Result.make_with_8_bit_rgb (248, 0, 0)
		ensure
			result_not_void: Result /= Void
		end	
					
	first_level_row_count: INTEGER
			-- First level row count

feature {EC_MAIN_WINDOW} -- Clean Up

	reset_report is
			-- Reset report interface
		require
			grid_output_not_void: grid_output /= Void
			btn_export_not_void: btn_export /= Void
			prg_check_not_void: prg_check /= Void
			btn_start_checking_not_void: btn_start_checking /= Void
		local
			l_checker: like checker
		do
			if is_checking then
				l_checker := checker
				on_check_selected
				l_checker.join
			end
			clear_report
			prg_check.set_value (0)
			btn_start_checking.set_text (button_check)
		end

feature {NONE} -- Formatting

	format_clip_type (a_type: EC_CHECKED_TYPE): STRING is
			-- Formats type `a_type' to a single STRING for clipboard.
		require
			a_type_not_void: a_type /= Void
		local
			l_ab_type: EC_CHECKED_ABSTRACT_TYPE
		do
			create Result.make (256)
			Result.append ("Type%T")
			Result.append (report_formatter.format_member (a_type.type, True))
			Result.append_character ('%T')
			
			l_ab_type ?= a_type
			
			if a_type.is_eiffel_compliant then
				if l_ab_type = Void or else l_ab_type.is_eiffel_compliant_interface then
					Result.append (eiffel_compliant_string)
				else
					Result.append (non_eiffel_compliant_string)
					Result.append (l_ab_type.non_eiffel_compliant_interface_reason)
				end
			else
				Result.append (non_eiffel_compliant_string)
				Result.append (a_type.non_eiffel_compliant_reason)
			end			

			Result.append_character ('%T')
			
			if a_type.is_compliant then
				if l_ab_type = Void or else l_ab_type.is_compliant_interface then
					Result.append (compliant_string)
				else
					Result.append (non_compliant_string)
					Result.append (l_ab_type.non_compliant_interface_reason)
				end
			else
				Result.append (non_compliant_string)
				Result.append (a_type.non_compliant_reason)
			end	
			Result.append_character ('%T')
			
			if a_type.is_marked then
				Result.append (marked_string)	
			else
				Result.append (not_marked_string)
			end
		ensure
			result_not_void: Result /= Void
		end

	format_clip_member (a_member: EC_CHECKED_MEMBER): STRING is
			-- Formats member `a_member' to a single STRING for clipboard.
		require
			a_member_not_void: a_member /= Void
		do
			create Result.make (256)
			Result.append ("Member%T")
			Result.append (report_formatter.format_member (a_member.member, True))
			Result.append_character ('%T')
			
			if a_member.is_eiffel_compliant then
				Result.append (eiffel_compliant_string)	
			else
				Result.append (non_eiffel_compliant_string)
				Result.append (a_member.non_eiffel_compliant_reason)
			end
			Result.append_character ('%T')
			
			if a_member.is_compliant then
				Result.append (compliant_string)	
			else
				Result.append (non_compliant_string)
				Result.append (a_member.non_compliant_reason)
			end
			Result.append_character ('%T')
			
			if a_member.is_marked then
				Result.append (marked_string)	
			else
				Result.append (not_marked_string)
			end
		ensure
			result_not_void: Result /= Void
		end
		
	illegaly_cls_compliant_string: STRING is "Illegal: "
	compliant_string: STRING is "CLS-Compliant"
	non_compliant_string: STRING is "Not CLS-Compliant: "
	eiffel_compliant_string: STRING is "Eiffel-Compliant"
	non_eiffel_compliant_string: STRING is "Not Eiffel-Compliant: "
	marked_string: STRING is "Marked with ClsCompliantAttribute"
	not_marked_string: STRING is "Not marked with ClsCompliantAttribute"

feature {NONE} -- Implementation

	clear_report is
			-- Clears data in `grid_output'
		require
			grid_output_not_void: grid_output /= Void
			btn_export_not_void: btn_export /= Void
		do
			if grid_output.row_count > 0 then
				grid_output.remove_rows (1, grid_output.row_count)
				first_level_row_count := 0
			end
			report := Void
			btn_export.disable_sensitive
		end
		
	resize_first_column is
			-- Resizes first column to fit grid space.
		require
			grid_output_not_void: grid_output /= Void
		local
			l_grid: like grid_output
			l_gap: INTEGER
			l_width: INTEGER
		do
			l_grid := grid_output
			l_grid.virtual_size_changed_actions.block
			l_grid.resize_actions.block
			l_gap := l_grid.column (2).width + l_grid.column (3).width + l_grid.column (4).width + 1
			l_width := l_grid.viewable_width - l_gap
			if l_width > 0 then
				l_grid.column (1).set_width (l_width)	
			end
			l_grid.virtual_size_changed_actions.resume
			l_grid.resize_actions.resume
		end
		
	project_assembly: ASSEMBLY is
			-- Retrieves assembly from project settings
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := {ASSEMBLY}.load_from (project.assembly)
			end
		rescue
			retried := True
			retry
		end
	
	old_check_pixmap: EV_PIXMAP
			-- old `btn_check' pixmap

	layout_agent: PROCEDURE [ANY, TUPLE [EV_GRID_LABEL_ITEM, EV_GRID_LABEL_ITEM_LAYOUT]] is
			-- 
		once
			Result := agent on_perform_layout
		ensure
			result_not_void: Result /= Void
		end
		
	report_formatter: EC_CHECK_REPORT_FORMATTER is
			-- Report item formatter
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end
		
	report: EC_REPORT
			-- Report generated
			
	report_all: BOOLEAN
			-- Should report include all assembly types and members?
	
	report_non_cls_compliant: BOOLEAN
			-- Should report include all non-CLS-compliant types and members?
			
			
	sync_actions: EC_REPORT_QUEUED_ACTION_TIMER
			-- Thread-safe action timer.
			
		
invariant
	owner_window_not_void: owner_window /= Void

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
end -- class EC_CHECK_REPORT_PANE

