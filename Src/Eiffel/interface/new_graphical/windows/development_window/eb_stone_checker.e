note
	description: "Stone checker used by EB_DEVELOPMENT_WINDOW."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_STONE_CHECKER

inherit
	ANY

	CONF_ACCESS

	SHARED_TEXT_ITEMS
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initlization

	make (a_window: EB_DEVELOPMENT_WINDOW)
			-- Creation method.
		require
			not_void: a_window /= Void
		do
			develop_window := a_window
			managed_main_formatters := develop_window.managed_main_formatters
		ensure
			set: develop_window = a_window
		end

feature -- Command

	set_stone_after_first_check (a_stone: STONE)
			-- Display text associated with `a_stone', if any and if possible
		require
			a_stone_attached: a_stone /= Void
		local
			l_warning: ES_DISCARDABLE_WARNING_PROMPT
			l_window_list: LIST [EB_DEVELOPMENT_WINDOW]
		do
			if a_stone /= Void then
				if attached {CLASSI_STONE} a_stone as l_class_i_stone then
					l_window_list := Window_manager.development_windows_with_class (l_class_i_stone.class_i)
					if l_window_list.is_empty or else l_window_list.has (develop_window) then
							-- We're not editing the class in another window.
						set_stone_after_first_check_internal (a_stone)
					else
						create l_warning.make_standard (warning_messages.w_class_already_edited, "", create {ES_BOOLEAN_PREFERENCE_SETTING}.make (preferences.dialog_data.already_editing_class_preference, True))
						l_warning.set_button_action (l_warning.dialog_buttons.ok_button, agent set_stone_after_first_check_internal (a_stone))
						l_warning.show (develop_window.window)
					end
				else
					set_stone_after_first_check_internal (a_stone)
				end
			end
		end

feature {NONE} -- Implementation functions

	set_stone_after_first_check_internal (a_stone: STONE)
			-- Display text associated with `a_stone', if any and if possible
		require
			a_stone_attached: a_stone /= Void
		local
			l_dev_window_stone: detachable STONE
			l_editors_manager: EB_EDITORS_MANAGER
			l_editor_displayer: EB_FORMATTER_EDITOR_DISPLAYER
			l_test_stone: CLASSI_STONE
					-- Text stone if exist.
			l_same_class: BOOLEAN
					-- If old stone and new stone are same class?
			l_new_class_stone: detachable CLASSI_STONE
					-- New class stone if exist.
			l_editor: detachable EB_SMART_EDITOR
					-- Editor related if exist.
			save_needed: BOOLEAN;
					-- If save file needed?
			l_text_formatter: EB_CLASS_TEXT_FORMATTER
		do
			l_dev_window_stone := develop_window.stone
			l_editors_manager := develop_window.editors_manager
			l_editor := l_editors_manager.editor_with_stone (a_stone)

			if l_editor /= Void then
				l_editors_manager.editor_switched_actions.block
				if
					not has_error_when_error_tool_auto_hide and then
					attached l_editor.docking_content as l_docking_content and then
					l_docking_content.is_docking_manager_attached
				then
					l_docking_content.set_focus_no_maximized (l_docking_content.user_widget)
				end
				l_editors_manager.editor_switched_actions.resume
			else
				if l_editors_manager.editor_count = 0 then
						-- FIXME: remove the following line if we really decided we can have Void editor
					l_editors_manager.create_editor
					l_editors_manager.last_created_editor.docking_content.set_focus
				end
			end

			if l_editor = Void then
				save_needed := True
			end


			if attached {CLASSI_STONE} a_stone as st then
				l_new_class_stone := st
			else
				l_new_class_stone := Void
			end


				-- Update the history.
				-- If it is not cancelled, we set it back in EB_STONE_CHECKER
			develop_window.set_history_moving_cancelled (True)
			if
				not attached {BREAKABLE_STONE} a_stone as l_conv_brkstone and
				not attached {ERROR_STONE} a_stone as l_conv_errst
			then
				if l_new_class_stone /= Void then
					develop_window.history_manager.extend (l_new_class_stone)
				elseif attached {CLUSTER_STONE} a_stone as l_cluster_st then
					develop_window.history_manager.extend (l_cluster_st)
				end
			end

				-- Refresh editor in main formatters.			
			if attached l_editors_manager.current_editor as l_curr_editor then
				create l_editor_displayer.make (l_curr_editor)
				across
					develop_window.managed_main_formatters as ic_managed_main_formatters
				loop
					l_text_formatter := ic_managed_main_formatters.item
					l_text_formatter.set_editor_displayer (l_editor_displayer)
					l_text_formatter.set_should_displayer_be_recycled (True)
				end
			end

			if attached {CLASSI_STONE} l_dev_window_stone as l_old_class_stone then
				create l_test_stone.make (l_old_class_stone.class_i)
				l_same_class := l_test_stone.same_as (a_stone)
					-- We need to compare classes. If `l_old_class_stone' is a FEATURE_STONE
					-- `same_as' will compare features. Therefore, we need `l_test_stone' to be sure
					-- we have a CLASSI_STONE.
				if
					l_same_class and then
					attached {FEATURE_STONE} a_stone as l_feature_stone
				then
					l_same_class := False
						-- if the stone corresponding to a feature of currently opened class is dropped
						-- we attempt to scroll to the feature without asking to save the file
						-- except if it is during a resynchronization, in which case we do not scroll at all.
					if not develop_window.is_text_loaded and then not develop_window.during_synchronization then
							-- TODO: maybe time to implement scroll_to_stone [2017-04-15].
						if attached {ACCESS_ID_STONE} l_feature_stone as l_access_id_stone then
							develop_window.scroll_to_ast (l_access_id_stone.ast, l_access_id_stone.class_i, False)
						else
							develop_window.scroll_to_feature (l_feature_stone.e_feature, l_new_class_stone.class_i)
						end
						develop_window.set_feature_stone_already_processed (True)
					else
						develop_window.set_feature_stone_already_processed (False)
					end
					if
						develop_window.feature_stone_already_processed and
						attached {FEATURE_ERROR_STONE} l_feature_stone as l_conv_ferrst
					then
							-- Scroll to the line of the error.
						if
							not develop_window.during_synchronization and then
							attached l_editors_manager.current_editor as l_curr_editor
						then
							l_curr_editor.display_line_when_ready (l_conv_ferrst.line_number, 0, True)
						end
					end
				end
			end

				-- first, let's check if there is already something in this window
				-- if there's nothing, there's no need to save anything...
			if l_dev_window_stone = Void or else not develop_window.changed or else develop_window.feature_stone_already_processed or else l_same_class then
				set_stone_after_check (a_stone)
				develop_window.set_feature_stone_already_processed (False)
			else
					-- there is something to be saved
					-- if user chooses to save, current file will be parsed
					-- if there is a syntax_error, new file is not loaded
				if save_needed then
					develop_window.save_and (agent set_stone_after_check (a_stone))
				else
					set_stone_after_check (a_stone)
				end
				if develop_window.text_saved and then not develop_window.syntax_is_correct then
					develop_window.set_text_saved (False)
					develop_window.set_during_synchronization (True)
					set_stone_after_check (develop_window.stone)
					develop_window.set_during_synchronization (False)
					develop_window.address_manager.refresh
				end
			end

			if l_editors_manager.current_editor /= Void and then not l_editors_manager.current_editor.has_focus and then not has_error_when_error_tool_auto_hide then
				develop_window.ev_application.do_once_on_idle (agent develop_window.set_focus_to_main_editor)
			end
		end

	set_stone_after_check (a_stone: STONE)
			-- First we check `a_stone' then we set stone if possible.
		require
			a_stone_attached: a_stone /= Void
		local
			l_current_window: detachable EV_WIDGET
			l_old_cursor: EV_POINTER_STYLE
		do
				-- The text does not change if the text was saved with syntax errors
			l_current_window := develop_window.window
				-- Only change the cursor in the event it is a different stone object.
			if
				l_current_window /= Void and then
				develop_window.stone /= a_stone
			then
				l_old_cursor := l_current_window.pointer_style
				l_current_window.set_pointer_style ((create {EV_STOCK_PIXMAPS}).Wait_cursor)
			end

			prepare (a_stone)

				-- History moving is not going to be cancelled.
			develop_window.set_history_moving_cancelled (False)

			handle_break_error_ace_external_file_stone (a_stone)
			if
				develop_window.stone /= Void and then
				not develop_window.is_unified_stone
			then
				develop_window.commands.send_stone_to_context_cmd.enable_sensitive
			else
				develop_window.commands.send_stone_to_context_cmd.disable_sensitive
			end
			if l_current_window /= Void and l_old_cursor /= Void then
				l_current_window.set_pointer_style (l_old_cursor)
			end
			develop_window.update_viewpoints
		end

	has_error_when_error_tool_auto_hide: BOOLEAN
			-- When project has errors and Errors Tools is auto hiding, we should not set focus to editor.
			-- Otherwise the Errors Tools sliding panel will be removed automatically, because it doesn't has focus.
			-- See bug#12765.
		local
			l_tool: ES_TOOL [EB_TOOL]
		do
			l_tool := develop_window.shell_tools.tool ({ES_ERROR_LIST_TOOL})
			if l_tool /= Void and then not l_tool.is_recycled and then l_tool.docking_content /= Void then
				Result := (l_tool.docking_content.state_value = {SD_ENUMERATION}.auto_hide) and (not develop_window.eiffel_project.successful)
			end
		end

	prepare (a_stone: STONE)
			-- Try to assign different kinds of stones.
		local
			l_editor: like current_editor
		do
			old_class_stone ?= develop_window.stone
			develop_window.old_set_stone (a_stone)
			text_loaded := develop_window.is_text_loaded
			prevent_duplicated_editor (a_stone)
			l_editor := current_editor
			if l_editor /= Void then
				l_editor.set_stone (a_stone)
			end

			conv_brkstone ?= a_stone
			conv_errst ?= a_stone

			target_stone ?= a_stone

			cluster_st ?= a_stone
			new_class_stone ?= a_stone
			ast_stone ?= a_stone
			line_stone ?= a_stone

				-- Refresh editor in stone.
			refresh_all_tabs (a_stone)

		end

	prevent_duplicated_editor (a_stone: STONE)
			-- To prevent duplicated editor
			-- Make sure no existing editor has `a_stone', otherwise change `current_editor' to the editor with `a_stone'
		do
			if
				attached develop_window.editors_manager.editor_with_stone (a_stone) as l_editor_with_stone and then
				l_editor_with_stone /= current_editor
			then
				develop_window.editors_manager.select_editor (l_editor_with_stone, True)
			end
		end

	handle_break_error_ace_external_file_stone (a_stone: STONE)
			-- Handle `conv_brkstone', `conv_errst', and `target_stone' if exist.
		local
			bpm: BREAKPOINTS_MANAGER
		do
			if attached conv_brkstone as l_conv_brkstone then
				bpm := develop_window.Debugger_manager.breakpoints_manager
				if bpm.is_breakpoint_enabled (l_conv_brkstone.routine, l_conv_brkstone.index) then
					bpm.remove_user_breakpoint (l_conv_brkstone.routine, l_conv_brkstone.index)
				else
					bpm.set_user_breakpoint (l_conv_brkstone.routine, l_conv_brkstone.index)
				end
				bpm.notify_breakpoints_changes
			elseif attached target_stone as tgt_stone and then tgt_stone.is_valid then
				handle_target_stone (tgt_stone)
			else
				handle_all_class_stones (a_stone)
			end
		end

	handle_target_stone (a_target_stone: TARGET_STONE)
			-- Handle TARGET_STONE
		local
			s: STRING_32
		do
			develop_window.tools.properties_tool.set_stone (a_target_stone)

				-- Update the title of the window
			if a_target_stone /= Void then
				if develop_window.changed then
					create s.make_from_string_general (a_target_stone.header)
					s.prepend_character (' ')
					s.prepend_character ('*')
					develop_window.set_title (s)
				else
					develop_window.set_title (a_target_stone.header)
				end
			else
				develop_window.set_title (develop_window.Interface_names.t_empty_development_window)
			end
		end

	handle_all_class_stones (a_stone: detachable STONE)
			-- Handle all class stones.
			-- `a_stone' can be new class stone or exists class stone.
		local
			s: STRING_32
		do
			develop_window.commands.new_feature_cmd.disable_sensitive

				-- We update the state of the `Add to Favorites' command.
			if new_class_stone /= Void then
				develop_window.menus.favorites_menu.first.enable_sensitive
			else
				develop_window.menus.favorites_menu.first.disable_sensitive
			end

				-- Update the address manager if needed.
			develop_window.address_manager.refresh
			check_new_class_stone (a_stone)
			handle_class_stone (a_stone)
				-- Update the title of the window
			if a_stone /= Void then
				if develop_window.changed then
					create s.make_from_string (a_stone.header.as_string_32)
					s.prepend_character (' ')
					s.prepend_character ('*')
					develop_window.set_title (s)
				else
					develop_window.set_title (a_stone.header.as_string_32)
				end
			else
				develop_window.set_title (develop_window.Interface_names.t_empty_development_window)
			end

				-- Refresh the tools.
			if
				attached {ES_STONABLE_I} develop_window.shell_tools.tool ({ES_FEATURES_TOOL}) as l_stonable and then
				l_stonable.is_stone_usable (a_stone)
			then
				l_stonable.set_stone_with_query (a_stone)
			end

				-- Use preference here to track editor.
--			if
--				attached {ES_STONABLE_I} develop_window.shell_tools.tool ({ES_GROUPS_TOOL}) as l_stonable and then
--				l_stonable.is_stone_usable (a_stone)
--			then
--				l_stonable.set_stone_with_query (a_stone)
--			end

				-- Update the context tool.
			if develop_window.is_unified_stone then
				develop_window.tools.set_stone (a_stone)
			end
		end

	check_new_class_stone (a_stone: STONE)
			-- Handle `a_stone' which is new class stone.
		do
			if attached new_class_stone as l_new_class_stone then
				if not develop_window.during_synchronization then
					develop_window.view_points_combo.set_conf_class (l_new_class_stone.class_i.config_class)
				end
					-- Text is now editable.
				if attached develop_window.editors_manager.current_editor as e then
					e.set_read_only (False)
				end

				if l_new_class_stone.is_valid then
					develop_window.tools.properties_tool.set_stone (l_new_class_stone)
				end

					-- class stone was dropped
				create class_file.make_with_path (l_new_class_stone.class_i.file_name)
				class_text_exists := class_file.exists
				feature_stone ?= a_stone
					--| We have to create a classi_stone to check whether the stones are really similar.
					--| Otherwise a redefinition of same_as may be called.
				create test_stone.make (l_new_class_stone.class_i)
				if test_stone.same_as (old_class_stone) then
					same_class := True
				end
				if not develop_window.feature_stone_already_processed then
					if same_class and then develop_window.text_saved then
							-- nothing changed in the editor
							-- we only have to update click_list
						if current_editor /= Void and then current_editor.is_editable then
							current_editor.update_click_list (False)
						end
					else
						if develop_window.changed then
								-- user has already chosen not to save the file
								-- do not ask again
							current_editor.no_save_before_next_load
						end
					end
				end

				conv_classc ?= l_new_class_stone

					-- First choose possible formatter
				possible_formater

				if text_loaded then
					across
						managed_main_formatters as ic
					loop
							--| Ted: Text might be changed
						ic.item.force_stone (a_stone)
						ic.item.refresh
					end
					if attached {like formatter} a_stone.pos_container as l_formatter then
						formatter := l_formatter
						l_formatter.enable_select
					else
						formatter := Void
					end
				end

				set_class_text_if_possible
				check_class_stone
				if attached current_editor as l_curr_editor then
					if not managed_main_formatters.first.selected then
						l_curr_editor.set_read_only (True)
					elseif attached new_class_stone as l_n_cl_st and then l_n_cl_st.class_i.is_read_only then
						l_curr_editor.set_read_only (True)
					end
				end

			else
				handle_cluster_stone
			end
		end

	handle_cluster_stone
			-- Handle cluster stone.
		do
				-- not a class text : cannot be edited
			if attached current_editor as curr_ed then
				curr_ed.set_read_only (True)
			end
			develop_window.address_manager.disable_formatters

			if attached cluster_st as l_cluster_st then
				if l_cluster_st.is_valid then
					develop_window.tools.properties_tool.set_stone (l_cluster_st)
				end
				if not text_loaded then
					if not develop_window.during_synchronization then
						develop_window.view_points_combo.set_conf_group (l_cluster_st.group)
					end
					formatted_context_for_group (l_cluster_st.group, l_cluster_st.path)
					if
						l_cluster_st.position > 0 and then
						attached current_editor as curr_ed
					then
						curr_ed.display_line_at_top_when_ready (l_cluster_st.position, 0)
					end

				end
			end
		end

	possible_formater
			-- Do works for formatters.
		do
			if attached {like main_formatter} new_class_stone.pos_container as l_main_formatter then
				main_formatter := l_main_formatter
				if not develop_window.during_synchronization then
					if
						not (conv_classc /= Void and class_text_exists and (not develop_window.changed or not same_class))
					then
						l_main_formatter.enable_select
					elseif feature_stone = Void then
						if l_main_formatter /= develop_window.pos_container then
							l_main_formatter.enable_select
						end
						if
							attached current_editor as l_curr_ed and then
							not text_loaded and then
							new_class_stone.position > 0
						then
							l_curr_ed.display_line_at_top_when_ready (new_class_stone.position, 0)
						end
					end
				end
			else
				main_formatter := Void
			end
		end

	handle_class_stone (a_stone: STONE)
			-- Handle `a_stone' which is a class stone.
		local
			l_selection: TUPLE [pos_start, pos_end: INTEGER]
		do
			if class_text_exists or else dotnet_class then
				if attached ast_stone as l_ast_stone then
					if (not text_loaded or develop_window.is_dropping_on_editor) and not develop_window.during_synchronization then
						if not develop_window.managed_main_formatters.first.selected then
							select_basic_main_formatter
						end
						develop_window.scroll_to_ast (l_ast_stone.ast, l_ast_stone.class_i, l_ast_stone.is_for_feature_invocation)
					end
				elseif attached feature_stone as l_feature_stone and not develop_window.feature_stone_already_processed then  -- and not same_class then
					if attached {like conv_ferrst} l_feature_stone as l_conv_ferrst then
						conv_ferrst := l_conv_ferrst
 						error_line := conv_ferrst.line_number
					else
						conv_ferrst := Void
							-- if a feature_stone has been dropped
							-- scroll to the corresponding feature in the basic text format
						if (not text_loaded or develop_window.is_dropping_on_editor) and not develop_window.during_synchronization then
							develop_window.scroll_to_feature (l_feature_stone.e_feature, new_class_stone.class_i)
						end
					end
				elseif attached line_stone as l_line_stone then
					if (not text_loaded or develop_window.is_dropping_on_editor) and not develop_window.during_synchronization then
						if not develop_window.managed_main_formatters.first.selected then
							select_basic_main_formatter
						end
						l_selection := line_stone.selection
						if l_selection /= Void then
							develop_window.scroll_to_selection (l_selection, True)
						else
							develop_window.editors_manager.current_editor.scroll_to_start_of_line_when_ready (l_line_stone.line_number, l_line_stone.column_number, l_line_stone.should_line_be_selected)
						end
					end
				else
					if attached {like cl_syntax_stone} a_stone as l_cl_syntax_stone then
						cl_syntax_stone := l_cl_syntax_stone
						error_line := cl_syntax_stone.line
					else
						cl_syntax_stone := Void
 					end
				end
				if not text_loaded and then error_line > 0 then
						-- Scroll to the line of the error.
					if not develop_window.during_synchronization then
						if not develop_window.managed_main_formatters.first.selected then
							develop_window.managed_main_formatters.first.execute
							check
								new_class_stone_not_void: new_class_stone /= Void
							end
							if new_class_stone.class_i.is_read_only and then current_editor /= Void then
								 current_editor.set_read_only (True)
							end
						end
						if attached current_editor as l_current_editor then
							l_current_editor.display_line_when_ready (error_line, 0, True)
						end
					end
				end
			end
		end

	set_class_text_if_possible
			-- Call `set_class_text_for_class_stone' if possible.
		do
			if
				conv_classc = Void
				or else conv_classc.e_class.is_external
					or else	feature_stone /= Void and
					not	develop_window.feature_stone_already_processed and
					not	same_class
			then
					-- If a classi_stone or a feature_stone or a external call
					-- has been dropped, check to see if a .NET class.
				set_class_text_for_class_stone
			end
		end

	set_class_text_for_class_stone
			-- Set class texts for class stone.
		do
			if class_text_exists or else new_class_stone.is_dotnet_class then
				if new_class_stone.is_dotnet_class then
					externali ?= new_class_stone.class_i
					check
						externali_not_void: externali /= Void
					end
					external_cons := externali.external_consumed_type
					if external_cons /= Void then
						-- A .NET class.
						dotnet_class := True
						if attached {like short_formatter} managed_main_formatters.i_th (4) as l_short_formatter then
							short_formatter := l_short_formatter
							l_short_formatter.set_dotnet_mode (True)
						else
							short_formatter := Void
						end
						if attached {like flat_formatter} managed_main_formatters.i_th (5) as l_flat_formatter then
							flat_formatter := l_flat_formatter
							l_flat_formatter.set_dotnet_mode (True)
						else
							flat_formatter := Void
 						end
					end
				elseif feature_stone /= Void then
					if not text_loaded then
						across
							managed_main_formatters as ic
						loop
								--| Ted: Text might change here
							ic.item.set_stone (new_class_stone)
						end
					end
				else
					if not text_loaded and not managed_main_formatters.is_empty then
						managed_main_formatters.first.set_stone (new_class_stone)
						managed_main_formatters.first.execute
					end
				end
			else
				if attached current_editor as l_current_editor then
					l_current_editor.clear_window
					l_current_editor.display_message (
							develop_window.Warning_messages.w_file_not_exist (new_class_stone.class_i.file_name.name)
						)
				end
			end
		end

	check_class_stone
			-- Handle class stone.
		do
			if class_text_exists then
				develop_window.commands.new_feature_cmd.enable_sensitive
			end

			if conv_classc = Void then
					--| The dropped class is not compiled.
					--| Display only the textual formatter.
				if dotnet_class and not text_loaded then
						-- FIXME: it should not use fixed index like 4 or 5! use constant declared in a specific interface. (TODO)
					managed_main_formatters.i_th (4).set_stone (new_class_stone)
					managed_main_formatters.i_th (5).set_stone (new_class_stone)
					managed_main_formatters.i_th (4).execute
				end
				develop_window.address_manager.disable_formatters
			else
					--| We have a compiled class.
				develop_window.update_formatters
				set_class_text
			end
		end

	set_class_text
			-- Set class text.
		do
			if not class_text_exists then
					--| Disable the textual formatter.
				managed_main_formatters.first.disable_sensitive
				if not same_class then
					if not text_loaded then
						across
							managed_main_formatters as ic
						loop
								--| Ted: Text might be changed
							ic.item.set_stone (new_class_stone)
						end
						if not dotnet_class then
							check managed_main_formatters.count >= 2 end
							managed_main_formatters.i_th (2).execute
						end
					else
						if not dotnet_class then
							check managed_main_formatters.count >= 2 end
							managed_main_formatters.i_th (2).enable_select
						end
					end
				end
			else
				if not develop_window.changed or not same_class then
						--| Enable all formatters.
					if
						(not develop_window.feature_stone_already_processed or
						not managed_main_formatters.first.selected) and
						feature_stone = Void
					then
						if not text_loaded then
							across
								managed_main_formatters as ic
							loop
									--| Ted: Text might be changed
								ic.item.set_stone (new_class_stone)
							end
						end
					end
				else
					if not develop_window.feature_stone_already_processed then
						develop_window.address_manager.disable_formatters
						across
							managed_main_formatters as ic
						loop
								--| Ted: Text might be changed
							ic.item.set_stone (new_class_stone)
						end
					end
				end
			end
		end

	formatted_context_for_group (a_group: CONF_GROUP; a_path: STRING_32)
			-- Formatted context representing the list of classes inside `a_group'.
		require
			a_group_not_void: a_group /= Void
			a_path_not_void: a_path /= Void
		local
			l_library: CONF_LIBRARY
			l_assembly: CONF_ASSEMBLY
			l_phys_as: CONF_PHYSICAL_ASSEMBLY
			l_cluster: CONF_CLUSTER
			l_sorted_cluster: EB_SORTED_CLUSTER
			l_subclu: DS_LIST [EB_SORTED_CLUSTER]
			l_classes: DS_ARRAYED_LIST [CLASS_I]
			l_in_classes: DS_ARRAYED_LIST [CLASS_I]
			l_out_classes: DS_ARRAYED_LIST [CLASS_I]
			l_over_classes: DS_ARRAYED_LIST [CLASS_I]
			l_cl_i: CLASS_I
			l_cl_c: CLASS_C
			l_assert_level: ASSERTION_I
			l_format_context: TEXT_FORMATTER_DECORATOR
			l_description: READABLE_STRING_32
			n: INTEGER
			l_is_void_safe: BOOLEAN
		do
			create l_format_context.make_for_case (current_editor.text_displayed)
			current_editor.handle_before_processing (False)
			l_format_context.process_keyword_text (ti_indexing_keyword, Void)
			l_format_context.put_new_line
			l_format_context.indent

				-- additional informations for assemblies
			if a_group.is_assembly then
				l_assembly ?= a_group
				check
					assembly: l_assembly /= Void
				end
				if l_assembly.physical_assembly /= Void then
					l_format_context.process_indexing_tag_text ("assembly_name")
					l_format_context.set_without_tabs
					l_format_context.process_symbol_text (ti_colon)
					l_format_context.put_space
					l_phys_as ?= l_assembly.physical_assembly
					check
						physical_assembly: l_phys_as /= Void
					end
					l_format_context.put_quoted_string_item (l_phys_as.assembly_name)
					l_format_context.put_new_line
				end

				l_format_context.process_indexing_tag_text ("assembly")
			elseif a_group.is_physical_assembly then
				l_phys_as ?= a_group
				check
					assembly: l_phys_as /= Void
				end
				l_format_context.process_indexing_tag_text ("assembly_name")
				l_format_context.set_without_tabs
				l_format_context.process_symbol_text (ti_colon)
				l_format_context.put_space
				l_format_context.put_quoted_string_item (l_phys_as.assembly_name)
				l_format_context.put_new_line
			elseif a_group.is_override then
				l_format_context.process_indexing_tag_text ("override")
				l_cluster ?= a_group
				check
					cluster: l_cluster /= Void
				end
			elseif a_group.is_cluster then
				l_format_context.process_indexing_tag_text ("cluster")
				l_cluster ?= a_group
				check
					cluster: l_cluster /= Void
				end
			elseif a_group.is_precompile then
				l_format_context.process_indexing_tag_text ("precompile")
			elseif a_group.is_library then
				l_format_context.process_indexing_tag_text ("library")
				l_library ?= a_group
				check
					library: l_library /= Void
				end
			else
				check
					should_not_reach: False
				end
			end
				-- name
			l_format_context.set_without_tabs
			l_format_context.process_symbol_text (ti_colon)
			l_format_context.put_space
			l_format_context.add_group (a_group, a_group.name)
			l_format_context.put_new_line


				-- location
			l_format_context.process_indexing_tag_text ("location")
			l_format_context.set_without_tabs
			l_format_context.process_symbol_text (ti_colon)
			l_format_context.put_space
			l_format_context.put_quoted_string_item (a_group.location.evaluated_path.name)

				-- path/namespace
			if a_path /= Void and then not a_path.is_empty then
				l_format_context.put_space
				l_format_context.set_without_tabs
				l_format_context.process_symbol_text (ti_l_parenthesis)
				l_format_context.put_quoted_string_item (a_path)
				l_format_context.set_without_tabs
				l_format_context.process_symbol_text (ti_r_parenthesis)
			end
			l_format_context.put_new_line

				-- Now try to get the description of the cluster/library/...
			l_description := a_group.description
			if
				l_description = Void and l_library /= Void and then
				attached l_library.library_target as l_lib_target
			then
				l_description := l_lib_target.description
				if l_description = Void and attached l_lib_target.system as l_system then
					l_description := l_system.description
				end
			end
			if l_description /= Void then
				l_format_context.process_indexing_tag_text ("description")
				l_format_context.set_without_tabs
				l_format_context.process_symbol_text (ti_colon)
				l_format_context.put_space
				l_format_context.set_in_indexing_clause (True)
				l_format_context.process_symbol_text (ti_double_quote)
				l_format_context.process_symbol_text (ti_l_bracket)
				l_format_context.put_new_line
				if l_description.has ('%N') then
						-- Indenting looks strange below because
						-- `add_multiline_string' does not take into accounts
						-- how many indents already exists.
					l_format_context.exdent
					l_format_context.add_multiline_string (l_description, 3)
					l_format_context.indent
				else
					l_format_context.indent
					l_format_context.indent
					l_format_context.add_string (l_description)
					l_format_context.exdent
					l_format_context.exdent
				end
				l_format_context.put_new_line
				l_format_context.indent
				l_format_context.process_symbol_text (ti_r_bracket)
				l_format_context.process_symbol_text (ti_double_quote)
				l_format_context.exdent
				l_format_context.put_new_line
			end

				--| Options, uuid, ... and library specific data.
			if l_library /= Void then
					-- Use application options
				if l_library.use_application_options then
					l_format_context.process_indexing_tag_text ("use application options: ")
					l_format_context.put_manifest_string (interface_names.b_yes)
					l_format_context.put_new_line
				end
				if attached l_library.library_target as l_lib_target then
					if attached l_lib_target.options as opts then
						if
							attached opts.void_safety as opt_void_safety and then
							attached opt_void_safety.item as l_void_safety and then
							not l_void_safety.is_whitespace
						then
							l_format_context.process_indexing_tag_text ("void safety: ")
							l_format_context.put_manifest_string (l_void_safety)
							l_format_context.put_new_line
							l_is_void_safe := opt_void_safety.index /= {CONF_OPTION}.void_safety_index_none
						else
							l_is_void_safe := False
						end
						if l_is_void_safe and then attached opts.is_attached_by_default_configured then
							l_format_context.process_indexing_tag_text ("is attached by default: ")
							if opts.is_attached_by_default then
								l_format_context.put_manifest_string (interface_names.b_yes)
							else
								l_format_context.put_manifest_string (interface_names.b_no)
							end
							l_format_context.put_new_line
						end
						if
							attached opts.syntax as opt_syntax and then
							attached opt_syntax.item as l_syntax and then
							not l_syntax.is_whitespace
						then
							l_format_context.process_indexing_tag_text ("syntax: ")
							l_format_context.put_manifest_string (l_syntax)
							l_format_context.put_new_line
						end
					end
					if attached l_lib_target.internal_libraries as l_libs and then l_libs.count > 0 then
						l_format_context.put_new_line
						l_format_context.process_indexing_tag_text ("depends on: ")
						if l_libs.count > 5 then
							l_format_context.put_new_line
							l_format_context.indent
						end
						from
							n := 0
							l_libs.start
						until
							l_libs.after
						loop
							if n > 0 and n \\ 5 = 0 then
								l_format_context.put_new_line
							end
							n := n + 1

							l_format_context.add_group (l_libs.item_for_iteration, l_libs.key_for_iteration)
							l_libs.forth
							if not l_libs.after then
								l_format_context.put_manifest_string (", ")
							end
						end
						if l_libs.count > 5 then
							l_format_context.exdent
						end
						l_format_context.put_new_line
					end
				end
			end

				-- parent
			if l_cluster /= Void and then l_cluster.parent /= Void then
				l_format_context.process_indexing_tag_text ("parent cluster")
				l_format_context.set_without_tabs
				l_format_context.process_symbol_text (ti_colon)
				l_format_context.put_new_line
				l_format_context.indent
				l_format_context.put_manifest_string (" - ")

				l_format_context.add_group (l_cluster.parent, l_cluster.parent.name)
				l_format_context.put_new_line
				l_format_context.exdent
			end

			create l_sorted_cluster.make (a_group)
			l_sorted_cluster.initialize

				-- sub clusters
			if not a_group.is_library and then not l_sorted_cluster.clusters.is_empty then
				l_format_context.process_indexing_tag_text ("sub cluster(s)")
				l_format_context.set_without_tabs
				l_format_context.process_symbol_text (ti_colon)
				l_format_context.put_new_line
				l_format_context.indent
				from
					l_subclu := l_sorted_cluster.clusters
					l_subclu.start
				until
					l_subclu.after
				loop
					l_cluster := l_subclu.item_for_iteration.actual_cluster
					l_format_context.put_manifest_string (" - ")
					l_format_context.add_group (l_cluster, l_cluster.name)
					l_format_context.put_space
					l_format_context.set_without_tabs
					l_format_context.process_symbol_text (ti_L_parenthesis)
					l_format_context.process_comment_text (l_cluster.classes.count.out, Void)
					l_format_context.set_without_tabs
					l_format_context.process_symbol_text (ti_R_parenthesis)
					l_format_context.put_new_line
					l_subclu.forth
				end
				l_format_context.exdent
			end

				-- classes			
			if not l_sorted_cluster.classes.is_empty then
				l_classes := l_sorted_cluster.classes
				from
					l_classes.start
					create l_in_classes.make (l_classes.count)
					create l_out_classes.make (l_classes.count)
					create l_over_classes.make (l_classes.count)
				until
					l_classes.after
				loop
					l_cl_i := l_classes.item_for_iteration
					if
						a_path.is_empty
						or else is_string_started_by (l_cl_i.path, a_path)
					then
						if l_cl_i.compiled_representation /= Void then
							l_in_classes.put_last (l_cl_i)
						elseif l_cl_i.config_class.is_overriden then
							l_over_classes.put_last (l_cl_i)
						else
							l_out_classes.put_last (l_cl_i)
						end
					end
					l_classes.forth
				end

				if l_in_classes.count > 0 then
					l_format_context.put_new_line
					if l_in_classes.count = 1 then
						l_format_context.process_indexing_tag_text ("1 compiled class")
					else
						l_format_context.process_indexing_tag_text (
							l_in_classes.count.out + " compiled classes")
					end
					l_format_context.set_without_tabs
					l_format_context.process_symbol_text (ti_colon)
					l_format_context.put_new_line
					l_format_context.indent

					from
						l_in_classes.start
					until
						l_in_classes.after
					loop
						l_cl_i := l_in_classes.item_for_iteration
						l_cl_c := l_cl_i.compiled_representation
						check compiled: l_cl_c /= Void end

						l_assert_level := l_cl_i.assertion_level
						l_format_context.put_manifest_string (" - ")
						l_format_context.put_classi (l_cl_c.original_class)
						l_format_context.set_without_tabs
						l_format_context.process_symbol_text (ti_colon)
						if l_assert_level.level = 0  then
							l_format_context.put_space
							l_format_context.process_comment_text (once "no assertion", Void)
						else
							l_format_context.put_space
							l_format_context.process_comment_text (once "assertions", Void)
							l_format_context.put_space
							l_format_context.process_symbol_text (ti_l_parenthesis)
							if l_assert_level.is_precondition then
								l_format_context.put_space
								l_format_context.set_without_tabs
								l_format_context.process_keyword_text (ti_Require_keyword, Void)
							end
							if l_assert_level.is_postcondition then
								l_format_context.put_space
								l_format_context.set_without_tabs
								l_format_context.process_keyword_text (ti_Ensure_keyword, Void)
							end
							if l_assert_level.is_check then
								l_format_context.put_space
								l_format_context.set_without_tabs
								l_format_context.process_keyword_text (ti_Check_keyword, Void)
							end
							if l_assert_level.is_loop then
								l_format_context.put_space
								l_format_context.set_without_tabs
								l_format_context.process_keyword_text (ti_Loop_keyword, Void)
							end
							if l_assert_level.is_invariant then
								l_format_context.put_space
								l_format_context.set_without_tabs
								l_format_context.process_keyword_text (ti_Invariant_keyword, Void)
							end
							if l_assert_level.is_supplier_precondition then
								l_format_context.put_space
								l_format_context.set_without_tabs
								l_format_context.process_keyword_text ("supplier-precondition", Void)
							end
							l_format_context.put_space
							l_format_context.process_symbol_text (ti_r_parenthesis)
						end
						l_format_context.put_new_line
						l_in_classes.forth
					end
					l_format_context.exdent
				end

				if l_out_classes.count > 0 then
					l_format_context.put_new_line
					if l_out_classes.count = 1 then
						l_format_context.process_indexing_tag_text ("1 class not in system")
					else
						l_format_context.process_indexing_tag_text (
							l_out_classes.count.out + " classes not in system")
					end
					l_format_context.set_without_tabs
					l_format_context.process_symbol_text (ti_colon)
					l_format_context.put_new_line
					l_format_context.indent
					from
						l_out_classes.start
					until
						l_out_classes.after
					loop
						l_cl_i := l_out_classes.item_for_iteration
						check not_in_system: not l_cl_i.is_compiled end
						l_format_context.put_manifest_string (" - ")
						l_format_context.put_classi (l_cl_i)
						l_format_context.put_new_line
						l_out_classes.forth
					end
					l_format_context.exdent
				end

				if
					l_over_classes.count > 0 and then
					a_group.overriders /= Void and then not a_group.overriders.is_empty
				then
					l_format_context.put_new_line
					l_format_context.process_indexing_tag_text ("Overriden")
					l_format_context.set_without_tabs
					l_format_context.process_symbol_text (ti_colon)
					l_format_context.put_new_line
					l_format_context.indent
					from
						l_over_classes.start
					until
						l_over_classes.after
					loop
						l_cl_i := l_over_classes.item_for_iteration
						check is_overriden_class: l_cl_i.config_class.is_overriden end

						l_format_context.put_manifest_string (" - ")

						if attached {CLASS_I} l_cl_i.config_class.overriden_by as l_overridden_class then
							l_cl_c := l_overridden_class.compiled_representation
							if l_cl_c /= Void then
								l_format_context.put_classi (l_cl_c.original_class)
							else
								l_format_context.put_classi (l_overridden_class)
							end
							l_format_context.put_manifest_string (" in ")
							l_format_context.add_group (l_cl_i.config_class.overriden_by.group, l_cl_i.config_class.overriden_by.group.name)
							l_format_context.put_new_line
						end
						l_over_classes.forth
					end
					l_format_context.exdent
					l_format_context.put_new_line
				end
			end
			l_format_context.exdent
			l_format_context.put_new_line
			current_editor.handle_after_processing
		end

	select_basic_main_formatter
			-- Ensure that basic text formatter is selected.
		local
			l_basic_formatter: EB_FORMATTER
		do
			l_basic_formatter := develop_window.managed_main_formatters.first
			l_basic_formatter.enable_select
			l_basic_formatter.set_must_format (True)
			l_basic_formatter.format
			l_basic_formatter.ensure_display_in_widget_owner
		end

	refresh_all_tabs (a_stone: STONE)
			-- Refresh all editor tabs
		require
			not_void: develop_window /= Void
			not_void: a_stone /= Void
		local
			l_editors_mamager: EB_EDITORS_MANAGER
			l_all_editors: ARRAYED_LIST [EB_SMART_EDITOR]
			l_one_editor: EB_SMART_EDITOR
			l_current_editor: EB_SMART_EDITOR
		do
			l_editors_mamager := develop_window.editors_manager
			if l_editors_mamager /= Void then
				from
					l_all_editors := l_editors_mamager.editors
					l_current_editor := l_editors_mamager.current_editor
					l_all_editors.start
				until
					l_all_editors.after
				loop
					l_one_editor := l_all_editors.item

					check not_void: l_one_editor /= Void end
					if l_one_editor = l_current_editor then
						-- We refresh current editor with lastest stone
						refresh_a_tab (a_stone, l_one_editor, l_editors_mamager)
					else
						refresh_a_tab (l_one_editor.stone, l_one_editor, l_editors_mamager)
					end

					l_all_editors.forth
				end
				if l_current_editor /= Void then
					l_current_editor.set_title_saved (not develop_window.changed)
				end
			end
		end

	refresh_a_tab (a_stone: STONE; a_editor: EB_SMART_EDITOR; a_editor_manager: EB_EDITORS_MANAGER)
			-- Refresh `a_editor' notebook tab's pixmap and title
			-- `a_stone' can be void, then this feature will use stone from `a_editor'
		require
			not_void: a_editor /= Void
			not_void: a_editor_manager /= Void
			not_void: develop_window /= Void
		local
			st: STONE
			l_group: CONF_GROUP
			l_content: SD_CONTENT
			l_factory: EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		do
			if a_editor /= Void then
				create l_factory
				st := a_editor.stone
				if a_stone /= Void and then a_stone /~ st then
					st := a_stone
				end

				l_content := a_editor.docking_content
				if
					attached {CLASSI_STONE} st as l_class_stone and then
					l_class_stone.is_valid
				then
					l_content.set_pixmap (l_factory.pixmap_from_class_i (l_class_stone.class_i))
					l_content.set_short_title (l_class_stone.class_name)
					l_content.set_long_title (l_class_stone.class_name)
					-- We should synchronize title with editor saving state, see bug#14443
					a_editor.set_title_saved_with (not a_editor.changed, l_class_stone.class_name)
				elseif attached {CLUSTER_STONE} st as l_cluster_stone then
					l_group := l_cluster_stone.group
					l_content.set_pixmap (l_factory.pixmap_from_group (l_group))
					l_content.set_short_title (l_group.name)
					l_content.set_long_title (l_group.name)
				end
				a_editor_manager.update_content_description (a_stone, l_content)
			end
		end

