indexing
	description: "Abstract representation of a system tool tab."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_SYSTEM_TAB

inherit
	LACE_AST_FACTORY
		export
			{NONE} all
		end

feature -- Initialization

	make is
		do
			create msil_specific_widgets.make (10)
			create c_specific_widgets.make (10)
			create widgets_set_before_has_compilation_started.make (10)
			create widgets_set_before_is_already_compiled.make (10)
		end

	reset is
			-- Set graphical elements to their default value.
		do
			is_item_removable := False
		ensure
			is_item_removable_disabled: not is_item_removable		
		end
	
feature -- Access

	name: STRING is
			-- Name of current tab.
		deferred
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
		end

	last_error_message: STRING
			-- Last error message, set after call to `check_validity'.

	msil_specific_widgets: ARRAYED_LIST [EV_WIDGET]
			-- List of widgets specific to MSIL generation.
			-- Not sensitive when no MSIL generation is chosen
			-- from EB_SYSTEM_GENERAL_TAB.

	c_specific_widgets: ARRAYED_LIST [EV_WIDGET]
			-- List of widgets specific to C generation.
			-- Not sensitive when MSIL generation is chosen
			-- from EB_SYSTEM_GENERAL_TAB.

	widgets_set_before_has_compilation_started: ARRAYED_LIST [EV_WIDGET]
			-- List of widgets that can be set only once
			-- before the first Eiffel compilation started.
			
	widgets_set_before_is_already_compiled: ARRAYED_LIST [EV_WIDGET]
			-- List of widgets that can be set only once
			-- before the end of the first compilation.
			
feature -- Status

	has_error: BOOLEAN is
			-- Did an error occur after call to `check_validity'.
		do
			Result := last_error_message /= Void
		end

feature -- Status setting

	enable_msil_widgets is
			-- Enable all MSIL widgets and disable all C specific ones.
		do
			msil_specific_widgets.do_all ({EV_WIDGET}~enable_sensitive)
			c_specific_widgets.do_all ({EV_WIDGET}~disable_sensitive)
		end

	enable_c_widgets is
			-- Enable all C widgets and disable all MSIL specific ones.
		do
			msil_specific_widgets.do_all ({EV_WIDGET}~disable_sensitive)
			c_specific_widgets.do_all ({EV_WIDGET}~enable_sensitive)
		end

	disable_widgets_set_before_has_compilation_started is
			-- Disable all widgets that can be set only once during
			-- a project lifetime.
		do
			widgets_set_before_has_compilation_started.do_all ({EV_WIDGET}~disable_sensitive)
		end

	disable_widgets_set_before_is_already_compiled is
			-- Disable all widgets that can be set only once during
			-- a project lifetime.
		do
			widgets_set_before_is_already_compiled.do_all ({EV_WIDGET}~disable_sensitive)
		end
		
feature -- Setting

	set_is_valid (v: BOOLEAN) is
			-- Set `is_valid' with `v'.
		do
			internal_is_valid := v
		ensure
			is_valid_set: is_valid = v
		end

feature -- Checking

	perform_check is
			-- Perform check on content of current tab.
		deferred
		end

	is_valid: BOOLEAN is
			-- Is content of current pane valid for Ace file.
			-- Set by call to `perform_check'.
		do
			Result := internal_is_valid
		end

	last_error: STRING
			-- Error message associated with invalid content.

feature -- Store/Retrieve

	store (root_ast: ACE_SD) is
			-- Store content of widget into `root_ast'.
		require
			root_ast_not_void: root_ast /= Void
		deferred
		end
	
	post_store_reset is
			-- Action to be done after a store has been done.
			-- Eg. refresh display. By default do nothing.
		do
		end

	retrieve (root_ast: ACE_SD) is
			-- Retrieve content of `root_ast' and update content of widget.
		require
			root_ast_not_void: root_ast /= Void
		deferred
		end

feature -- Validity

	check_validity is
			-- Check validity of current tab.
		do
			last_error_message := Void
		end

feature -- Action

	desactivation_action (controler: EV_SELECTABLE; controlee: EV_WIDGET) is
			-- Selecting `controler' will make `controlee' sensitive
			-- and set focus on `controlee'. Unselecting it will make `controlee'
			-- unsensitive.
		require
			controler_not_void: controler /= Void
			controlee_not_void: controlee /= Void
			controler_selected: controler.is_selected implies (not controlee.is_sensitive
				and then not controlee.has_focus)
			controler_not_selected: not controler.is_selected implies controlee.is_sensitive
		local
			l: LINKED_LIST [EV_WIDGET]
		do
			create l.make
			l.extend (controlee)
			list_desactivation_action (controler, l)
		ensure
			controler_selected: controler.is_selected implies controlee.is_sensitive
					and then (controlee.is_displayed implies controlee.has_focus)
			controler_not_selected: not controler.is_selected implies (not controlee.is_sensitive
					and then (controlee.is_displayed implies not controlee.has_focus))
		end

	list_desactivation_action (controler: EV_SELECTABLE; l_controlee: LIST [EV_WIDGET]) is
			-- Selecting `controler' will make widgets in `l_controlee' sensitive
			-- and set focus on last item of `l_controlee'. Unselecting it will make `l_controlee'
			-- unsensitive.
		require
			controler_not_void: controler /= Void
			l_controlee_not_void: l_controlee /= Void
			controler_selected: controler.is_selected implies
				(not l_controlee.for_all ({EV_WIDGET}~is_sensitive)
				and then not l_controlee.for_all ({EV_WIDGET}~has_focus))
			controler_not_selected: not controler.is_selected implies
				l_controlee.for_all ({EV_WIDGET}~is_sensitive)
		do
			if controler.is_selected then
				from
					l_controlee.start
				until
					l_controlee.after
				loop
					l_controlee.item.enable_sensitive
					l_controlee.forth
				end
				if l_controlee.last.is_displayed then
					l_controlee.last.set_focus
				end
			else
				from
					l_controlee.start
				until
					l_controlee.after
				loop
					l_controlee.item.disable_sensitive
					l_controlee.forth
				end

			end
		ensure
			controler_selected:
				controler.is_selected implies (l_controlee.for_all ({EV_WIDGET}~is_sensitive)
				and then (l_controlee.last.is_displayed implies l_controlee.last.has_focus))
			controler_not_selected:
				not controler.is_selected implies (not l_controlee.for_all ({EV_WIDGET}~is_sensitive)
				and then (l_controlee.last.is_displayed implies not l_controlee.for_all ({EV_WIDGET}~has_focus)))
		end

