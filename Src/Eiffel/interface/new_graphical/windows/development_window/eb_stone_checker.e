indexing
	description: "Stone checker used by EB_DEVELOPMENT_WINDOW."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_STONE_CHECKER

inherit
	ANY

	SHARED_TEXT_ITEMS
		export
			{NONE} All
		end
create
	make

feature {NONE} -- Initlization

	make (a_window: EB_DEVELOPMENT_WINDOW) is
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

	set_stone_after_check (a_stone: STONE) is
			-- First we check `a_stone' then we set stone if possible.
		do
				-- the text does not change if the text was saved with syntax errors
			cur_wid := develop_window.window
			prepare (a_stone)

				-- History moving is not going to be cancelled.
			develop_window.set_history_moving_cancelled (False)

			handle_break_error_ace_external_file_stone (a_stone)
			if
				develop_window.stone /= Void and then
				not develop_window.unified_stone
			then
				develop_window.commands.send_stone_to_context_cmd.enable_sensitive
			else
				develop_window.commands.send_stone_to_context_cmd.disable_sensitive
			end
			if cur_wid = Void then
				--| Do nothing.
			else
				cur_wid.set_pointer_style (old_cur)
				old_cur := Void
				cur_wid := Void
			end
			develop_window.update_viewpoints
		end

feature {NONE} -- Implementation functions

	prepare (a_stone: STONE) is
			-- Try to assign different kinds of stones.
		local
			l_pixmaps: EV_STOCK_PIXMAPS
			l_editor: like current_editor
		do
			if cur_wid = Void then
				--| Do nothing.
			else
				if old_cur = Void then
					old_cur := cur_wid.pointer_style
				end
				create l_pixmaps
				cur_wid.set_pointer_style (l_pixmaps.Wait_cursor)
			end
			old_class_stone ?= develop_window.stone
			develop_window.old_set_stone (a_stone)
			text_loaded := develop_window.is_text_loaded
			l_editor := current_editor
			if l_editor /= Void then
				l_editor.set_stone (a_stone)
			end

			conv_brkstone ?= a_stone
			conv_errst ?= a_stone

			ef_stone ?= a_stone
			target_stone ?= a_stone

			cluster_st ?= a_stone
			new_class_stone ?= a_stone
			ast_stone ?= a_stone
			line_stone ?= a_stone

				-- Refresh editor in stone.
			develop_window.refresh_tab (a_stone)

		end

	handle_break_error_ace_external_file_stone (a_stone: STONE) is
			-- Handle `conv_brkstone', `conv_errst', `ef_stone' and `target_stone' if eixst.
		local
			bpm: BREAKPOINTS_MANAGER
		do
			if conv_brkstone /= Void then
				bpm := develop_window.Debugger_manager.breakpoints_manager
				if bpm.is_breakpoint_enabled (conv_brkstone.routine, conv_brkstone.index) then
					bpm.remove_breakpoint (conv_brkstone.routine, conv_brkstone.index)
				else
					bpm.set_breakpoint (conv_brkstone.routine, conv_brkstone.index)
				end
				bpm.notify_breakpoints_changes
			elseif ef_stone /= Void then
				if not text_loaded and then current_editor /= Void then
					f := ef_stone.file
					f.make_open_read (f.name)
					f.read_stream (f.count)
					f.close
					current_editor.set_stone (a_stone)
					current_editor.load_text (f.last_string)
				end
			elseif target_stone /= Void and then target_stone.is_valid then
				develop_window.tools.properties_tool.set_stone (target_stone)
			else
				handle_all_class_stones (a_stone)
			end
		end

	handle_all_class_stones (a_stone: STONE) is
			-- Handle all class stones.
			-- `a_stone' can be new class stone or exists class stone.
		do
				-- Remember previous stone.
			old_stone := develop_window.stone
			old_cluster_st ?= develop_window.stone

			develop_window.commands.new_feature_cmd.disable_sensitive
			develop_window.commands.toggle_feature_alias_cmd.disable_sensitive
			develop_window.commands.toggle_feature_signature_cmd.disable_sensitive
			develop_window.commands.toggle_feature_assigner_cmd.disable_sensitive

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
					str := a_stone.header.twin.as_string_32
					str.prepend ("* ")
					develop_window.set_title (str)
				else
					develop_window.set_title (a_stone.header)
				end
			else
				develop_window.set_title (develop_window.Interface_names.t_empty_development_window)
			end

				-- Refresh the tools.
			develop_window.tools.features_tool.set_stone (a_stone)
			develop_window.tools.cluster_tool.set_stone (a_stone)
				-- Update the context tool.
			if develop_window.unified_stone then
				develop_window.tools.set_stone (a_stone)
			end
		end

	check_new_class_stone (a_stone: STONE) is
			-- Handle `a_stone' which is new class stone.
		do
			if new_class_stone /= Void then
				if not develop_window.during_synchronization then
					develop_window.view_points_combo.set_conf_class (new_class_stone.class_i.config_class)
				end
					-- Text is now editable.
				if develop_window.editors_manager.current_editor /= Void then
					develop_window.editors_manager.current_editor.set_read_only (False)
				end

				if new_class_stone.is_valid then
					develop_window.tools.properties_tool.set_stone (new_class_stone)
				end

					-- class stone was dropped
				create class_file.make (new_class_stone.class_i.file_name)
				class_text_exists := class_file.exists
				feature_stone ?= a_stone
					--| We have to create a classi_stone to check whether the stones are really similar.
					--| Otherwise a redefinition of same_as may be called.
				create test_stone.make (new_class_stone.class_i)
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

				conv_classc ?= new_class_stone

					-- First choose possible formatter
				possible_formater

				if text_loaded then
					from
						managed_main_formatters.start
					until
						managed_main_formatters.after
					loop
							--| Ted: Text might be changed
						managed_main_formatters.item.force_stone (a_stone)
						managed_main_formatters.item.refresh
						managed_main_formatters.forth
					end
					formatter ?= a_stone.pos_container
					if formatter /= Void then
						formatter.enable_select
					end
				end

				set_class_text_if_possible
				check_class_stone
				if current_editor /= Void then
					if not managed_main_formatters.first.selected then
						current_editor.set_read_only (true)
					elseif new_class_stone /= Void and then new_class_stone.class_i.is_read_only then
						current_editor.set_read_only (True)
					end
				end

			else
				handle_cluster_stone
			end
		end

	handle_cluster_stone is
			-- Handle cluster stone.
		do
				-- not a class text : cannot be edited
			if current_editor /= Void then
				current_editor.set_read_only (True)
			end
			develop_window.address_manager.disable_formatters

			if cluster_st /= Void then
				if cluster_st.is_valid then
					develop_window.tools.properties_tool.set_stone (cluster_st)
				end
				if not text_loaded then
					if not develop_window.during_synchronization then
						develop_window.view_points_combo.set_conf_group (cluster_st.group)
					end
					formatted_context_for_group (cluster_st.group, cluster_st.path)
					if cluster_st.position > 0 and then current_editor /= Void then
						current_editor.display_line_at_top_when_ready (cluster_st.position, 0)
					end

				end
			end
		end

	possible_formater is
			-- Do works for formatters.
		do
			main_formatter ?= new_class_stone.pos_container
			if main_formatter /= Void and not develop_window.during_synchronization then
				if
					not (conv_classc /= Void and class_text_exists and (not develop_window.changed or not same_class))
				then
					main_formatter.enable_select
				elseif feature_stone = Void then
					if main_formatter /= develop_window.pos_container then
						main_formatter.enable_select
					end
					if current_editor /= Void and then not text_loaded and then new_class_stone.position > 0 then
						current_editor.display_line_at_top_when_ready (new_class_stone.position, 0)
					end
				end
			end
		end

	handle_class_stone (a_stone: STONE) is
			-- Handle `a_stone' which is a class stone.
		local
			l_selection: TUPLE [pos_start, pos_end: INTEGER]
		do
			if class_text_exists then
				if feature_stone /= Void and not develop_window.feature_stone_already_processed then  -- and not same_class then
					conv_ferrst ?= feature_stone
					if conv_ferrst /= Void then
						error_line := conv_ferrst.line_number
					else
							-- if a feature_stone has been dropped
							-- scroll to the corresponding feature in the basic text format
						if (not text_loaded or develop_window.is_dropping_on_editor) and not develop_window.during_synchronization then
							develop_window.scroll_to_feature (feature_stone.e_feature, new_class_stone.class_i)
						end
					end
				elseif ast_stone /= Void then
					if (not text_loaded or develop_window.is_dropping_on_editor) and not develop_window.during_synchronization then
						if not develop_window.managed_main_formatters.first.selected then
							select_basic_main_formatter
						end
						develop_window.scroll_to_ast (ast_stone.ast, ast_stone.class_i, ast_stone.is_for_feature_invocation)
					end
				elseif line_stone /= Void then
					if (not text_loaded or develop_window.is_dropping_on_editor) and not develop_window.during_synchronization then
						if not develop_window.managed_main_formatters.first.selected then
							select_basic_main_formatter
						end
						l_selection := line_stone.selection
						if l_selection /= Void then
							develop_window.scroll_to_selection (l_selection, True)
						else
							develop_window.editors_manager.current_editor.scroll_to_start_of_line_when_ready (line_stone.line_number, line_stone.column_number, line_stone.should_line_be_selected)
						end
					end
				else
					cl_syntax_stone ?= a_stone
					if cl_syntax_stone /= Void then
						error_line := cl_syntax_stone.line
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
								 current_editor.set_read_only (true)
							end
						end
						if current_editor /= Void then
							current_editor.display_line_when_ready (error_line, 0, True)
						end
					end
				end
			end
		end

	set_class_text_if_possible is
			-- Call `set_class_text_for_class_stone' if possible.
		do
			if conv_classc = Void or else
				conv_classc.e_class.is_external or else
				feature_stone /= Void and not
				develop_window.feature_stone_already_processed and not
				same_class then
					-- If a classi_stone or a feature_stone or a external call
					-- has been dropped, check to see if a .NET class.
				set_class_text_for_class_stone
			end
		end

	set_class_text_for_class_stone is
			-- Set class texts for class stone.
		do
			if class_text_exists or else new_class_stone.class_i.is_external_class then
				if new_class_stone.class_i.is_external_class then
					externali ?= new_class_stone.class_i
					check
						externali_not_void: externali /= Void
					end
					external_cons := externali.external_consumed_type
					if external_cons /= Void then
						-- A .NET class.
						dotnet_class := True
						short_formatter ?= managed_main_formatters.i_th (4)
						flat_formatter ?= managed_main_formatters.i_th (5)
						if short_formatter /= Void then
							short_formatter.set_dotnet_mode (True)
						end
						if flat_formatter /= Void then
							flat_formatter.set_dotnet_mode (True)
						end
					end
				elseif feature_stone /= Void then
					if not text_loaded then
						from
							managed_main_formatters.start
						until
							managed_main_formatters.after
						loop
								--| Ted: Text might change here
							managed_main_formatters.item.set_stone (new_class_stone)
							managed_main_formatters.forth
						end
					end
				else
					if not text_loaded then
						managed_main_formatters.first.set_stone (new_class_stone)
						managed_main_formatters.first.execute
					end
				end
			else
				if current_editor /= Void then
					current_editor.clear_window
					current_editor.display_message (
						develop_window.Warning_messages.w_file_not_exist (
							new_class_stone.class_i.file_name))
				end
			end
		end

	check_class_stone is
			-- Handle class stone.
		do
			if conv_classc = Void then
					--| The dropped class is not compiled.
					--| Display only the textual formatter.
				if dotnet_class and not text_loaded then
					managed_main_formatters.i_th (4).set_stone (new_class_stone)
					managed_main_formatters.i_th (5).set_stone (new_class_stone)
					managed_main_formatters.i_th (4).execute
				end
				develop_window.address_manager.disable_formatters
			else
					--| We have a compiled class.
				if
					class_text_exists and then
					develop_window.Eiffel_project.Workbench.last_reached_degree <= 2
				then
					develop_window.commands.new_feature_cmd.enable_sensitive
					develop_window.commands.toggle_feature_alias_cmd.enable_sensitive
					develop_window.commands.toggle_feature_signature_cmd.enable_sensitive
					develop_window.commands.toggle_feature_assigner_cmd.enable_sensitive
				end

				--address_manager.enable_formatters
				develop_window.update_formatters
				set_class_text
			end
		end

	set_class_text is
			-- Set class text.
		do
			if not class_text_exists then
					--| Disable the textual formatter.
				managed_main_formatters.first.disable_sensitive
				if not text_loaded then
					from
						managed_main_formatters.start
					until
						managed_main_formatters.after
					loop
							--| Ted: Text might be changed
						managed_main_formatters.item.set_stone (new_class_stone)
						managed_main_formatters.forth
					end
					if not dotnet_class then
						managed_main_formatters.i_th (2).execute
					end
				else
					if not dotnet_class then
						managed_main_formatters.i_th (2).enable_select
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
							from
								managed_main_formatters.start
							until
								managed_main_formatters.after
							loop
									--| Ted: Text might be changed
								managed_main_formatters.item.set_stone (new_class_stone)
								managed_main_formatters.forth
							end
						end
					end
				else
					if not develop_window.feature_stone_already_processed then
						develop_window.address_manager.disable_formatters
						from
							managed_main_formatters.start
						until
							managed_main_formatters.after
						loop
								--| Ted: Text might be changed
							managed_main_formatters.item.set_stone (new_class_stone)
							managed_main_formatters.forth
						end
					end
				end
			end
		end

	formatted_context_for_group (a_group: CONF_GROUP; a_path: STRING) is
			-- Formatted context representing the list of classes inside `a_group'.
		require
			a_group_not_void: a_group /= Void
			a_path_not_void: a_path /= Void
		local
			l_assembly: CONF_ASSEMBLY
			l_phys_as: CONF_PHYSICAL_ASSEMBLY
			l_cluster: CONF_CLUSTER
			l_sorted_cluster: EB_SORTED_CLUSTER
			l_subclu: DS_LIST [EB_SORTED_CLUSTER]
			l_classes: DS_ARRAYED_LIST [CLASS_I]
			l_in_classes: DS_ARRAYED_LIST [CLASS_I]
			l_out_classes: DS_ARRAYED_LIST [CLASS_I]
			l_over_classes: DS_ARRAYED_LIST [CLASS_I]
			l_cl_i, l_overridden_class: CLASS_I
			l_cl_c: CLASS_C
			l_assert_level: ASSERTION_I
			l_format_context: TEXT_FORMATTER_DECORATOR
			l_description: STRING
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
			l_format_context.process_indexing_tag_text ("path")
			l_format_context.set_without_tabs
			l_format_context.process_symbol_text (ti_colon)
			l_format_context.put_space
			l_format_context.put_quoted_string_item (a_group.location.evaluated_path)

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

				-- Now try to get the description of the cluster, and if not
				-- we take the one from its target.
			l_description := a_group.description
			if l_description = Void then
				l_description := a_group.target.description
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
				l_classes := Void

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
							l_format_context.process_comment_text (once "None", Void)
						else
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
						end
						l_format_context.put_new_line
						l_in_classes.forth
					end
					l_format_context.exdent
				end
				l_in_classes := Void

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
				l_out_classes := Void

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

						l_overridden_class ?= l_cl_i.config_class.overriden_by
						if l_overridden_class /= Void then
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
				l_over_classes := Void
			end

			l_format_context.exdent
			l_format_context.put_new_line
			current_editor.handle_after_processing
		end

	select_basic_main_formatter is
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

feature {NONE} -- Implementation attributes

	develop_window: EB_DEVELOPMENT_WINDOW
			-- Development window associate with current.

	old_stone: STONE
			-- Old stone.

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

	old_cluster_st: CLUSTER_STONE
			-- Old cluster stone.

	feature_stone: FEATURE_STONE
			-- Feature stone.

	conv_ferrst: FEATURE_ERROR_STONE
			-- Feature error stone.

	target_stone: TARGET_STONE
			-- Target stone.

	ef_stone: EXTERNAL_FILE_STONE
			-- External file stone.

	f: FILE
			-- File associate with `ef_stone'.

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

	str: STRING_32
			-- String that describe current stone.

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

	old_cur: EV_POINTER_STYLE
			-- Cursor saved while displaying the hourglass cursor.

	cur_wid: EV_WIDGET
			-- Widget on which the hourglass cursor was set.

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

	is_string_started_by (s1, s2: STRING_GENERAL): BOOLEAN is
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
