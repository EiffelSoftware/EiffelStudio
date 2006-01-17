indexing
	description: "Graphical representation of .NET tab in EB_SYSTEM_WINDOW"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_MSIL_TAB

inherit
	EV_VERTICAL_BOX

	EB_SYSTEM_TAB
		rename
			make as tab_make
		undefine
			default_create, is_equal, copy
		redefine
			reset
		end

	EB_CONSTANTS
		undefine
			default_create, is_equal, copy
		end

	EB_FILE_DIALOG_CONSTANTS
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

	REFACTORING_HELPER
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

create
	make

feature -- Access

	name: STRING is "General"
			-- Name of tab in System Window.

feature -- MSIL options

	verifiable_check: EV_CHECK_BUTTON
			-- Will IL generated code be verifiable?

	dll_check: EV_CHECK_BUTTON
			-- Will generated assembly be a DLL?

	cls_compliant_check: EV_CHECK_BUTTON
			-- Will generated assembly be CLS compliant?

	dotnet_naming_convention_check: EV_CHECK_BUTTON
			-- Will names generated in assembly follow the .NET guideline?

	cluster_name_check: EV_CHECK_BUTTON
			-- Will we generate names with cluster name?

	full_cluster_name_check: EV_CHECK_BUTTON
			-- Will we generate full names with cluster name?

	signing_key_field: EV_PATH_FIELD
			-- Filename of the cryptographic assembly key

	generate_key_button: EV_BUTTON
			-- Button to generate a public/private key pair for assembly

	full_name_field: EV_TEXT_FIELD
			-- Full name of current assembly.

	version_field: EV_TEXT_FIELD
			-- Version information of current assembly.

	company_field: EV_TEXT_FIELD
			-- Name of company with assembly ownership, if any

	product_field: EV_TEXT_FIELD
			-- Name of product to which assembly belongs, if any

	trademark_field: EV_TEXT_FIELD
			-- Name of trademark information

	copyright_field: EV_TEXT_FIELD
			-- Name of copyright information

	culture_combo: EV_COMBO_BOX
			-- Culture of current assembly.

	compatibility_combo: EV_COMBO_BOX
			-- Compatibility status of current assembly.

	clr_runtime_version_combo: EV_COMBO_BOX
			-- Enable user to target a specific version of the run-time.

feature -- Parent access

	system_window: EB_SYSTEM_WINDOW
			-- Graphical parent of Current.

feature -- Actions

	show_key_dialog is
			-- Display the save as dialog for key generation file
		local
			fd: EB_FILE_SAVE_DIALOG
			l_env: EXECUTION_ENVIRONMENT
			l_dir: STRING
		do
			create fd.make_with_preference (preferences.dialog_data.last_saved_system_generate_key_directory_preference)
			fd.save_actions.extend (agent generate_and_save_key (fd))
			set_dialog_filters_and_add_all (fd, <<strong_name_key_files_filter>>)
			fd.set_title ("Save key file as...")
			create l_env
			l_dir := l_env.current_working_directory
			fd.show_modal_to_window (system_window.window)
			l_env.change_working_directory (l_dir)
		end

