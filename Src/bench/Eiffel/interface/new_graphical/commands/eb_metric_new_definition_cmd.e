indexing
	description: "Command to open a dialog which allows%N%
				%composite metric definition."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_NEW_DEFINITION_CMD

inherit
	EB_METRIC_COMMAND

	EB_CONSTANTS

	SHARED_XML_ROUTINES

	EV_KEY_CONSTANTS

create
	make

feature -- Initialization

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_new_metric
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := "Define new metric formula"
		end

	description: STRING is
			-- Description for this command.
		do
			Result := "New metric formula"
		end

	name: STRING is "new"
			-- Name of the command. Used to store the command in the
			-- preferences.

feature -- Widget

	build_new_metric_definition_dialog is
			-- Build `new_metric_definition_dialog' to define new metrics of type: derived, linear, metric ratio and scope ratio.
		local
			ok_button, cancel_button: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			ev_any: EV_WIDGET
		do
--		once
			create new_metric_definition_dialog
			new_metric_definition_dialog.set_title ("New metric formula")

			create vb
				vb.set_padding (5)
				vb.set_border_width (5)

				create notebook
				create derived_tab.make (Current)
				notebook.extend (derived_tab)
				notebook.set_item_text (derived_tab, "Derived")

				create linear_tab.make (Current)
				notebook.extend (linear_tab)
				notebook.set_item_text (linear_tab, "Linear")

				create ratio_metric_tab.make (Current)
				notebook.extend (ratio_metric_tab)
				notebook.set_item_text (ratio_metric_tab, "Metric Ratio")

				create ratio_scope_tab.make (Current)
				notebook.extend (ratio_scope_tab)
				notebook.set_item_text (ratio_scope_tab, "Scope Ratio")

				notebook.selection_actions.extend (~on_tab_changed)
				vb.extend (notebook)

--			create frame
--				frame.set_style ((create {EV_FRAME_CONSTANTS}).Ev_frame_lowered)
--				frame.set_minimum_height (50)
--				vb.extend (frame)
--				vb.disable_item_expand (frame)

			create hb
				create ok_button.make_with_text_and_action ("OK", ~ok_action)
				ok_button.set_minimum_width (80)
				hb.extend (create {EV_CELL})
				hb.extend (ok_button)
				hb.disable_item_expand (ok_button)

				create save_button.make_with_text_and_action ("Save", ~save_action)
				save_button.set_minimum_width (80)
				create {EV_CELL} ev_any
				ev_any.set_minimum_width (20)
				hb.extend (ev_any)
				hb.disable_item_expand (ev_any)
				hb.extend (save_button)
				hb.disable_item_expand (save_button)

				create cancel_button.make_with_text_and_action ("Cancel", ~cancel_action)
				cancel_button.set_minimum_width (80)
				create {EV_CELL} ev_any
				ev_any.set_minimum_width (20)
				hb.extend (ev_any)
				hb.disable_item_expand (ev_any)
				hb.extend (cancel_button)
				hb.disable_item_expand (cancel_button)
				hb.extend (create {EV_CELL})

			vb.extend (hb)
			vb.disable_item_expand (hb)

			new_metric_definition_dialog.extend (vb)
			new_metric_definition_dialog.set_default_push_button (ok_button)
			new_metric_definition_dialog.set_default_cancel_button (cancel_button)

			ok_button.key_press_actions.extend (~key_enter_pressed (?, ok_button))
			save_button.key_press_actions.extend (~key_enter_pressed (?, save_button))
			cancel_button.key_press_actions.extend (~key_enter_pressed (?, cancel_button))
			is_derived := True
			is_linear := False
			is_metric_ratio := False
			is_scope_ratio := False
			tab ?= linear_tab
		end

	fill_metric_combobox (combobox: EV_COMBO_BOX)is
			-- Fill `combobox' with all available metrics whose unit is different from ratio.
		require
			existing_tool: tool /= Void
			existing_combobox: combobox /= Void 
		local
			measure_item: EV_LIST_ITEM
		do
			from
				tool.metrics.start
			until
				tool.metrics.after
			loop
				if not equal (tool.metrics.item.unit, interface_names.metric_ratio_unit) then
					create measure_item.make_with_text (tool.metrics.item.name)
					combobox.extend (measure_item)
				end
				tool.metrics.forth
			end
		end

