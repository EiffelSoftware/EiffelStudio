indexing
	description: "Graphical representation of General tab in EB_SYSTEM_WINDOW"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_GENERAL_TAB

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

	EIFFEL_ENV
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	SHARED_WORKBENCH
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

create
	make

feature -- Access

	name: STRING is "General"
			-- Name of tab in System Window.

feature -- System name access

	compilation_combo: EV_COMBO_BOX
			-- Selected compilation type
			-- Only enabled at project creation time.

	normal_code: INTEGER is 1
	library_code: INTEGER is 2
	precompiled_code: INTEGER is 3
			-- Type of Eiffel compilation.

	app_name_field: EV_TEXT_FIELD
			-- Text field for putting name of application

	root_class_field: EV_TEXT_FIELD
			-- Root class of System.

	root_creation_field: EV_TEXT_FIELD
			-- Name of creation procedure of System.

	precompiled_combo: EV_COMBO_BOX
			-- Name of precompiled library if any

feature -- Generation type

	generation_combo: EV_COMBO_BOX
			-- Selected generation type.
			-- Only enabled at project creation time.
			
	standard_code: INTEGER is 1
	msil_code: INTEGER is 2
	java_code: INTEGER is 3
			-- Types of generation.

feature -- Assertion access

	check_check, require_check, ensure_check,
	loop_check, invariant_check: EV_CHECK_BUTTON
			-- Assertion levels for current system.

feature -- Parent access

	system_window: EB_SYSTEM_WINDOW
			-- Graphical parent of Current.

feature -- Store/Retrieve

	store (root_ast: ACE_SD) is
			-- Store content of widget into `root_ast'.
		local
			root_sd: ROOT_SD
			defaults: LACE_LIST [D_OPTION_SD]
		do
			defaults := root_ast.defaults
			if defaults = Void then
					-- No default option, we need to create them.
				create defaults.make (10)
				root_ast.set_defaults (defaults)
			end

				-- Set name of system.
			root_ast.set_system_name (new_id_sd (app_name_field.text, False))

				-- Set name of root class and creation procedure if any.
			create root_sd
			root_sd.set_root_name (new_id_sd (root_class_field.text, False))
			if root_creation_field.text /= Void then
				root_sd.set_creation_procedure_name (new_id_sd (root_creation_field.text, False))
			end
			root_ast.set_root (root_sd)

			store_precompiled (root_ast)
			store_assertion_level (root_ast)

				-- Store special compilation type
			if generation_combo.index_of (generation_combo.selected_item, 1) = msil_code then
				defaults.extend (new_special_option_sd ("msil_generation", Void, True))
--			elseif generation_combo.index_of (generation_combo.selected_item, 1) = java_code then
--				defaults.extend (new_special_option_sd ("java_generation", Void, True))
--			else
--				defaults.extend (new_special_option_sd ("java_generation", Void, False))
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
			app_name_field_not_void: app_name_field /= Void
			root_class_field_not_void: root_class_field /= Void
			root_creation_field_not_void: root_creation_field /= Void
			precompiled_combo_not_void: precompiled_combo /= Void
			root_ast_has_system_name: root_ast.system_name /= Void
			root_ast_has_root_class: root_ast.root /= Void
		local
			defaults: LACE_LIST [D_OPTION_SD]
			precomp_opt: D_PRECOMPILED_SD
			opt: D_OPTION_SD
			precomp_text_set: BOOLEAN
			tmpstr: STRING
		do
				-- Retrieve application name.
			tmpstr := root_ast.system_name
			if tmpstr.is_empty then
				app_name_field.remove_text
			else
				app_name_field.set_text (tmpstr)
			end

				-- Retrieve root_class name
			tmpstr := to_upper (root_ast.root.root_name)
			if tmpstr.is_empty then
				root_class_field.remove_text
			else
				root_class_field.set_text (tmpstr)
			end

				-- Retrieve root_class creation procedure if any
			tmpstr := root_ast.root.creation_procedure_name
			if tmpstr = Void then
				root_creation_field.disable_sensitive
			else
				if tmpstr.is_empty then
					root_creation_field.remove_text
				else
					root_creation_field.set_text (tmpstr)
				end
			end

				-- Retrieve existing precompiled libraries from installation
				-- directory.
			initialize_precompiled

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
					if precomp_opt /= Void then
							-- Find a precompiled option, there should be only one.
						tmpstr := precomp_opt.value.value
						if not tmpstr.is_empty then
							precompiled_combo.put_front (
								create {EV_LIST_ITEM}.make_with_text (precomp_opt.value.value))
							set_selected (precompiled_combo.first, True)
							precompiled_combo.set_text (precomp_opt.value.value)
							is_item_removable := True
						end
						precomp_text_set := True
					else
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

			precompiled_combo.put_front (
				create {EV_LIST_ITEM}.make_with_text ("None"))

			if not precomp_text_set then
				precompiled_combo.set_text ("None")
			end

			if Workbench.is_already_compiled then
					-- As soon as we do a successful compilation we cannot
					-- change some options.
				precompiled_combo.disable_sensitive
				generation_combo.disable_sensitive
				compilation_combo.disable_sensitive
			end
		end

	initialize_with_default_option (a_opt: D_OPTION_SD) is
			-- Initialize check buttons and text field associated with `a_opt'.
		require
			a_opt_not_void: a_opt /= Void
			a_opt_not_precompiled_option: not a_opt.conforms_to (create {D_PRECOMPILED_SD})
			a_opt_not_optional_option: not a_opt.conforms_to (create {O_OPTION_SD})
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
			if opt.is_assertion then
				if val.is_check then
					enable_select (check_check)
				elseif val.is_require then
					enable_select (require_check)
				elseif val.is_ensure then
					enable_select (ensure_check)
				elseif val.is_loop then
					enable_select (loop_check)
				elseif val.is_invariant then
					enable_select (invariant_check)
				elseif val.is_all then
					enable_select (check_check)
					enable_select (require_check)
					enable_select (ensure_check)
					enable_select (loop_check)
					enable_select (invariant_check)
				end
				is_item_removable := True
			elseif opt.is_free_option then
				free_option ?= opt
				if free_option.code = free_option.msil_generation then
					if generation_combo.is_sensitive then
						enable_select (generation_combo.i_th (msil_code))
					else
						generation_combo.enable_sensitive
						enable_select (generation_combo.i_th (msil_code))
						generation_combo.disable_sensitive
					end
					is_item_removable := True
