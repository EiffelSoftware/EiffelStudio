indexing
	description: "Graphical representation of Defaults tab in EB_SYSTEM_WINDOW"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_ADVANCED_TAB

inherit
	EV_VERTICAL_BOX

	EB_SYSTEM_TAB
		rename
			make as tab_make
		undefine
			default_create, is_equal, copy
		redefine
			reset, enable_c_widgets
		end

	EB_CONSTANTS
		undefine
			default_create, is_equal, copy
		end

	EIFFEL_ENV
		undefine
			default_create, is_equal, copy
		end

	SHARED_WORKBENCH
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

create
	make

feature -- Access

	name: STRING is "Advanced"
			-- Name of tab in System Window.

feature -- System analyzis access

	exception_trace_check: EV_CHECK_BUTTON
			-- RTEA status for current system.

feature -- Optimization access

	array_optimization_check: EV_CHECK_BUTTON
			-- Array optimization status for current system.

	dead_code_removal_check: EV_CHECK_BUTTON
			-- Dead code removal status for current system.

	inlining_check: EV_CHECK_BUTTON
			-- Inlining status for current system.

	inlining_size_field: EV_SPIN_BUTTON
			-- Inlining size for current system.

feature -- Language access

	address_expression_check: EV_CHECK_BUTTON
			-- Address expression status for current system.
	
	vape_check: EV_CHECK_BUTTON
			-- VAPE status for current system.

feature -- Code generation access

	console_check: EV_CHECK_BUTTON
			-- Console application status for current system.

	dynamic_rt_check: EV_CHECK_BUTTON
			-- Dynamic run-time status for current system.

	mt_runtime_check: EV_CHECK_BUTTON
			-- Multithreaded run-time status for current system.

	shared_library_check: EV_CHECK_BUTTON
			-- Shared library generation status for current system.

	shared_library_field: EV_PATH_FIELD
			-- Shared library field name for current system.

feature -- Parent access

	system_window: EB_SYSTEM_WINDOW
			-- Graphical parent of Current.

