indexing 
	description: "Dialog properties window of Resource Bench"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class 
	DIALOG_PROPERTIES

inherit

	EV_HORIZONTAL_BOX

creation
	make

feature -- Initialization

	make (a_dialog: TDS_DIALOG; w_window: WIZARD_STATE_WINDOW) is
			-- Create the dialog.
		require
--			a_dialog_not_void: a_dialog /= Void
		local
			v1, v2, v3, v4, v5: EV_VERTICAL_BOX
			h1, h3: EV_HORIZONTAL_BOX
			fr1, fr2: EV_FRAME
			cell: EV_CELL
		do
			default_create

			create check_code_generation.make_with_text ("Generate code")
			check_code_generation.select_actions.extend (~on_select_check_code)

			create dialog_class_name.make ("Class name", "", 10, 10, w_window, False)

			create control_selection_list
			control_selection_list.enable_multiple_selection

			create idc_dialog_caption.make_with_text ("Select the controls you want to generate:")

			create idc_setup_dialog.make_with_text ("setup_dialog")
			create idc_notify.make_with_text ("notify")
			create idc_on_ok.make_with_text ("on_ok")
			create idc_on_cancel.make_with_text ("on_cancel")
			create idc_on_abort.make_with_text ("on_abord")
			create idc_on_ignore.make_with_text ("on_ignore")
			create idc_on_retry.make_with_text ("on_retry")
			create idc_on_yes.make_with_text ("on_yes")
			create idc_on_no.make_with_text ("on_no")

			create inherit_combo
			create idc_modal.make_with_text ("WEL_MODAL_DIALOG")
			create idc_modeless.make_with_text ("WEL_MODELESS_DIALOG")
			create idc_main_dialog.make_with_text ("WEL_MAIN_DIALOG")
			inherit_combo.extend (idc_modal)
			inherit_combo.extend (idc_modeless)
			inherit_combo.extend (idc_main_dialog)

			create fr1.make_with_text ("Inherit from")
			create fr2.make_with_text ("Redefined features")

			
			create cell
			cell.set_minimum_height (3)

			create v1
--			v1.extend (check_code_generation)
--			v1.disable_item_expand (check_code_generation)
			create h3
			v1.extend (h3)
			v1.disable_item_expand (h3)

			create v5
			v5.extend (check_code_generation)
			v5.disable_item_expand (check_code_generation)

			v5.extend (dialog_class_name)
			v5.disable_item_expand (dialog_class_name)

			v5.extend (fr1)
			v5.disable_item_expand (fr1)
			h3.extend (v5)
			h3.disable_item_expand (v5)


			create v2
--			v2.extend (idc_modal)
--			v2.disable_item_expand (idc_modal)
--			v2.extend (idc_modeless)
--			v2.disable_item_expand (idc_modeless)
--			v2.extend (idc_main_dialog)
--			v2.disable_item_expand (idc_main_dialog)
			v2.extend (inherit_combo)
			fr1.extend (v2)

			create v4
			v5.extend (idc_dialog_caption)
			v5.disable_item_expand (idc_dialog_caption)
			v5.extend (control_selection_list)
--			v5.extend (v4)

			create v2
			v2.extend (idc_notify)
			v2.disable_item_expand (idc_notify)
			v2.extend (idc_on_ok)
			v2.disable_item_expand (idc_on_ok)
			v2.extend (idc_on_cancel)
			v2.disable_item_expand (idc_on_cancel)
			v2.extend (idc_on_abort)
			v2.disable_item_expand (idc_on_abort)
			v2.extend (idc_on_ignore)
			v2.disable_item_expand (idc_on_ignore)
			v2.extend (idc_on_retry)
			v2.disable_item_expand (idc_on_retry)
			v2.extend (idc_on_yes)
			v2.disable_item_expand (idc_on_yes)
			v2.extend (idc_on_no)
			v2.disable_item_expand (idc_on_no)
			fr2.extend (v2)
			h3.extend (fr2)
			h3.disable_item_expand (fr2)

			extend (create {EV_VERTICAL_SEPARATOR})
			extend (v1)
			disable_item_expand (v1)
			current_dialog := a_dialog

		ensure
			current_dialog_set: current_dialog = a_dialog
		end

	default_process_message (msg, wparam, lparam: INTEGER) is
		local
			tt1: WEL_TOOLTIP_TEXT 
		do
--			if msg = Wm_notify then
--				!! tt1.make_by_pointer (cwel_integer_to_pointer (lparam))
--				if tt1.hdr.code = Ttn_needtext then
--						-- Set resource string id.
--					tt1.set_text_id (tt1.hdr.id_from)
--					message_beep_ok
--				end
--			end
		end

	setup_dialog is
		do
			get_dialog_properties
		end

	on_select_check_code is
		do
			if check_code_generation.is_selected  then
				enable_all_controls
			else
				disable_all_controls
			end
		end

	notify (control: WEL_CONTROL; notify_code: INTEGER) is
		do