feature -- Access

	new_metric_definition_dialog: EV_DIALOG
			-- Dialog to define new metrics of type: derived, linear, metric ratio and scope ratio.

	notebook: EV_NOTEBOOK
		-- Notebook containing tabs.

	derived_tab: EB_METRIC_DERIVED_TAB
		-- Tab to define derived metrics.

	linear_tab: EB_METRIC_LINEAR_TAB
		-- Tab to define linear composite metrics.

	ratio_metric_tab: EB_METRIC_RATIO_TAB
		-- Tab to define ratio composite metrics.

	ratio_scope_tab: EB_METRIC_RATIO_SCOPE_TAB
		-- Tab to define ratio composite metrics over 2 scopes.

	tab: EB_METRIC_NEW_DEFINITION_TAB
		-- Currentlu selected tab

	save_button: EV_BUTTON
		-- Button to save new metric characteristics.

	valid_metric_definition: BOOLEAN
		-- Is new metric's definition syntaxly correct?

	metric_definition: XML_ELEMENT
		-- Definition part of the newly defined metric.

	is_derived: BOOLEAN
		-- Is the new composite metric a derived one?

	is_linear: BOOLEAN
		-- Is the new composite metric a linear one?

	is_metric_ratio: BOOLEAN
		-- Is the new composite metric a ratio over metrics one?

	is_scope_ratio: BOOLEAN
		-- Is the new composite metric a ratio over scopes one?

feature -- Overwrite a metric

	overwrite: BOOLEAN
		-- Overwrite metric of same name?

	set_overwrite (o: BOOLEAN) is
			-- Assign `o' to `overwrite'.
		do
			overwrite := o
		end

feature -- Edit a metric

	edition: BOOLEAN
		-- Is `new_metric_definition_dialog' displayed for editing a previously defined metric?

	set_edition (e: BOOLEAN) is
			-- Assign `e' to `edition'.
		do
			edition := e
		end

feature -- Action

	on_tab_changed is
			-- Adjust attributes regarding selected tab.
		do
			if notebook.selected_item = derived_tab then
				is_derived := True
				is_linear := False
				is_metric_ratio := False
				is_scope_ratio := False
			elseif notebook.selected_item = linear_tab then
				is_derived := False
				is_linear := True
				is_metric_ratio := False
				is_scope_ratio := False
			elseif notebook.selected_item = ratio_metric_tab then
				is_derived := False
				is_linear := False
				is_metric_ratio := True
				is_scope_ratio := False
			elseif notebook.selected_item = ratio_scope_tab then
				is_derived := False
				is_linear := False
				is_metric_ratio := False
				is_scope_ratio := True
			end
			tab ?= notebook.selected_item
			if tab.saved then
				save_button.disable_sensitive
			else
				save_button.enable_sensitive
			end
--			tab.name_field.set_focus
		ensure
			tab_set: tab /= Void
		end

	ok_action is
			-- Action to be performed on clicking on `ok_button'.
			-- Save if anything to save and exit.
		require
			tab_set: tab /= Void
		do
			if not tab.saved and then tab.something_to_save then
				save_action
				if not tab.error then
					new_metric_definition_dialog.hide
				end
			end
			if not tab.something_to_save or tab.saved then
				edition := False
				new_metric_definition_dialog.hide
			end
		end

	save_action is
			-- Action to be performed on clicking on `save_button'.
			-- Save if anything to save and do not exit.
		require
			tab_set: tab /= Void
		local
			new_metric_element: XML_ELEMENT
			retried: BOOLEAN
			x_pos, y_pos, index_of_metric: INTEGER
			error_dialog: EB_INFORMATION_DIALOG
			new_metric: EB_METRIC
			index: INTEGER
		do
			x_pos := new_metric_definition_dialog.x_position + 40
			y_pos := new_metric_definition_dialog.y_position + 80

			if not retried then
				if tab.error then
					tab.throw_error
				else
					if tab.existing_name and not overwrite then
						tab.build_confirm_dialog
						tab.confirm_dialog.show_modal_to_window (new_metric_definition_dialog)