feature -- Store/Retrieve

	store (root_ast: ACE_SD) is
			-- Store content of widget into `root_ast'.
		local
			defaults: LACE_LIST [D_OPTION_SD]
			l_name: STRING
		do
			defaults := root_ast.defaults
			if defaults = Void then
					-- No default option, we need to create them.
				create defaults.make (10)
				root_ast.set_defaults (defaults)
			end
			
			defaults.finish
			
			defaults.extend (new_special_option_sd ("check_vape", Void, vape_check.is_selected))
			defaults.extend (new_special_option_sd ("console_application", Void,
				console_check.is_selected))

			if address_expression_check.is_sensitive then
				defaults.extend (new_special_option_sd ("address_expression", Void,
					address_expression_check.is_selected))
			end

			if array_optimization_check.is_sensitive then
				defaults.extend (new_special_option_sd ("array_optimization", Void,
					array_optimization_check.is_selected))
			end

			if dead_code_removal_check.is_sensitive then
				defaults.extend (new_special_option_sd ("dead_code_removal", Void,
					dead_code_removal_check.is_selected))
			end

			if dynamic_rt_check.is_sensitive then
				defaults.extend (new_special_option_sd ("dynamic_runtime", Void,
					dynamic_rt_check.is_selected))
			end

			if exception_trace_check.is_sensitive then
				defaults.extend (new_special_option_sd ("exception_trace", Void,
					exception_trace_check.is_selected))
			end

			if inlining_check.is_sensitive then
				defaults.extend (new_special_option_sd ("inlining", Void,
					inlining_check.is_selected))
				if inlining_check.is_selected then
					defaults.extend (new_special_option_sd ("inlining_size",
						inlining_size_field.text, True))
				end
			end

			if mt_runtime_check.is_sensitive then
				defaults.extend (new_special_option_sd ("multithreaded", Void,
					mt_runtime_check.is_selected))
				if shared_library_check.is_selected then
					l_name := shared_library_field.text
					if l_name.is_empty then
						l_name := " "
					end
					defaults.extend (new_special_option_sd ("shared_library_definition",
						l_name, True))
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
			defaults: LACE_LIST [D_OPTION_SD]
			precomp_opt: D_PRECOMPILED_SD
			opt: D_OPTION_SD
		do
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
						if is_item_removable then
							defaults.remove
						else
							defaults.forth
						end
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
			a_opt_not_precompiled_option: not a_opt.conforms_to (create {D_PRECOMPILED_SD})
			a_opt_not_optional_option: not a_opt.conforms_to (create {O_OPTION_SD})
			a_opt_has_option: a_opt.option /= Void
			a_opt_has_no_precompiled_option: not a_opt.option.is_precompiled
			a_opt_has_value: a_opt.value /= Void
		local
			opt: OPTION_SD
			val: OPT_VAL_SD
			free_option: FREE_OPTION_SD
		do
			is_item_removable := False
			opt := a_opt.option
			val := a_opt.value
			if opt.is_free_option then
				free_option ?= opt
				is_item_removable := True
				if free_option.code = free_option.address_expression then
					set_selected (address_expression_check, val.is_yes)
					
				elseif free_option.code = free_option.array_optimization then
					set_selected (array_optimization_check, val.is_yes)
				
				elseif free_option.code = free_option.console_application then
					set_selected (console_check, val.is_yes)

				elseif free_option.code = free_option.dead_code then
					set_selected (dead_code_removal_check, val.is_yes)
									
				elseif free_option.code = free_option.dynamic_runtime then
					set_selected (dynamic_rt_check, val.is_yes)
					
				elseif free_option.code = free_option.exception_stack_managed then
					set_selected (exception_trace_check, val.is_yes)
				
				elseif free_option.code = free_option.inlining then
					set_selected (inlining_check, val.is_yes)
				
				elseif free_option.code = free_option.inlining_size then
					inlining_size_field.set_text (val.value)

				elseif free_option.code = free_option.multithreaded then
					set_selected (mt_runtime_check, val.is_yes)
								
				elseif free_option.code = free_option.shared_library_definition then
					enable_select (shared_library_check)
					shared_library_field.set_text (val.value)

				elseif free_option.code = free_option.check_vape then
					set_selected (vape_check, val.is_yes)
					
				else
					is_item_removable := False		
				end
			elseif opt.is_optimize then
			end
		end

feature -- Checking

	perform_check is
			-- Perform check on content of current pane.
		do
			set_is_valid (True)
		end

feature -- Status setting

	enable_c_widgets is
			-- Enable all C widgets and disable all MSIL specific ones.	
		do
			Precursor {EB_SYSTEM_TAB}
			if not inlining_check.is_selected then
				inlining_size_field.disable_sensitive
			end

			if not shared_library_check.is_selected then
				shared_library_field.disable_sensitive
			end
		end

feature -- Initialization

	reset is
			-- Set graphical elements to their default value.
		do
			Precursor {EB_SYSTEM_TAB}
			disable_select (address_expression_check)
			disable_select (array_optimization_check)
			disable_select (console_check)
			enable_select (dead_code_removal_check)
			disable_select (dynamic_rt_check)
			disable_select (exception_trace_check)
			disable_select (inlining_check)
			disable_select (mt_runtime_check)
			disable_select (shared_library_check)
			enable_select (vape_check)
			inlining_size_field.set_value (inlining_size_field.value_range.lower)
			shared_library_field.remove_text
		ensure then
			address_expression_check_not_selected: not address_expression_check.is_selected
			array_optimization_check_not_selected: not array_optimization_check.is_selected
			console_check_not_selected: not console_check.is_selected
			dead_code_removal_check_selected: dead_code_removal_check.is_selected
			dynamic_rt_check_not_selected: not dynamic_rt_check.is_selected
			exception_trace_check_not_selected: not exception_trace_check.is_selected
			inlining_check_not_selected: not inlining_check.is_selected
			mt_runtime_check_not_selected: not mt_runtime_check.is_selected
			vape_check_selected: vape_check.is_selected
			inlining_size_field_set: inlining_size_field.value = 0
			shared_library_check_not_selected: not shared_library_check.is_selected
			shared_library_field_is_insensitive: not shared_library_field.is_sensitive
			shared_library_field_voided: shared_library_field.text.is_empty
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
			set_border_width (5)
			set_padding (5)

				-- Generation option
			extend (ace_frame ("Global setting"))
			disable_item_expand (i_th (1))
			extend (options_frame ("Standard options"))
			extend (finalized_options_frame ("Finalization options"))

				-- Add C specific widgets
			c_specific_widgets.extend (address_expression_check)
			c_specific_widgets.extend (dynamic_rt_check)
			c_specific_widgets.extend (mt_runtime_check)
			c_specific_widgets.extend (shared_library_check)
			c_specific_widgets.extend (shared_library_field)
			c_specific_widgets.extend (exception_trace_check)
			c_specific_widgets.extend (array_optimization_check)
			c_specific_widgets.extend (dead_code_removal_check)
			c_specific_widgets.extend (inlining_check)
			c_specific_widgets.extend (inlining_size_field)
		end
	
	ace_frame (st: STRING): EV_FRAME is
			-- Frame containing ability to reset or load a project setting.
		require
			st_not_void: st /= Void
		local
			button: EV_BUTTON
			hbox: EV_HORIZONTAL_BOX
		do
			create Result.make_with_text (st)

			create hbox
			hbox.set_border_width (10)
			hbox.set_padding (20)

			hbox.extend (create {EV_CELL})

				-- Create Load Ace button
			create button.make_with_text_and_action (Interface_names.b_Load_ace,
				system_window~load_ace)
			hbox.extend (button)
			hbox.disable_item_expand (button)

			create button.make_with_text_and_action (Interface_names.b_Edit_ace,
				system_window~edit_ace)
			hbox.extend (button)
			hbox.disable_item_expand (button)


			create button.make_with_text_and_action (Interface_names.b_New_ace,
				system_window~reset_content)
			hbox.extend (button)
			hbox.disable_item_expand (button)

			hbox.extend (create {EV_CELL})

			Result.extend (hbox)
		end

	options_frame (st: STRING): EV_FRAME is
			-- Create a frame containing all options
		require
			st_not_void: st /= Void
		local
			vbox: EV_VERTICAL_BOX
			list: ARRAYED_LIST [EV_WIDGET]
		do
			create Result.make_with_text (st)
			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)

			console_check := new_check_button (vbox, "Console application")
			vape_check := new_check_button (vbox, "Enforce VAPE validity constraint")
			dynamic_rt_check := new_check_button (vbox, "Dynamic runtime")
			mt_runtime_check := new_check_button (vbox, "Multithreaded runtime")
			address_expression_check := new_check_button (vbox, "Address expression")
			shared_library_check := new_check_button (vbox, "Shared library definition")

			vbox.set_padding (Layout_constants.Tiny_padding_size)
			create shared_library_field.make_with_text_and_parent (" Location: ", system_window.window)
			shared_library_field.set_browse_for_file ("*.def")
			shared_library_field.disable_sensitive
			vbox.extend (shared_library_field)
			vbox.disable_item_expand (shared_library_field)
			
			create list.make (2)
			list.extend (shared_library_field)
			shared_library_check.select_actions.extend (~list_desactivation_action
					(shared_library_check, list))

			Result.extend (vbox)
		end

	finalized_options_frame (st: STRING): EV_FRAME is
			-- Create a frame containing all options
		require
			st_not_void: st /= Void
		local
			vbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
		do
			create Result.make_with_text (st)
			create vbox
			vbox.set_border_width (3)

			array_optimization_check := new_check_button (vbox, "Array optimization")
			dead_code_removal_check := new_check_button (vbox, "Dead code removal")
			exception_trace_check := new_check_button (vbox, "Exception trace")

			create hbox
			create inlining_size_field
			inlining_size_field.value_range.resize_exactly (0, 100)
			inlining_check := new_check_button (hbox, "Inlining ")
			inlining_check.select_actions.extend (~desactivation_action
					(inlining_check, inlining_size_field))
			inlining_size_field.disable_sensitive
			hbox.extend (inlining_size_field)
			vbox.extend (hbox)
			vbox.disable_item_expand (hbox)

			Result.extend (vbox)
		end

invariant
	address_expression_check_not_void: address_expression_check /= Void
	array_optimization_check_not_void: array_optimization_check /= Void
	console_check_not_void: console_check /= Void
	dead_code_removal_check_not_void: dead_code_removal_check /= Void
	dynamic_rt_check_not_void: dynamic_rt_check /= Void
	exception_trace_check_not_void: exception_trace_check /= Void
	inlining_check_not_void: inlining_check /= Void
	inlining_size_field_not_void: inlining_size_field /= Void
	mt_runtime_check_not_void: mt_runtime_check /= Void
	shared_library_check_not_void: shared_library_check /= Void
	shared_library_field_not_void: shared_library_field /= Void
	vape_check_not_void: vape_check /= Void
	
end -- class EB_SYSTEM_ADVANCED_TAB










