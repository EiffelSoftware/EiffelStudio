indexing
	description: "Graphical representation of .NET tab in EB_SYSTEM_WINDOW"
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

create
	make

feature -- Access

	name: STRING is ".NET"
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

feature -- Assembly information

	full_name_field: EV_TEXT_FIELD
			-- Full name of current assembly.

	version_field: EV_TEXT_FIELD
			-- Version information of current assembly.

	culture_combo: EV_COMBO_BOX
			-- Culture of current assembly.

	compatibility_combo: EV_COMBO_BOX
			-- Compatibility status of current assembly.

feature -- Assembly access

	assembly_list: EV_ADD_REMOVE_PATH_LIST
			-- List of assembly used in Current project.

feature -- Parent access

	system_window: EB_SYSTEM_WINDOW
			-- Graphical parent of Current.
			
feature -- Store/Retrieve

	store (root_ast: ACE_SD) is
			-- Store content of widget into `root_ast'.
		local
			cl: LACE_LIST [LANG_TRIB_SD]
			defaults: LACE_LIST [D_OPTION_SD]
		do
			defaults := root_ast.defaults
			if defaults = Void then
					-- No default option, we need to create them.
				create defaults.make (10)
				root_ast.set_defaults (defaults)
			end

			defaults.finish

			defaults.extend (new_special_option_sd (feature {FREE_OPTION_SD}.il_verifiable, Void, verifiable_check.is_selected))
			defaults.extend (new_special_option_sd (feature {FREE_OPTION_SD}.cls_compliant, Void, cls_compliant_check.is_selected))
			defaults.extend (new_special_option_sd (feature {FREE_OPTION_SD}.dotnet_naming_convention, Void, dotnet_naming_convention_check.is_selected))
			
			if dll_check.is_selected then
				defaults.extend (new_special_option_sd (feature {FREE_OPTION_SD}.msil_generation_type, "dll", False))
			else
				defaults.extend (new_special_option_sd (feature {FREE_OPTION_SD}.msil_generation_type, "exe", False))
			end

			if not assembly_list.is_empty then
				cl := root_ast.externals
				if cl = Void then
						-- No default option, we need to create them.
					create cl.make (2)
					root_ast.set_externals (cl)
				end

				if not assembly_list.is_empty then
					cl.extend (create {LANG_TRIB_SD}.initialize (
						create {LANGUAGE_NAME_SD}.initialize (new_id_sd ("assembly", False)),
						new_lace_list (assembly_list.list)))
				end
			end
		end

	retrieve (root_ast: ACE_SD) is
			-- Retrieve content of `root_ast' and update content of widget.
		do
			initialize_from_ast (root_ast)
		end

