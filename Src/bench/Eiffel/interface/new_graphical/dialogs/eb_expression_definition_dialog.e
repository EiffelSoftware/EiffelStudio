indexing
	description: "Dialogs that allow to define a new expression in the debugger sense"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXPRESSION_DEFINITION_DIALOG

inherit
	ANY

	EB_CONSTANTS
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	EB_SHARED_DEBUG_TOOLS
		export
			{NONE} all
		end

	SHARED_DEBUGGED_OBJECT_MANAGER
		export
			{NONE} all
		end

create
	make_new_expression,
	make_with_expression_text,
	make_with_class,
	make_with_object,
	make_with_named_object,
	make_as_named_object,
	make_for_context,
	make_with_expression_on_object,
	make_with_expression

feature {NONE} -- Initialization

	make_new_expression is
		do
			make
			set_expression_mode
		end

	make_with_expression_text (t: STRING) is
			-- Initialize `Current' and set the expression string to `t'.
		require
			valid_string: t /= Void and not t.is_empty
		do
			make
			expression_field.set_text (t)
			expression_field.select_all
			set_expression_mode
		end

	make_with_class (cl: CLASS_C) is
			-- Initialize `Current' and force the creation of a class-related expression.
		require
			valid_class: cl /= Void and cl.is_valid
		do
			make
			class_radio.enable_select
			class_field.set_text (cl.name_in_upper)
			set_expression_mode
			disable_all
		end

	stick_with_current_object: BOOLEAN
			-- Do we stick to object mode ?
			-- i.e: disable other context/class mode
			-- and disable address editing

	make_with_object (oa: STRING) is
			-- Initialize `Current' and force the creation of an object-related expression.
			-- `oa' is the address of the object.
		require
			application_stopped: eb_debugger_manager.application_is_executing and then eb_debugger_manager.application_is_stopped
			valid_address: oa /= Void and then eb_debugger_manager.application.is_valid_object_address (oa)
		do
			stick_with_current_object := True
			make
			on_object_radio.enable_select
			address_field.set_text (oa)
			set_expression_mode
			disable_all_but_object_radios
		end

	make_as_named_object (oa: STRING; on: STRING) is
			-- Initialize `Current' and force the creation of an object-related expression.
			-- `oa' is the address of the object.
			-- `on' is a name for this object
		require
			application_stopped: eb_debugger_manager.application_is_executing and then eb_debugger_manager.application_is_stopped
			valid_address: oa /= Void and then eb_debugger_manager.application.is_valid_object_address (oa)
			valid_object_name: on /= Void and then not on.is_empty
		do
			stick_with_current_object := True
			make
			as_object_radio.enable_select
			address_field.set_text (oa)
			object_name_field.set_text (on)
			set_object_name_mode
			disable_all_but_object_radios
		end

	make_with_expression_on_object	(oa: STRING; a_exp: STRING) is
		require
			application_stopped: eb_debugger_manager.application_is_executing and then eb_debugger_manager.application_is_stopped
			valid_address: oa /= Void and then eb_debugger_manager.application.is_valid_object_address (oa)
			valid_expression: a_exp /= Void and then not a_exp.is_empty
		do
			make_with_object (oa)
			expression_field.set_text (a_exp)
		end

	make_with_named_object (oa: STRING; on: STRING) is
			-- Initialize `Current' and force the creation of an object-related expression.
			-- `oa' is the address of the object.
			-- `on' is a name for this object
		require
			application_stopped: eb_debugger_manager.application_is_executing and then eb_debugger_manager.application_is_stopped
			valid_address: oa /= Void and then eb_debugger_manager.application.is_valid_object_address (oa)
			valid_object_name: on /= Void and then not on.is_empty
		do
			stick_with_current_object := True
			make
			on_object_radio.enable_select
			address_field.set_text (oa)
			object_name_field.set_text (on)
			set_expression_mode
			disable_all_but_object_radios
		end

	make_for_context is
			-- Initialize `Current' and force the creation of a context-related expression.
		do
			make
			context_radio.enable_select
			set_expression_mode
			disable_all
		end

	make_with_expression (expr: EB_EXPRESSION) is
			-- Initialize `Current' based on `expr'.
		require
			valid_expression: expr /= Void
		do
			if expr.on_class then
				make_with_class (expr.context_class)
			elseif expr.as_object then
				make_as_named_object (expr.context_address, expr.name)
			elseif expr.on_object then
				make_with_object (expr.context_address)
			else
				make_for_context
			end
			if expr.expression /= Void then
				expression_field.set_text (expr.expression)
			end
			if expr.name /= Void then
				object_name_field.set_text (expr.name)
			end
			modified_expression := expr
		end