--			if control = check_code_generation then
--				if check_code_generation.is_selected  then
--					enable_all_controls
--				else
--					disable_all_controls
--				end
--			end
		end

	set_current_dialog (d: TDS_DIALOG) is
		do
			current_dialog:= d
		end

feature -- Access

	current_dialog: TDS_DIALOG



	check_code_generation: EV_CHECK_BUTTON
	dialog_class_name: WIZARD_SMART_TEXT_FIELD
	control_selection_list: EV_LIST

	idc_dialog_caption: EV_LABEL

	idc_setup_dialog: EV_CHECK_BUTTON
	idc_notify: EV_CHECK_BUTTON
	idc_on_ok: EV_CHECK_BUTTON
	idc_on_cancel: EV_CHECK_BUTTON
	idc_on_abort: EV_CHECK_BUTTON
	idc_on_ignore: EV_CHECK_BUTTON
	idc_on_retry: EV_CHECK_BUTTON
	idc_on_yes: EV_CHECK_BUTTON
	idc_on_no: EV_CHECK_BUTTON

	inherit_combo: EV_COMBO_BOX
	idc_modal: EV_LIST_ITEM -- EV_RADIO_BUTTON
	idc_modeless: EV_LIST_ITEM -- EV_RADIO_BUTTON
	idc_main_dialog: EV_LIST_ITEM -- EV_RADIO_BUTTON


feature -- Element change

	set_dialog_properties (a_dialog: TDS_DIALOG) is
		local
			selected_list: DYNAMIC_LIST [EV_LIST_ITEM]
			control_list: TDS_CONTROL_STATEMENT
			i: INTEGER
		do
			a_dialog.set_class_name (dialog_class_name.text)
			
			if check_code_generation.is_selected then
				a_dialog.set_wel_code (true)
			else
				a_dialog.set_wel_code (false)
			end
			
			if idc_modal.is_selected  then
				a_dialog.set_inherited_class ("WEL_MODAL_DIALOG")
			end

			if idc_modeless.is_selected  then
				a_dialog.set_inherited_class ("WEL_MODELESS_DIALOG")
			end

			if idc_main_dialog.is_selected  then
				a_dialog.set_inherited_class ("WEL_MAIN_DIALOG")
			end

			if idc_setup_dialog.is_selected  then
				a_dialog.add_feature ("setup_dialog")
			else
				a_dialog.remove_feature ("setup_dialog")
			end

			if idc_notify.is_selected  then
				a_dialog.add_feature ("notify")
			else
				a_dialog.remove_feature ("notify")
			end

			if idc_on_ok.is_selected  then
				a_dialog.add_feature ("on_ok")
			else
				a_dialog.remove_feature ("on_ok")
			end

			if idc_on_cancel.is_selected  then
				a_dialog.add_feature ("on_cancel")
			else
				a_dialog.remove_feature ("on_cancel")
			end

			if idc_on_abort.is_selected  then
				a_dialog.add_feature ("on_abort")
			else
				a_dialog.remove_feature ("on_abort")
			end

			if idc_on_ignore.is_selected  then
				a_dialog.add_feature ("on_ignore")
			else
				a_dialog.remove_feature ("on_ignore")
			end

			if idc_on_retry.is_selected  then
				a_dialog.add_feature ("on_retry")
			else
				a_dialog.remove_feature ("on_retry")
			end

			if idc_on_yes.is_selected  then
				a_dialog.add_feature ("on_yes")
			else
				a_dialog.remove_feature ("on_yes")
			end

			if idc_on_no.is_selected  then
				a_dialog.add_feature ("on_no")
			else
				a_dialog.remove_feature ("on_no")
			end

			if a_dialog.statement_list /= Void then
				from
					a_dialog.statement_list.start
					i := 1
					selected_list := control_selection_list.selected_items
				until 
					a_dialog.statement_list.off
				loop
					control_list := a_dialog.statement_list.item_for_iteration

					from
						control_list.start
					until
						control_list.after
					loop
						if check_list_entry (selected_list, i) then
							control_list.item.set_wel_code (true)
						else
							control_list.item.set_wel_code (false)
						end

						control_list.forth
						i := i + 1
	      			end
				a_dialog.statement_list.forth
				end
			end
		end

	get_dialog_properties is
		local
			control_name: STRING
			control_list: TDS_CONTROL_STATEMENT
			control: TDS_CONTROL_STATEMENT
			index_2: INTEGER
			feature_name: STRING
			list_item: EV_LIST_ITEM
		do
			dialog_class_name.set_text (current_dialog.class_name)

			clear_all

			if current_dialog.options.caption /= Void then
				idc_dialog_caption.set_text (current_dialog.options.caption)
			end
			
			if current_dialog.is_wel_code_on then
				check_code_generation.enable_select
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
						idc_setup_dialog.enable_select			
					end

					if feature_name.is_equal ("notify") then
						idc_notify.enable_select
					end

					if feature_name.is_equal ("on_ok") then
						idc_on_ok.enable_select
					end

					if feature_name.is_equal ("on_cancel") then
						idc_on_cancel.enable_select
					end

					if feature_name.is_equal ("on_abort") then
						idc_on_abort.enable_select
					end

					if feature_name.is_equal ("on_ignore") then
						idc_on_ignore.enable_select
					end

					if feature_name.is_equal ("on_retry") then
						idc_on_retry.enable_select
					end

					if feature_name.is_equal ("on_yes") then
						idc_on_yes.enable_select
					end

					if feature_name.is_equal ("on_no") then
						idc_on_no.enable_select
					end

					current_dialog.redefined_features.forth
				end
			end

			if current_dialog.inherited_class.is_equal ("WEL_MODAL_DIALOG") then
				idc_modal.enable_select
			elseif current_dialog.inherited_class.is_equal ("WEL_MODELESS_DIALOG") then
				idc_modeless.enable_select
			else
				idc_main_dialog.enable_select
			end
                        			
			if current_dialog.statement_list /= Void then
				create control_name.make (20)

				from
					current_dialog.statement_list.start
					index_2 := 1
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

						control_name := clone (control.variable_name)
						control_name.append ("_" + control.id.number_id.out)
						control_name.append (" (")
						control_name.append (control.wel_class_name)
						control_name.append (")")

						create list_item.make_with_text (control_name)
						list_item.set_data (index_2.out)
						control_selection_list.extend (list_item)