--				elseif free_option.code = free_option.java_generation then
--					if generation_combo.is_sensitive then
--						enable_select (generation_combo.i_th (java_code))
--					end
--					is_item_removable := True
				end
			end
		end

feature {NONE} -- Filling AST

	store_precompiled (root_ast: ACE_SD) is
			-- Store content of `precompiled' combo into `root_ast'.
		require
			root_ast_not_void: root_ast /= Void
			root_ast_has_defaults: root_ast.defaults /= Void
		local
			d_option: D_OPTION_SD
			pre: PRECOMPILED_SD
			v: OPT_VAL_SD
			title: STRING
		do
			title := precompiled_combo.text
			if
				precompiled_combo.is_sensitive and then
				not title.is_equal ("None")
			then
				pre := new_precompiled_sd
				v := new_name_sd (new_id_sd (title, True))
				d_option := new_d_option_sd (pre, v)
				root_ast.defaults.extend (d_option)
			end
		end

	store_assertion_level (root_ast: ACE_SD) is
			-- Store content of `assertion' into `root_ast'.
		require
			root_ast_not_void: root_ast /= Void
			root_ast_has_defaults: root_ast.defaults /= Void
		local
			d_option: D_OPTION_SD
			ass: ASSERTION_SD
			v: OPT_VAL_SD
			had_assertion: BOOLEAN
		do
			if check_check.is_selected then
				had_assertion := True
				v := new_check_sd (new_id_sd ("check", False))
				ass := new_assertion_sd
				d_option := new_d_option_sd (ass, v)
				root_ast.defaults.extend (d_option)
			end
			if require_check.is_selected then
				had_assertion := True
				v := new_require_sd (new_id_sd ("require", False))
				ass := new_assertion_sd
				d_option := new_d_option_sd (ass, v)
				root_ast.defaults.extend (d_option)
			end
			if ensure_check.is_selected then
				had_assertion := True
				v := new_ensure_sd (new_id_sd ("ensure", False))
				ass := new_assertion_sd
				d_option := new_d_option_sd (ass, v)
				root_ast.defaults.extend (d_option)
			end
			if loop_check.is_selected then
				had_assertion := True
				v := new_loop_sd (new_id_sd ("loop", False))
				ass := new_assertion_sd
				d_option := new_d_option_sd (ass, v)
				root_ast.defaults.extend (d_option)
			end
			if invariant_check.is_selected then
				had_assertion := True
				v := new_invariant_sd (new_id_sd ("invariant", False))
				ass := new_assertion_sd
				d_option := new_d_option_sd (ass, v)
				root_ast.defaults.extend (d_option)
			end
			if not had_assertion then
				v := new_no_sd (new_id_sd ("no", False))
				ass := new_assertion_sd
				d_option := new_d_option_sd (ass, v)
				root_ast.defaults.extend (d_option)
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
			app_name_field.remove_text
			disable_select (check_check)
			disable_select (require_check)
			disable_select (ensure_check)
			disable_select (loop_check)
			disable_select (invariant_check)
			root_class_field.remove_text
			root_creation_field.remove_text

				-- Default should be C generation unless specified
				-- otherwise in Ace file.
			if generation_combo.is_sensitive then
				enable_select (generation_combo.i_th (standard_code))
			end
		ensure then
			app_name_field_voided: app_name_field.text = Void
			root_class_field_voided: root_class_field.text = Void
			root_creation_field_voided: root_creation_field.text = Void
			check_check_not_selected: not check_check.is_selected
			require_check_not_selected: not require_check.is_selected
			ensure_check_not_selected: not ensure_check.is_selected
			loop_check_not_selected: not loop_check.is_selected
			invariant_check_not_selected: not invariant_check.is_selected
		end

