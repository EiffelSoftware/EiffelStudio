indexing
	description	: "Location to enter the name of a class and the name of a feature.%
				  % Manage the history of the parent as well."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr] "

class
	EB_ADDRESS_MANAGER

inherit
	EB_CONSTANTS
		export
			{NONE} all
		end

	EB_RECYCLABLE

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	EB_HISTORY_MANAGER_OBSERVER
		redefine
			on_update,
			on_item_added,
			on_item_removed,
			on_position_changed
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: like parent; for_context_tool: BOOLEAN) is
			-- Initialize the widget and set up the activate actions.
			-- If `for_context_tool', do not initialize `widget', but
			-- initialize `header_info' and `address_dialog' (Saves widgets).
		require
			valid_parent: a_parent /= Void
		do
				-- Set up the parent.
			parent ?= a_parent
			set_mode (for_context_tool)
			parent.history_manager.add_observer (Current)

				-- Create the widget.
			build_interface
		end

	build_interface is
			-- Build Vision2 architecture.
		local
			hbox: like widget
			vb: EV_VERTICAL_BOX
			label: EV_LABEL
		do
			create hbox
			hbox.set_padding (Layout_constants.Small_border_size)

			if mode then
					-- Cluster label.
				create label.make_with_text ("Cluster")
				hbox.extend (label)
				hbox.disable_item_expand (label)

					-- Cluster selector.
				create cluster_address
				cluster_address.set_minimum_width (130)
				hbox.extend (cluster_address)
			end

				-- Class label.
			create label.make_with_text ("Class")
			hbox.extend (label)
			hbox.disable_item_expand (label)

				-- Class selector.
			create class_address
			class_address.set_minimum_width (Layout_constants.Dialog_unit_to_pixels(65))
			hbox.extend (class_address)

				-- Feature label.
			create label.make_with_text ("Feature")
			hbox.extend (label)
			hbox.disable_item_expand (label)

				-- Feature selector
			create feature_address
			feature_address.set_minimum_width (Layout_constants.Dialog_unit_to_pixels(90))
			hbox.extend (feature_address)

			if not mode then
					-- View label
				create label.make_with_text ("View")
				hbox.extend (label)
				hbox.disable_item_expand (label)
			end

				-- Setup the widget.
			if not mode then
				widget := hbox
			else
				create vb
				vb.extend (hbox)
				create output_line
				output_line.align_text_left
				vb.extend (output_line)
				create address_dialog
				address_dialog.set_title (Interface_names.t_Select_location)
				address_dialog.close_request_actions.extend (address_dialog~hide)
				address_dialog.extend (vb)
				generate_header_info

				cluster_address.return_actions.extend (~execute_with_cluster)
				cluster_address.key_press_actions.extend (~type_cluster)
				cluster_address.select_actions.extend (~change_hist_to_cluster)

				cluster_address.focus_out_actions.extend (~one_lost_focus)
				class_address.focus_out_actions.extend (~one_lost_focus)
				feature_address.focus_out_actions.extend (~one_lost_focus)
			end

			class_address.return_actions.extend (~execute_with_class)
			class_address.key_press_actions.extend (~type_class)
			class_address.select_actions.extend (~change_hist_to_class)

			feature_address.return_actions.extend (~execute_with_feature)
			feature_address.key_press_actions.extend (~type_feature)
			feature_address.select_actions.extend (~change_hist_to_feature)

			if not Eiffel_project.manager.is_created then
					-- Project is not yet loaded, disable controls.
				on_project_unloaded
			end
		end

feature -- Access

	parent: EB_HISTORY_OWNER
			-- Parent for Current.

	widget: EV_HORIZONTAL_BOX
			-- Vision2 widget representing the control.

	header_info: EV_VIEWPORT
			-- Box containing labels representing the history status.

	class_name: STRING
			-- Name of the class as it appears in the combo box.
			-- Void if none.

	feature_name: STRING
			-- Name of the feature as it appears in the combo box.
			-- Void if none.

