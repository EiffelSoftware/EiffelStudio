note
	description: "Dialog to add a library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ADD_LIBRARY_DIALOG

inherit
	ADD_GROUP_DIALOG
		redefine
			initialize,
			create_interface_objects,
			last_group
		end

	CONF_ACCESS
		undefine
			copy,
			default_create
		end

	PROPERTY_GRID_LAYOUT
		undefine
			copy,
			default_create
		end

	CONF_FILE_CONSTANTS
		undefine
			copy,
			default_create
		end

	CONF_VALIDITY
		undefine
			copy,
			default_create
		end

	CONF_GUI_INTERFACE_CONSTANTS
		undefine
			default_create,
			copy
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	create_interface_objects
		local
			l_service: ES_GUI_IRON_SERVICE
		do
			Precursor
			create l_service
			iron_service := l_service

			create filter
			create selection_cell
			create search_results_box.make (target)
			create library_widget.make (target)
			create iron_package_widget.make (l_service)
		end

	initialize
			-- Initialize.
		local
			fr: EV_FRAME
			main, vb: EV_VERTICAL_BOX
			cl: EV_CELL
			hsp: EV_VERTICAL_SPLIT_AREA
			l_service: like iron_service
		do
			l_service := iron_service

			Precursor

			set_title (conf_interface_names.dialog_create_library_title)
			set_icon_pixmap (conf_pixmaps.new_library_icon)

				-- libraries
			create main
			main.set_padding (layout_constants.default_padding_size)
			main.set_border_width (layout_constants.default_border_size)

			extend (main)
			create hsp
			main.extend (hsp)
			create fr
			create vb
			fr.extend (vb)

			hsp.set_first (fr)
			build_search_box (vb)

			cl := selection_cell
			hsp.set_second (cl)
			build_iron_package_box
			build_library_selection_box
			cl.extend (library_selection_box)
			cl.set_minimum_height (library_selection_box.height)

				-- Initial Event
			show_actions.extend_kamikaze (agent (a_split: EV_VERTICAL_SPLIT_AREA)
				do
					a_split.set_proportion (0.9)
					populate
					search_results_box.set_focus
				end (hsp))

			resize_actions.extend (agent (ia_x, ia_y, ia_width, ia_height: INTEGER; a_split: EV_VERTICAL_SPLIT_AREA)
				do
					a_split.set_proportion (0.9)
				end (?, ?, ?, ?, hsp))

			dpi_changed_actions.extend (agent (a_dpi: NATURAL_32; ia_x, ia_y, ia_width, ia_height: INTEGER; a_split: EV_VERTICAL_SPLIT_AREA)
				do
					a_split.set_proportion (0.9)
				end (?, ?, ?, ?, ?, hsp))


			l_service.set_associated_widget (Current)
		end

	launch_iron_tool
		local
			dlg: detachable IRON_PACKAGE_TOOL_DIALOG
		do
			dlg := last_launch_iron_tool
			if dlg /= Void and then dlg.is_destroyed then
				dlg := Void
			end
			if dlg = Void then
				create dlg.make (iron_service)
				dlg.set_size (width, height)
				dlg.set_position (x_position, y_position)
					--| Whenever an operation is made on iron packages via the current EiffelStudio's dialog
					--| `on_iron_packages_changed' will be executed.
				dlg.iron_box.on_iron_packages_changed_actions.extend (agent on_iron_packages_changed)
				last_launch_iron_tool := dlg
			end
			dlg.show_modal_to_window (Current)
		end

	last_launch_iron_tool: detachable IRON_PACKAGE_TOOL_DIALOG

	build_search_box (vb: EV_VERTICAL_BOX)
			-- Build the filter + grid + button.
		local
			l_btn: EV_BUTTON
			vb2, l_padding: EV_VERTICAL_BOX
			hb1: EV_HORIZONTAL_BOX
			l_update_index_button: EV_BUTTON
		do
				-- default libraries
			create vb2
			vb.extend (vb2)

			vb2.set_padding (layout_constants.small_padding_size)
			vb2.set_border_width (layout_constants.small_border_size)

				-- Search container
			build_search_options_bar (vb2)


				-- Create grid
--			create search_results_box.make (target)
			search_results_box.set_minimum_size (600, 100)
			search_results_box.on_item_selected_actions.extend (agent on_search_item_selected ({ES_LIBRARY_PROVIDER_ITEM}?))

				-- Create border for the grid
			create l_padding
			l_padding.set_border_width (1)
			l_padding.set_background_color ((create {EV_STOCK_COLORS}).color_3d_shadow)
			l_padding.extend (search_results_box.widget)

			vb2.extend (l_padding)

				-- Libraries cache update
			create hb1
			hb1.set_padding (layout_constants.small_padding_size)
			vb2.extend (hb1)
			vb2.disable_item_expand (hb1)

			create l_btn
			l_btn.select_actions.extend (agent on_search_item_selected (Void))
			l_btn.set_text (conf_interface_names.dialog_create_library_custom_location)
			l_btn.enable_sensitive
			hb1.extend (l_btn)
			hb1.disable_item_expand (l_btn)
			layout_constants.set_default_width_for_button (l_btn)

			hb1.extend (create {EV_CELL})

			create l_update_index_button
			l_update_index_button.select_actions.extend (agent update_index)
			l_update_index_button.set_text (conf_interface_names.dialog_create_refresh)
			l_update_index_button.set_tooltip (conf_interface_names.dialog_create_refresh_tooltip)
			l_update_index_button.enable_sensitive
			hb1.extend (l_update_index_button)
			hb1.disable_item_expand (l_update_index_button)
			layout_constants.set_default_width_for_button (l_update_index_button)

			create l_btn
			l_btn.set_pixmap (conf_pixmaps.project_settings_advanced_icon)
			l_btn.select_actions.extend (agent popup_configuration_information)
			l_btn.set_tooltip (conf_interface_names.dialog_display_configuration_tooltip)
			hb1.extend (l_btn)
			hb1.disable_item_expand (l_btn)


			create l_btn.make_with_text_and_action (conf_interface_names.dialog_search_library_iron_package_manage_button_label, agent launch_iron_tool)
			l_btn.set_pixmap (conf_pixmaps.library_iron_package_icon)
			l_btn.set_tooltip (conf_interface_names.dialog_search_library_iron_package_manage_button_tooltip)
			hb1.extend (l_btn)
			hb1.disable_item_expand (l_btn)
			layout_constants.set_default_width_for_button (l_btn)
		end

	build_search_options_bar (a_vertical_container: EV_VERTICAL_BOX)
			-- Search options bar
			-- |[ Search in       (*)  abc [x] def [x]  ]| CE |                   |
			-- |[ Search by class ( )  index [x]        ]| LL |[[ search ][Reset]]|

		local
			l_opts_vb, vbf: EV_VERTICAL_BOX
			l_search_hb, hbf, hb1,hb2,hb1cb,hb2cb: EV_HORIZONTAL_BOX
			l_radio1, l_radio2: EV_RADIO_BUTTON
			l_filter: like filter
			l_clear_filter_button: EV_BUTTON
			cb: EV_CHECK_BUTTON
			l_checkboxes: like provider_checkboxes
		do
			create l_search_hb
			a_vertical_container.extend (l_search_hb)
			a_vertical_container.disable_item_expand (l_search_hb)

				-- Opts
			create l_opts_vb
			l_search_hb.extend (l_opts_vb)

				-- hbf: filter + reset
			create hbf
			hbf.extend (create {EV_LABEL}.make_with_text (Names.l_filter))
			hbf.disable_item_expand (hbf.last)
			l_filter := filter
			hbf.extend (l_filter)
			l_filter.change_actions.extend (agent request_update_filter)
			create l_clear_filter_button
			l_clear_filter_button.select_actions.extend (agent l_filter.remove_text)
			l_clear_filter_button.set_pixmap (conf_pixmaps.general_remove_icon)
			l_clear_filter_button.set_tooltip (names.b_reset)
			hbf.extend (l_clear_filter_button)
			hbf.disable_item_expand (l_clear_filter_button)


				-- Vertical: filter text field + reset button
			create vbf
			vbf.extend (create {EV_CELL})
			vbf.extend (hbf)
			vbf.disable_item_expand (hbf)

			l_search_hb.extend (vbf)
--			l_search_hb.disable_item_expand (vbf)

				-- 2 lines, for search in, and search by class options.
			create hb1
			l_opts_vb.extend (hb1)
			l_opts_vb.disable_item_expand (hb1)
			create hb2
			l_opts_vb.extend (hb2)
			l_opts_vb.disable_item_expand (hb2)

				-- lib providers checkbox list.
			create l_checkboxes.make (search_in_manager.providers.count + search_by_class_manager.providers.count)
			provider_checkboxes := l_checkboxes

				-- hb1: Search in
			if search_in_manager.providers.is_empty then
				hb1.hide
			else
				hb1.set_padding (layout_constants.small_padding_size)
				create l_radio1.make_with_text (conf_interface_names.dialog_search_library_in)
				l_radio1.set_tooltip (conf_interface_names.dialog_search_library_in_tooltip)
				l_radio1.align_text_left
				hb1.extend (l_radio1)
				hb1.disable_item_expand (l_radio1)
				create hb1cb
				across
					search_in_manager.providers as ic
				loop
					create cb.make_with_text (ic.key)
					cb.enable_select
					if attached ic.item.description as d then
						cb.set_tooltip (d)
					end
					hb1cb.extend (cb)
					hb1cb.disable_item_expand (cb)
					l_checkboxes.put (cb, ic.key)
					cb.select_actions.extend (agent request_update_filter)
				end
				hb1.extend (hb1cb)
			end

				-- hb2: Search by class
			if search_by_class_manager.providers.is_empty then
				hb2.hide
			else
				hb2.set_padding (layout_constants.small_padding_size)
				create l_radio2.make_with_text (conf_interface_names.dialog_search_library_by_class)
				l_radio2.set_tooltip (conf_interface_names.dialog_search_library_by_class_tooltip)
				l_radio2.align_text_left
				hb2.extend (l_radio2)
				hb2.disable_item_expand (l_radio2)
				create hb2cb
				across
					search_by_class_manager.providers as ic
				loop
					create cb.make_with_text (ic.key)
					cb.enable_select
					if attached ic.item.description as d then
						cb.set_tooltip (d)
					end
					hb2cb.extend (cb)
					hb2cb.disable_item_expand (cb)
					l_checkboxes.put (cb, ic.key)
					cb.select_actions.extend (agent request_update_filter)
				end
				hb2.extend (hb2cb)
			end

				-- make the 2 radio buttons works together  (in same radio group).
			hb2.merge_radio_button_groups (hb1)

				-- Enable/disable sensitive on collection of checkboxes, according to selected radio buttons.
			if l_radio1 /= Void then
				l_radio1.select_actions.extend (agent enable_search_in_mode)
				if hb1cb /= Void then
					l_radio1.select_actions.extend (agent hb1cb.enable_sensitive)
				end
				if hb2cb /= Void then
					l_radio1.select_actions.extend (agent hb2cb.disable_sensitive)
				end

					-- Default is "search in .."
				l_radio1.enable_select
			end
			if l_radio2 /= Void then
				l_radio2.select_actions.extend (agent enable_search_by_class_mode)
				if hb1cb /= Void then
					l_radio2.select_actions.extend (agent hb1cb.disable_sensitive)
				end
				if hb2cb /= Void then
					l_radio2.select_actions.extend (agent hb2cb.enable_sensitive)
				end
			end

		end

	build_iron_package_box
			-- Build the iron package box.
		local
			w: like iron_package_widget
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			but: EV_BUTTON
		do
			w := iron_package_widget

			create vb
			vb.extend (w.widget)

			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)

			create but.make_with_text_and_action (names.b_cancel, agent on_cancel)
			layout_constants.set_default_width_for_button (but)
			hb.extend (create {EV_CELL})
			hb.extend (but)
			hb.disable_item_expand (but)

			iron_package_box := vb

			w.on_install_actions.extend (agent (p: IRON_PACKAGE)
					do
						iron_service.install_package (p, agent on_iron_package_installed (p, ?))
					end
				)
			w.on_uninstall_actions.extend (agent (p: IRON_PACKAGE)
					do
						iron_service.uninstall_package (p, agent on_iron_package_uninstalled (p, ?))
					end
				)
		end

	build_library_selection_box
			-- Build the name + location + browse button.
		local
			w: like library_widget
		do
			w := library_widget
			w.on_ok_actions.extend (agent on_ok)
			w.on_cancel_actions.extend (agent on_cancel)
		end

feature {NONE} -- Update filter

	search_mode: INTEGER

	is_search_in_mode: BOOLEAN
		do
			Result := search_mode = search_in_mode
		end

	is_search_by_class_mode: BOOLEAN
		do
			Result := search_mode = search_by_class_mode
		end

	search_in_mode: INTEGER = 1
	search_by_class_mode: INTEGER = 2

	enable_search_in_mode
		do
			search_mode := search_in_mode
		end

	enable_search_by_class_mode
		do
			search_mode := search_by_class_mode
		end

	update_filter_timeout: detachable EV_TIMEOUT

	request_update_filter
		local
			l_update_filter_timeout: like update_filter_timeout
		do
			cancel_delayed_update_filter
			l_update_filter_timeout := update_filter_timeout
			if l_update_filter_timeout = Void then
				create l_update_filter_timeout
				update_filter_timeout := l_update_filter_timeout
				l_update_filter_timeout.actions.extend_kamikaze (agent delayed_update_filter)
			end
			l_update_filter_timeout.set_interval (1_000) -- 1 second is enough.
		end

	cancel_delayed_update_filter
		do
			if attached update_filter_timeout as l_update_filter_timeout then
				l_update_filter_timeout.destroy
				update_filter_timeout := Void
			end
		end

	delayed_update_filter
		do
			cancel_delayed_update_filter
			if not is_destroyed then
				update_filter
			end
		end

	update_filter
		do
			populate
		end

feature {NONE} -- GUI elements

	selection_cell: EV_CELL

	iron_package_box: detachable EV_WIDGET

	iron_package_widget: IRON_PACKAGE_WIDGET

	library_selection_box: EV_WIDGET
		do
			Result := library_widget.widget
		end

	library_widget: ADD_LIBRARY_WIDGET

	search_results_box: EIFFEL_SEARCH_ITEMS_BOX [ES_LIBRARY_PROVIDER_ITEM]
			-- Search results box.

	filter: EV_TEXT_FIELD
			-- Filter.

	filter_text: STRING_32
			-- Filter text.
		do
			Result := filter.text
		end

	provider_checkboxes: detachable STRING_TABLE [EV_CHECK_BUTTON]

	provider_ids: detachable ARRAYED_LIST [READABLE_STRING_GENERAL]
		do
			if attached provider_checkboxes as tb then
				create Result.make (tb.count)
				across
					tb as ic
				loop
					if ic.item.is_sensitive and then ic.item.is_selected then
						Result.extend (ic.key)
					end
				end
				if Result.is_empty then
					Result := Void
				end
			end
		end

feature -- Access

	last_group: detachable CONF_LIBRARY
			-- Last created group.

feature {NONE} -- Callback

	on_iron_packages_changed (a_package: detachable IRON_PACKAGE)
			-- Called when the iron packages are changed from the IRON_PACKAGE_COLLECTION_BOX.
		do
			reset_iron_configuration_libraries (target)
			if not repopulate_requested then
				populate
			end
		end

	repopulate_requested: BOOLEAN
			-- Any pending request to call `populate'?

	on_iron_package_installed (p: IRON_PACKAGE; a_succeed: BOOLEAN)
		do
			if a_succeed then
				on_iron_packages_changed (p)
				search_results_box.select_row_by_value (p)
			end
		end

	on_iron_package_uninstalled (p: IRON_PACKAGE; a_succeed: BOOLEAN)
		do
			if a_succeed then
				on_iron_packages_changed (p)
				search_results_box.select_row_by_value (p)
			end
		end