feature {NONE} -- Implementation attributes

	develop_window: EB_DEVELOPMENT_WINDOW
			-- Development window associate with current.

	new_class_stone: CLASSI_STONE
			-- New class stone.

	old_class_stone: CLASSI_STONE
			-- Old class stone.

	conv_classc: CLASSC_STONE
			-- Complied class stone.

	conv_brkstone: BREAKABLE_STONE
			-- Breakable stone.

	cluster_st: CLUSTER_STONE
			-- Cluster stone.

	feature_stone: FEATURE_STONE
			-- Feature stone.

	conv_ferrst: FEATURE_ERROR_STONE
			-- Feature error stone.

	target_stone: TARGET_STONE
			-- Target stone.

	conv_errst: ERROR_STONE
			-- Error stone.

	cl_syntax_stone: CL_SYNTAX_STONE
			-- Syntax stone.

	error_line: INTEGER
			-- Line number where has error.

	class_file: RAW_FILE
			-- File associate with a class.

	class_text_exists: BOOLEAN
			-- If class text exists?

	same_class: BOOLEAN
			-- If old stone and new stone similiar?

	test_stone: CLASSI_STONE
			-- Test if stones are similiar.

	externali: EXTERNAL_CLASS_I
			-- External class.

	external_cons: CONSUMED_TYPE
			-- External consumed type.

	dotnet_class: BOOLEAN
			-- .Net class

	short_formatter: EB_SHORT_FORMATTER
			-- Short formatter

	flat_formatter: EB_FLAT_SHORT_FORMATTER
			-- Flat formatter

	main_formatter: EB_CLASS_TEXT_FORMATTER
			-- Main formatter

	text_loaded: BOOLEAN
			-- If text loaded?

	formatter: EB_FORMATTER
			-- Formatter

	managed_main_formatters: ARRAYED_LIST [EB_CLASS_TEXT_FORMATTER]
			-- Managed main formatters.

	ast_stone: AST_STONE
			-- AST stone

	line_stone: LINE_STONE

feature {NONE} -- Implementation

	current_editor: EB_SMART_EDITOR
			-- Current editor
		do
			Result := develop_window.editors_manager.current_editor
		end

	is_string_started_by (s1, s2: STRING_GENERAL): BOOLEAN
			-- Is `s1' starting by `s2' characters
		require
			s2_not_void: s2 /= Void
		local
			i: INTEGER
		do
			if s1 /= Void and then s1.count >= s2.count then
				from
					i := 1
					Result := True
				until
					i > s2.count or not Result
				loop
					Result := s1.code (i) = s2.code (i)
					i := i + 1
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
