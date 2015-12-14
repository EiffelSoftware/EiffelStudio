note
	description: "Dialog to add a library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_LIBRARY_DIALOG

inherit
	CREATE_GROUP_DIALOG
		redefine
			initialize,
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

	initialize
			-- Initialize.
		local
			l_btn: EV_BUTTON
			main, vb, vb2, l_padding: EV_VERTICAL_BOX
			hb, hbf, hb1, hb2: EV_HORIZONTAL_BOX
			l_lbl: EV_LABEL
			l_filter: like filter
			l_clear_filter_button: EV_BUTTON
			l_update_index_button: EV_BUTTON
			nb: EV_NOTEBOOK
			libs_tab: detachable EV_NOTEBOOK_TAB
			iron_box: IRON_PACKAGE_COLLECTION_BOX
		do
			Precursor

			set_title (conf_interface_names.dialog_create_library_title)
			set_icon_pixmap (conf_pixmaps.new_library_icon)

				-- notebook
			create nb
			extend (nb)

				-- libraries		
			create main
			main.set_padding (layout_constants.default_padding_size)
			main.set_border_width (layout_constants.default_border_size)

			nb.extend (main)

			if nb.has (main) then
				libs_tab := nb.item_tab (main)
				nb.item_tab (main).set_text (conf_interface_names.dialog_create_libraries)
			end

			create vb
			main.extend (vb)

				-- default libraries
			create vb2
			vb.extend (vb2)

			vb2.set_padding (layout_constants.small_padding_size)
			vb2.set_border_width (layout_constants.small_border_size)

			create hb1
			hb1.set_padding (layout_constants.small_padding_size)

			create l_lbl.make_with_text (conf_interface_names.dialog_create_library_defaults)
			l_lbl.align_text_left
			hb1.extend (l_lbl)
			hb1.disable_item_expand (l_lbl)

			hb1.extend (create {EV_CELL})
			create hbf
			hb1.extend (hbf)

			hbf.extend (create {EV_LABEL}.make_with_text (Names.l_filter))
			hbf.disable_item_expand (hbf.last)
			create l_filter
			filter := l_filter
			hbf.extend (l_filter)
			l_filter.change_actions.extend (agent request_update_filter)

			create l_clear_filter_button
			l_clear_filter_button.select_actions.extend (agent l_filter.remove_text)
			l_clear_filter_button.set_pixmap (conf_pixmaps.general_remove_icon)
			l_clear_filter_button.set_tooltip (names.b_reset)
			hbf.extend (l_clear_filter_button)
			hbf.disable_item_expand (l_clear_filter_button)


			vb2.extend (hb1)
			vb2.disable_item_expand (hb1)

				-- Create grid
			create libraries_box.make (target)
			libraries_box.set_minimum_size (400, 200)
			libraries_box.on_library_selected_actions.extend (agent on_library_selected)

				-- Create border for the grid
			create l_padding
			l_padding.set_border_width (1)
			l_padding.set_background_color ((create {EV_STOCK_COLORS}).color_3d_shadow)
			l_padding.extend (libraries_box.widget)

			vb2.extend (l_padding)

				-- Libraries cache update
			create hb1
			hb1.set_padding (layout_constants.small_padding_size)
			vb2.extend (hb1)
			vb2.disable_item_expand (hb1)

			hb1.extend (create {EV_CELL})

			create l_update_index_button
			l_update_index_button.select_actions.extend (agent update_index)
			l_update_index_button.set_text (conf_interface_names.dialog_create_refresh)
			l_update_index_button.set_tooltip (conf_interface_names.dialog_create_refresh_tooltip)
			l_update_index_button.enable_sensitive
			hb1.extend (l_update_index_button)
			hb1.disable_item_expand (l_update_index_button)
			libraries_update_button := l_update_index_button

			create l_btn
			l_btn.set_pixmap (conf_pixmaps.project_settings_advanced_icon)
			l_btn.select_actions.extend (agent popup_configuration_information)
			l_btn.set_tooltip (conf_interface_names.dialog_display_configuration_tooltip)
			hb1.extend (l_btn)
			hb1.disable_item_expand (l_btn)

				-- name
			create vb2
			vb.extend (vb2)
			vb.disable_item_expand (vb2)
			vb2.set_padding (layout_constants.small_padding_size)
			vb2.set_border_width (layout_constants.small_border_size)

			create l_lbl.make_with_text (conf_interface_names.dialog_create_library_name)
			vb2.extend (l_lbl)
			vb2.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create name
			vb2.extend (name)
			vb2.disable_item_expand (name)

				-- location
			create vb2
			vb.extend (vb2)
			vb.disable_item_expand (vb2)
			vb2.set_padding (layout_constants.small_padding_size)
			vb2.set_border_width (layout_constants.small_border_size)

			create l_lbl.make_with_text (conf_interface_names.dialog_create_library_location)
			vb2.extend (l_lbl)
			vb2.disable_item_expand (l_lbl)
			l_lbl.align_text_left

			create hb2
			vb2.extend (hb2)
			vb2.disable_item_expand (hb2)
			hb2.set_padding (layout_constants.small_padding_size)

			create location
			hb2.extend (location)

			create l_btn.make_with_text_and_action (conf_interface_names.browse, agent browse)
			l_btn.set_pixmap (conf_pixmaps.general_open_icon)
			hb2.extend (l_btn)
			hb2.disable_item_expand (l_btn)

			-----------------
			--| [Ok] [Cancel]
			create hb
			main.extend (hb)
			main.disable_item_expand (hb)
			hb.extend (create {EV_CELL})
			hb.set_padding (layout_constants.default_padding_size)

			create l_btn.make_with_text (names.b_ok)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			set_default_push_button (l_btn)
			l_btn.select_actions.extend (agent on_ok)
			layout_constants.set_default_width_for_button (l_btn)

			create l_btn.make_with_text (names.b_cancel)
			hb.extend (l_btn)
			hb.disable_item_expand (l_btn)
			set_default_cancel_button (l_btn)
			l_btn.select_actions.extend (agent on_cancel)
			layout_constants.set_default_width_for_button (l_btn)

				-- end of notebook tab #1 : Standard libraries
				-- notebook tab #2: Iron

				-- libraries		
			create main
			main.set_padding (layout_constants.default_padding_size)
			main.set_border_width (layout_constants.default_border_size)

			create vb2
			main.extend (vb2)

			nb.extend (main)
			if
				nb.has (main) and then
				attached nb.item_tab (main) as iron_tab
			then
				iron_tab.set_text (conf_interface_names.dialog_create_iron_packages)
				create iron_box.make (target)
					--| Whenever an operation is made on iron packages via the current EiffelStudio's dialog
					--| `on_iron_packages_changed' will be executed.
				iron_box.on_iron_packages_changed_actions.extend (agent on_iron_packages_changed)
				vb2.extend (iron_box.widget)

				-----------------
				--| [Back to libraries]
				create hb
				main.extend (hb)
				main.disable_item_expand (hb)
				hb.extend (create {EV_CELL})
				hb.set_padding (layout_constants.default_padding_size)

				create l_btn.make_with_text (conf_interface_names.dialog_create_back_to_previous_tab)
				hb.extend (l_btn)
				hb.disable_item_expand (l_btn)
				if libs_tab /= Void then
					l_btn.select_actions.extend (agent libs_tab.enable_select)
				else
					l_btn.select_actions.extend (agent nb.select_item (nb.first))
				end
				layout_constants.set_default_width_for_button (l_btn)

				nb.selection_actions.extend (agent (ia_libs, ia_nb: detachable EV_NOTEBOOK_TAB; ia_iron_box: IRON_PACKAGE_COLLECTION_BOX)
						do
							if ia_nb /= Void and then ia_nb.is_selected then
									--| the "IRON Packages" tab is selected
									--| then populate the associated grid to display iron packages
								ev_application.add_idle_action_kamikaze (agent ia_iron_box.populate)
							elseif ia_libs /= Void and then ia_libs.is_selected then
									--| the "Libraries" tab is selected
								if repopulate_requested then
										--| a command requested the re-population of the libraries grid
										--| most likely due to recent IRON changes from the related dialog
										--| that resetted the cache of iron libraries data.
									ev_application.add_idle_action_kamikaze (agent populate_libraries)
								end
							end
						end (libs_tab, iron_tab, iron_box)
					)
			end

				-- Initial Event
			show_actions.extend_kamikaze (agent
				do
					populate_libraries
					libraries_box.set_focus
				end)
		end

feature {NONE} -- Update filter

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
			l_update_filter_timeout.set_interval (700)
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
			update_filter
		end

	update_filter
		local
			l_style: EV_POINTER_STYLE
		do
			l_style := pointer_style
			set_pointer_style (create {EV_POINTER_STYLE}.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.busy_cursor))

			libraries_box.set_filter_text (filter_text)
			libraries_box.update_grid

			set_pointer_style (l_style)
		end

feature {NONE} -- GUI elements

	libraries_box: EIFFEL_LIBRARY_COLLECTION_BOX
			-- Libraries collection box.

	filter: EV_TEXT_FIELD
			-- Filter.

	filter_text: detachable STRING_32
			-- Filter text.
		do
			Result := filter.text
		end

	name: EV_TEXT_FIELD
			-- Name of the library.

	location: EV_TEXT_FIELD
			-- Location of the library configuration file, choosen by the user.

	browse_dialog: EV_FILE_OPEN_DIALOG
			-- Dialog to browse to a library
		local
			l_dir: DIRECTORY
		once
			create Result
			create l_dir.make_with_path (target.system.directory)
			if l_dir.is_readable then
				Result.set_start_path (l_dir.path)
			end
			Result.filters.extend ([config_files_filter, config_files_description])
			Result.filters.extend ([all_files_filter, all_files_description])
		ensure
			Result_not_void: Result /= Void
		end

	libraries_update_button: EV_BUTTON
			-- Update libraries cache.

feature -- Access

	last_group: CONF_LIBRARY
			-- Last created group.

feature {NONE} -- Callback

	on_iron_packages_changed (a_package: detachable IRON_PACKAGE)
			-- Called when the iron packages are changed from the IRON_PACKAGE_COLLECTION_BOX.
		do
			reset_iron_configuration_libraries_cache
			if not repopulate_requested then
				repopulate_requested := True
			end
		end

	repopulate_requested: BOOLEAN
			-- Any pending request to call `populate_libraries'?

