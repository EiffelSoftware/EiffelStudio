indexing
	description: "Constants definition of Resource Bench"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_IDS

feature -- Access 

		-- Menus
	Idr_menu: INTEGER is 101
	Cmd_file_new: INTEGER is 40010
	Cmd_file_open: INTEGER is 40001
	cmd_file_close: INTEGER is 40002
	Cmd_file_save_project: INTEGER is 40009
	Cmd_file_exit: INTEGER is 40003

	Cmd_build_wel_code: INTEGER is 40004
	Cmd_build_resource_file: INTEGER is 40011 

	Cmd_edit_cut: INTEGER is 40012
	Cmd_edit_copy: INTEGER is 40013
	Cmd_edit_paste: INTEGEr is 40014

	Cmd_help_content: INTEGER is 40006
	Cmd_help_about_rb: INTEGER is 40007


		-- Dialogs
	Idd_dialog_message: INTEGER is 200
	Idd_dialog_error: INTEGER is 201
	Idd_dialog_about: INTEGER is 202
	Idc_info: INTEGER is 1000
	Idc_static: INTEGER is -1

	Idd_dialog_browse: INTEGER is 203
	Idc_edit_path: INTEGER is 1000

	Idd_dialog_properties_constant: INTEGER is 204
	Idc_class_name_constant: INTEGER is 1000
	Idc_check_code_generation_constant: INTEGER is 1001
	Idc_control_list_constant: INTEGER is 1002
	Idc_dialog_caption_constant: INTEGER is 1018
	Idc_modal_constant: INTEGER is 1015
	Idc_modeless_constant: INTEGER is 1016
	Idc_main_dialog_constant: INTEGER is 1017
	Idc_setup_dialog_constant: INTEGER is 1006
	Idc_notify_constant: INTEGER is 1007
	Idc_on_ok_constant: INTEGER is 1008
	Idc_on_cancel_constant: INTEGER is 1009
	Idc_on_abort_constant: INTEGER is 1010
	Idc_on_ignore_constant: INTEGER is 1011
	Idc_on_retry_constant: INTEGER is 1012
	Idc_on_yes_constant: INTEGER is 1013
	Idc_on_no_constant: INTEGER is 1014

		-- Icons
	Rb_icon: INTEGER is 1


		-- Accelerators
	Idr_accelerator: INTEGER is 101


		-- Toolbar
	Idr_toolbar: INTEGER is 103


end -- class APPLICATION_IDS