feature {NONE} -- Libraries cache.

	update_index
		local
			nb: INTEGER
		do
			if attached lib_manager as m then
				if attached provider_checkboxes as l_provider_checkboxes then
					across
						l_provider_checkboxes as ic
					loop
						if ic.item.is_sensitive and then ic.item.is_selected then
							m.reset_provider (ic.key, target)
							nb := nb + 1
						end
					end
				end
				if nb = 0 then
					m.reset_all (target)
				end
			end
			populate
		end

feature {NONE} -- Configuration settings for libraries

	popup_configuration_information
			-- Popup information related to library dialog configuration.
		local
			dlg: EV_DIALOG
			p1, p2: PATH
			us1, us2: detachable READABLE_STRING_GENERAL
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			t: EV_TEXT
			l_close_button: EV_BUTTON
		do
			p1 := eiffel_layout.libraries_config_name
			if eiffel_layout.is_user_files_supported and then attached eiffel_layout.user_priority_file_name (p1, False) as p then
				us1 := p.name
			end
			p2 := eiffel_layout.precompiles_config_name
			if eiffel_layout.is_user_files_supported and then attached eiffel_layout.user_priority_file_name (p2, False) as p then
				us2 := p.name
			end

			create dlg
			dlg.set_title (conf_interface_names.dialog_display_configuration_title)
			create vb
			vb.set_border_width (Layout_constants.Default_border_size)
			vb.set_padding (Layout_constants.Default_padding_size)

			create t.make_with_text (conf_interface_names.dialog_display_configuration_text (p1.name, us1, p2.name, us2 , eiffel_layout.is_user_files_supported))
			t.disable_edit
			t.set_background_color ((create {EV_STOCK_COLORS}).white)
			t.set_minimum_size (500, 200)
			vb.extend (t)
			create hb
			create l_close_button.make_with_text (conf_interface_names.general_close)
			l_close_button.select_actions.extend (agent dlg.destroy)
			hb.set_padding (Layout_constants.Default_padding_size)
			dlg.set_icon_pixmap (Default_pixmaps.Information_pixmap)

			hb.extend (create {EV_CELL})
			hb.extend (l_close_button)
			hb.disable_item_expand (l_close_button)
			hb.extend (create {EV_CELL})
			vb.extend (hb)
			vb.disable_item_expand (hb)
			dlg.extend (vb)

			dlg.show_modal_to_window (Current)
		end

