note
	description: "Popup dialog to import settings from previous installations."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_SETTINGS_IMPORT_DIALOG

inherit
	EB_DIALOG

	EV_KEY_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	SHARED_ES_CLOUD_SERVICE
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_window: EB_DEVELOPMENT_WINDOW)
			-- Initialize Current with `a_window' as parent.
		require
			a_window_not_void: a_window /= Void
		do
			dev_window := a_window
			create on_finish_actions

			make_with_title (interface_names.l_settings_management)
			set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)
			set_size (600, 50)

			build_interface

			key_press_actions.extend (agent escape_check (?))
			focus_in_actions.extend (agent on_window_focused)
			close_request_actions.extend (agent on_close)
		end

	build_interface
		local
			cell: EV_CELL
			vbox,vb: EV_VERTICAL_BOX
			l_advanced_box: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			cb: EV_COMBO_BOX
			fr: EV_FRAME
			tf: EV_TEXT_FIELD
			but_check: EV_CHECK_BUTTON
			but: EV_BUTTON
			tg_but: EV_TOGGLE_BUTTON
			align_lst: ARRAYED_LIST [EV_WIDGET]
			w: INTEGER
		do
			create vbox
			vbox.set_border_width (layout_constants.default_border_size)
			vbox.set_padding_width (layout_constants.default_padding_size)
			extend (vbox)

			create cell
			main_cell := cell
			vbox.extend (cell) --; vbox.disable_item_expand (cell)

			create fr.make_with_text (interface_names.l_installed_versions)
			cell.extend (fr)

			versions_frame := fr

			create vb
			fr.extend (vb)
			vb.set_border_width (layout_constants.default_border_size)
			vb.set_padding_width (layout_constants.default_padding_size)

				-- Installed Versions
			create cb
			versions_combo := cb
			cb.disable_edit
			vb.extend (cb)
			vb.disable_item_expand (cb)

			create progress_bar
			progress_bar.set_step (1)
			progress_bar.reset_with_range (1 |..| 100)

			create l_advanced_box
			l_advanced_box.set_border_width (layout_constants.default_border_size)
			l_advanced_box.set_padding_width (layout_constants.default_padding_size)
			l_advanced_box.hide
			vb.extend (l_advanced_box)
			vb.disable_item_expand (l_advanced_box)

			create align_lst.make (5)

					-- Preferences
			create hb
			hb.set_padding_width (layout_constants.tiny_padding_size)
			l_advanced_box.extend (hb); l_advanced_box.disable_item_expand (hb)
			create but_check.make_with_text ("Preferences")
			but_check.enable_select
			align_lst.extend (but_check)
			hb.extend (but_check); hb.disable_item_expand (but_check)
			preferences_cb := but_check
			create tf; tf.disable_edit; hb.extend (tf)
			preferences_tf := tf

				-- UI layout (docking)
			create hb
			hb.set_padding_width (layout_constants.tiny_padding_size)
			l_advanced_box.extend (hb); l_advanced_box.disable_item_expand (hb)
			create but_check.make_with_text ("UI layout settings")
			but_check.set_tooltip ("UI layout settings (tools configuration, ...)")
			but_check.enable_select
			align_lst.extend (but_check)
			hb.extend (but_check); hb.disable_item_expand (but_check)
			ui_layout_cb := but_check
			create tf; tf.disable_edit; hb.extend (tf)
			ui_layout_tf := tf

				-- user_files_path ("studio")
			create hb
			hb.set_padding_width (layout_constants.tiny_padding_size)
			l_advanced_box.extend (hb); l_advanced_box.disable_item_expand (hb)
			create but_check.make_with_text ("Configuration Files")
			but_check.set_tooltip ("Overriding files from $ISE_EIFFEL/studio .")
			but_check.enable_select
			align_lst.extend (but_check)
			hb.extend (but_check); hb.disable_item_expand (but_check)
			studio_config_cb := but_check
			create tf; tf.disable_edit; hb.extend (tf)
			studio_config_tf := tf

				-- user_templates_path
			create hb
			hb.set_padding_width (layout_constants.tiny_padding_size)
			l_advanced_box.extend (hb); l_advanced_box.disable_item_expand (hb)
			create but_check.make_with_text ("Templates")
			but_check.set_tooltip ("User templates.")
			but_check.enable_select
			align_lst.extend (but_check)
			hb.extend (but_check); hb.disable_item_expand (but_check)
			templates_cb := but_check
			create tf; tf.disable_edit; hb.extend (tf)
			templates_tf := tf

				-- *.ini files under user_files_path
			create hb
			hb.set_padding_width (layout_constants.tiny_padding_size)
			l_advanced_box.extend (hb); l_advanced_box.disable_item_expand (hb)
			create but_check.make_with_text ("*.ini files")
			but_check.set_tooltip (".ini files such as external commands.")
			but_check.enable_select
			align_lst.extend (but_check)
			hb.extend (but_check); hb.disable_item_expand (but_check)
			ini_files_cb := but_check
			create tf; tf.disable_edit; hb.extend (tf)
			ini_files_tf := tf

				-- Cloud account data
			create hb
			hb.set_padding_width (layout_constants.tiny_padding_size)
			l_advanced_box.extend (hb); l_advanced_box.disable_item_expand (hb)
			create but_check.make_with_text ("Cloud account data")
			but_check.set_tooltip ("Cloud account data such as credential.")
			but_check.enable_select
			align_lst.extend (but_check)
			hb.extend (but_check); hb.disable_item_expand (but_check)
			cloud_account_cb := but_check
			create tf; tf.disable_edit; hb.extend (tf)
			cloud_account_tf := tf

				-- Custom Edit
			create hb
			hb.set_padding_width (layout_constants.tiny_padding_size)
			l_advanced_box.extend (hb); l_advanced_box.disable_item_expand (hb)
			hb.extend (create {EV_CELL})
			create tg_but.make_with_text (interface_names.b_edit_settings)
			tg_but.set_tooltip (interface_names.l_edit_custom_settings)
			tg_but.set_minimum_width (tg_but.width.max (100))
			hb.extend (tg_but); hb.disable_item_expand (tg_but)
			tg_but.select_actions.extend (agent on_custom_edit (tg_but))

				-- Align check button
			across
				align_lst as ic
			loop
				w := w.max (ic.item.width)
			end
			across
				align_lst as ic
			loop
				ic.item.set_minimum_width (w)
			end

				-- End of l_advanced_box
			advanced_box := l_advanced_box

			vb.extend (create {EV_CELL})

			create hb
			create but_check.make_with_text (interface_names.b_advanced)
			but_check.set_tooltip (interface_names.l_advanced_options)
			hb.extend (but_check)
			hb.disable_item_expand (but_check)
			advanced_button := but_check
			but_check.select_actions.extend (agent on_advanced_selected)
			hb.extend (create {EV_CELL})

			create but.make_with_text (interface_names.b_import_settings)
			but.select_actions.extend (agent on_import)
			import_button := but
			but.disable_sensitive
			hb.extend (but)
			hb.disable_item_expand (but)
			layout_constants.set_default_size_for_button (but)

			create but.make_with_text (interface_names.b_close)
			but.select_actions.extend (agent on_close)
			hb.extend (but)
			hb.disable_item_expand (but)
			layout_constants.set_default_size_for_button (but)

			create but.make_with_text (interface_names.b_arrow_back)
			but.select_actions.extend (agent update)
			back_button := but
			hb.extend (but)
			hb.disable_item_expand (but)
			layout_constants.set_default_size_for_button (but)

			vbox.extend (hb)
			vbox.disable_item_expand (hb)

			show_actions.extend (agent update)
		end

feature -- Access

	dev_window: EB_DEVELOPMENT_WINDOW

	main_cell: EV_CELL

	progress_bar: EB_PERCENT_PROGRESS_BAR

	versions_frame: EV_FRAME

	versions_combo: EV_COMBO_BOX

	preferences_tf,
	ui_layout_tf,
	templates_tf,
	studio_config_tf,
	ini_files_tf,
	cloud_account_tf: EV_TEXT_FIELD


	preferences_cb,
	ui_layout_cb,
	studio_config_cb,
	templates_cb,
	ini_files_cb,
	cloud_account_cb: EV_CHECK_BUTTON

	advanced_button: EV_CHECK_BUTTON
	advanced_box: EV_BOX

	import_button: EV_BUTTON
	back_button: EV_BUTTON

feature -- Actions

	on_finish_actions: ACTION_SEQUENCE
			-- Actions triggered when import is done or cancelled.

feature -- Event

	on_advanced_selected
		do
			if advanced_button.is_selected then
				advanced_box.show
			else
				advanced_box.hide
				set_size (width, 50)
			end
		end

	on_custom_edit (but: EV_TOGGLE_BUTTON)
		do
			if but.is_selected then
				but.set_text (interface_names.b_apply)
				preferences_cb.enable_sensitive
				preferences_tf.enable_edit

				ui_layout_cb.enable_sensitive
				ui_layout_tf.enable_edit

				studio_config_cb.enable_sensitive
				studio_config_tf.enable_edit

				templates_cb.enable_sensitive
				templates_tf.enable_edit

				ini_files_cb.enable_sensitive
				ini_files_tf.enable_edit

				cloud_account_cb.enable_sensitive
				cloud_account_tf.enable_edit

				import_button.hide
			else
				but.set_text (interface_names.b_edit_settings)
				preferences_tf.disable_edit

				ui_layout_tf.disable_edit

				studio_config_tf.disable_edit

				templates_tf.disable_edit

				ini_files_tf.disable_edit

				cloud_account_tf.disable_edit

				update_choices_status
				import_button.show
			end
		end

	on_import
		local
			l_prefs_versions: PREFERENCES_VERSIONS
			l_prefs: PREFERENCES_STORAGE_DEFAULT
			is_verbose: BOOLEAN
			d: DIRECTORY
			l_prefs_import_callback: detachable PROCEDURE [TUPLE [ith: INTEGER; total: INTEGER; name, value: READABLE_STRING_GENERAL]]
			text_widget: detachable EV_TEXT
			vb: EV_VERTICAL_BOX
			lab: EV_LABEL
			retried: BOOLEAN
		do
			if retried then
				back_button.show
				main_cell.wipe_out
				create lab
				lab.set_text ("Import failed (exception)!")
				main_cell.extend (lab)
				lab.refresh_now
			else
				import_button.hide
				back_button.show
				main_cell.wipe_out
				create vb
				progress_bar.set_value (1)

				vb.extend (progress_bar)
				vb.disable_item_expand (progress_bar)
				create lab
				lab.set_text ({STRING_32} "Importing from " + selected_version_name.as_string_32)
				vb.extend (lab)
				vb.disable_item_expand (lab)

				if advanced_button.is_selected then
					create text_widget
					text_widget.set_text ({STRING_32} "Importing from " + selected_version_name.as_string_32 + " ...%N")
					vb.extend (text_widget)
				else
					text_widget := Void
				end
				main_cell.replace (vb)

				is_verbose := True
				lab.refresh_now

				if preferences_cb.is_sensitive and then preferences_cb.is_selected then
					if text_widget /= Void then
						text_widget.append_text ("- Preferences from %"")
						text_widget.append_text (preferences_tf.text)
						text_widget.append_text ("%"%N")
					end

					create l_prefs_versions
					create l_prefs.make_with_location_and_version (preferences_tf.text, l_prefs_versions.version_2_0)

					if is_verbose then
						l_prefs_import_callback := agent (itxt: detachable EV_TEXT; ith: INTEGER_32; total: INTEGER_32; name, value: READABLE_STRING_GENERAL)
									do
										progress_bar.set_value ((100 * ith) // total)
										progress_bar.refresh_now
										if itxt /= Void then
											itxt.append_text (" [" + ith.out + "/" + total.out + "] ")
											itxt.append_text (name)
											itxt.append_text (": ")
											itxt.append_text (value)
											itxt.append_text ("%N")
										end
									end(text_widget, ?,?,?,?)
					end
					if attached preferences as prefs then
						prefs.preferences.import_from_storage_with_callback_and_exclusion (l_prefs,
								True, -- Ignore hidden preferences
								l_prefs_import_callback,
								agent (itxt: detachable EV_TEXT; ith: INTEGER; total: INTEGER; k, v: READABLE_STRING_GENERAL): BOOLEAN
									do
										progress_bar.set_value ((100 * ith) // total)
										progress_bar.refresh_now
										Result := is_excluded_preference (k, v)
										if Result and itxt /= Void then
											itxt.append_text (" [" + ith.out + "/" + total.out + "] ")
											itxt.append_text (k)
											itxt.append_text (": Excluded!%N")
										end
									end(text_widget, ?,?,?,?)
							)
							-- Save imported preferences!
						prefs.preferences.save_preferences
					end
				end
				if ui_layout_cb.is_sensitive and then ui_layout_cb.is_selected then
					if text_widget /= Void then
						text_widget.append_text ("- UI layout settings.%N")
					end
					safe_copy_directory_content_into (create {PATH}.make_from_string (ui_layout_tf.text), eiffel_layout.docking_data_path, text_widget, Void)
					reload_docking_layout (text_widget)
				end
				if studio_config_cb.is_sensitive and then studio_config_cb.is_selected then
					if text_widget /= Void then
						text_widget.append_text ("- Configuration file.%N")
					end
					safe_copy_directory_content_into (create {PATH}.make_from_string (studio_config_tf.text), eiffel_layout.user_files_path.extended ("studio"), text_widget, <<"code_analysis.xml">>)
				end
				if templates_cb.is_sensitive and then templates_cb.is_selected then
					if text_widget /= Void then
						text_widget.append_text ("- Templates.%N")
					end
					safe_copy_directory_content_into (create {PATH}.make_from_string (templates_tf.text), eiffel_layout.user_templates_path, text_widget, Void)
				end
				if ini_files_cb.is_sensitive and then ini_files_cb.is_selected then
					if text_widget /= Void then
						text_widget.append_text ("- *.ini files.%N")
					end
					create d.make_with_name (ini_files_tf.text)
					across
						d.entries as ic
					loop
						if ic.item.is_current_symbol or ic.item.is_parent_symbol then
						elseif attached ic.item.extension as ext and then ext.same_string ("ini") then
							safe_copy_file_to (
									create {RAW_FILE}.make_with_path (d.path.extended_path (ic.item)),
									create {RAW_FILE}.make_with_path (eiffel_layout.user_files_path.extended_path (ic.item)),
									text_widget
								)
						end
					end
						-- Update external commands
					if
						attached dev_window as w and then
						attached w.commands.edit_external_commands_cmd as c
					then
						c.update_commands_from_ini_file
						c.update_menus_from_outside
					end
				end
				if cloud_account_cb.is_sensitive and then cloud_account_cb.is_selected then
					if text_widget /= Void then
						text_widget.append_text ("- Cloud account data.%N")
					end
					if attached es_cloud_s.service as cld then
						create d.make_with_name (cloud_account_tf.text)
						across
							d.entries as ic
						loop
							if ic.item.is_current_symbol or ic.item.is_parent_symbol then
							elseif ic.item.name.ends_with ("-credential.dat") then
								if attached cld.kept_credential_from_file (d.path.extended_path (ic.item)) as l_acc then
									if cld.kept_credential = Void then
										cld.keep_credential (l_acc.username, l_acc.password)
									end
								end
							end
						end
					end
				end
				progress_bar.set_value (100)
				progress_bar.refresh_now;
				(create {EXECUTION_ENVIRONMENT}).sleep (1_000_000_000)
				lab.set_text ("Import completed!")
				lab.refresh_now
			end
		rescue
			retried := True
			retry
		end

	is_excluded_preference (a_name, a_value: READABLE_STRING_GENERAL): BOOLEAN
			-- Is excluding preference named `a_name` with value `a_value`?
		do
			if attached selected_version_name as vn and then a_value.has_substring (vn) then
					-- Be prudent, and do not import preference whose value may have version specific values.
				Result := True
			end
		end

	update
		local
			li: EV_LIST_ITEM
			l_curr_version: READABLE_STRING_GENERAL
			l_prev_version: detachable READABLE_STRING_GENERAL
			l_prev_version_list_item: detachable EV_LIST_ITEM
		do
			import_button.show
			back_button.hide
			if attached progress_bar.parent as par then
				par.wipe_out
			end
			main_cell.wipe_out
			main_cell.put (versions_frame)

			selected_version_name := Void
			if is_eiffel_layout_defined then
				l_curr_version := current_version_name
				versions_combo.enable_edit
				versions_combo.wipe_out
				across
					eiffel_layout.installed_version_names as ic
				loop
					if l_curr_version.same_string (ic.item) then
						create li.make_with_text (eiffel_layout.product_name_for_version (ic.item) + " (Current version)")
					else
						create li.make_with_text (eiffel_layout.product_name_for_version (ic.item))
						l_prev_version := ic.item
						l_prev_version_list_item := li
					end
					li.set_data (ic.item)
					versions_combo.extend (li)
					li.select_actions.extend (agent on_version_selected (ic.item))
				end
				if l_prev_version_list_item /= Void then
					l_prev_version_list_item.enable_select
				end
				versions_combo.disable_edit
			end
		end

	current_version_name: READABLE_STRING_32
		do
			Result := eiffel_layout.version_name
			if eiffel_layout.is_workbench then
				Result := Result + {STRING_32} "_" + eiffel_layout.wkbench_suffix
			end
		end

	selected_version_name: detachable READABLE_STRING_GENERAL

	on_version_selected (v: READABLE_STRING_GENERAL)
		local
			p, ufp: PATH
			s: READABLE_STRING_32
			cb: EV_CHECK_BUTTON
			tf: EV_TEXT_FIELD
		do
			selected_version_name := v
			ufp := eiffel_layout.user_files_path_for_version (v, False)

				-- Preferences
			preferences_cb.enable_sensitive
			s := eiffel_layout.eiffel_preferences_for_version (v, False)
			preferences_cb.set_tooltip ({STRING_32} "Preferences at " + s)
			preferences_tf.set_text (s)

				-- UI layout
			p := eiffel_layout.docking_data_path_for_version (v, False)
			cb := ui_layout_cb
			tf := ui_layout_tf
			tf.set_text (p.name)
			cb.set_tooltip ({STRING_32} "Import directory %"" + p.name + "%"")

				-- Studio
			p := ufp.extended ("studio")
			cb := studio_config_cb
			tf := studio_config_tf
			tf.set_text (p.name)
			cb.set_tooltip ({STRING_32} "Import directory %"" + p.name + "%"")

				-- Templates
			p := ufp.extended ("templates")
			tf := templates_tf
			cb := templates_cb
			tf.set_text (p.name)
			cb.set_tooltip ({STRING_32} "Import directory %"" + p.name + "%"")

				-- *.ini files
			cb := ini_files_cb
			tf := ini_files_tf
			p := ufp
			cb.set_tooltip (ufp.name + "  *.ini files")
			tf.set_text (ufp.name)

				-- Cloud account data
				--| See {ES_CLOUD}.make_with_url
			p := eiffel_layout.hidden_files_path_for_version (v, False).extended ("accounts")
			if eiffel_layout.is_workbench then
				p := p.extended ("workbench")
			end
			cb := cloud_account_cb
			tf := cloud_account_tf
			cb.set_tooltip (p.name + "  Cloud accout data")
			tf.set_text (p.name)

				-- Update choices
			update_choices_status

				-- Button Import
			if current_version_name.same_string (v) then
				import_button.disable_sensitive
			else
				import_button.enable_sensitive
			end
		end

	update_choices_status
		local
			p: READABLE_STRING_32
			ut: FILE_UTILITIES
			cb: EV_CHECK_BUTTON
			d: DIRECTORY
		do
				-- Preferences
			preferences_cb.enable_sensitive

				-- Studio
			p := studio_config_tf.text
			cb := studio_config_cb
			if ut.directory_exists (p) then
				cb.enable_sensitive
			else
				cb.disable_sensitive
			end

				-- Templates
			p := templates_tf.text
			cb := templates_cb
			if ut.directory_exists (p) then
				cb.enable_sensitive
			else
				cb.disable_sensitive
			end

				-- *.ini files
			cb := ini_files_cb
			p := ini_files_tf.text
			if ut.directory_exists (p) then
				create d.make_with_name (p)
				if across d.entries as ic some attached ic.item.extension as ext and then ext.is_case_insensitive_equal_general ("ini") end then
					cb.enable_sensitive
				else
					cb.disable_sensitive
				end
			else
				cb.disable_sensitive
			end

				-- Cloud account data
			p := cloud_account_tf.text
			cb := cloud_account_cb
			if ut.directory_exists (p) then
				cb.enable_sensitive
			else
				cb.disable_sensitive
			end

		end

feature {NONE} -- Implementation

	reload_docking_layout (text_widget: detachable EV_TEXT)
		do
			if dev_window.eb_debugger_manager.debug_mode_forced then
				if text_widget /= Void then
					text_widget.append_text ("- Loading layout for debug mode ...")
				end
				dev_window.docking_layout_manager.restore_standard_debug_docking_layout
				dev_window.docking_layout_manager.restore_debug_docking_layout
			else
				if text_widget /= Void then
					text_widget.append_text ("- Loading layout for standard mode ...")
				end
				dev_window.docking_layout_manager.restore_standard_tools_docking_layout
				dev_window.docking_layout_manager.restore_tools_docking_layout
			end
			if text_widget /= Void then
				text_widget.append_text ("-> completed.%N")
			end
		end

	safe_copy_directory_content_into (a_dirname: PATH; a_target_dirname: PATH; a_txt: detachable EV_TEXT; a_excludes: detachable ITERABLE [READABLE_STRING_GENERAL])
		local
			p,tgt: PATH
			p_name: READABLE_STRING_GENERAL
			d_src, d_tgt: DIRECTORY
			f_src: RAW_FILE
		do
			create d_src.make_with_path (a_dirname)
			if d_src.exists then
				create d_tgt.make_with_path (a_target_dirname)
				if not d_tgt.exists then
					d_tgt.create_dir
					if a_txt /= Void then
						a_txt.append_text ("Create directory ")
						a_txt.append_text (a_target_dirname.name)
						a_txt.append_text ("%N")
					end
				end
				if d_tgt.exists then
					across
						d_src.entries as ic
					loop
						p := ic.item
						p_name := p.name
						if p.is_current_symbol or p.is_parent_symbol then
								-- Skip
						elseif
							a_excludes /= Void and then
							across a_excludes as ex_ic some p_name.same_string (ex_ic.item) end
						then
								-- Ignored/excluded.
						else
							create f_src.make_with_path (d_src.path.extended_path (p))
							tgt := a_target_dirname.extended_path (p)
							if f_src.is_directory then
								safe_copy_directory_content_into (f_src.path, tgt, a_txt, a_excludes)
							else
								safe_copy_file_to (f_src, create {RAW_FILE}.make_with_path (tgt), a_txt)
							end
						end
					end
				end
			end
		end

	safe_copy_file_to (f_src, f_tgt: FILE; a_txt: detachable EV_TEXT)
		local
			retried: BOOLEAN
			l_tgt_existed: BOOLEAN
		do
			if retried then
				if not f_src.is_closed then
					f_src.close
				end
				if not f_tgt.is_closed then
					f_tgt.close
				end

				if a_txt /= Void then
					a_txt.append_text ("Error while copying file to ")
					a_txt.append_text (f_tgt.path.name)
					a_txt.append_text ("%N")
				end
			elseif f_tgt.exists and then not f_tgt.is_access_writable then
				if a_txt /= Void then
					a_txt.append_text ("Could not replace file ")
					a_txt.append_text (f_tgt.path.name)
					a_txt.append_text ("%N")
				end
			elseif f_tgt.exists and then f_src.date < f_tgt.date then
				if a_txt /= Void then
					a_txt.append_text ("Keep more recent file ")
					a_txt.append_text (f_tgt.path.name)
					a_txt.append_text ("%N")
				end
			else
				if f_tgt.exists then
					f_tgt.open_write
					l_tgt_existed := True
				else
					f_tgt.create_read_write
				end
				f_src.open_read
				f_src.copy_to (f_tgt)
				f_src.close
				f_tgt.close
				if a_txt /= Void then
					if l_tgt_existed then
						a_txt.append_text ("Replace file ")
					else
						a_txt.append_text ("Copy to file ")
					end
					a_txt.append_text (f_tgt.path.name)
					a_txt.append_text ("%N")
				end
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Actions

	on_close
	 		-- Action to take when user presses 'Cancel' button.
		do
			import_button.show
			back_button.hide
			main_cell.wipe_out
			main_cell.put (versions_frame)
			hide
			on_finish_actions.call (Void)
		end

feature {NONE} -- Implementation

	on_window_focused
			-- Acion to be taken when window gains focused.
		do
			versions_combo.set_focus
		end

	escape_check (key: EV_KEY)
			-- Check for keyboard escape character.
		require
			key_not_void: key /= Void
     	do
        	if key.code = {EV_KEY_CONSTANTS}.key_escape then
            	on_close
            end
      	end

	execute
		do
		end

	execute_and_close
		do
			execute
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
