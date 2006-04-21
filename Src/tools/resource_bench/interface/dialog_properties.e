indexing
	description: "Dialog properties window of Resource Bench"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	DIALOG_PROPERTIES

inherit
	WEL_MODELESS_DIALOG
		redefine
			default_process_message,
			setup_dialog,
			notify
		end

	WEL_LB_CONSTANTS
		export
			{NONE} all
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_TTN_CONSTANTS
		export
			{NONE} all
		end

	WEL_WINDOWS_ROUTINES

creation
	make

feature -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW; a_dialog: TDS_DIALOG) is
			-- Create the dialog.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
			a_dialog_not_void: a_dialog /= Void
		do
			make_by_id (a_parent, Idd_dialog_properties_constant)
			!! check_code_generation.make_by_id (Current, Idc_check_code_generation_constant)
			!! dialog_class_name.make_by_id (Current, Idc_class_name_constant)
			!! control_selection_list.make_by_id (Current, Idc_control_list_constant)

			!! idc_dialog_caption.make_by_id (Current, Idc_dialog_caption_constant)

			!! idc_setup_dialog.make_by_id (Current, Idc_setup_dialog_constant)
			!! idc_notify.make_by_id (Current, Idc_notify_constant)
			!! idc_on_ok.make_by_id (Current, Idc_on_ok_constant)
			!! idc_on_cancel.make_by_id (Current, Idc_on_cancel_constant)
			!! idc_on_abort.make_by_id (Current, Idc_on_abort_constant)
			!! idc_on_ignore.make_by_id (Current, Idc_on_ignore_constant)
			!! idc_on_retry.make_by_id (Current, Idc_on_retry_constant)
			!! idc_on_yes.make_by_id (Current, Idc_on_yes_constant)
			!! idc_on_no.make_by_id (Current, Idc_on_no_constant)

			!! idc_modal.make_by_id (Current, Idc_modal_constant)
			!! idc_modeless.make_by_id (Current, Idc_modeless_constant)
			!! idc_main_dialog.make_by_id (Current, Idc_main_dialog_constant)

			current_dialog := a_dialog
		ensure
			current_dialog_set: current_dialog = a_dialog
		end

	default_process_message (msg: INTEGER; wparam, lparam: POINTER) is
		local
			tt1: WEL_TOOLTIP_TEXT
		do
			if msg = Wm_notify then
				!! tt1.make_by_pointer (lparam)
				if tt1.hdr.code = Ttn_needtext then
						-- Set resource string id.
					tt1.set_text_id (tt1.hdr.id_from)
					message_beep_ok
				end
			end
		end

	setup_dialog is
		do
			get_dialog_properties
		end

	notify (control: WEL_CONTROL; notify_code: INTEGER) is
		do
			if control = check_code_generation then
				if check_code_generation.checked then
					enable_all_controls
				else
					disable_all_controls
				end
			end
		end

feature -- Access

	current_dialog: TDS_DIALOG

	check_code_generation: WEL_CHECK_BOX
	dialog_class_name: WEL_SINGLE_LINE_EDIT
	control_selection_list: WEL_MULTIPLE_SELECTION_LIST_BOX

	idc_dialog_caption:WEL_STATIC

	idc_setup_dialog: WEL_CHECK_BOX
	idc_notify: WEL_CHECK_BOX
	idc_on_ok: WEL_CHECK_BOX
	idc_on_cancel: WEL_CHECK_BOX
	idc_on_abort: WEL_CHECK_BOX
	idc_on_ignore: WEL_CHECK_BOX
	idc_on_retry: WEL_CHECK_BOX
	idc_on_yes: WEL_CHECK_BOX
	idc_on_no: WEL_CHECK_BOX
	idc_modal: WEL_RADIO_BUTTON
	idc_modeless: WEL_RADIO_BUTTON
	idc_main_dialog: WEL_RADIO_BUTTON