feature -- Store/Retrieve

	store (root_ast: ACE_SD) is
			-- Store content of widget into `root_ast'.
		local
			defaults: LACE_LIST [D_OPTION_SD]
		do
			if msil_widgets_enabled then
				defaults := root_ast.defaults
				if defaults = Void then
						-- No default option, we need to create them.
					create defaults.make (10)
					root_ast.set_defaults (defaults)
				end

				defaults.finish

					-- Save check box options
				defaults.extend (new_special_option_sd ({FREE_OPTION_SD}.il_verifiable,
					Void, verifiable_check.is_selected))
				defaults.extend (new_special_option_sd ({FREE_OPTION_SD}.cls_compliant,
					Void, cls_compliant_check.is_selected))
				defaults.extend (new_special_option_sd (
					{FREE_OPTION_SD}.dotnet_naming_convention, Void,
					dotnet_naming_convention_check.is_selected))
				defaults.extend (new_special_option_sd (
					{FREE_OPTION_SD}.use_cluster_name_as_namespace, Void,
					cluster_name_check.is_selected))
				defaults.extend (new_special_option_sd (
					{FREE_OPTION_SD}.use_all_cluster_name_as_namespace, Void,
					full_cluster_name_check.is_selected))

				if dll_check.is_selected then
					defaults.extend (new_special_option_sd (
						{FREE_OPTION_SD}.msil_generation_type, "dll", False))
				else
					defaults.extend (new_special_option_sd (
						{FREE_OPTION_SD}.msil_generation_type, "exe", False))
				end

					-- Save text field values
				if not full_name_field.text.is_empty then
					defaults.extend (new_special_option_sd ({FREE_OPTION_SD}.Namespace,
						full_name_field.text, False))
				end
				if not version_field.text.is_empty then
					defaults.extend (new_special_option_sd ({FREE_OPTION_SD}.Version,
						version_field.text, False))
				end
				if not company_field.text.is_empty then
					defaults.extend (new_special_option_sd ({FREE_OPTION_SD}.Company,
						company_field.text, False))
				end
				if not product_field.text.is_empty then
					defaults.extend (new_special_option_sd ({FREE_OPTION_SD}.Product,
						product_field.text, False))
				end
				if not trademark_field.text.is_empty then
					defaults.extend (new_special_option_sd ({FREE_OPTION_SD}.Trademark,
						trademark_field.text, False))
				end
				if not copyright_field.text.is_empty then
					defaults.extend (new_special_option_sd ({FREE_OPTION_SD}.Copyright,
						copyright_field.text, False))
				end
				if not signing_key_field.text.is_empty then
					defaults.extend (new_special_option_sd ({FREE_OPTION_SD}.Msil_key_file_name, signing_key_field.text, False))
				end

					-- Save combobox selections
				if not culture_combo.selected_item.text.substring
					(1, culture_combo.selected_item.text.index_of (',', 1) - 1).is_equal ("n/a") then
						defaults.extend (new_special_option_sd ({FREE_OPTION_SD}.Msil_culture,
							culture_combo.selected_item.text.substring
							(1, culture_combo.selected_item.text.index_of (',', 1) - 1), False))
				end

				if not clr_runtime_version_combo.is_empty then
					defaults.extend (new_special_option_sd ({FREE_OPTION_SD}.Msil_clr_version,
						clr_runtime_version_combo.text, False))
				end

				defaults.extend (new_special_option_sd ({FREE_OPTION_SD}.Msil_assembly_compatibility, compatibility_combo.text, False))
			end
		end

	retrieve (root_ast: ACE_SD) is
			-- Retrieve content of `root_ast' and update content of widget.
		do
			if msil_widgets_enabled then
				initialize_from_ast (root_ast)
			end
		end

