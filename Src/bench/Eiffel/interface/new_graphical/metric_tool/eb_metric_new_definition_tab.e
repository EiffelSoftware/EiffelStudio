indexing
	description: "Tab to compose a new metric definition."
	author: "Tanit Talbi"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_NEW_DEFINITION_TAB

inherit
	EB_METRIC_SCOPE_INFO

	SHARED_XML_ROUTINES
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EV_KEY_CONSTANTS
		export
			{NONE} all
			{ANY} Key_enter
		end
		
	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

feature -- Access

	name_field: EV_TEXT_FIELD
		-- Text field to enter new metric's name.

	unit_field: EV_TEXT_FIELD
		-- Text_field to display new_metric' unit. Automatically filled in
		-- regarding metric constituants.

	interface: EB_METRIC_NEW_DEFINITION_CMD
		-- Parent command.

	new_metric_successful: BOOLEAN
		-- Has new metric definition been successful?

	metric_definition: XML_ELEMENT
		-- XML representation of the currently defined metric.

	error_name: BOOLEAN
		-- Does `name' contain errors?

	existing_basic_name: BOOLEAN
		-- Is there a basic metric defined with `name'?

	saved: BOOLEAN
		-- Has current new metric been saved?

	min_scope: INTEGER
		-- Lowest scope for the new composite metric.

	confirm_dialog: EV_CONFIRMATION_DIALOG
		-- Dialog to confirm overwritting.

feature -- Setting

	set_saved (bool: BOOLEAN) is
			-- Assign `bool' to `saved'.
		do
			saved := bool
		end

	set_min_scope (int: INTEGER) is
			-- Assign `int' to min_scope.
		do
			min_scope := int
		end

feature -- Action

	dialog_key_press_action (a_key: EV_KEY; a_widget: EV_WIDGET) is
			-- Keybord shortcuts: ESC, CTRL+N, CTRL+S, CR.
		local
			a_key_code: INTEGER
			a_button: EV_BUTTON
		do
			a_key_code := a_key.code

			inspect a_key_code 
				when Key_escape then
						-- Escape key pressed, so push the cancel button.
					interface.new_metric_definition_dialog.default_cancel_button.select_actions.call ([])

				when Key_n then
					if ev_application.ctrl_pressed then
						interface.tab.preset
					end

				when Key_s then
					if ev_application.ctrl_pressed then
						interface.save_button.select_actions.call ([])
					end

				when Key_enter then
						-- Enter key pressed, so push the default button.
					a_button ?= a_widget
					if a_button /= Void then
						a_button.select_actions.call ([])
					end
				else
			end
		end

	following_widget (a_key: EV_KEY; next_widget: EV_WIDGET) is
			-- On Carriage Return, set focus on `next_widget'.
		require
			existing_widget: a_key.code = Key_enter implies next_widget /= Void
		do
			if a_key.code = Key_enter then
				next_widget.set_focus
			end
		end

	change_in_name (s: STRING) is
			-- Enable `save_button' when name is changed.
		do
			if s /= Void then
				enable_save
			end
		end

	key_enter_pressed (a_key: EV_KEY; a_button: EV_BUTTON) is
			-- Action to be performed on CR.
		require
			existing_button: a_key.code = Key_enter implies a_button /= Void
		do
			if a_key.code = Key_enter then
				a_button.select_actions.call ([])
			end
		end

	enable_save is
			-- Allow metric definition saving.
		do
			saved := False
			if interface /= Void and then interface.save_button /= Void then
				interface.save_button.enable_sensitive
			end
		end

	disable_save is
			-- Forbid metric_definition saving.
		do
			saved := True
			if interface /= Void and then interface.save_button /= Void then
				interface.save_button.disable_sensitive
			end
		end

	put_item_with_text (combobox: EV_COMBO_BOX; text: STRING) is
			-- Display `text' in `combobox' when disabled for edition.
		require
			not_editable: not combobox.is_editable
			text_not_empty: text /= Void and then not text.is_empty
		do
			from
				combobox.start
			until
				combobox.after
			loop
				if equal (combobox.item.text, text) then
					combobox.select_actions.block
					combobox.item.enable_select
					combobox.select_actions.resume
				end
				combobox.forth
			end
		end
		
	yes_action is
			-- Action to be performed when user overwrites a metric previously defined
			-- with same name as the currently being defined.
		do
			interface.set_overwrite (True)
		end

feature -- Metric constituents.

	new_metric: EB_METRIC is
			-- Build a metric object regarding user's definition.
		require
			valid_name: name_field.text /= Void and then not name_field.text.is_empty
			valid_unit: unit_field.text /= Void and then not unit_field.text.is_empty		
			metric_not_saved: not saved
		deferred
		ensure
			metric_built: Result /= Void
		end

	new_metric_element: XML_ELEMENT is
			-- Build a storable definition for the metric being saved.
		require
			valid_name: name_field.text /= Void and then not name_field.text.is_empty
			valid_unit: unit_field.text /= Void and then not unit_field.text.is_empty
			metric_not_saved: not saved
		deferred
		ensure
			metric_definition_built: valid_metric_definition implies not metric_definition.is_empty	
		end

	valid_metric_definition: BOOLEAN is
			-- Is current definition correct regarding metric type?
		deferred
		end

	error: BOOLEAN is
			-- Has current definition any syntax error regarding metric_type?
		deferred
		end
		
	throw_error is
			-- Must be called after `error' to display an information dialog.
		deferred
		end

	something_to_save: BOOLEAN is
			-- Did user make some changes that could be saved?
		deferred
		end

feature -- Existing name

	existing_name: BOOLEAN is
			-- Is current metric name previously used for another metric?
		do
			Result := name_field.text /= Void and then not name_field.text.is_empty and then
				interface.tool.metrics.has (interface.tool.metric (name_field.text))
		end
	
	build_confirm_dialog is
		local
			actions_array: ARRAY [PROCEDURE [ANY, TUPLE []]]
		do
			create actions_array.make (1, 2)
			actions_array.put (~yes_action, 1)
			actions_array.put (~do_nothing, 2)
			create confirm_dialog.make_with_text_and_actions (
								"Name is already used to define%N%
								%a metric. Do you want%N%
								%to overwrite it?", actions_array)
		end
	
	to_scope (a_min_scope: INTEGER): STRING is
			-- Transalte unique value `a_min_scope' to a storable one.
		require
			correct_scope: a_min_scope >= Feature_scope and
							a_min_Scope <= System_scope
		do
			inspect a_min_scope
				when Feature_scope then Result := "Feature_scope"
				when Class_scope then Result := "Class_scope"
				when Cluster_scope then Result := "Cluster_scope"
				when System_scope then Result := "System_scope"
			end
		end

feature -- Reinitialize

	preset is
			-- Reste needed objects.
		do
			name_field.remove_text
		end

end -- class EB_METRIC_NEW_DEFINITION_TAB