--						tab.existing_name_dialog.set_position (x_pos, y_pos)
--						tab.existing_name_dialog.show_modal_to_window (new_metric_definition_dialog)
					end
					if not tab.existing_name or overwrite then
						if overwrite then
							index_of_metric := tool.file_manager.index_of_metric (tab.name_field.text)
						end

						new_metric_element := tab.new_metric_element
						new_metric := tab.new_metric
						if tab.new_metric_successful then
							if overwrite then
								tool.file_manager.replace_metric (index_of_metric, new_metric_element)
							else
								index := index_insert (new_metric)
								tool.file_manager.add_metric (new_metric_element, index)
							end
							if not tool.file_manager.metric_file.exists then
								tool.file_manager.destroy_file_name
								tool.set_file_loaded (False)
								tool.file_handler.load_files
							end
							check tool.file_manager.metric_file.exists end
							tool.file_manager.store
							tool.file_manager.metric_file.close

								-- Build tree formula starting from xml definition.
								-- Notify all observers. Caution: definition part only is provided via `metric_definition'.
								-- Update interface and create the corresponding metric object.
							tool.file_manager.new_metric_notify_all (new_metric, new_metric_element, overwrite, index)

							tab.disable_save
							overwrite := False
							if edition then
								tool.manage.refresh (new_metric, new_metric_element)
							end
						else
							tab.enable_save
							create error_dialog.make_with_text ("Error in metric definition.%NSave aborted.")
							error_dialog.set_position (x_pos, y_pos)
							error_dialog.show_modal_to_window (new_metric_definition_dialog)
						end
					end
				end
			end
		rescue
			retried := True
			create error_dialog.make_with_text ("Unable to read file:%N"
								+ tool.file_manager.metric_file_name )
			error_dialog.set_position (x_pos, y_pos)
			error_dialog.show_modal_to_window (new_metric_definition_dialog)
			retry
		end

	cancel_action is
			-- Action to be performed on clicking on `cancel_button'.
		do
			new_metric_definition_dialog.hide
			edition := False
		end

	key_enter_pressed (a_key: EV_KEY; a_button: EV_BUTTON) is
			-- On CR, call `a_button' associated action.
		do
			if a_key.code = Key_enter then
				a_button.select_actions.call ([])
			end
		end
	
	index_insert (a_metric: EB_METRIC): INTEGER is
			-- index `a_metric' should be inserted in `tool.metrics'.
		require
			valid_metric: a_metric /= Void
		local
			comp_metrics: LINKED_LIST [EB_METRIC]
			sorted_list: SORTED_TWO_WAY_LIST [EB_METRIC]
			cursor: CURSOR
		do
			cursor := tool.metrics.cursor
			tool.metrics.go_i_th (tool.nb_basic_metrics + 1)
			comp_metrics := tool.metrics.duplicate (tool.metrics.count - tool.nb_basic_metrics)
			check tool.metrics.count = comp_metrics.count + tool.nb_basic_metrics end
			create sorted_list.make
			from
				comp_metrics.start
			until
				comp_metrics.after
			loop
				sorted_list.extend (comp_metrics.item)
				comp_metrics.forth
			end
			check sorted_list.count = comp_metrics.count end
			sorted_list.extend (a_metric)
			Result := sorted_list.index_of (a_metric, 1)
		end

feature -- Initialization

	execute is
			-- Display `new_metric_definition_dialog' and reset all needed fields and tabs.
		require else
			existing_tool: tool /= Void
		local
			x_pos, y_pos: INTEGER
		do
			tool.development_window.window.set_pointer_style (tool.development_window.Wait_cursor)
			if new_metric_definition_dialog = Void then
				build_new_metric_definition_dialog	
			end
			x_pos := tool.development_window.window.x_position + 200
			y_pos := tool.development_window.window.y_position + 40
			new_metric_definition_dialog.set_position (x_pos, y_pos)
			derived_tab.preset
			linear_tab.preset
			ratio_metric_tab.preset
			ratio_scope_tab.preset
			tab ?= notebook.selected_item
	--		new_metric_definition_dialog.show
	--		tab.name_field.set_focus
			tool.development_window.window.set_pointer_style (tool.development_window.Standard_cursor)
			new_metric_definition_dialog.show_modal_to_window (tool.development_window.window)
		end

end -- class EB_METRIC_NEW_DEFINITION_CMD