feature {NONE} -- Access

	lib_manager: detachable ES_LIBRARY_PROVIDER_SERVICE
		do
			if is_search_by_class_mode then
				Result := search_by_class_manager
			elseif is_search_in_mode then
				Result := search_in_manager
			end
		end

	search_in_manager: ES_LIBRARY_PROVIDER_SERVICE
		once
			create Result.make (3)
			Result.register (create {ES_LIBRARY_LOCAL_PROVIDER})
			Result.register (create {ES_LIBRARY_IRON_PROVIDER})
			Result.register (create {ES_LIBRARY_IRON_PACKAGE_PROVIDER}.make (create {ES_IRON_SERVICE}))
		end

	search_by_class_manager: ES_LIBRARY_PROVIDER_SERVICE
		once
			create Result.make (1)
			Result.register (create {ES_LIBRARY_INDEX_PROVIDER})
		end

	reset_configuration_libraries (a_target: CONF_TARGET)
		do
			search_in_manager.reset_provider ({ES_LIBRARY_LOCAL_PROVIDER}.identifier, a_target)
		end

	reset_iron_configuration_libraries (a_target: CONF_TARGET)
		do
			search_in_manager.reset_provider ({ES_LIBRARY_IRON_PROVIDER}.identifier, a_target)
			search_in_manager.reset_provider ({ES_LIBRARY_IRON_PACKAGE_PROVIDER}.identifier, a_target)
		end

