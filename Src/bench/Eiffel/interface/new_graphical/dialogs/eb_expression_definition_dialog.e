indexing
	description: "Dialogs that allow to define a new expression in the debugger sense"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXPRESSION_DEFINITION_DIALOG

inherit
	EB_CONSTANTS
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end

create
	make,
	make_with_class,
	make_with_object,
	make_for_context,
	make_with_expression

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		local
			cnt: EV_VERTICAL_BOX
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			f: EV_FRAME
			cn_l: EV_LABEL
			oa_l: EV_LABEL
			sz: INTEGER
			cb: EV_BUTTON
		do
				--| Create and set up the dialog.
			create dialog
			dialog.set_title (Interface_names.t_New_expression)

				--| Create and set up the radio buttons.
			create class_radio.make_with_text (Interface_names.t_Class)
			class_radio.select_actions.extend (~on_class_radio_selected)
			create object_radio.make_with_text (Interface_names.l_Object)
			object_radio.select_actions.extend (~on_object_radio_selected)
			create context_radio.make_with_text (Interface_names.l_Current_context)
			context_radio.select_actions.extend (~on_context_radio_selected)
			
				--| Create and set up the text fields.
			create class_field
			create address_field
			create expression_field
			class_field.disable_sensitive
			address_field.disable_sensitive
			expression_field.change_actions.extend (~on_expression_changed)
			if
				not application.is_running or
				not Application.is_stopped
			then
				object_radio.disable_sensitive
				address_field.disable_sensitive
			end
			
				--| Create the labels.
			create cn_l.make_with_text (Interface_names.l_Class_name)
			create oa_l.make_with_text (Interface_names.l_Address)
			
				--| Create and set up the buttons.
			create ok_button.make_with_text (Interface_names.b_Ok)
			ok_button.select_actions.extend (~on_ok_pressed)
			create cb.make_with_text (Interface_names.b_Cancel)
			cb.select_actions.extend (~destroy)
			Layout_constants.set_default_size_for_button (ok_button)
			Layout_constants.set_default_size_for_button (cb)
			
				--| Compute the size of the labels.
			sz := cn_l.minimum_width.max (oa_l.minimum_width)
			cn_l.set_minimum_width (sz)
			oa_l.set_minimum_width (sz)

				--| Organize all the widgets.
			create cnt
			cnt.set_border_width (Layout_constants.default_border_size)
			cnt.set_padding (Layout_constants.small_padding_size)

				--| 1) Context frame.
			create f.make_with_text (Interface_names.l_Context)
			create vb
			vb.set_padding (Layout_constants.small_padding_size)
			vb.set_border_width (Layout_constants.small_border_size)
			vb.extend (context_radio)
			vb.extend (object_radio)
			create hb
			hb.extend (oa_l)
			hb.disable_item_expand (oa_l)
			hb.extend (address_field)
			vb.extend (hb)
			vb.extend (class_radio)
			create hb
			hb.extend (cn_l)
			hb.disable_item_expand (cn_l)
			hb.extend (class_field)
			vb.extend (hb)
			f.extend (vb)
			cnt.extend (f)

				--| 2) Expression frame.
			create f.make_with_text (Interface_names.l_Expression)
			create vb
			vb.set_border_width (Layout_constants.small_border_size)
			vb.extend (expression_field)
			f.extend (vb)
			cnt.extend (f)

				--| 3) Buttons.
			create hb
			hb.set_padding (Layout_constants.default_padding_size)
			hb.extend (create {EV_CELL})
			hb.extend (ok_button)
			hb.disable_item_expand (ok_button)
			hb.extend (cb)
			hb.disable_item_expand (cb)
			cnt.extend (hb)
			
			dialog.extend (cnt)

				--| Finish setting up the dialog.
			dialog.set_minimum_width (dialog.minimum_width.max (2 * sz))
			dialog.set_width (dialog.minimum_width.max (3 * sz))
			dialog.set_maximum_height (dialog.minimum_height)
			dialog.set_default_push_button (ok_button)
			dialog.set_default_cancel_button (cb)
			dialog.show_actions.extend (~on_shown)
			focused_widget := expression_field
		end

	make_with_class (cl: CLASS_C) is
			-- Initialize `Current' and force the creation of a class-related expression.
		require
			valid_class: cl /= Void and cl.is_valid
		do
			make
			class_radio.enable_select
			class_field.set_text (cl.name_in_upper)
			disable_all
		end

	make_with_object (oa: STRING) is
			-- Initialize `Current' and force the creation of an object-related expression.
			-- `oa' is the address of the object.
		require
			valid_address: oa /= Void
			application_stopped: Application.is_running and Application.is_stopped
		do
			make
			object_radio.enable_select
			address_field.set_text (oa)
			disable_all
		end

	make_for_context is
			-- Initialize `Current' and force the creation of a context-related expression.
		do
			make
			context_radio.enable_select
			disable_all
		end

	make_with_expression (expr: EB_EXPRESSION) is
			-- Initialize `Current' based on `expr'.
		require
			valid_expression: expr /= Void
		do
			if expr.on_class then
				make_with_class (expr.context_class)
			elseif expr.on_object then
				make_with_object (expr.context_object.object_address)
			else
				make_for_context
			end
			expression_field.set_text (expr.expression)
			modified_expression := expr
		end