feature -- Element change

	set_dialog_properties (a_dialog: TDS_DIALOG) is
		local
			selected_list: ARRAY [INTEGER]
			control_list: TDS_CONTROL_STATEMENT
			index: INTEGER
		do
			current_dialog.set_class_name (dialog_class_name.text)

			if check_code_generation.checked then
				current_dialog.set_wel_code (true)
			else
				current_dialog.set_wel_code (false)
			end

			if idc_modal.checked then
				current_dialog.set_inherited_class ("WEL_MODAL_DIALOG")
			end

			if idc_modeless.checked then
				current_dialog.set_inherited_class ("WEL_MODELESS_DIALOG")
			end

			if idc_main_dialog.checked then
				current_dialog.set_inherited_class ("WEL_MAIN_DIALOG")
			end

			if idc_setup_dialog.checked then
				current_dialog.add_feature ("setup_dialog")
			else
				current_dialog.remove_feature ("setup_dialog")
			end

			if idc_notify.checked then
				current_dialog.add_feature ("notify")
			else
				current_dialog.remove_feature ("notify")
			end

			if idc_on_ok.checked then
				current_dialog.add_feature ("on_ok")
			else
				current_dialog.remove_feature ("on_ok")
			end

			if idc_on_cancel.checked then
				current_dialog.add_feature ("on_cancel")
			else
				current_dialog.remove_feature ("on_cancel")
			end

			if idc_on_abort.checked then
				current_dialog.add_feature ("on_abort")
			else
				current_dialog.remove_feature ("on_abort")
			end

			if idc_on_ignore.checked then
				current_dialog.add_feature ("on_ignore")
			else
				current_dialog.remove_feature ("on_ignore")
			end

			if idc_on_retry.checked then
				current_dialog.add_feature ("on_retry")
			else
				current_dialog.remove_feature ("on_retry")
			end

			if idc_on_yes.checked then
				current_dialog.add_feature ("on_yes")
			else
				current_dialog.remove_feature ("on_yes")
			end

			if idc_on_no.checked then
				current_dialog.add_feature ("on_no")
			else
				current_dialog.remove_feature ("on_no")
			end

			if current_dialog.statement_list /= Void then
				from
					current_dialog.statement_list.start
					index := 0
					selected_list := control_selection_list.selected_items
				until
					current_dialog.statement_list.off
				loop
					control_list := current_dialog.statement_list.item_for_iteration

					from
						control_list.start
					until
						control_list.after
					loop
						if selected_list.has (index) then
							control_list.item.set_wel_code (true)
						else
							control_list.item.set_wel_code (false)
						end

						control_list.forth
						index := index + 1
        				end
					current_dialog.statement_list.forth
				end
			end
		end

	get_dialog_properties is
		local
			control_name: STRING
			control_list: TDS_CONTROL_STATEMENT
			control: TDS_CONTROL_STATEMENT
			index: INTEGER
			feature_name: STRING
		do
			dialog_class_name.set_text (current_dialog.class_name)

			if current_dialog.options.caption /= Void then
				idc_dialog_caption.set_text (current_dialog.options.caption)
			end

			if current_dialog.is_wel_code_on then
				check_code_generation.set_checked
				enable_all_controls
			else
				disable_all_controls
			end

			if current_dialog.redefined_features /= Void then
				from
					current_dialog.redefined_features.start
				until
					current_dialog.redefined_features.after
				loop
					feature_name := current_dialog.redefined_features.item

					if feature_name.is_equal ("setup_dialog") then
						idc_setup_dialog.set_checked
					end

					if feature_name.is_equal ("notify") then
						idc_notify.set_checked
					end

					if feature_name.is_equal ("on_ok") then
						idc_on_ok.set_checked
					end

					if feature_name.is_equal ("on_cancel") then
						idc_on_cancel.set_checked
					end

					if feature_name.is_equal ("on_abort") then
						idc_on_abort.set_checked
					end

					if feature_name.is_equal ("on_ignore") then
						idc_on_ignore.set_checked
					end

					if feature_name.is_equal ("on_retry") then
						idc_on_retry.set_checked
					end

					if feature_name.is_equal ("on_yes") then
						idc_on_yes.set_checked
					end

					if feature_name.is_equal ("on_no") then
						idc_on_no.set_checked
					end

					current_dialog.redefined_features.forth
				end
			end

			if current_dialog.inherited_class.is_equal ("WEL_MODAL_DIALOG") then
				idc_modal.set_checked
			elseif current_dialog.inherited_class.is_equal ("WEL_MODELESS_DIALOG") then
				idc_modeless.set_checked
			else
				idc_main_dialog.set_checked
			end

			if current_dialog.statement_list /= Void then
				!! control_name.make (20)

				from
					current_dialog.statement_list.start
					index := 0
				until
					current_dialog.statement_list.off
				loop
					control_list := current_dialog.statement_list.item_for_iteration

					from
						control_list.start
					until
						control_list.after
					loop
						control := control_list.item

						control_name := control.variable_name.twin
						control_name.append (" (")
						control_name.append (control.wel_class_name)
						control_name.append (")")

						control_selection_list.add_string (control_name)

						if control.is_wel_code_on then
							control_selection_list.select_item (index)
						end

						control_list.forth
						index := index + 1
					end

					current_dialog.statement_list.forth
				end
			end
		end

feature {NONE} -- Implementation

	enable_all_controls is
		do
			control_selection_list.enable
			dialog_class_name.enable
			idc_modal.enable
			idc_modeless.enable
			idc_main_dialog.enable
			idc_setup_dialog.enable
			idc_notify.enable
			idc_on_ok.enable
			idc_on_cancel.enable
			idc_on_abort.enable
			idc_on_ignore.enable
			idc_on_retry.enable
			idc_on_yes.enable
			idc_on_no.enable
		end

	disable_all_controls is
		do
			control_selection_list.disable
			dialog_class_name.disable
			idc_modal.disable
			idc_modeless.disable
			idc_main_dialog.disable
			idc_setup_dialog.disable
			idc_notify.disable
			idc_on_ok.disable
			idc_on_cancel.disable
			idc_on_abort.disable
			idc_on_ignore.disable
			idc_on_retry.disable
			idc_on_yes.disable
			idc_on_no.disable
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
end -- class IDD_DIALOG_PROPERTIES