feature -- Element change

	set_format_name (a_name: STRING) is
			-- Set `format_name' to `a_name'.
			-- `a_name' cannot be Void nor empty.
		require
			a_name_non_void: a_name /= Void
			a_name_non_empty: not a_name.is_empty
			-- `a_name' should be the name of a known formatter
		local
			name_copy: STRING
			found: BOOLEAN
		do
			name_copy := clone (a_name)
			name_copy.to_lower
			from
				known_formatters.start
			until
				known_formatters.after or else found
			loop
				if name_copy.is_equal (known_formatters.item.command_name) then
					known_formatters.item.invalidate
					known_formatters.item.execute
					found := True
				end
				known_formatters.forth
			end
		end

	set_formatters (new_formatters: like known_formatters) is
			-- Set `known_formatters' to `new_formatters'.
		require
			formatters_not_initialized: known_formatters = Void
			new_formatters_non_void: new_formatters /= Void
			for_development_window: not mode
		local
			tb: EV_TOOL_BAR
			but: EV_TOOL_BAR_BUTTON
		do
			create tb
			known_formatters := new_formatters
			from
				known_formatters.start
			until
				known_formatters.after
			loop
				but := known_formatters.item.new_button
				but.drop_actions.set_veto_pebble_function (~is_not_feature_stone (?))
				tb.extend (but)
				known_formatters.forth
			end
			widget.extend (tb)
			widget.disable_item_expand (tb)
		end

	disable_formatters is
			-- Make the format combo box insensitive.
		require
			formatters_initialized: known_formatters /= Void
		local
			cur: CURSOR
		do
			cur := known_formatters.cursor
			from
				known_formatters.start
			until
				known_formatters.after
			loop
				known_formatters.item.disable_sensitive
				known_formatters.forth
			end
			known_formatters.go_to (cur)
		end

	enable_formatters is
			-- Make the format combo box insensitive.
		require
			formatters_initialized: known_formatters /= Void
		local
			cur: CURSOR
		do
			cur := known_formatters.cursor
			from
				known_formatters.start
			until
				known_formatters.after
			loop
				known_formatters.item.enable_sensitive
				known_formatters.forth
			end
			known_formatters.go_to (cur)
		end

	reset is
			-- Reset the address manager.
		do
			class_name := Void
			feature_name := Void
			class_i := Void
			class_address.remove_text
			feature_address.remove_text
		end

	set_focus is
			-- Give the focus to the class combo box.
		require
			displayed: widget.is_displayed
		do
			if class_address.is_sensitive then
				class_address.set_focus
			end
		end

	set_output_line (t: EV_LABEL) is
			-- Set the textable in which messages will be displayed.
			-- `t' may be Void, this means that there will be no output.
		do
			output_line := t
		end

feature -- Observer management

	on_update is
			-- The history has changed. Update `Current'.
		local
			f: FEATURE_STONE
			cell: CELL2 [STONE, INTEGER]
			list: LIST [CELL2 [STONE, INTEGER]]
			nitem: EV_LIST_ITEM
			cur_sel: STONE
		do
			class_address.select_actions.block
			class_address.wipe_out
			feature_address.select_actions.block
			feature_address.wipe_out
			if mode then
				cluster_address.select_actions.block
				cluster_address.wipe_out
			end
			list := history_manager.feature_display_list
			cur_sel := history_manager.active
			from
				list.start
			until
				list.after
			loop
				cell := list.item
				f ?= cell.item1
				if f /= Void then
					create nitem.make_with_text (
						f.feature_name + l_From + f.class_i.name_in_upper)
					nitem.set_data (cell.item2)
					feature_address.extend (nitem)
					if cell.item1 = cur_sel then
						nitem.enable_select
					end
				end
				list.forth
			end
			if not feature_address.is_empty then
				feature_address.first.disable_select
			end
			list := history_manager.class_display_list
			from
				list.start
			until
				list.after
			loop
				cell := list.item
					--| FIXME XR: The extra space is there because otherwise
					--| when the user types his class names in upper case, the combo box automatically selects the item.
				create nitem.make_with_text (cell.item1.stone_signature + l_Space)
				nitem.set_data (cell.item2)
				class_address.extend (nitem)
				if cell.item1 = cur_sel then
					nitem.enable_select
				end
				list.forth
			end
			if not class_address.is_empty then
				class_address.first.disable_select
			end
			if mode then
				list := history_manager.cluster_display_list
				from
					list.start
				until
					list.after
				loop
					cell := list.item
					create nitem.make_with_text (cell.item1.stone_signature)
					nitem.set_data (cell.item2)
					cluster_address.extend (nitem)
					if cell.item1 = cur_sel then
						nitem.enable_select
					end
					list.forth
				end
				if not cluster_address.is_empty then
					cluster_address.first.disable_select
				end
			end
			update_combos
			if mode then
				update_labels
				address_dialog.hide
				cluster_address.select_actions.resume
			end
			class_address.select_actions.resume
			feature_address.select_actions.resume
		end

	on_item_added (a_stone: STONE; a_stone_position: INTEGER) is
			-- `a_stone' has just been added.
		do
			on_update
		end

	on_item_removed (a_stone: STONE; index_item: INTEGER) is
			-- `a_stone' has just been removed.
		do
			on_update
		end

	on_position_changed is
			-- Position in history has changed.
		do
			on_update
		end