feature -- Access

	callback: PROCEDURE [ANY, TUPLE]
			-- Callback that should be called after the dialog is closed.

feature -- Measurement

feature -- Status report

	is_destroyed: BOOLEAN is
			-- Is `Current's implementation destroyed?
		do
			Result := dialog.is_destroyed
		end

	new_expression: EB_EXPRESSION
			-- Expression defined  by `Current', if any.

feature -- Status setting

	set_callback (cb: PROCEDURE [ANY, TUPLE]) is
			-- Define the callback that should be called after the dialog is closed.
		require
			valid_callback: cb /= Void
		do
			callback := cb
		ensure
			callback_set: callback = cb
		end

	show_modal_to_window (w: EV_WINDOW) is
			-- Display `Current' modally to window `w'.
		require
			not_destroyed: not is_destroyed
			w_not_void: w /= void
		do
			dialog.show_modal_to_window (w)
		end

	show_relative_to_window (w: EV_WINDOW) is
			-- Display `Current' modally to window `w'.
		require
			not_destroyed: not is_destroyed
			w_not_void: w /= void
		do
			dialog.show_relative_to_window (w)
		end

	destroy is
			-- Destroy `Current's implementation.
		do
			dialog.destroy
		end

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Event handling

	on_class_radio_selected is
			-- User selected to create an expression based on a class.
		do
			class_field.enable_sensitive
			if class_field.is_displayed then
				class_field.set_focus
			end
			address_field.disable_sensitive
		end

	on_object_radio_selected is
			-- User selected to create an expression based on a class.
		do
			address_field.enable_sensitive
			if address_field.is_displayed then
				address_field.set_focus
			end
			class_field.disable_sensitive
		end

	on_context_radio_selected is
			-- User selected to create an expression based on a class.
		do
			address_field.disable_sensitive
			class_field.disable_sensitive
			if expression_field.is_displayed then
				expression_field.set_focus
			end
		end

	on_expression_changed is
			-- User changed the expression.
		do
			if expression_field.text.is_empty then
				ok_button.disable_sensitive
			else
				ok_button.enable_sensitive
			end
		end

	on_ok_pressed is
			-- User pressed the "OK" button.
		local
			o: DEBUGGED_OBJECT
			cl_i: LIST [CLASS_I]
			cl: CLASS_C
			t: STRING
			wd: EV_WARNING_DIALOG
			oe: STRING
		do
			if modified_expression = Void then
				if class_radio.is_selected then
						-- We try to create an expression related to a class.
					t := class_field.text
						--| First find the class given in `class_field'.
					cl_i := Eiffel_universe.classes_with_name (t)
					if not cl_i.is_empty then
						from
							cl_i.start
						until
							cl_i.after or cl /= Void
						loop
							cl := cl_i.item.compiled_class
							cl_i.forth
						end
						if cl /= Void then
								--| Now we have the class, create the expression.
							create new_expression.make_with_class (cl, expression_field.text)
							if new_expression.syntax_error then
								expression_field.set_focus
								create wd.make_with_text (Warning_messages.w_Syntax_error_in_expression (expression_field.text))
								wd.show_modal_to_window (dialog)
							end
						else
							class_field.set_focus
							create wd.make_with_text (Warning_messages.w_Not_a_compiled_class (t))
							wd.show_modal_to_window (dialog)
						end
					else
						class_field.set_focus
						create wd.make_with_text (Warning_messages.w_Cannot_find_class (t))
						wd.show_modal_to_window (dialog)
					end
				elseif object_radio.is_selected then
						-- We try to create an expression related to a class.
					t := address_field.text
					if
						application.is_running and
						application.is_stopped and then
						application.is_valid_object_address (t)
					then
						create o.make (t, 0, 1)
						create new_expression.make_with_object (o, expression_field.text)
						if new_expression.syntax_error then
							expression_field.set_focus
							create wd.make_with_text (Warning_messages.w_Syntax_error_in_expression (expression_field.text))
							wd.show_modal_to_window (dialog)
						end
					else
						address_field.set_focus
						create wd.make_with_text (Warning_messages.w_Invalid_address (t))
						wd.show_modal_to_window (dialog)
					end
				else
					create new_expression.make_for_context (expression_field.text)
					if new_expression.syntax_error then
						expression_field.set_focus
						create wd.make_with_text (Warning_messages.w_Syntax_error_in_expression (expression_field.text))
						wd.show_modal_to_window (dialog)
					end
				end
			else
				oe := modified_expression.expression
				modified_expression.set_expression (expression_field.text)
				if modified_expression.syntax_error then
						-- Restore the previous expression, since the new one is broken.
					modified_expression.set_expression (oe)
					expression_field.set_focus
					create wd.make_with_text (Warning_messages.w_Syntax_error_in_expression (expression_field.text))
					wd.show_modal_to_window (dialog)
				end
				new_expression := modified_expression
			end
			if new_expression /= Void and then not new_expression.syntax_error then
				destroy
				if callback /= Void then
					callback.call ([])
				end
			end
		end

	on_shown is
			-- The dialog has just been displayed.
		do
			focused_widget.set_focus
		end