feature {NONE} -- Libraries cache.

	update_index
		do
			cache_data (Void, iron_configuration_libraries_cache_name (target.setting_msil_generation))
			cache_data (Void, configuration_libraries_cache_name (target.setting_msil_generation))
			populate_libraries
		end

	reset_iron_configuration_libraries_cache
		do
			cache_data (Void, iron_configuration_libraries_cache_name (target.setting_msil_generation))
		end

	iron_configuration_libraries_cache_name (a_is_dotnet: BOOLEAN): STRING
		do
			if a_is_dotnet then
				Result := "iron_configuration_libraries_dotnet.cache"
			else
				Result := "iron_configuration_libraries.cache"
			end
		end

	configuration_libraries_cache_name (a_is_dotnet: BOOLEAN): STRING
		do
			if a_is_dotnet then
				Result := "configuration_libraries_dotnet.cache"
			else
				Result := "configuration_libraries.cache"
			end
		end

	cached_data (a_name: READABLE_STRING_GENERAL): detachable ANY
		local
			p: PATH
			f: RAW_FILE
			retried: BOOLEAN
			sed: SED_STORABLE_FACILITIES
			sed_rw: SED_MEDIUM_READER_WRITER
			l_deserializer: detachable SED_RECOVERABLE_DESERIALIZER
		do
			if not retried then
				p := eiffel_layout.temporary_path.extended (a_name)
				create f.make_with_path (p)
				if f.exists and then f.is_readable then
					f.open_read
					create sed
					create sed_rw.make_for_reading (f)
						--| Read only if it is a "recoverable" storable file.
						--| and thus, avoid trying to load old data stored
						--| using basic_store ...
					sed_rw.read_header
					if sed_rw.read_natural_32 = sed.eiffel_recoverable_store then
						create l_deserializer.make (sed_rw)
						l_deserializer.decode (False)
						if not l_deserializer.has_error then
							Result := l_deserializer.last_decoded_object
							sed_rw.read_footer
						end
					end
					f.close
				end
			end
		rescue
			retried := True
			retry
		end

	cache_data (a_data: ANY; a_name: READABLE_STRING_GENERAL)
		local
			p: PATH
			f: RAW_FILE
			retried: BOOLEAN
			sed: SED_STORABLE_FACILITIES
			sed_rw: SED_MEDIUM_READER_WRITER
		do
			if not retried then
				p := eiffel_layout.temporary_path.extended (a_name)
				create f.make_with_path (p)
				if a_data /= Void then
					if f.exists and then not f.is_writable then
							-- Ignored but should not occured.
						check False end
					else
						f.create_read_write
						create sed
						create sed_rw.make_for_writing (f)
						sed.store (a_data, sed_rw)
						f.close
					end
				else
					if f.exists then
						f.delete
					end
				end
			end
		rescue
			retried := True
			retry
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
			if eiffel_layout.is_user_files_supported then
				us1 := eiffel_layout.user_priority_file_name (p1, False).name
			end
			p2 := eiffel_layout.precompiles_config_name
			if eiffel_layout.is_user_files_supported then
				us2 := eiffel_layout.user_priority_file_name (p2, False).name
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

	libraries: SEARCH_TABLE [STRING_32]
			-- A set of libraries to display in the dialog
		require
			is_eiffel_layout_defined: is_eiffel_layout_defined
		local
			l_dirs: like lookup_directories
			l_libraries: STRING_TABLE [BOOLEAN]
			l_dir: DIRECTORY
			l_path: IMMUTABLE_STRING_32
			l_lib_path: STRING_32
			l_location: CONF_DIRECTORY_LOCATION
		do
			l_dirs := lookup_directories
			create Result.make (l_dirs.count)
			across l_dirs as ic loop
				create l_location.make (ic.item.path, target)
				l_path := l_location.evaluated_path.name
				create l_dir.make (l_path)
				if l_dir.is_readable then
					create l_libraries.make (10)
					add_configs_in_directory (l_dir, ic.item.depth, l_libraries)
					across l_libraries as ic_libs loop
							-- If the config file was using some environment variable, we just
							-- replace the computed path with what was specified in the config file
							-- for the current entry of `ic'.
						l_lib_path := ic_libs.key.as_string_32.twin
						l_lib_path.replace_substring (ic.item.path, 1, l_path.count)
						Result.put (l_lib_path)
					end
				end
			end
		ensure
			result_attached: Result /= Void
		end

	conf_system_list_from (libs: ITERABLE [READABLE_STRING_32]; nb: INTEGER): STRING_TABLE [CONF_SYSTEM_VIEW]
			-- A set of libraries configurations from `lst' path name.
		require
			is_eiffel_layout_defined: is_eiffel_layout_defined
		local
			l_location: CONF_DIRECTORY_LOCATION
			l_cfg_data: CONF_SYSTEM_VIEW
		do
			create Result.make (nb)

			across libs as ic loop
				create l_location.make (ic.item, target)

				create l_cfg_data.make (l_location)
				if l_cfg_data.has_library_target then
					Result.force (l_cfg_data, ic.item)
				end
			end
		ensure
			result_attached: attached Result
		end

	configuration_libraries: STRING_TABLE [CONF_SYSTEM_VIEW]
			-- A set of libraries configurations to display in the dialog
		require
			is_eiffel_layout_defined: is_eiffel_layout_defined
		local
			l_libs: like libraries
		do
			if attached {like configuration_libraries} cached_data (configuration_libraries_cache_name (target.setting_msil_generation)) as cfg_libs then
				Result := cfg_libs
			else
				l_libs := libraries
				Result := conf_system_list_from (l_libs, l_libs.count)
				cache_data (Result, configuration_libraries_cache_name (target.setting_msil_generation))
			end
		ensure
			result_attached: attached Result
		end

	iron_configuration_libraries: STRING_TABLE [CONF_SYSTEM_VIEW]
		local
			l_installation_api: IRON_INSTALLATION_API
			lst: ARRAYED_LIST [READABLE_STRING_32]
			p: PATH
			l_iron_installation_api_factory: CONF_IRON_INSTALLATION_API_FACTORY
		do
			if attached {like configuration_libraries} cached_data (iron_configuration_libraries_cache_name (target.setting_msil_generation)) as cfg_libs then
				Result := cfg_libs
			else
				create l_iron_installation_api_factory
					--| TODO: improve performance, by caching iron_installation_api in the whole system.
					--| idea: l_iron_installation_api_factory.enable_caching
				l_installation_api := l_iron_installation_api_factory.iron_installation_api (create {IRON_LAYOUT}.make_with_path (eiffel_layout.iron_path, eiffel_layout.installation_iron_path), create {IRON_URL_BUILDER})
				if attached l_installation_api.installed_packages as l_packages then
					create lst.make (l_packages.count)
					across
						l_packages as ic
					loop
						p := l_installation_api.package_installation_path (ic.item)
						if attached l_installation_api.projects_from_installed_package (ic.item) as l_projects then
							across
								l_projects as proj_ic
							loop
								lst.force ({STRING} "iron:" + ic.item.identifier + {STRING_32} ":" + proj_ic.item.name)
							end
						end
					end
					Result := conf_system_list_from (lst, lst.count)
						--| TODO: improve performance, by caching iron_installation_api in the whole system.
						--| this point would be good location to disable the caching.
						--| idea: l_iron_installation_api_factory.disable_caching
				else
					create Result.make (0)
				end
				cache_data (Result, iron_configuration_libraries_cache_name (target.setting_msil_generation))
			end
		end

	lookup_directories: ARRAYED_LIST [TUPLE [path: STRING_32; depth: INTEGER]]
			-- A list of lookup directories
		require
			is_eiffel_layout_defined: is_eiffel_layout_defined
		local
			l_filename: detachable PATH
			l_file: RAW_FILE
		do
			create Result.make (10)

			l_filename := eiffel_layout.libraries_config_name
			create l_file.make_with_path (l_filename)
			if l_file.exists then
				add_lookup_directories (l_filename.name, Result)
			end
			if eiffel_layout.is_user_files_supported then
				l_filename := eiffel_layout.user_priority_file_name (l_filename, True)
				if l_filename /= Void then
					l_file.reset_path (l_filename)
					if l_file.exists then
						add_lookup_directories (l_filename.name, Result)
					end
				end
			end

			if Result.is_empty then
					-- Extend the default library path
				Result.extend ([eiffel_layout.library_path.name.as_string_32, 4])
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Actions

	browse
			-- Browse for a location.
		local
			l_loc: CONF_FILE_LOCATION
			l_dir: DIRECTORY
			l_cfg_data: CONF_SYSTEM_VIEW
		do
			if not location.text.is_empty then
				create l_loc.make (location.text, target)
				create l_dir.make_with_path (l_loc.evaluated_directory)
			end
			if l_dir /= Void and then l_dir.exists then
				browse_dialog.set_start_path (l_dir.path)
			end

			browse_dialog.show_modal_to_window (Current)
			if attached browse_dialog.file_name as l_fn and then not l_fn.is_empty then
				create l_cfg_data.make_from_path (create {PATH}.make_from_string (l_fn))
				if l_cfg_data.has_library_target then
					if
						attached l_cfg_data.conf_option as l_options and then
						l_options.is_void_safety_sufficient (target.options)
					then
						on_library_selected (l_cfg_data, l_fn)
					else
						prompts.show_question_prompt (conf_interface_names.add_non_void_safe_library, Current, agent on_library_selected (l_cfg_data, l_fn), Void)
					end
				else
					prompts.show_error_prompt (conf_interface_names.file_is_not_a_library, Current, Void)
				end
			end
		end