--						control_selection_list.add_string (control_name)

						if control.is_wel_code_on then
							control_selection_list.i_th (index_2).enable_select
						end

						control_list.forth
						index_2 := index_2 + 1
					end

					current_dialog.statement_list.forth
				end
			end
		end

feature {NONE} -- Implementation

	check_list_entry (list: DYNAMIC_LIST [EV_LIST_ITEM]; i: INTEGER): BOOLEAN is
		local
			f_end: BOOLEAN
			s_data: STRING
		do
			from 
				list.start
				f_end := False
			until
				list.after or f_end = True
			loop
				s_data ?= list.item.data
				if s_data.is_equal (i.out) then
					f_end:= True
				end
				list.forth
			end
			Result:= f_end
		end


	enable_all_controls is
		do
			control_selection_list.enable_sensitive
			dialog_class_name.enable_sensitive
			inherit_combo.enable_sensitive
--			idc_modal.enable_sensitive
--			idc_modeless.enable_sensitive
--			idc_main_dialog.enable_sensitive
			idc_setup_dialog.enable_sensitive
			idc_notify.enable_sensitive
			idc_on_ok.enable_sensitive
			idc_on_cancel.enable_sensitive
			idc_on_abort.enable_sensitive
			idc_on_ignore.enable_sensitive
			idc_on_retry.enable_sensitive
			idc_on_yes.enable_sensitive
			idc_on_no.enable_sensitive
		end

	disable_all_controls is
		do
			control_selection_list.disable_sensitive
			dialog_class_name.disable_sensitive
			inherit_combo.disable_sensitive			
--			idc_modal.disable_sensitive
--			idc_modeless.disable_sensitive
--			idc_main_dialog.disable_sensitive
			idc_setup_dialog.disable_sensitive
			idc_notify.disable_sensitive
			idc_on_ok.disable_sensitive
			idc_on_cancel.disable_sensitive
			idc_on_abort.disable_sensitive
			idc_on_ignore.disable_sensitive
			idc_on_retry.disable_sensitive
			idc_on_yes.disable_sensitive
			idc_on_no.disable_sensitive
		end

	clear_all is
		do
			check_code_generation.disable_select
			control_selection_list.wipe_out
			idc_setup_dialog.disable_select
			idc_notify.disable_select
			idc_on_ok.disable_select
			idc_on_cancel.disable_select
			idc_on_abort.disable_select
			idc_on_ignore.disable_select
			idc_on_retry.disable_select
			idc_on_yes.disable_select
			idc_on_no.disable_select
			control_selection_list.wipe_out


--			dialog_class_name.disable_select
--			idc_dialog_caption: EV_LABEL

--			idc_modal: EV_RADIO_BUTTON
--			idc_modeless: EV_RADIO_BUTTON
--			idc_main_dialog: EV_RADIO_BUTTON

		end

end -- class IDD_DIALOG_PROPERTIES

--|-------------------------------------------------------------------
--| This class was automatically generated by Resource Bench
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------