feature {NONE} -- Initialization

	make (top: EB_SYSTEM_WINDOW) is
			-- Create widget corresponding to `General' tab in notebook.
		local
			hbox: EV_HORIZONTAL_BOX
			vbox: EV_VERTICAL_BOX
			label: EV_LABEL
			sep: EV_HORIZONTAL_SEPARATOR
			frame: EV_FRAME
			item_box: EV_VERTICAL_BOX
		do
			system_window := top
			tab_make
			
			default_create
			set_border_width (Layout_constants.Small_border_size)
			set_padding (Layout_constants.Small_padding_size)

				-- Application information entry.
			create frame.make_with_text ("Application information ")
			create vbox

				-- Compilation type
			create label.make_with_text ("Compilation_type: ")
			label.align_text_left
			create compilation_combo
			create item_box
			item_box.set_padding (Layout_constants.Tiny_padding_size)
			item_box.extend (label)
			item_box.extend (compilation_combo)
			vbox.extend (item_box)

				-- Application name
			create label.make_with_text ("Application name: ")
			label.align_text_left
			create app_name_field
			create item_box
			item_box.set_padding (Layout_constants.Tiny_padding_size)
			item_box.extend (label)
			item_box.extend (app_name_field)
			vbox.extend (item_box)

				-- Root class entry
			create label.make_with_text ("Root class: ")
			label.align_text_left
			create root_class_field
			create item_box
			item_box.set_padding (Layout_constants.Tiny_padding_size)
			item_box.extend (label)
			item_box.extend (root_class_field)
			vbox.extend (item_box)

				-- Root creation procedure entry
			create label.make_with_text ("Creation procedure name: ")
			label.align_text_left
			create root_creation_field
			create item_box
			item_box.set_padding (Layout_constants.Tiny_padding_size)
			item_box.extend (label)
			item_box.extend (root_creation_field)
			vbox.extend (item_box)

			vbox.set_padding (Layout_constants.Small_padding_size)
			vbox.set_border_width (Layout_constants.Small_border_size)
			frame.extend (vbox)
			extend (frame)
			disable_item_expand (frame)

			create sep
			extend (sep)
			disable_item_expand (sep)

			create hbox
			hbox.extend (assertion_frame ("Default assertions"))
			hbox.extend (generation_type_frame ("Generation output"))
			hbox.set_padding (Layout_constants.Small_padding_size)
			extend (hbox)

			create frame.make_with_text ("Precompiled library")
			create hbox
			hbox.set_border_width (Layout_constants.Small_border_size)
			create label.make_with_text ("Location: ")
			hbox.extend (label)
			hbox.disable_item_expand (label)
			create precompiled_combo
			hbox.extend (precompiled_combo)
			frame.extend (hbox)
			extend (frame)
			disable_item_expand (frame)

			compilation_combo.extend (create {EV_LIST_ITEM}.make_with_text ("Application"))
			compilation_combo.extend (create {EV_LIST_ITEM}.make_with_text ("Library"))
			compilation_combo.extend (create {EV_LIST_ITEM}.make_with_text ("Precompilation"))
			enable_select (compilation_combo.i_th (normal_code))
			compilation_combo.disable_edit
		end

	generation_type_frame (st: STRING): EV_FRAME is
			-- Frame containing type of generator.
		require
			st_not_void: st /= Void
		local
			vbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			label: EV_LABEL
			l_item: EV_LIST_ITEM
			dotnet_name: FILE_NAME
			dotnet_file: RAW_FILE
		do
			create Result.make_with_text (st)
			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)

			create hbox
			create label.make_with_text ("Type: ")
			hbox.extend (label)
			hbox.disable_item_expand (label)
			create generation_combo
			generation_combo.set_minimum_width (Layout_constants.dialog_unit_to_pixels(136))
			create l_item.make_with_text ("Standard (C/byte code)")
			l_item.select_actions.extend (system_window~enable_c_generation)
			generation_combo.extend (l_item)
			if Platform_constants.is_windows then
				create l_item.make_with_text (".NET (MSIL)")
				l_item.select_actions.extend (system_window~enable_msil_generation)
				generation_combo.extend (l_item)
			end

				-- FIXME: when fully working we have to remove this.
			--generation_combo.extend (create {EV_LIST_ITEM}.make_with_text ("Java"))

			generation_combo.disable_edit

			create dotnet_name.make_from_string (Eiffel_installation_dir_name)
			dotnet_name.set_file_name ("dotnet")
			create dotnet_file.make (dotnet_name)
			if not dotnet_file.exists then
				generation_combo.disable_sensitive
			end

			hbox.extend (generation_combo)
			vbox.extend (hbox)
			vbox.disable_item_expand (hbox)

			Result.extend (vbox)
		end

	assertion_frame (st: STRING): EV_FRAME is
			-- Create a frame containing all options
		require
			st_not_void: st /= Void
		local
			vbox: EV_VERTICAL_BOX
		do
			create Result.make_with_text (st)
			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)

			check_check := new_check_button (vbox, "check")
			require_check := new_check_button (vbox, "require")
			ensure_check := new_check_button (vbox, "ensure")
			loop_check := new_check_button (vbox, "loop")
			invariant_check := new_check_button (vbox, "class invariant")

			Result.extend (vbox)
		end

feature {NONE} -- Standard precompiled libraries

	initialize_precompiled is
			-- Initialize `precompiled_combo' with currently available precompiled
			-- libraries.
		local
			l: like available_precompiled
		do
			l := available_precompiled
			precompiled_combo.wipe_out
			if l /= Void then
				from
					l.start
				until
					l.after
				loop
					precompiled_combo.extend (
						create {EV_LIST_ITEM}.make_with_text (l.item))
					l.forth
				end
			end
		end

	available_precompiled: LINKED_LIST [STRING] is
			-- Looks up the disk to find the precompiled libraries in default
			-- location of Eiffel installation.
			-- The list will only contain those precompiles that are actually
			-- precompiled (by the means the file ./EIFGEN/project.eif exists).
		local
			dir: DIRECTORY
			file_name: FILE_NAME
			dir_name: DIRECTORY_NAME
			file: RAW_FILE
		once
			create dir.make (Default_precompiled_location)
			if dir.exists and then dir.is_readable then
				from
					dir.open_read
					dir.start
					dir.readentry
				until
					dir.lastentry = Void
				loop
					create file_name.make_from_string (dir.name)
					file_name.extend (dir.lastentry)
					create dir_name.make_from_string (file_name)

					file_name.set_file_name (Dot_workbench)
					create file.make (file_name)

					if file.exists then
						if Result = Void then
							create Result.make
						end
						Result.extend (dir_name)
					end
					dir.readentry
				end
				dir.close
			end
		ensure
			no_precompiled_library: Result /= Void implies not Result.is_empty
		end

end -- class EB_SYSTEM_GENERAL_TAB