feature -- Convenience

	set_selected (w: EV_DESELECTABLE; v: BOOLEAN) is
			-- If `v' select `w' if not selected.
			-- Otherwise, deselect `w' if selected.
		require
			w_not_void: w /= Void
		do
			if v and then not w.is_selected then
				w.enable_select
			elseif not v and then w.is_selected then
				w.disable_select
			end
		ensure
			w_is_selected: v implies w.is_selected
			w_not_is_selected: not v implies not w.is_selected
		end

	enable_select (w: EV_DESELECTABLE) is
			-- Select `w' if not selected. Otherwise nothing
		require
			w_not_void: w /= Void
		do
			set_selected (w, True)
		ensure
			w_is_selected: w.is_selected
		end

	disable_select (w: EV_DESELECTABLE) is
			-- Deselect `w' if selected. Otherwise nothing
		require
			w_not_void: w /= Void
		do
			set_selected (w, False)
		ensure
			w_not_is_selected: not w.is_selected
		end

	to_upper (st: STRING): like st is
			-- Duplicate `st' with all upper case characters.
		require
			st_not_void: st /= Void
		do
			Result := clone (st)
			Result.to_upper
		ensure
			Result_not_void: Result /= Void
			Result_is_duplicated: Result /= st
			-- Result characters are upper case.
		end

	new_check_button (box: EV_BOX; st: STRING): EV_CHECK_BUTTON is
			-- Add check button with title `st' to `box'
		require
			box_not_void: box /= Void
			st_not_void: st /= Void
		do
			create Result.make_with_text (st)
			box.extend (Result)
			box.disable_item_expand (Result)
		ensure
			result_not_void: Result /= Void
		end

	new_radio_button (box: EV_BOX; st: STRING): EV_RADIO_BUTTON is
			-- Add radio button with title `st' to `box'
		require
			box_not_void: box /= Void
			st_not_void: st /= Void
		do
			create Result.make_with_text (st)
			box.extend (Result)
			box.disable_item_expand (Result)
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Generation of AST

	new_special_option_sd (type_id: INTEGER; a_name: STRING; flag: BOOLEAN): D_OPTION_SD is
			-- Create new `D_OPTION_SD' node corresponding to a free
			-- option clause. If `a_name' Void then it is `free_option (flag)'.
		require
			valid_type_id: type_id > 0
			type_id_big_enough: type_id < feature {FREE_OPTION_SD}.free_option_count
		local
			argument_sd: FREE_OPTION_SD
			v: OPT_VAL_SD
			l_type_name: STRING
		do
			l_type_name := free_option_names.item (type_id)
			argument_sd := new_free_option_sd (new_id_sd (l_type_name, False))
			if a_name /= Void then
				v := new_name_sd (new_id_sd (a_name, True))
			else
				if flag then
					v := new_yes_sd (new_id_sd ("yes", False))
				else
					v := new_no_sd (new_id_sd ("no", False))
				end
			end
			Result := new_d_option_sd (argument_sd, v)
		ensure
			result_not_void: Result /= Void
		end

	new_lace_list (list: EV_LIST): LACE_LIST [ID_SD] is
			-- Convert `list' into `LACE_LIST [ID_SD]'.
		require
			list_not_void: list /= Void
		do
			create Result.make (list.count)
			from
				list.start
			until
				list.after
			loop
				Result.extend (new_id_sd (list.item.text, True))
				list.forth
			end
		ensure
			result_not_void: Result /= Void
		end

	new_trace_option_sd (enabled: BOOLEAN): D_OPTION_SD is
			-- Create new `D_OPTION_SD' node corresponding to a trace
			-- clause. If `enabled' it will be `trace (yes)' otherwise it
			-- will be `trace (no)'.
		local
			trace_sd: TRACE_SD
			v: OPT_VAL_SD
		do
			trace_sd := new_trace_sd
			if enabled then
				v := new_yes_sd (new_id_sd ("yes", False))
			else
				v := new_no_sd (new_id_sd ("no", False))
			end
			Result := new_d_option_sd (trace_sd, v)
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	is_item_removable: BOOLEAN
			-- Does current option being analyzed need to be deleted from AST?

	internal_is_valid: BOOLEAN
			-- Is content of current pane valid for Ace file.
			-- Set by call to `perform_check'.

	free_option_names: ARRAY [STRING] is
			-- List all option names used in FREE_OPTION_SD
		once
			Result := (create {FREE_OPTION_SD}).option_names
		ensure
			result_not_void: Result /= Void
		end

invariant
	msil_specific_widgets_not_void: msil_specific_widgets /= Void
	c_specific_widgets_not_void: c_specific_widgets /= Void
	widgets_set_before_has_compilation_started_not_void: widgets_set_before_has_compilation_started /= Void
	widgets_set_before_is_already_compiled_not_void: widgets_set_before_is_already_compiled /= Void

end -- class EB_SYSTEM_TAB