feature {NONE} -- Filling

	initialize_from_ast (root_ast: ACE_SD) is
			-- Initialize window with all data taken from `root_ast'.
		require
			root_ast_not_void: root_ast /= Void
		local
			defaults: LACE_LIST [D_OPTION_SD]
			precomp_opt: D_PRECOMPILED_SD
			opt: D_OPTION_SD
		do
				-- Retrieve default options.
			defaults := root_ast.defaults
			if defaults /= Void then
				from
					defaults.start
				until
					defaults.after
				loop
					opt := defaults.item
					precomp_opt ?= opt
					if precomp_opt = Void then
						initialize_with_default_option (opt)
					end
					if is_item_removable then
						is_item_removable := False
						defaults.remove
					else
						defaults.forth
					end
				end
			end
		end

	initialize_with_default_option (a_opt: D_OPTION_SD) is
			-- Initialize check buttons and text field associated with `a_opt'.
		require
			a_opt_not_void: a_opt /= Void
			a_opt_not_precompiled_option: not a_opt.is_precompiled
			a_opt_not_optional_option: not a_opt.is_optional
			a_opt_has_option: a_opt.option /= Void
			a_opt_has_no_precompiled_option: not a_opt.option.is_precompiled
			a_opt_has_value: a_opt.value /= Void
			is_item_removable_disabled: not is_item_removable
		local
			opt: OPTION_SD
			free_option: FREE_OPTION_SD
			val: OPT_VAL_SD
		do
			opt := a_opt.option
			val := a_opt.value
			if opt.is_free_option then
				free_option ?= opt
				is_item_removable := True
				inspect free_option.code
				when {FREE_OPTION_SD}.Namespace then
					full_name_field.set_text (val.value)
				when {FREE_OPTION_SD}.Version then
					version_field.set_text (val.value)
				when {FREE_OPTION_SD}.Company then
					company_field.set_text (val.value)
				when {FREE_OPTION_SD}.Product then
					product_field.set_text (val.value)
				when {FREE_OPTION_SD}.Trademark then
					trademark_field.set_text (val.value)
				when {FREE_OPTION_SD}.Copyright then
					copyright_field.set_text (val.value)
				when {FREE_OPTION_SD}.Msil_culture then
					select_culture (val.value)
				when {FREE_OPTION_SD}.Msil_assembly_compatibility then
					select_assembly_compatibility (val.value)
				when {FREE_OPTION_SD}.Msil_key_file_name then
					signing_key_field.set_text (val.value)
				when {FREE_OPTION_SD}.Il_verifiable then
					set_selected (verifiable_check, val.is_yes)
				when {FREE_OPTION_SD}.Msil_generation_type then
					set_selected (dll_check, val.value.is_equal (new_id_sd ("dll", True)))
				when {FREE_OPTION_SD}.Cls_compliant then
					set_selected (cls_compliant_check, val.is_yes)
				when {FREE_OPTION_SD}.Dotnet_naming_convention then
					set_selected (dotnet_naming_convention_check, val.is_yes)
				when {FREE_OPTION_SD}.Use_cluster_name_as_namespace then
					set_selected (cluster_name_check, val.is_yes)
				when {FREE_OPTION_SD}.Use_all_cluster_name_as_namespace then
					set_selected (full_cluster_name_check, val.is_yes)
				when {FREE_OPTION_SD}.Msil_clr_version then
					select_runtime_version (val.value)
				else
					is_item_removable := False
				end
			end
		end

feature -- Checking

	perform_check is
			-- Perform check on content of current pane.
		do
			set_is_valid (True)
		end

feature -- Initialization

	reset is
			-- Set graphical elements to their default value.
		do
			Precursor {EB_SYSTEM_TAB}
			enable_select (cls_compliant_check)
			enable_select (verifiable_check)
			disable_select (dll_check)
			enable_select (full_cluster_name_check)
			enable_select (cluster_name_check)
			disable_select (dotnet_naming_convention_check)
		ensure then
			verifiable_check_selected: verifiable_check.is_selected
			dll_check_not_selected: not dll_check.is_selected
			cls_compliant_check_selected: cls_compliant_check.is_selected
			full_cluster_name_selected: full_cluster_name_check.is_selected
			cluster_name_selected: cluster_name_check.is_selected
			dotnet_naming_convention_check_selected: not dotnet_naming_convention_check.is_selected
		end