feature {NONE} -- Widgets

	expression_field: EV_TEXT_FIELD
			-- Text field that contains the expression.

	class_field: EV_TEXT_FIELD
			-- Text field that contains the context class name.

	address_field: EV_TEXT_FIELD
			-- Text field that contains the context object address.

	class_radio: EV_RADIO_BUTTON
			-- Radio button that is selected when we are creating an expression based on a class.

	object_radio: EV_RADIO_BUTTON
			-- Radio button that is selected when we are creating an expression based on an object.

	context_radio: EV_RADIO_BUTTON
			-- Radio button that is selected when we are creating an expression based on the current context.

	dialog: EV_DIALOG
			-- Real dialog object.

	ok_button: EV_BUTTON
			-- "OK" button.

feature {NONE} -- Implementation

	modified_expression: EB_EXPRESSION
			-- Expression that is being edited, if any.

	disable_all is
			-- Disable the sensitivity of all context widgets.
		do
			class_radio.disable_sensitive
			object_radio.disable_sensitive
			context_radio.disable_sensitive
			class_field.disable_sensitive
			address_field.disable_sensitive
		end

	focused_widget: EV_WIDGET
			-- Widget that should be given the focus when the dialog is displayed.

invariant
	invariant_clause: True -- Your invariant here

end -- class EB_EXPRESSION_DEFINITION_DIALOG