feature -- Memory management

	recycle is
			-- Recycle `Current' and leave it in an unstable state, 
			-- so that we know whether we're not referenced any longer.
		do
			if widget /= Void then
				widget.destroy
				widget := Void
			end
			parent := Void
		end

feature {NONE} -- Vision2 Controls

	cluster_address: EV_COMBO_BOX
			-- Cluster part of the address.

	class_address: EV_COMBO_BOX
			-- Class part of the address.

	feature_address: EV_COMBO_BOX
			-- Feature part of the address.

feature -- Properties

	new_class_win: EB_CREATE_CLASS_DIALOG
			-- New dialog for a class tool.

feature -- Updating

	refresh is
			-- Update the text in the widgets according to parent's stone.
		do
			update_combos
		end

	on_project_created is
			-- A new project has been loaded. Enable all controls.
		do
			if cluster_address /= Void then
				cluster_address.enable_sensitive
				class_label.enable_sensitive
				cluster_label.enable_sensitive
				feature_label.enable_sensitive
			end
			class_address.enable_sensitive
			feature_address.enable_sensitive
		end

	on_project_unloaded is
			-- Current project has been closed. Disable all controls.
		do
			if mode then
				cluster_address.disable_sensitive
				class_label.disable_sensitive
				cluster_label.disable_sensitive
				feature_label.disable_sensitive
			end
			class_address.disable_sensitive
			feature_address.disable_sensitive
		end

feature {NONE} -- Execution

	execute_with_cluster is
			-- The user just entered a new cluster name, process it.
		do
			extract_cluster_from_user_entry
			if current_cluster = Void then
				if output_line /= Void then
					output_line.set_text (Warning_messages.w_No_cluster_matches)
				else
					--| FIXME XR: How do we warn the user?
				end
				if cluster_address.is_displayed then
					cluster_address.set_focus
					if cluster_address.text /= Void then
						cluster_address.select_all
					end
				end
			else
				parent.advanced_set_stone (create {CLUSTER_STONE}.make (current_cluster))
			end
		end

	execute_with_class is
			-- The user just entered a new class name, process it.
		local
			ctxt: STRING
			wd: EV_WARNING_DIALOG
		do
			process_user_entry
			if class_i = Void then
				ctxt := class_address.text
				if
					ctxt /= Void and then
					not ctxt.has ('*') and then
					not ctxt.has ('?')
				then
					if is_valid_class_name (ctxt) then
						create new_class_win.make_default (parent)
						new_class_win.set_stone_when_finished
						new_class_win.call (class_address.text)
					else
						create wd.make_with_text (Warning_messages.w_Invalid_class_name (ctxt))
						wd.show_modal_to_window (parent.window)
					end
				else
					if output_line /= Void then
						output_line.set_text (Warning_messages.w_No_class_matches)
					else
						--| FIXME XR: How do we warn the user?
					end
					if class_address.is_displayed then
						class_address.set_focus
						if class_address.text /= Void then
							class_address.select_all
						end
					end
				end
			else
				if not class_i.compiled then
					parent.advanced_set_stone (create {CLASSI_STONE}.make (class_i))
				else
					extract_feature_from_user_entry
					if
						current_feature = Void or else
						current_feature.written_class /= class_i.compiled_class and
						not mode
					then
						parent.advanced_set_stone (create {CLASSC_STONE}.make (current_class))
					else
						parent.advanced_set_stone (create {FEATURE_STONE}.make (current_feature))
					end
				end
			end
		end

	execute_with_feature is
			-- The user just entered a new feature name, process it.
		do
			process_user_entry
			if current_class = Void then
				if class_i = Void then
					if class_address.is_displayed then
						if output_line /= Void then
							output_line.set_text (Warning_messages.w_Specify_a_class)
						else
							--| FIXME XR: How do we warn the user?
						end
						class_address.set_focus
						if class_address.text /= Void then
							class_address.select_all
						end
					end
				else
					parent.advanced_set_stone (create {CLASSI_STONE}.make (class_i))
				end
			else
				if feature_address.text /= Void then
					extract_feature_from_user_entry
					if current_feature = Void then
						if output_line /= Void then
							output_line.set_text (Warning_messages.w_No_feature_matches)
						else
							--| FIXME XR: How do we warn the user?
						end
						if feature_address.is_displayed then
								-- The selected feature is not in the selected class.
							feature_address.set_focus
							if feature_address.text /= Void then
								feature_address.select_all
							end
						end
--| FIXME XR: Propose to create a new feature in current_class instead?
					elseif mode then
						parent.advanced_set_stone (create {FEATURE_STONE}.make (current_feature))
					elseif current_feature.written_class.has_feature_table then
						parent.advanced_set_stone (create {FEATURE_STONE}.make (
							current_feature.written_class.feature_with_body_index (current_feature.body_index)
						))
					else
							-- Gasp, we are in the editor address and we can't find the origin feature...
						parent.advanced_set_stone (create {FEATURE_STONE}.make (current_feature))
					end
				else
					parent.advanced_set_stone (create {CLASSC_STONE}.make (current_class))
				end
			end
		end

	process_cluster_callback (pos: INTEGER) is
			-- The choice `pos' has been selected, process the choice.
		require
			looking_for_a_cluster: cluster_list /= Void
		local
			cname: STRING
		do
			if pos /= 0 then
				current_cluster := cluster_list.i_th (pos)
				cname := clone (current_cluster.cluster_name)
				cluster_address.set_text (cname)
			end
			cluster_list := Void
		end

	process_class_callback (pos: INTEGER) is
			-- The choice `pos' has been selected, process the choice.
		require
			looking_for_a_class: class_list /= Void
		local
			cname: STRING
		do
			if pos /= 0 then
				class_i := class_list.i_th (pos)
				cname := clone (class_i.name)
				cname.to_upper
				class_address.set_text (cname)
			end
			class_list := Void
		end

	process_feature_callback (pos: INTEGER) is
			-- The choice `pos' has been selected, process the choice.
		require
			looking_for_a_feature: feature_list /= Void
		local
			fname: STRING
		do
			if pos > 0 then
				current_feature := feature_list.i_th (pos)
				fname := clone (current_feature.name)
				fname.to_lower
				feature_address.set_text (fname)
			end
			feature_list := Void
		end