feature {NONE} -- Initialization

	make (top: like system_window) is
			-- Create widget corresponding to `General' tab in notebook.
		require
			top_not_void: top /= Void
		do
			system_window := top
			tab_make
			default_create

			extend (msil_info_frame (".NET application information"))
			extend (options_box)

			msil_specific_widgets.extend (Current)
		end

	options_box: EV_HORIZONTAL_BOX is
			-- Box containing use options.
		do
			create Result
			Result.set_border_width (Layout_constants.Small_border_size)
			Result.set_padding (Layout_constants.Small_padding_size)
			Result.enable_homogeneous
			Result.extend (options_frame ("Options"))
			Result.extend (name_options_frame ("Class and feature naming"))
		end

	msil_info_frame (st: STRING): EV_FRAME is
			-- MSIL information about current assembly.
		require
			st_not_void: st /= Void
			st_not_empty: not st.is_empty
		local
			hbox, h_item_box: EV_HORIZONTAL_BOX
			label: EV_LABEL
			item_box, vbox, vbox2: EV_VERTICAL_BOX
			cell: EV_CELL
		do
			create Result.make_with_text (st)
			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)
			vbox.set_padding (Layout_constants.Small_padding_size)

			create hbox
			create vbox2
			vbox2.set_minimum_width (0)
			vbox2.set_padding (Layout_constants.Small_padding_size)

			create item_box
			item_box.set_padding (Layout_constants.Tiny_padding_size)
			create label.make_with_text ("Default Namespace: ")
			label.align_text_left
			create full_name_field
			item_box.extend (label)
			item_box.extend (full_name_field)
			vbox2.extend (item_box)
			vbox2.disable_item_expand (item_box)

			create item_box
			item_box.set_padding (Layout_constants.Tiny_padding_size)
			create label.make_with_text ("Version: ")
			label.align_text_left
			create version_field
			item_box.extend (label)
			item_box.extend (version_field)
			vbox2.extend (item_box)
			vbox2.disable_item_expand (item_box)

			create item_box
			item_box.set_padding (Layout_constants.Tiny_padding_size)
			create label.make_with_text ("Assembly compatibility: ")
			label.align_text_left
			create compatibility_combo
			compatibility_combo.disable_edit
			item_box.extend (label)
			item_box.extend (compatibility_combo)
			compatibility_combo.extend (create {EV_LIST_ITEM}.make_with_text ("None"))
			compatibility_combo.extend (create {EV_LIST_ITEM}.make_with_text ("Same domain"))
			compatibility_combo.extend (create {EV_LIST_ITEM}.make_with_text ("Same machine"))
			compatibility_combo.extend (create {EV_LIST_ITEM}.make_with_text ("Same process"))
			vbox2.extend (item_box)
			vbox2.disable_item_expand (item_box)

			create item_box
			item_box.set_padding (Layout_constants.Tiny_padding_size)
			create label.make_with_text ("Culture: ")
			label.align_text_left
			create culture_combo
			culture_combo.disable_edit
			item_box.extend (label)
			item_box.extend (culture_combo)
			vbox2.extend (item_box)
			vbox2.disable_item_expand (item_box)
			load_culture


			create item_box
			create label.make_with_text (".NET runtime version: ")
			label.align_text_left
			item_box.extend (label)
			item_box.disable_item_expand (label)
			create clr_runtime_version_combo
			item_box.extend (clr_runtime_version_combo)
			item_box.disable_item_expand (clr_runtime_version_combo)
			item_box.set_padding (Layout_constants.Tiny_padding_size)
			load_runtime_version

				-- As soon as we do a successful compilation we cannot
				-- change some options.
			widgets_set_before_has_compilation_started.extend (clr_runtime_version_combo)

			vbox2.extend (item_box)
			vbox2.disable_item_expand (item_box)

			hbox.extend (vbox2)

			create vbox2
			vbox2.set_minimum_width (15)
			hbox.extend (vbox2)
			hbox.disable_item_expand (vbox2)

			create vbox2
			vbox2.set_minimum_width (0)
			vbox2.set_padding (Layout_constants.Small_padding_size)
			create item_box
			item_box.set_padding (Layout_constants.Tiny_padding_size)
			create label.make_with_text ("Company: ")
			label.align_text_left
			create company_field
			item_box.extend (label)
			item_box.extend (company_field)
			vbox2.extend (item_box)
			vbox2.disable_item_expand (item_box)

			create item_box
			item_box.set_padding (Layout_constants.Tiny_padding_size)
			create label.make_with_text ("Product: ")
			label.align_text_left
			create product_field
			item_box.extend (label)
			item_box.extend (product_field)
			vbox2.extend (item_box)
			vbox2.disable_item_expand (item_box)

			create item_box
			item_box.set_padding (Layout_constants.Tiny_padding_size)
			create label.make_with_text ("Trademark: ")
			label.align_text_left
			create trademark_field
			item_box.extend (label)
			item_box.extend (trademark_field)
			vbox2.extend (item_box)
			vbox2.disable_item_expand (item_box)

			create item_box
			item_box.set_padding (Layout_constants.Tiny_padding_size)
			create label.make_with_text ("Copyright: ")
			label.align_text_left
			create copyright_field
			item_box.extend (label)
			item_box.extend (copyright_field)
			vbox2.extend (item_box)
			hbox.extend (vbox2)
			vbox2.disable_item_expand (item_box)

			vbox.extend (hbox)
			vbox.disable_item_expand (hbox)


			create vbox2
			create h_item_box
			create item_box
			vbox2.set_padding (Layout_constants.Small_padding_size)
			h_item_box.set_padding (Layout_constants.Tiny_padding_size)
			item_box.set_padding (Layout_constants.Tiny_padding_size)
			label.align_text_left
			create signing_key_field.make_with_text_and_parent ("Signing key:",
				system_window.window)
			signing_key_field.set_padding (Layout_constants.Tiny_padding_size)
			signing_key_field.set_browse_for_file ("*.snk")
			h_item_box.extend (signing_key_field)
			create cell
			create generate_key_button.make_with_text_and_action ("Generate..", agent show_key_dialog)
			cell.set_minimum_height (signing_key_field.i_th (1).height)
			item_box.extend (cell)
			item_box.extend (generate_key_button)
			h_item_box.extend (item_box)
			h_item_box.disable_item_expand (item_box)

			vbox2.extend (h_item_box)
			vbox2.disable_item_expand (h_item_box)
			vbox.extend (vbox2)
			vbox.disable_item_expand (vbox2)

			Result.extend (vbox)
		end

	options_frame (st: STRING): EV_FRAME is
			-- MSIL specific options
		require
			st_not_void: st /= Void
			st_not_empty: not st.is_empty
		local
			vbox, item_box: EV_VERTICAL_BOX
		do
			create Result.make_with_text (st)

			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)

			create item_box
			cls_compliant_check := new_check_button (item_box, "CLS compliant", False)
			vbox.extend (item_box)
			vbox.disable_item_expand (item_box)

			create item_box
			verifiable_check := new_check_button (item_box, "Verifiable", False)
			vbox.extend (item_box)
			vbox.disable_item_expand (item_box)

			create item_box
			dll_check := new_check_button (item_box, "Generate DLL", False)
			vbox.extend (item_box)
			vbox.disable_item_expand (item_box)

			Result.extend (vbox)
		end

	name_options_frame (st: STRING): EV_FRAME is
			-- MSIL specific options
		require
			st_not_void: st /= Void
			st_not_empty: not st.is_empty
		local
			vbox, item_box: EV_VERTICAL_BOX
		do
			create Result.make_with_text (st)

			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)

			create item_box
			dotnet_naming_convention_check := new_check_button (item_box,
				"Follow .NET naming guidelines", False)
			vbox.extend (item_box)
			vbox.disable_item_expand (item_box)
			widgets_set_before_has_compilation_started.extend (dotnet_naming_convention_check)

			create item_box
			cluster_name_check := new_check_button (item_box,
				"Use cluster names", False)
			vbox.extend (item_box)
			vbox.disable_item_expand (item_box)
			widgets_set_before_has_compilation_started.extend (cluster_name_check)

			create item_box
			full_cluster_name_check := new_check_button (item_box, "Use full cluster names", False)
			vbox.extend (item_box)
			vbox.disable_item_expand (item_box)
			widgets_set_before_has_compilation_started.extend (full_cluster_name_check)

			Result.extend (vbox)
		end

feature {NONE} -- Implementation

	load_runtime_version is
			-- Load all installed version of CLR runtime on current computer.
		require
			clr_runtime_version_combo_not_void: clr_runtime_version_combo /= Void
		local
			l_versions: DS_LINEAR [STRING]
			l_il_environment: IL_ENVIRONMENT
		do
			create l_il_environment
			l_versions := l_il_environment.installed_runtimes
			from
				l_versions.start
			until
				l_versions.after
			loop
				clr_runtime_version_combo.extend
					(create {EV_LIST_ITEM}.make_with_text (l_versions.item_for_iteration))
				l_versions.forth
			end
			if clr_runtime_version_combo.is_empty then
				clr_runtime_version_combo.disable_sensitive
			end
			select_runtime_version (l_il_environment.default_version)
		end

	load_culture is
			-- Fill `culture_combo' with list of available cultures		
		require
			culture_combo_not_void: culture_combo /= Void
		local
			file: PLAIN_TEXT_FILE
		do
			create file.make ((create {EIFFEL_ENV}).msil_culture_name)
			if not file.exists or else not file.is_readable then
				culture_combo.disable_sensitive
			else
				from
					file.open_read
				until
					file.end_of_file
				loop
					file.read_line
					if not file.end_of_file and not file.last_string.is_empty then
						culture_combo.extend (
							create {EV_LIST_ITEM}.make_with_text (file.last_string))
					end
				end
			end
		end

	select_runtime_version (a_version: STRING) is
			-- Select version in 'clr_runtime_version_combo' associated with 'a_version'
		require
			a_version_not_void: a_version /= Void
			clr_runtime_version_combo_not_void: clr_runtime_version_combo /= Void
		local
			match_found: BOOLEAN
			l_version: STRING
			l_sensitive: BOOLEAN
		do
			if not clr_runtime_version_combo.is_empty then
				l_sensitive := clr_runtime_version_combo.is_sensitive
				clr_runtime_version_combo.enable_sensitive
				from
					clr_runtime_version_combo.start
				until
					clr_runtime_version_combo.after or match_found
				loop
					l_version := clr_runtime_version_combo.item.text
					if l_version.is_equal (a_version) then
						clr_runtime_version_combo.item.enable_select
						match_found := True
					end
					clr_runtime_version_combo.forth
				end
				if not match_found then
					clr_runtime_version_combo.i_th (1).enable_select
				end
				if not l_sensitive then
					clr_runtime_version_combo.disable_sensitive
				end
			end
		end

	select_culture (a_culture: STRING) is
			-- Select culture in 'culture_combo' associated with 'a_culture'
		require
			culture_not_void: a_culture /= Void
		local
			match_found: BOOLEAN
			curr_culture: STRING
		do
			from
				culture_combo.start
			until
				culture_combo.after or match_found
			loop
				curr_culture := culture_combo.item.text
				curr_culture := curr_culture.substring (1, curr_culture.index_of (',', 1) - 1)
				if curr_culture.is_equal (a_culture) then
					culture_combo.item.enable_select
					match_found := True
				end
				culture_combo.forth
			end
			if not match_found then
				culture_combo.i_th (1).enable_select
			end
		end

	select_assembly_compatibility (a_comp_type: STRING) is
			-- Select a compatiblity type associated with 'a_comp_type'
		require
			compatibility_not_void: a_comp_type /= Void
		local
			match_found: BOOLEAN
			curr_comp: STRING
		do
			from
				compatibility_combo.start
			until
				compatibility_combo.after or match_found
			loop
				curr_comp := compatibility_combo.item.text
				if curr_comp.is_equal (a_comp_type) then
						compatibility_combo.item.enable_select
						match_found := True
				end
				compatibility_combo.forth
			end
			if not match_found then
				compatibility_combo.i_th (1).enable_select
			end
		end

	generate_and_save_key (fd: EB_FILE_SAVE_DIALOG) is
			-- Generate a new signing key in the chosen file from 'fd'
			--and set as new assembly key
		require
			file_dialog_not_void: fd /= Void
		local
			ilkg: IL_KEY_GENERATOR
			l_error: EV_INFORMATION_DIALOG
		do
			create ilkg
			fixme ("If version is changed, then we are screwed because the code below will load the incorrect version of the .NET runtime")
			ilkg.generate_key (fd.file_name, clr_runtime_version_combo.text)
			if ilkg.successful then
				signing_key_field.set_text (fd.file_name)
			else
				create l_error.make_with_text (ilkg.error_message)
				l_error.show_modal_to_window (system_window.window)
			end
		end


invariant
	verifiable_check_not_void: verifiable_check /= Void
	dll_check_not_void: dll_check /= Void
	cls_compliant_check_not_void: cls_compliant_check /= Void
	dotnet_naming_convention_check_not_void: dotnet_naming_convention_check /= Void
	signing_key_field_not_void:	signing_key_field /= Void
	full_name_field_not_void: full_name_field /= Void
	version_field_not_void:	version_field /= Void
	company_field_not_void:	company_field /= Void
	product_field_not_void:	product_field /= Void
	trademark_field_not_void: trademark_field /= Void
	copyright_field_not_void: copyright_field /= Void
	culture_combo_not_void:	culture_combo /= Void
	compatibility_combo_not_void: compatibility_combo /= Void

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

end -- class EB_SYSTEM_MSIL_TAB