feature {NONE} -- Action handlers

	on_library_selected (a_library: detachable CONF_SYSTEM_VIEW)
			-- Called when a library is selected
		require
			is_library_target: a_library /= Void implies a_library.has_library_target
		do
			library_widget.set_library (a_library)
		end

	on_iron_package_selected (a_iron_package: IRON_PACKAGE)
		require
			a_iron_package_set: a_iron_package /= Void
		do
			iron_package_widget.set_package (a_iron_package)
		end

	on_search_item_selected (a_search_item: detachable ES_LIBRARY_PROVIDER_ITEM)
		local
			cl_item: EV_WIDGET
			w: EV_WIDGET
		do
			if not selection_cell.is_empty then
				cl_item := selection_cell.item
			else
				w := library_selection_box
			end

			if a_search_item = Void then
				w := library_selection_box
				on_library_selected (Void)
			elseif attached {CONF_SYSTEM_VIEW} a_search_item.value as cfg then
				w := library_selection_box
				on_library_selected (cfg)
			elseif attached {IRON_PACKAGE} a_search_item.value as l_iron_package then
				w := iron_package_box
				on_iron_package_selected (l_iron_package)
			elseif attached {LIBRARY_INFO} a_search_item.value as l_lib_info then
					-- FIXME: try to get more information from the associated library!
				w := library_selection_box
				on_library_selected (Void)
				library_widget.set_name (l_lib_info.name)
				library_widget.set_location (l_lib_info.location.name)
			else
				w := library_selection_box
			end
			if cl_item /= w then
				selection_cell.wipe_out
				if w /= Void then
					selection_cell.extend (w)
				end
			end
		end

	on_ok (w: ADD_LIBRARY_WIDGET)
			-- Add library and close the dialog.
		local
			l_sys: CONF_SYSTEM
			l_name: READABLE_STRING_32
			l_location: READABLE_STRING_32
			g: like last_group
		do
				-- library choosen?
			if filter.has_focus then
					-- Ignore global Ok.
			else
				l_name := w.name
				l_location := w.location
				if not l_location.is_empty and not l_name.is_empty then
					if not is_valid_group_name (l_name) then
						(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.invalid_library_name, Current, Void)
					elseif group_exists (l_name, target) then
						(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.group_already_exists (l_name), Current, Void)
					else
						g := factory.new_library (l_name, l_location, target)
						last_group := g
							-- add an empty classes list that it get's displayed in the classes tree
						g.set_classes (create {STRING_TABLE [CONF_CLASS]}.make (0))
						l_sys := factory.new_system_generate_uuid_with_file_name ("dummy_location", "dummy", latest_namespace)
						l_sys.set_application_target (target)
						g.set_library_target (factory.new_target ("dummy", l_sys))
						target.add_library (g)
						destroy
					end
				end
			end
		ensure
			is_ok_last_library: is_ok implies last_group /= Void
		end

	on_cancel
			-- Close the dialog.
		do
			destroy
		end