feature {NONE} -- Filling

	initialize_from_ast (root_ast: ACE_SD) is
			-- Initialize window with all data taken from `root_ast'.
		require
			root_ast_not_void: root_ast /= Void
		local
			cl: LACE_LIST [LANG_TRIB_SD]
			lace_list: LACE_LIST [ID_SD]
			list_item: EV_LIST_ITEM
			list: EV_LIST
			text_field: EV_TEXT_FIELD
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

				-- Retrieve assembly part
			cl := root_ast.externals
			if cl /= Void then
				from
					cl.start
				until
					cl.after
				loop
					if cl.item.language_name.is_assembly then
						from
							lace_list := cl.item.file_names
							lace_list.start
							list := assembly_list.list
							text_field := assembly_list.text_field
						until
							lace_list.after
						loop
							create list_item.make_with_text (lace_list.item)
							list_item.select_actions.extend (text_field~set_text (lace_list.item))
							list.extend (list_item)
							lace_list.forth
						end
						cl.remove
					else
						cl.forth
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
				when feature {FREE_OPTION_SD}.Il_verifiable then
					set_selected (verifiable_check, val.is_yes)
				when feature {FREE_OPTION_SD}.Msil_generation_type then
					set_selected (dll_check, val.value.is_equal (new_id_sd ("dll", True))) 
				when feature {FREE_OPTION_SD}.Cls_compliant then
					set_selected (cls_compliant_check, val.is_yes)
				when feature {FREE_OPTION_SD}.Dotnet_naming_convention then
					set_selected (dotnet_naming_convention_check, val.is_yes)
				else
					is_item_removable := False
				end
			end
		end

feature {NONE} -- Filling AST

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
			enable_select (dotnet_naming_convention_check)
			enable_select (verifiable_check)
			disable_select (dll_check)
			assembly_list.reset

				-- Disabled non-implemented functionality
			full_name_field.disable_sensitive
			version_field.disable_sensitive
			culture_combo.disable_sensitive
			compatibility_combo.disable_sensitive
		ensure then
			verifiable_check_selected: verifiable_check.is_selected
			dll_check_not_selected: not dll_check.is_selected
			cls_compliant_check_selected: cls_compliant_check.is_selected
			dotnet_naming_convention_check_selected: dotnet_naming_convention_check.is_selected
			assembly_list_empty: assembly_list.is_empty
		end

feature {NONE} -- Initialization

	make (top: like system_window) is
			-- Create widget corresponding to `General' tab in notebook.
		require
			top_not_void: top /= Void
		local
			assembly_frame: EV_FRAME
		do
			system_window := top
			tab_make
			default_create
			
			extend (msil_info_frame (".NET application information"))
			disable_item_expand (i_th (1))

			extend (options_frame ("Options"))
			disable_item_expand (i_th (2))
			
			create assembly_frame.make_with_text ("Assemblies")
			create assembly_list.make_with_parent (top.window)
			assembly_list.set_browse_for_file ("*.dll")
			assembly_frame.extend (assembly_list)
			extend (assembly_frame)

			msil_specific_widgets.extend (Current)
		end

	msil_info_frame (st: STRING): EV_FRAME is
			-- MSIL information about current assembly.
		require
			st_not_void: st /= Void
			st_not_empty: not st.is_empty
		local
			vbox: EV_VERTICAL_BOX
			label: EV_LABEL
			item_box: EV_VERTICAL_BOX
		do
			create Result.make_with_text (st)
			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)
			vbox.set_padding (Layout_constants.Tiny_padding_size)

			create item_box
			item_box.set_padding (Layout_constants.Tiny_padding_size)
			create label.make_with_text ("Full name: ")
			label.align_text_left
			create full_name_field
			item_box.extend (label)
			item_box.extend (full_name_field)
			vbox.extend (item_box)

			create item_box
			item_box.set_padding (Layout_constants.Tiny_padding_size)
			create label.make_with_text ("Version: ")
			label.align_text_left
			create version_field
			item_box.extend (label)
			item_box.extend (version_field)
			vbox.extend (item_box)

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
			vbox.extend (item_box)

			create item_box
			item_box.set_padding (Layout_constants.Tiny_padding_size)
			create label.make_with_text ("Culture: ")
			label.align_text_left
			create culture_combo
			culture_combo.disable_edit
			item_box.extend (label)
			item_box.extend (culture_combo)
			vbox.extend (item_box)
			load_culture

			Result.extend (vbox)
		end

	options_frame (st: STRING): EV_FRAME is
			-- MSIL specific options
		require
			st_not_void: st /= Void
			st_not_empty: not st.is_empty
		local
			vbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
		do
			create Result.make_with_text (st)
			
			create hbox
			hbox.set_border_width (Layout_constants.Small_border_size)
			
			create vbox
			cls_compliant_check := new_check_button (vbox, "CLS compliant")
			dotnet_naming_convention_check := new_check_button (vbox, "Follow .NET naming guidelines")
			hbox.extend (vbox)
			
			create vbox
			verifiable_check := new_check_button (vbox, "Verifiable")
			dll_check := new_check_button (vbox, "Generate DLL")
			hbox.extend (vbox)

			Result.extend (hbox)
		end
		
feature {NONE} -- Implementation

	load_culture is
			-- Fill `culture_combo' with list of available culture.
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
						culture_combo.extend (create {EV_LIST_ITEM}.make_with_text (file.last_string))
					end
				end
			end
		end

end -- class EB_SYSTEM_MSIL_TAB