feature -- Assertions

	known_formatters: ARRAYED_LIST [EB_CLASS_TEXT_FORMATTER]
			-- Formatters that can be selected in the format combo box.

	mode: BOOLEAN
			-- If `mode' then the display is for the context tool (`window', `header_info' are generated),
			-- otherwise it is for a development window (`widget' is generated).

feature {NONE} -- Implementation

	class_i: CLASS_I
			-- Current selected class.

	current_feature: E_FEATURE
			-- Current selected feature.

	current_cluster: CLUSTER_I
			-- Current selected cluster.

	class_list: LINKED_LIST [CLASS_I]
			-- List of classes displayed in `choice'.

	cluster_list: LINKED_LIST [CLUSTER_I]
			-- List of clusters displayed in `choice'.

	feature_list: LINKED_LIST [E_FEATURE]
			-- List of features of current class, if any.

	history_manager: EB_HISTORY_MANAGER is
			-- History for parent.
		do
			Result := parent.history_manager
		end

	display_cluster_choice is
				-- Display cluster names from `cluster_list' to `choice'.
		require
			cluster_list_not_void: cluster_list /= Void
		local
			choice: EB_CHOICE_DIALOG
			cluster_names: ARRAYED_LIST [STRING]
			clusteri: CLUSTER_I
			cname: STRING
		do
			create cluster_names.make (cluster_list.count)
			from
				cluster_list.start
			until
				cluster_list.after
			loop
				clusteri := cluster_list.item
				cname := clone (clusteri.cluster_name)
				cluster_names.extend (cname)
				cluster_list.forth
			end
			if not cluster_names.is_empty then
				if cluster_names.count = 1 then
					process_cluster_callback (1)
				else
					create choice.make_default (~process_cluster_callback (?))
					choice.set_title (Interface_names.t_Select_cluster)
					choice.set_list (cluster_names)
					choice.set_position (cluster_address.screen_x, cluster_address.screen_y + cluster_address.height)
					choice.show_modal_to_window (window_manager.last_focused_window.window)
				end
			else
				if output_line /= Void then
					output_line.set_text (Warning_messages.w_No_cluster_matches)
				else
					--| FIXME XR: Add a way to cleanly say that.
				end
			end
		end

	display_class_choice is
				-- Display class names from `class_list' to `choice'.
		require
			class_list_not_void: class_list /= Void
		local
			choice: EB_CHOICE_DIALOG
			class_names: ARRAYED_LIST [STRING]
			classi, last_class: CLASS_I
			cname, last_name: STRING
			first_ambiguous: BOOLEAN
		do
			create class_names.make (class_list.count)
			from class_list.start until class_list.after loop
				classi := class_list.item
				cname := clone (classi.name)
				if
					last_class /= Void and then
					last_class.name.is_equal (cname)
				then
					if not first_ambiguous then
						first_ambiguous := True
						last_name := class_names.last
						last_name.extend ('@')
						last_name.append (last_class.cluster.cluster_name)
					end
					cname.to_upper
					cname.extend ('@')
					cname.append (classi.cluster.cluster_name)
				else
					cname.to_upper
					first_ambiguous := False
				end
				class_names.extend (cname)
				last_class := classi
				class_list.forth
			end
			if not class_names.is_empty then
				if class_names.count = 1 then
					process_class_callback (1)
				else
					create choice.make_default (~process_class_callback (?))
					choice.set_title (Interface_names.t_Select_class)
					choice.set_list (class_names)
					choice.set_position (class_address.screen_x, class_address.screen_y + class_address.height)
					choice.show_modal_to_window (window_manager.last_focused_window.window)
				end
			else
				if output_line /= Void then
					output_line.set_text (Warning_messages.w_No_class_matches)
				else
					--| FIXME XR: Add a way to cleanly say that.
				end
			end
		end

	display_feature_choice is
			-- Display feature names from `feature_list' to `choice'.
		require
			feature_list_not_void: feature_list /= Void
		local
			choice: EB_CHOICE_DIALOG
			feature_names: ARRAYED_LIST [STRING]
		do
			create feature_names.make (feature_list.count)
			from
				feature_list.start
			until
				feature_list.after
			loop
				feature_names.extend (feature_list.item.name)
				feature_list.forth
			end
			if not feature_names.is_empty then
				if feature_names.count = 1 then
					process_feature_callback (1)
				else
					create choice.make_default (~process_feature_callback (?))
					choice.set_title (Interface_names.t_Select_feature)
					choice.set_list (feature_names)
					choice.set_position (feature_address.screen_x, feature_address.screen_y + feature_address.height)
					choice.show_modal_to_window (window_manager.last_focused_window.window)
				end
			else
				if output_line /= Void then
					output_line.set_text (Warning_messages.w_No_class_matches)
				else
					--| FIXME XR: Add a way to cleanly say that.
				end
			end
		end

	get_cluster_from_name (a_cluster_name: STRING): CLUSTER_I is
			-- Get the CLUSTER_I corresponding named `a_cluster_name'.
		do
			Result := Universe.cluster_of_name (a_cluster_name)
		end

--	get_classi_from_name (a_class_name: STRING): CLASS_I is
			-- Get the CLASS_I corresponding to the class named `a_class_name'.
--		local
--			loc_list: LINKED_LIST [CLASS_I]
--		do
--			loc_list := Universe.classes_with_name (class_name)
		
				-- Return the first element of the list.
--			if loc_list /= Void and then not loc_list.is_empty then
--				Result := loc_list.first
--			end
--		end

	change_format is
			-- Change the display format: a new one has been selected.
		obsolete
			"Do not use"
		do
--			set_format_name (format_selector.text)
		end

feature {NONE} -- open new class
	
	extract_cluster_from_user_entry is
			-- Process the user entry in `cluster_address' to generate `current_cluster'.
		local
			fname: STRING
			cl: LINKED_LIST [CLUSTER_I]
			matcher: KMP_WILD
			matching: SORTED_TWO_WAY_LIST [CLUSTER_I]
		do
			current_cluster := Void
			fname := clone (cluster_address.text)
			if fname /= Void then
				fname.left_adjust
				fname.right_adjust
			end
			if fname = Void or else fname.is_empty then
				-- Do nothing here, do it in execute_from*.
			else
				fname.to_lower
				create matcher.make_empty
				matcher.set_pattern (fname)
				if not matcher.has_wild_cards then
					current_cluster := get_cluster_from_name (fname)
				else
					from
						cl := Universe.clusters
						cl.start
						create matching.make
					until
						cl.after
					loop
						matcher.set_text (cl.item.cluster_name) 
						if matcher.pattern_matches then
							matching.extend (cl.item)
						end
						cl.forth
					end
					matching.sort
					cluster_list := matching
					display_cluster_choice
				end
--				if current_cluster = Void then
--						-- Cluster does not exist, create it (?).
--					if cluster_address.is_displayed then
--						cluster_address.set_focus
--					end
----| FIXME XR: propose to create a new cluster named fname (?).
--				else
--					launch_cluster
--				end
			end
		end

	process_user_entry is
			-- process the user entry
		local
			cname: STRING
			clusters: LINKED_LIST [CLUSTER_I]
			sorted_classes: SORTED_TWO_WAY_LIST [CLASS_I]
			at_pos: INTEGER
			cluster: CLUSTER_I
			cluster_name: STRING
			matcher: KMP_WILD
			classes: EXTEND_TABLE [CLASS_I, STRING]
			wd: EV_WARNING_DIALOG
		do
			class_i := Void
			cname := clone (class_address.text)
			if cname /= Void then
				cname.left_adjust
				cname.right_adjust
			end
			if cname = Void or else cname.is_empty then
				-- Do nothing here, do it in execute_from*.
			else
				cname.to_lower
				create matcher.make_empty
				matcher.set_pattern (cname)
				if not matcher.has_wild_cards then
					at_pos := cname.index_of ('@', 1)
					if at_pos = cname.count then
						cname.head (cname.count - 1)
						class_address.set_text (cname)
						at_pos := 0
					end
					if at_pos = 0 then
						class_list := Universe.classes_with_name (cname)
						if class_list.is_empty then
							class_list := Void
--							create new_class_win.make_default (parent)
--							new_class_win.call (cname)
						elseif class_list.count = 1 then
							class_i := class_list.first
--							process
--							class_list := Void
						else
							display_class_choice
						end
					else
						cluster_name := cname.substring (at_pos + 1, cname.count)
						if at_pos > 1 then
							cname := cname.substring (1, at_pos - 1)
						else
							cname := ""
						end
						cluster := Universe.cluster_of_name (cluster_name)
						if cluster = Void then
							create wd.make_with_text (Warning_messages.w_Cannot_find_cluster (cluster_name))
							wd.show_modal_to_window (window_manager.last_focused_development_window.window)
							if class_address.is_displayed then
								class_address.set_focus
								class_address.select_region (at_pos + 1, class_address.text_length)
							end
						else
							class_i := cluster.classes.item (cname)
--							if class_i = Void then
--								create new_class_win.make_default (parent)
--								new_class_win.call (cname)
--							end
						end	
					end
				else
					from
						create sorted_classes.make
						clusters := Universe.clusters
						clusters.start
					until
						clusters.after
					loop
						from
							classes := clusters.item.classes
							classes.start
						until
							classes.after
						loop
							matcher.set_text (classes.key_for_iteration) 
							if matcher.pattern_matches then
								sorted_classes.put_front (classes.item_for_iteration)
							end
							classes.forth
						end
						clusters.forth
					end
					sorted_classes.sort
					class_list := sorted_classes
					display_class_choice
				end
			end
		end

	extract_feature_from_user_entry is
			-- Process the user entry in `feature_address' to generate `feature_name'.
		require
			give_a_class_first: current_class /= Void
		local
			fname: STRING
			sorted_features: SORTED_TWO_WAY_LIST [E_FEATURE]
			ft: E_FEATURE_TABLE
			matcher: KMP_WILD
		do
			current_feature := Void
			fname := clone (feature_address.text)
			if fname /= Void then
				fname.left_adjust
				fname.right_adjust
			end
			if fname = Void or else fname.is_empty then
				-- Do nothing here, do it in execute_from*.
			else
				fname.to_lower
				create matcher.make_empty
				matcher.set_pattern (fname)
				if not matcher.has_wild_cards then
					current_feature := get_feature_named (fname)
					if current_feature = Void then
							-- Feature does not exist, create it (?).
--| FIXME XR: propose to create a new feature named fname in class_c.
					end
				else
					from
						create sorted_features.make
						ft := current_class.api_feature_table
						ft.start
					until
						ft.after
					loop
						matcher.set_text (ft.item_for_iteration.name) 
						if matcher.pattern_matches then
							sorted_features.put_front (ft.item_for_iteration)
						end
						ft.forth
					end
					sorted_features.sort
					feature_list := sorted_features
					display_feature_choice
				end
			end
		end

	get_feature_named (name: STRING): E_FEATURE is
			-- Return the feature named `name' of class `current_class'.
		require
			class_selected: class_i /= Void
			valid_class: current_class /= Void
		local
			t: E_FEATURE_TABLE
			found: BOOLEAN
		do
			t := current_class.api_feature_table
			if t /= Void then
					-- Even in a class_c, the feature table may be Void (if half-compiled).
				from
					t.start
				until
					t.after or else found
				loop
					if t.item_for_iteration.name.is_equal (name) then
						Result := t.item_for_iteration
						found := True
					else
						t.forth
					end
				end
			end
		end

	change_hist_to_class is
			-- Center the history manager on a different stone.
		local
			conv_int: INTEGER_REF
			item: EV_LIST_ITEM
		do
			item := class_address.selected_item
			if item /= Void then
				conv_int ?= item.data
				parent.history_manager.go_i_th (conv_int.item)
			end
		end

	change_hist_to_feature is
			-- Center the history manager on a different stone.
		local
			conv_int: INTEGER_REF
			item: EV_LIST_ITEM
		do
			item := feature_address.selected_item
			if item /= Void then
				conv_int ?= item.data
				parent.history_manager.go_i_th (conv_int.item)
			end
		end

	change_hist_to_cluster is
			-- Center the history manager on a different stone.
		local
			conv_int: INTEGER_REF
			item: EV_LIST_ITEM
		do
			item := cluster_address.selected_item
			if item /= Void then
				conv_int ?= item.data
				parent.history_manager.go_i_th (conv_int.item)
			end
		end

	type_class (k: EV_KEY) is
			-- The user typed a new key in the class combo.
			-- Try to complete the class name.
		local
			str: STRING
			nb: INTEGER
			index: INTEGER
			list: CLASS_C_SERVER
			current_found: STRING
			cname: STRING
			last_string: STRING
			array_count: INTEGER
		do
			if
				mode and then
				k.code = Key_csts.Key_escape
			then
				address_dialog.hide
			else
				str := clone (class_address.text)
				if str /= Void then
					str.left_adjust
					str.right_adjust
					str.to_lower
					nb := str.count
				end
					-- Prevent the auto completion. (Temporary: waiting for Vision2)
				nb := 0
				
				if nb > 1 then
						--| This string should be alphabetically after any class name...
					last_string := "¦¦¦¦"
					current_found := last_string
					list := System.classes
					array_count := list.count
					from
						index := 1
					until
						index > array_count
					loop
						cname := (list @ index).name
						if cname.substring (1, nb).is_equal (str) then
							if cname < current_found then
								current_found := cname
							end
						end
						index := index + 1
					end
					if not current_found.is_equal (last_string) then
						current_found := clone (current_found)
						current_found.to_upper
						class_address.set_text (current_found)
						class_address.select_region (nb, current_found.count)
					end
				end
			end
		end

	type_feature (k: EV_KEY) is
			-- The user typed a new key in the feature combo.
			-- Try to complete the feature name.
		do
			if
				mode and then
				k.code = Key_csts.Key_escape
			then
				address_dialog.hide
			else
--				io.put_string ("2 ")
			end
		end

	type_cluster (k: EV_KEY) is
			-- The user typed a new key in the cluster combo.
			-- Try to complete the cluster name.
		require
			for_context_tool: mode
		do
			if
				mode and then
				k.code = Key_csts.Key_escape
			then
				address_dialog.hide
			else
--				io.put_string ("2 ")
			end
		end

	current_class: CLASS_C is
			-- Currently examined class_c.
			-- Either what the user typed in `class_address' or manager's stone.
		local
--			st: CLASSC_STONE
		do
			if class_i /= Void then
				if class_i.compiled then
					Result := class_i.compiled_class
				else
					Result := Void
				end
--			else
--				st ?= parent.stone
--				if st /= Void then
--					Result := st.e_class
--				end
			end
		end

	launch_cluster is
			-- Send a stone representing `current_cluster' to `parent'.
		require
			cluster_selected: current_cluster /= Void
		do
			if current_cluster /= Void then
				parent.advanced_set_stone (create {CLUSTER_STONE}.make (current_cluster))
			end
		end

	launch_class is
			-- Send a stone representing `current_class' or `class_i' to `parent'.
		require
			class_selected: class_i /= Void
		do
			if current_class /= Void then
				parent.advanced_set_stone (create {CLASSC_STONE}.make (current_class))
			else
				parent.advanced_set_stone (create {CLASSI_STONE}.make (class_i))
			end
		end

	launch_feature is
			-- Send a stone representing `feature' to `parent'.
		require
			feature_selected: current_feature /= Void
		local
			st: FEATURE_STONE
		do
			create st.make (current_feature)
			parent.advanced_set_stone (st)
		end

	is_valid_class_name (cl_name: STRING): BOOLEAN is
			-- Check that name `cl_name' is a valid class name.
		local
			cn: STRING
			cchar: CHARACTER
			i: INTEGER
		do
			cn := cl_name
			if cn = Void or else cn.is_empty or else not (cn @ 1).is_alpha then
				Result := False
			else
				Result := True
				from
					i := 2
				until
					i > cn.count or not Result
				loop
					cchar := (cn @ i)
					Result := cchar.is_alpha or cchar.is_digit or cchar = '_'
					i := i + 1
				end
			end
		end

feature {NONE} -- Implementation of the clickable labels for `header_info'

	cluster_label: EV_LABEL
	class_label: EV_LABEL
	feature_label: EV_LABEL
			-- Labels displayed in the header_info.
			
	output_line: EV_LABEL
			-- Textable in which warnings are displayed.
			-- May be Void, warnings are then not displayed.

	address_dialog: EV_WINDOW
			-- Window that pops up in the context tool to change the stone centering.

	key_csts: EV_KEY_CONSTANTS is
			-- Global key constants.
		once
			create Result
		end

	is_not_feature_stone (st: ANY): BOOLEAN is
			-- Is `st' not a feature stone?
		local
			fst: FEATURE_STONE
		do
			fst ?= st
			Result := fst = Void
		end

	set_mode (for_context_tool: BOOLEAN) is
			-- Define `Current's execution mode (generated widgets are different).
		do
			mode := for_context_tool
		end

	generate_header_info is
			-- Create all widgets used in `header_info'.
		local
			def_col: EV_STOCK_COLORS
			hb: EV_HORIZONTAL_BOX
		do
			create header_info
			create cluster_label
			create class_label
			create feature_label
			create def_col
			create hb

			cluster_label.set_foreground_color (def_col.Dark_red)
				-- This should be brown.
			class_label.set_foreground_color (def_col.Blue)
				-- This should be blue.
			feature_label.set_foreground_color (def_col.Dark_green)
				-- This should be green.

			cluster_label.pointer_enter_actions.extend (~highlight_label (cluster_label))
			cluster_label.pointer_leave_actions.extend (~unhighlight_label (cluster_label))
			class_label.pointer_enter_actions.extend (~highlight_label (class_label))
			class_label.pointer_leave_actions.extend (~unhighlight_label (class_label))
			feature_label.pointer_enter_actions.extend (~highlight_label (feature_label))
			feature_label.pointer_leave_actions.extend (~unhighlight_label (feature_label))

			cluster_label.pointer_button_release_actions.extend (~button_action (cluster_address, ?, ?, ?, ?, ?, ?, ?, ?))
			class_label.pointer_button_release_actions.extend (~button_action (class_address, ?, ?, ?, ?, ?, ?, ?, ?))
			feature_label.pointer_button_release_actions.extend (~button_action (feature_address, ?, ?, ?, ?, ?, ?, ?, ?))

			cluster_label.enable_sensitive
			class_label.enable_sensitive
			feature_label.enable_sensitive

			cluster_label.set_accept_cursor (Cursors.cur_Cluster)
			class_label.set_accept_cursor (Cursors.cur_Class)
			feature_label.set_accept_cursor (Cursors.cur_Feature)
			cluster_label.set_deny_cursor (Cursors.cur_X_Cluster)
			class_label.set_deny_cursor (Cursors.cur_X_Class)
			feature_label.set_deny_cursor (Cursors.cur_X_Feature)

			cluster_label.set_minimum_width ((default_font.string_width (default_cluster_name) * bold_ratio).ceiling)
			cluster_label.set_text (default_cluster_name)
			class_label.set_minimum_width ((default_font.string_width (default_class_name) * bold_ratio).ceiling)
			class_label.set_text (default_class_name)
			feature_label.set_minimum_width ((default_font.string_width (default_feature_name) * bold_ratio).ceiling)
			feature_label.set_text (default_feature_name)

			hb.set_padding (2)
			hb.extend (cluster_label)
			hb.extend (class_label)
			hb.extend (feature_label)
			hb.disable_item_expand (cluster_label)
			hb.disable_item_expand (class_label)
			hb.disable_item_expand (feature_label)
			header_info.extend (hb)
		end

	update_labels is
			-- Refresh the text of the labels according to the history status.
		require
			for_context_tool: mode
		local
			conv_clus: CLUSTER_STONE
			conv_class: CLASSI_STONE
			conv_f: FEATURE_STONE
			text: STRING
			c_stone: STONE
		do
			c_stone := parent.history_manager.active
			conv_clus ?= c_stone
			if conv_clus /= Void then
				text := conv_clus.cluster_i.cluster_name
				cluster_label.set_minimum_width (big_font.string_width (text))
				cluster_label.set_text (text)
				cluster_label.set_pebble (conv_clus)
				class_label.set_minimum_width (big_font.string_width (default_class_name))
				class_label.set_text (default_class_name)
				class_label.remove_pebble
				feature_label.set_minimum_width (big_font.string_width (default_feature_name))
				feature_label.set_text (default_feature_name)
				feature_label.remove_pebble
			else
				conv_f ?= c_stone
				if conv_f /= Void then
					text := conv_f.feature_name
					feature_label.set_minimum_width (big_font.string_width (text))
					feature_label.set_text (text)
					feature_label.set_pebble (create {FEATURE_STONE}.make (conv_f.e_feature))
					text := conv_f.e_feature.associated_class.name_in_upper
					class_label.set_minimum_width (big_font.string_width (text))
					class_label.set_text (text)
					class_label.set_pebble (create {CLASSC_STONE}.make (conv_f.e_feature.associated_class))
					text := conv_f.e_feature.associated_class.cluster.cluster_name
					cluster_label.set_pebble (create {CLUSTER_STONE}.make (conv_f.e_feature.associated_class.cluster))
					cluster_label.set_minimum_width (big_font.string_width (text))
					cluster_label.set_text (text)
				else
					conv_class ?= c_stone
					if conv_class /= Void then
						text := conv_class.cluster.cluster_name
						cluster_label.set_pebble (create {CLUSTER_STONE}.make (conv_class.cluster))
						cluster_label.set_minimum_width (big_font.string_width (text))
						cluster_label.set_text (text)
						text := conv_class.class_i.name_in_upper
						if conv_class.class_i.compiled then
							class_label.set_pebble (create {CLASSC_STONE}.make (conv_class.class_i.compiled_class))
						else
							class_label.set_pebble (create {CLASSI_STONE}.make (conv_class.class_i))
						end
						class_label.set_minimum_width (big_font.string_width (text))
						class_label.set_text (text)
						feature_label.remove_pebble
						feature_label.set_minimum_width (big_font.string_width (default_feature_name))
						feature_label.set_text (default_feature_name)
					else
						cluster_label.remove_pebble
						cluster_label.set_minimum_width (big_font.string_width (default_cluster_name))
						cluster_label.set_text (default_cluster_name)
						class_label.remove_pebble
						class_label.set_minimum_width (big_font.string_width (default_class_name))
						class_label.set_text (default_class_name)
						feature_label.remove_pebble
						feature_label.set_minimum_width (big_font.string_width (default_feature_name))
						feature_label.set_text (default_feature_name)
					end
				end
			end
--			header_info.set_size (header_info.minimum_size)
		end

	update_combos is
			-- Refresh the text in the combo boxes in order to display the current stone.
		local
			conv_clus: CLUSTER_STONE
			conv_class: CLASSI_STONE
			conv_f: FEATURE_STONE
			c_stone: STONE
		do
			c_stone := parent.history_manager.active
			conv_clus ?= c_stone 
			if conv_clus /= Void then
				if mode then
					cluster_address.set_text (conv_clus.cluster_i.cluster_name)
				end
				class_address.remove_text
				feature_address.remove_text
			else
				if not mode then
					conv_class ?= c_stone
					if conv_class /= Void then
						class_address.set_text (conv_class.class_i.name_in_upper)
						conv_f ?= c_stone
						if conv_f /= Void then
							feature_address.set_text (conv_f.origin_name)
						else
							feature_address.remove_text
						end
					end
				else
					conv_f ?= c_stone
					if conv_f /= Void then
						feature_address.set_text (conv_f.feature_name)
						class_address.set_text (conv_f.e_feature.associated_class.name_in_upper)
						cluster_address.set_text (conv_f.e_feature.associated_class.cluster.cluster_name)
					else
						conv_class ?= c_stone
						if conv_class /= Void then
							cluster_address.set_text (conv_class.cluster.cluster_name)
							class_address.set_text (conv_class.class_i.name_in_upper)
							feature_address.remove_text
						else
							cluster_address.remove_text
							class_address.remove_text
							feature_address.remove_text
						end
					end
				end
			end
		end

	pop_up_address_bar is
			-- Display a window containing an address bar to change the stone.
		require
			for_context_tool: mode
		local
			start_x: INTEGER
			parent_window: EV_WINDOW
		do
			start_x := header_info.screen_x
			parent_window := parent.window
			address_dialog.set_position (start_x, header_info.screen_y)
			address_dialog.set_size (parent_window.width + parent_window.screen_x - start_x, header_info.height)
			address_dialog.show
			output_line.remove_text
		end

	button_action (combo: EV_COMBO_BOX; x, y, b: INTEGER; d1, d2, d3: DOUBLE; ax, ay: INTEGER) is
			-- Action performed when one of the labels is clicked.
			-- Pop up `address_dialog' and give focus to `combo'.
		require
			for_context_tool: mode
		do
			if b = 1 then
				pop_up_address_bar
				if combo.is_displayed then
					combo.set_focus
				end
			end
		end

	one_lost_focus is
			-- One of the widgets displayed in `address_dialog' has lost the focus.
			-- If none now has the focus, hide `address_dialog'.
		require
			for_context_tool: mode
		do
			if
				not class_address.has_focus and then
				not feature_address.has_focus and then
				not cluster_address.has_focus and then
				not address_dialog.has_focus
			then
				address_dialog.hide
			end
		end

	Big_font: EV_FONT is
			-- Font used to highlight labels.
		local
			orig_font: EV_FONT
			csts: EV_FONT_CONSTANTS
		once
			create csts
			orig_font := create {EV_FONT}
			create Result.make_with_values (
				orig_font.family, csts.Weight_black, orig_font.shape, orig_font.height)
		end

	Default_font: EV_FONT is
			-- Font used to display labels.
		once
			Result := create {EV_FONT}
		end

	highlight_label (lab: EV_LABEL) is
			-- Display `lab' with a bold font.
		do
			lab.set_font (big_font)
		end

	unhighlight_label (lab: EV_LABEL) is
			-- Display `lab' with a bold font.
		do
			lab.set_font (create {EV_FONT})
		end

	default_class_name: STRING is "(no_class)"
	default_feature_name: STRING is "(no_feature)"
	default_cluster_name: STRING is "(no_cluster)"
	
	l_From: STRING is " from "
	l_Space: STRING is " "

	bold_ratio: DOUBLE is 1.19

end -- class EB_ADDRESS_MANAGER