feature {NONE} -- Basic operation

	all_search_results (a_filter: detachable READABLE_STRING_GENERAL; a_provider_ids: detachable LIST [READABLE_STRING_GENERAL]): LIST [ES_LIBRARY_PROVIDER_ITEM]
		require
			provider_ids_void_or_not_empty: a_provider_ids /= Void implies not a_provider_ids.is_empty
		local
			libs: detachable LIST [ES_LIBRARY_PROVIDER_ITEM]
		do
			if attached lib_manager as m then
				libs := m.libraries (a_filter, target, provider_ids)
			end
			if libs /= Void then
				create {ARRAYED_LIST [ES_LIBRARY_PROVIDER_ITEM]} Result.make (libs.count)
				across
					libs as ic
				loop
					Result.force (ic.item)
				end
				sort_search_items (Result)
			else
				create {ARRAYED_LIST [ES_LIBRARY_PROVIDER_ITEM]} Result.make (0)
			end
		end

	populate
			-- Populates items in the UI
		local
			l_style: detachable EV_POINTER_STYLE
			l_box: like search_results_box
			retried: BOOLEAN
			popup: detachable EV_POPUP_WINDOW
			bb,vb: EV_VERTICAL_BOX
			lab: EV_LABEL
		do
			repopulate_requested := False
			if not retried and attached lib_manager as l_lib_manager then
				l_style := pointer_style
				set_pointer_style ((create {EV_STOCK_PIXMAPS}).busy_cursor)
				create popup.make_with_shadow
				create bb
				bb.set_border_width (1)
				create vb
				bb.extend (vb)
				vb.set_border_width (3 * layout_constants.default_border_size)
				vb.extend (create {EV_LABEL}.make_with_text (conf_interface_names.dialog_create_searching_please_wait_message))

				create lab.make_with_text ("...")
				vb.extend (lab)

				popup.extend (bb)
				popup.set_background_color ((create {EV_STOCK_COLORS}).white)
				popup.propagate_background_color
				bb.set_background_color ((create {EV_STOCK_COLORS}).blue)
				popup.set_position (x_position + (width - popup.width) // 2, y_position + (height - popup.height) // 2)
				popup.show_relative_to_window (Current)
				popup.refresh_now


				l_lib_manager.on_provider_execution_begin_actions.extend (agent (ia_prov: ES_LIBRARY_PROVIDER; ia_lab: EV_LABEL)
						do
							ia_lab.set_text ("Process " + ia_prov.identifier + " ...")
							ia_lab.refresh_now
						end(?, lab)
					)
				l_lib_manager.on_provider_execution_end_actions.extend (agent (ia_prov: ES_LIBRARY_PROVIDER; ia_lab: EV_LABEL)
						do
							ia_lab.set_text ("...")
							ia_lab.refresh_now
						end(?, lab)
					)

				l_box := search_results_box
				l_box.set_items (all_search_results (filter_text, provider_ids))

				l_box.update_grid
				l_lib_manager.on_provider_execution_begin_actions.wipe_out
				l_lib_manager.on_provider_execution_end_actions.wipe_out
			end
			if popup /= Void then
				popup.destroy
			end

			if l_style /= Void then
				set_pointer_style (l_style)
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation: iron api

	iron_service: ES_GUI_IRON_SERVICE

feature {NONE} -- Implementation

	sort_search_items (lst: LIST [ES_LIBRARY_PROVIDER_ITEM])
		do
			if attached lib_manager as m then
				m.sort_list (lst)
			end
		end

invariant
	target_set_in_boxes: search_results_box.target = target

;note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