feature {NONE} -- Graphical initialization and changes

	make is
			-- Initialize `Current'.
		local
			cnt: EV_VERTICAL_BOX
			vb: EV_VERTICAL_BOX
			object_box_hb, hb: EV_HORIZONTAL_BOX
			f: EV_FRAME
			cn_l: EV_LABEL
			oa_l: EV_LABEL
			sz: INTEGER
			cb: EV_BUTTON
		do
				--| Create and set up the dialog.
			create dialog
			dialog.set_title (Interface_names.t_New_expression)
			dialog.set_icon_pixmap (pixmaps.icon_dialog_window)

				--| Create and set up the radio buttons.
			create class_radio.make_with_text (Interface_names.t_Class)
			class_radio.select_actions.extend (agent event_class_radio_selected)

			create on_object_radio.make_with_text (Interface_names.l_On_object)
			on_object_radio.select_actions.extend (agent event_on_object_radio_selected)

			create as_object_radio.make_with_text (Interface_names.l_As_object)
			as_object_radio.select_actions.extend (agent event_as_object_radio_selected)

			create context_radio.make_with_text (Interface_names.l_Current_context)
			context_radio.select_actions.extend (agent event_context_radio_selected)

				--| Create and set up the text fields.
			create class_field.make
			create expression_field.make
			create address_field
			create object_name_field



			setup_completion_possibilities_providers

			class_field.disable_sensitive
			address_field.disable_sensitive
			object_name_field.change_actions.extend (agent on_object_name_changed)
			expression_field.change_actions.extend (agent on_expression_changed)
			expression_field.focus_in_actions.extend (agent on_expression_focus)
			if
				not eb_debugger_manager.application_is_executing
				or else not eb_debugger_manager.application_is_stopped
			then
				on_object_radio.disable_sensitive
				as_object_radio.disable_sensitive
				address_field.disable_sensitive
			end

				--| Create the labels.
			create cn_l.make_with_text (Interface_names.l_Class_name)
			create oa_l.make_with_text (Interface_names.l_Address)

				--| Create and set up the buttons.
			create ok_button.make_with_text (Interface_names.b_Ok)
			ok_button.select_actions.extend (agent on_ok_pressed)
			create cb.make_with_text (Interface_names.b_Cancel)
			cb.select_actions.extend (agent destroy)
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

				--| current feature context
			create context_box
			context_box.extend (context_radio)
			vb.extend (context_box)

				--| object address context
			create object_box
			create object_box_hb
			object_box_hb.extend (on_object_radio)
			object_box_hb.extend (as_object_radio)
			object_box.extend (object_box_hb)
			create hb
			hb.extend (oa_l)
			hb.disable_item_expand (oa_l)
			hb.extend (address_field)
			object_box.extend (hb)
			vb.extend (object_box)


				--| class context
			create class_box
			class_box.extend (class_radio)
			create hb
			hb.extend (cn_l)
			hb.disable_item_expand (cn_l)
			hb.extend (class_field)
			class_box.extend (hb)
			vb.extend (class_box)

			vb.merge_radio_button_groups (context_box)
			vb.merge_radio_button_groups (object_box)
			vb.merge_radio_button_groups (object_box_hb)
			vb.merge_radio_button_groups (class_box)

				--| ...
			f.extend (vb)
			cnt.extend (f)
			cnt.disable_item_expand (f)

				--| 2 : expression_or_name_cell
			create expression_or_name_cell
			cnt.extend (expression_or_name_cell)

				--| 2,1) Expression frame.
			create expression_frame.make_with_text (Interface_names.l_Expression)
			create vb
			vb.set_border_width (Layout_constants.small_border_size)
			vb.extend (expression_field)
			expression_frame.extend (vb)

				--| 2,2) Object name frame.
			create object_name_frame.make_with_text ("Name") --Interface_names.l_Expression)
			create vb
			vb.set_border_width (Layout_constants.small_border_size)
			vb.extend (object_name_field)
			object_name_frame.extend (vb)

				--| 3) Buttons.
			create hb
			hb.set_padding (Layout_constants.default_padding_size)
			hb.extend (create {EV_CELL})
			hb.extend (ok_button)
			hb.disable_item_expand (ok_button)
			hb.extend (cb)
			hb.disable_item_expand (cb)
			hb.extend (create {EV_CELL})
			cnt.extend (hb)
			cnt.disable_item_expand (hb)

			dialog.extend (cnt)

				--| Finish setting up the dialog.
			dialog.set_minimum_width (dialog.minimum_width.max (2 * sz))
			dialog.set_width (dialog.minimum_width.max (3 * sz))
			dialog.set_default_push_button (ok_button)
			dialog.set_default_cancel_button (cb)
			dialog.show_actions.extend (agent on_shown)
			focused_widget := expression_field
		end

	set_expression_mode is
		do
			if
				expression_or_name_cell /= Void
				and then expression_frame.parent = Void
			then
				expression_or_name_cell.replace (expression_frame)
			end
		end

	set_object_name_mode is
		do
			if
				expression_or_name_cell /= Void
				and then object_name_frame.parent = Void
			then
				expression_or_name_cell.replace (object_name_frame)
			end
		end

feature -- Access

	callback: PROCEDURE [ANY, TUPLE]
			-- Callback that should be called after the dialog is closed.

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

feature {NONE} -- Event handling

	event_class_radio_selected is
			-- User selected to create an expression based on a class.
		do
			set_expression_mode
			class_field.enable_sensitive
			set_focus (class_field)
			address_field.disable_sensitive
		end

	event_on_object_radio_selected is
			-- User selected to create an expression based on a class.
		do
			set_expression_mode
			class_field.disable_sensitive
			if stick_with_current_object then
				set_focus (expression_field)
			else
				address_field.enable_sensitive
				set_focus (address_field)
			end
		end

	event_as_object_radio_selected is
			-- User selected to create an expression based on a class.
		do
			set_object_name_mode
			class_field.disable_sensitive
			if stick_with_current_object then
				set_focus (object_name_field)
			else
				address_field.enable_sensitive
				set_focus (address_field)
			end
		end

	event_context_radio_selected is
			-- User selected to create an expression based on a class.
		do
			set_expression_mode
			address_field.disable_sensitive
			class_field.disable_sensitive
			set_focus (expression_field)
		end

	on_object_name_changed is
			-- User changed the object name.
		do
			if object_name_field.text.is_empty then
				ok_button.disable_sensitive
			else
				ok_button.enable_sensitive
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

	on_expression_focus is
			-- Expression text field gets focus.
		local
			l_class_name: STRING
			l_class_c: CLASS_C
			l_list: LIST [CLASS_I]
		do
			if class_radio.is_selected then
				l_class_name := class_field.text
				l_class_name.to_upper
				l_list := eiffel_universe.classes_with_name (l_class_name)
				if l_list /= Void and then not l_list.is_empty and then l_list.first.is_compiled then
					l_class_c := l_list.first.compiled_class
					create expression_field_provider.make (l_class_c, Void, True)
					expression_field.set_completion_possibilities_provider (expression_field_provider)
					expression_field_provider.set_code_completable (expression_field)
				else
					expression_field.set_completion_possibilities_provider (Void)
				end
			else
				setup_completion_possibilities_providers
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
			do_not_close_dialog: BOOLEAN
			app_exec: APPLICATION_EXECUTION
		do
			if modified_expression = Void then
				if class_radio.is_selected then
						-- We try to create an expression related to a class.
					t := class_field.text.as_upper
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
							if new_expression.syntax_error_occurred then
								set_focus (expression_field)
								create wd.make_with_text (Warning_messages.w_Syntax_error_in_expression (expression_field.text))
								wd.show_modal_to_window (dialog)
							end
						else
							set_focus (class_field)
							create wd.make_with_text (Warning_messages.w_Not_a_compiled_class (t))
							wd.show_modal_to_window (dialog)
						end
					else
						set_focus (class_field)
						create wd.make_with_text (Warning_messages.w_Cannot_find_class (t))
						wd.show_modal_to_window (dialog)
					end
				elseif on_object_radio.is_selected or as_object_radio.is_selected then
						-- We try to create an expression related to a class.
					t := address_field.text.as_upper
					if
						t.item (1).is_equal ('0')
						and then t.item (2).is_equal ('X')
						and t.count > 2
					then
						t := t.substring (3, t.count)
					end
					t.prepend ("0x")
					app_exec := eb_debugger_manager.application
					if
						app_exec.is_running and then app_exec.is_stopped
						and then app_exec.is_valid_object_address (t)
					then
						o := debugged_object_manager.debugged_object (t, 0, 0)
						if as_object_radio.is_selected then
							create new_expression.make_as_object (o.dtype , o.object_address)
							new_expression.set_name (object_name_field.text)
						else
							create new_expression.make_with_object (o, expression_field.text)
						end
						if new_expression.syntax_error_occurred then
							set_focus (expression_field)
							create wd.make_with_text (Warning_messages.w_Syntax_error_in_expression (expression_field.text))
							wd.show_modal_to_window (dialog)
						else
							app_exec.status.keep_object (t)
						end
					else
						set_focus (address_field)
						create wd.make_with_text (Warning_messages.w_Invalid_address (t))
						wd.show_modal_to_window (dialog)
					end
				else
					create new_expression.make_for_context (expression_field.text)
					if new_expression.syntax_error_occurred then
						set_focus (expression_field)
						create wd.make_with_text (Warning_messages.w_Syntax_error_in_expression (expression_field.text))
						wd.show_modal_to_window (dialog)
					end
				end
			else
				if as_object_radio.is_selected and modified_expression.on_object then
						--| only the name may change
					modified_expression.set_name (object_name_field.text)
					modified_expression.enable_as_object
				else
					if on_object_radio.is_selected and modified_expression.as_object then
							--| In case, we decide to evaluate on the object
							--| instead of pointing the object
						modified_expression.disable_as_object
					end
					oe := modified_expression.expression
					modified_expression.set_expression (expression_field.text)
					if modified_expression.syntax_error_occurred then
							-- Restore the previous expression, since the new one is broken.
						modified_expression.set_expression (oe)
						set_focus (expression_field)
						create wd.make_with_text (Warning_messages.w_Syntax_error_in_expression (expression_field.text))
						wd.show_modal_to_window (dialog)
						do_not_close_dialog := True
					end
				end
				new_expression := modified_expression
			end
			if
				not do_not_close_dialog
				and then new_expression /= Void
				and then not new_expression.syntax_error_occurred
			then
				destroy
				if callback /= Void then
					callback.call (Void)
				end
			end
		end

	on_shown is
			-- The dialog has just been displayed.
		do
			set_focus (focused_widget)
		end

feature {NONE} -- Code completion.

	expression_field_provider : EB_NORMAL_COMPLETION_POSSIBILITIES_PROVIDER

	class_provider: EB_NORMAL_COMPLETION_POSSIBILITIES_PROVIDER

	setup_completion_possibilities_providers is
			-- Setup code completion possiblilities providers.
		require
			expression_field_attached: expression_field /= Void
			class_field_attached: class_field /= Void
		do
			create expression_field_provider.make (Void, Void, false)
			expression_field_provider.set_code_completable (expression_field)
			expression_field.set_completion_possibilities_provider (expression_field_provider)

			if class_provider = Void then
				create class_provider.make (Void, Void, false)
				class_field.set_completing_feature (false)
				class_field.set_completion_possibilities_provider (class_provider)
				class_provider.set_code_completable (class_field)
			end
		end

feature {NONE} -- Widgets

	expression_field: EB_CODE_COMPLETABLE_TEXT_FIELD
			-- Text field that contains the expression.

	class_field: EB_CODE_COMPLETABLE_TEXT_FIELD
			-- Text field that contains the context class name.

	address_field: EV_TEXT_FIELD
			-- Text field that contains the context object address.

	expression_or_name_cell: EV_CELL
			-- Cell containing either `expression_frame' or `object_name_frame'.

	expression_frame, object_name_frame: EV_FRAME
			-- Container for expression or object name zones.

	context_box, object_box, class_box: EV_VERTICAL_BOX
			-- Container for current feature/object address/class zones.

	class_radio: EV_RADIO_BUTTON
			-- Radio button that is selected when we are creating an expression based on a class.

	on_object_radio: EV_RADIO_BUTTON
			-- Radio button that is selected when we are creating an expression based on an object.

	as_object_radio: EV_RADIO_BUTTON
			-- Radio button that is selected when we are creating an item as the object.

	object_name_field: EV_TEXT_FIELD

	context_radio: EV_RADIO_BUTTON
			-- Radio button that is selected when we are creating an expression based on the current context.

	dialog: EV_DIALOG
			-- Real dialog object.

	ok_button: EV_BUTTON
			-- "OK" button.

feature {NONE} -- Implementation

	set_focus (w: EV_WIDGET) is
		require
			w /= Void
		do
			if w.is_displayed then
				w.set_focus
			end
		end


	modified_expression: EB_EXPRESSION
			-- Expression that is being edited, if any.

	disable_all is
			-- Disable the sensitivity of all context widgets
		do
			disable_all_but_object_radios
			on_object_radio.disable_sensitive
			as_object_radio.disable_sensitive
		end

	disable_all_but_object_radios is
			-- Disable the sensitivity of all context widgets
			-- but as_object and on_object radio
		do
			class_radio.disable_sensitive
			context_radio.disable_sensitive
			class_field.disable_sensitive
			address_field.disable_sensitive
		end

	focused_widget: EV_WIDGET
			-- Widget that should be given the focus when the dialog is displayed.

invariant
	invariant_clause: True -- Your invariant here

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

end -- class EB_EXPRESSION_DEFINITION_DIALOG