feature {NONE} -- Action handlers

	on_library_selected (a_library: CONF_SYSTEM_VIEW; a_location: READABLE_STRING_GENERAL)
			-- Called when a library is selected
		require
			is_library_target: a_library.has_library_target
		do
			name.set_text (a_library.library_target_name)
			location.set_text (a_location)
		end

	on_ok
			-- Add library and close the dialog.
		local
			l_sys: CONF_SYSTEM
		do
				-- library choosen?
			if not location.text.is_empty and not name.text.is_empty then
				if not is_valid_group_name (name.text) then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.invalid_library_name, Current, Void)
				elseif group_exists (name.text, target) then
					(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (conf_interface_names.group_already_exists (name.text), Current, Void)
				else
					last_group := factory.new_library (name.text, location.text, target)
						-- add an empty classes list that it get's displayed in the classes tree
					last_group.set_classes (create {STRING_TABLE [CONF_CLASS]}.make (0))
					l_sys := factory.new_system_generate_uuid_with_file_name ("dummy_location", "dummy")
					l_sys.set_application_target (target)
					last_group.set_library_target (factory.new_target ("dummy", l_sys))
					target.add_library (last_group)
					is_ok := True
					destroy
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

	all_libraries: STRING_TABLE [CONF_SYSTEM_VIEW]
		local
			l_libraries: like configuration_libraries
			l_iron_libraries: like iron_configuration_libraries
		do
			l_libraries := configuration_libraries
			l_iron_libraries := iron_configuration_libraries
			create Result.make (l_libraries.count + l_iron_libraries.count)
			Result.merge (l_libraries)
			Result.merge (l_iron_libraries)
		end

	populate_libraries
			-- Populates the list of libraries in the UI
		local
			l_style: detachable EV_POINTER_STYLE
			libs_box: like libraries_box
			retried: BOOLEAN
			popup: detachable EV_POPUP_WINDOW
			bb,vb: EV_VERTICAL_BOX
		do
			repopulate_requested := False
			if not retried then
				l_style := pointer_style
				set_pointer_style (create {EV_POINTER_STYLE}.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.busy_cursor))
				create popup.make_with_shadow
				create bb
				bb.set_border_width (1)
				create vb
				bb.extend (vb)
				vb.set_border_width (3 * layout_constants.default_border_size)
				vb.extend (create {EV_LABEL}.make_with_text (conf_interface_names.dialog_create_searching_please_wait_message))

				popup.extend (bb)
				popup.set_background_color ((create {EV_STOCK_COLORS}).white)
				popup.propagate_background_color
				bb.set_background_color ((create {EV_STOCK_COLORS}).blue)
				popup.set_position (x_position + (width - popup.width) // 2, y_position + (height - popup.height) // 2)
				popup.show_relative_to_window (Current)
				popup.refresh_now

				libs_box := libraries_box
				libs_box.set_configuration_libraries (all_libraries)
				libs_box.set_filter_text (filter_text)
				libs_box.update_grid
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

	add_configs_in_directory (a_dir: DIRECTORY; a_depth: INTEGER; a_libraries: STRING_TABLE [BOOLEAN])
			-- Add config files in `a_path' to `a_libraries'.
			-- if `a_depth' is -1, scan all subdirectories without any depth limits.
		require
			a_dir_attached: attached a_dir
			a_dir_is_readable: a_dir.is_readable
			a_depth_big_enough: a_depth >= -1
			a_libraries_attached: attached a_libraries
		local
			l_file_name: PATH
			l_file: RAW_FILE
			l_entry: PATH
		do
			across a_dir.entries as l_entries loop
				l_entry := l_entries.item
				if l_entry.is_current_symbol or l_entry.is_parent_symbol then
					 -- Nothing to do
				else
					l_file_name := a_dir.path.extended_path (l_entry)
					create l_file.make_with_path (l_file_name)
					if l_file.exists then
						if l_file.is_directory then
							if a_depth = -1 or a_depth > 0 then
									-- Recurse
								add_configs_in_directory (create {DIRECTORY}.make_with_path (l_file_name), (a_depth - 1).max (-1), a_libraries)
							end
						elseif l_file.is_plain and then valid_config_extension (l_entry.name) then
								-- File is an ECF, we add it to `a_libraries'.
							a_libraries.put (True, l_file_name.name)
						end
					end
				end
			end
		end

	add_lookup_directories (a_path: STRING_32; a_list: ARRAYED_LIST [TUPLE [path: READABLE_STRING_GENERAL; depth: INTEGER]])
			-- Adds look up directories from a file located at `a_path' into `a_list'
		require
			a_path_attached: attached a_path
			not_a_path_is_empty: not a_path.is_empty
			a_path_exists: (create {RAW_FILE}.make_with_name (a_path)).exists
			a_list_attached: attached a_list
		local
			l_file: RAW_FILE
			l_line: STRING
			l_pos: INTEGER
			l_location: STRING
			l_depth_string: STRING
			l_depth: INTEGER
		do
			create l_file.make_with_name (a_path)
			if l_file.is_readable then
				from l_file.open_read until l_file.end_of_file loop
					l_file.read_line
					l_line := l_file.last_string
					if l_line.is_empty then
							-- Ignore
					elseif l_line.starts_with ("--") then
							-- Ignore comment
					else
						l_line.left_adjust
						l_line.right_adjust
						l_pos := l_line.last_index_of ('%T', l_line.count)
						if l_pos > 1 then
							l_location := l_line.substring (1, l_pos - 1)
							l_location.right_adjust
							if l_pos < l_line.count then
								l_depth_string := l_line.substring (l_pos + 1, l_line.count)
								l_depth_string.left_adjust
								l_depth_string.right_adjust
							end
						else
							l_location := l_line
						end
						l_depth := 1 -- Default
						if l_depth_string /= Void then
							if l_depth_string.is_integer then
								l_depth := l_depth_string.to_integer
							elseif l_depth_string.is_case_insensitive_equal_general ("*") then
								l_depth := -1
							end
						end
						--| FIXME: Unicode content of the file, does not provide Unicode file name
						--| unless it is UTF-8 encoded ...
						a_list.extend ([l_location.as_string_32, l_depth])
					end
				end
			end
		end

feature {NONE} -- Constants

	name_column: INTEGER = 1
			-- Index of a column with a library name.

	void_safety_column: INTEGER = 2
			-- Index of a column with void-safety status.

	location_column: INTEGER = 3
			-- Index of a column with a library location.

invariant
	target_set_in_boxes: libraries_box.target = target

;note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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
