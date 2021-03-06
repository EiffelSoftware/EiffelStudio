note
	description: "Registration code generator for out-of-process server."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_OUTPROC_EIFFEL_REGISTRATION_GENERATOR

inherit
	WIZARD_REGISTRATION_GENERATOR

	WIZARD_VARIABLE_NAME_MAPPER

feature -- Access

	eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS

feature -- Basic operations

	generate
			-- Generate Eiffel registration code for out-of-process server.
		do
			create eiffel_writer.make

			eiffel_writer.set_class_name (registration_class_name)
			eiffel_writer.set_description (description_message)
			set_default_ancestors (eiffel_writer)

			add_creation

			eiffel_writer.add_feature (make_feature, Initialization)
			eiffel_writer.add_feature (main_window_feature, Access)
			eiffel_writer.add_feature (default_show_command_feature, Access)

			eiffel_writer.add_feature (default_show_cmd_feature, Implementation)
			eiffel_writer.add_feature (initialize_com_feature, Implementation)
			eiffel_writer.add_feature (cleanup_com_feature, Implementation)
			eiffel_writer.add_feature (register_server_feature, Implementation)
			eiffel_writer.add_feature (unregister_server_feature, Implementation)

			eiffel_writer.add_feature (ccom_initialize_com_feature, Externals)
			eiffel_writer.add_feature (ccom_cleanup_com_feature, Externals)
			eiffel_writer.add_feature (ccom_register_server_feature, Externals)
			eiffel_writer.add_feature (ccom_unregister_server_feature, Externals)

			-- Generate code and file name.
			Shared_file_name_factory.create_registration_file_name (Current, eiffel_writer)
			eiffel_writer.save_file (Shared_file_name_factory.last_created_file_name)

		end

	create_file_name (a_factory: WIZARD_FILE_NAME_FACTORY)
		do
			a_factory.process_coclass_eiffel_server
		end

feature {NONE} -- Implementation

	description_message: STRING = 
		"Objects of this class set the registry keys necessary for COM to access the component%%%N%T%T%T%T  %
		% %%and activate a new instance of the component whenever COM asks for if.%%%N%T%T%T%T  %
		% %%User may inherit from this class and redifine `main_window'."

	default_show_cmd: STRING = "default_show_cmd"
			-- Used for code generation.

	Sw_shownormal: STRING = "Sw_shownormal"
			-- Used for code generation.

	Sw_hide: STRING = "Sw_hide"
			-- Used for code generation.

	Local_string_var: STRING = "local_string"
			-- Used for code generation.

	Initialize_com: STRING = "initialize_com"
			-- Used for code generation.

	Cleanup_com: STRING = "cleanup_com"
			-- Used for code generation.

	Register_server: STRING = "register_server"
			-- Used for code generation.

	Unregister_server: STRING = "unregister_server"
			-- Used for code generation.

	set_default_ancestors (an_eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS)
			-- Set default ancestors.
		local
			tmp_writer: WIZARD_WRITER_INHERIT_CLAUSE
			feature_list: ARRAYED_LIST [STRING]
		do
			create tmp_writer.make
			tmp_writer.set_name ("ARGUMENTS")
			an_eiffel_writer.add_inherit_clause (tmp_writer)

			create tmp_writer.make
			tmp_writer.set_name ("WEL_APPLICATION")
			tmp_writer.add_rename (Make_word, "wel_make")
			tmp_writer.add_redefine ("default_show_command")
			an_eiffel_writer.add_inherit_clause (tmp_writer)

			create tmp_writer.make
			tmp_writer.set_name ("WEL_SW_CONSTANTS")
			create feature_list.make (20)
			feature_list.force (All_keyword.twin)
			tmp_writer.add_export (feature_list, None_keyword)
			an_eiffel_writer.add_inherit_clause (tmp_writer)
		end

	add_creation
			-- Add creation procedures.
		do
			eiffel_writer.add_creation_routine (Make_word)
		end

	make_feature: WIZARD_WRITER_FEATURE
			-- `make' feature
		local
			tmp_body: STRING
			local_var_string: STRING
		do
			create Result.make
			Result.set_name (make_word)
			Result.set_effective
			Result.set_comment ("Initialize server.")

			create local_var_string.make (100)
			local_var_string.append (local_string_var)
			local_var_string.append (Colon)
			local_var_string.append (Space)
			local_var_string.append (String_type)
			Result.add_local_variable (local_var_string)

			create tmp_body.make (1000)
			tmp_body.append (Tab_tab_tab)
			-- default_show_cmd := Sw_shownormal

			tmp_body.append (default_show_cmd)
			tmp_body.append (Space)
			tmp_body.append (Assignment)
			tmp_body.append (Space)
			tmp_body.append (Sw_shownormal)
			tmp_body.append (New_line_tab_tab_tab)

			-- if argument_count > 0 then

			tmp_body.append (If_keyword)
			tmp_body.append (Space)
			tmp_body.append ("argument_count")
			tmp_body.append (Space)
			tmp_body.append (More)
			tmp_body.append (Space)
			tmp_body.append (Zero)
			tmp_body.append (Space)
			tmp_body.append (Then_keyword)
			tmp_body.append (New_line_tab_tab_tab)
			tmp_body.append (Tab)

			-- 	local_string := argument (1)

			tmp_body.append (Local_string_var)
			tmp_body.append (Space)
			tmp_body.append (Assignment)
			tmp_body.append ("argument")
			tmp_body.append (Space)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (One)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (New_line_tab_tab_tab)
			tmp_body.append (Tab)

			-- 	local_string.to_lower

			tmp_body.append (Local_string_var)
			tmp_body.append (Dot)
			tmp_body.append ("to_lower")
			tmp_body.append (New_line_tab_tab_tab)

			-- end

			tmp_body.append (End_keyword)
			tmp_body.append (New_line_tab_tab_tab)

			-- if local_string /= Void and (local_string.is_equal ("-regserver") or local_string.is_equal ("/regserver")) then

			tmp_body.append (If_keyword)
			tmp_body.append (Space)
			tmp_body.append (Local_string_var)
			tmp_body.append (Space)
			tmp_body.append (Eiffel_not_equal)
			tmp_body.append (Space)
			tmp_body.append (Void_type)
			tmp_body.append (Space)
			tmp_body.append (And_keyword)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Local_string_var)
			tmp_body.append (Dot)
			tmp_body.append ("is_equal")
			tmp_body.append (Space)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (Double_quote)
			tmp_body.append ("-regserver")
			tmp_body.append (Double_quote)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Space)
			tmp_body.append (Or_keyword)
			tmp_body.append (Space)
			tmp_body.append (Local_string_var)
			tmp_body.append (Dot)
			tmp_body.append ("is_equal")
			tmp_body.append (Space)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (Double_quote)
			tmp_body.append ("/regserver")
			tmp_body.append (Double_quote)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Space)
			tmp_body.append (Then_keyword)
			tmp_body.append (New_line_tab_tab_tab)
			tmp_body.append (Tab)

			-- 	register_server

			tmp_body.append (Register_server)
			tmp_body.append (New_line_tab_tab_tab)

			-- elseif local_string.is_equal ("-unregserver") or local_string.is_equal ("/unregserver") then

			tmp_body.append (Elseif_keyword)
			tmp_body.append (Space)
			tmp_body.append (Local_string_var)
			tmp_body.append (Space)
			tmp_body.append (Eiffel_not_equal)
			tmp_body.append (Space)
			tmp_body.append (Void_type)
			tmp_body.append (Space)
			tmp_body.append (And_keyword)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Local_string_var)
			tmp_body.append (Dot)
			tmp_body.append ("is_equal")
			tmp_body.append (Space)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (Double_quote)
			tmp_body.append ("-unregserver")
			tmp_body.append (Double_quote)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Space)
			tmp_body.append (Or_keyword)
			tmp_body.append (Space)
			tmp_body.append (Local_string_var)
			tmp_body.append (Dot)
			tmp_body.append ("is_equal")
			tmp_body.append (Space)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (Double_quote)
			tmp_body.append ("/unregserver")
			tmp_body.append (Double_quote)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Space)
			tmp_body.append (Then_keyword)
			tmp_body.append (New_line_tab_tab_tab)
			tmp_body.append (Tab)

			-- 	unregister_server

			tmp_body.append (Unregister_server)
			tmp_body.append (New_line_tab_tab_tab)

			-- else

			tmp_body.append (Else_keyword)
			tmp_body.append (New_line_tab_tab_tab)
			tmp_body.append (Tab)

			-- 	if local_string /= Void and then local_string.is_equal ("-embedding") or local_string.is_equal ("/embedding") then

			tmp_body.append (If_keyword)
			tmp_body.append (Space)
			tmp_body.append (Local_string_var)
			tmp_body.append (Space)
			tmp_body.append (Eiffel_not_equal)
			tmp_body.append (Space)
			tmp_body.append (Void_type)
			tmp_body.append (Space)
			tmp_body.append (And_keyword)
			tmp_body.append (Space_open_parenthesis)
			tmp_body.append (Local_string_var)
			tmp_body.append (Dot)
			tmp_body.append ("is_equal")
			tmp_body.append (Space)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (Double_quote)
			tmp_body.append ("-embedding")
			tmp_body.append (Double_quote)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Space)
			tmp_body.append (Or_keyword)
			tmp_body.append (Space)
			tmp_body.append (Local_string_var)
			tmp_body.append (Dot)
			tmp_body.append ("is_equal")
			tmp_body.append (Space)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (Double_quote)
			tmp_body.append ("/embedding")
			tmp_body.append (Double_quote)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Close_parenthesis)
			tmp_body.append (Space)
			tmp_body.append (Then_keyword)
			tmp_body.append (New_line_tab_tab_tab)
			tmp_body.append (Tab_tab)

			-- default_show_cmd := Sw_hide

			tmp_body.append (default_show_cmd)
			tmp_body.append (Space)
			tmp_body.append (Assignment)
			tmp_body.append (Space)
			tmp_body.append (Sw_hide)
			tmp_body.append (New_line_tab_tab_tab)
			tmp_body.append (Tab)

			-- 	end

			tmp_body.append (End_keyword)
			tmp_body.append (New_line_tab_tab_tab)
			tmp_body.append (Tab)

			-- 	initialize_com

			tmp_body.append (Initialize_com)
			tmp_body.append (New_line_tab_tab_tab)
			tmp_body.append (Tab)

			-- 	wel_make

			tmp_body.append ("wel_make")
			tmp_body.append (New_line_tab_tab_tab)
			tmp_body.append (Tab)

			-- 	cleanup_com

			tmp_body.append (Cleanup_com)
			tmp_body.append (New_line_tab_tab_tab)

			-- end

			tmp_body.append (End_keyword)

			Result.set_body (tmp_body)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	main_window_feature: WIZARD_WRITER_FEATURE
			-- Main Window.
		local
			tmp_body: STRING
		do
			create Result.make
			Result.set_name ("main_window")
			Result.set_once
			Result.set_comment ("Server main window")

			create tmp_body.make (1000)
			tmp_body.append (Tab_tab_tab)
			tmp_body.append (Create_keyword)
			tmp_body.append (Space)
			tmp_body.append (Result_keyword)
			tmp_body.append (Dot)
			tmp_body.append ("make_top")
			tmp_body.append (Space)
			tmp_body.append (Open_parenthesis)
			tmp_body.append (Double_quote)
			tmp_body.append (environment.project_name)
			tmp_body.append (Double_quote)
			tmp_body.append (Close_parenthesis)

			Result.set_body (tmp_body)
			Result.set_result_type ("WEL_FRAME_WINDOW")
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	default_show_command_feature: WIZARD_WRITER_FEATURE
			-- Default Show command.
		local
			tmp_comment, tmp_body: STRING
		do
			create Result.make
			Result.set_name ("default_show_command")
			Result.set_once
			create tmp_comment.make (100)
			tmp_comment.append ("Default command used to show ")
			tmp_comment.append (Back_quote)
			tmp_comment.append ("main_window")
			tmp_comment.append (Single_quote)
			tmp_comment.append (Dot)
			Result.set_comment (tmp_comment)
			Result.set_result_type (Integer_type)

			create tmp_body.make (1000)
			tmp_body.append (Tab_tab_tab)
			tmp_body.append (Result_keyword)
			tmp_body.append (Space)
			tmp_body.append (Assignment)
			tmp_body.append (Space)
			tmp_body.append (default_show_cmd)

			Result.set_body (tmp_body)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	default_show_cmd_feature: WIZARD_WRITER_FEATURE
			-- Default Show command.
		local
			tmp_comment: STRING
		do
			create Result.make
			Result.set_name (default_show_cmd)
			Result.set_attribute
			create tmp_comment.make (100)
			tmp_comment.append ("Default command used to show ")
			tmp_comment.append (Back_quote)
			tmp_comment.append ("main_window")
			tmp_comment.append (Single_quote)
			tmp_comment.append (Dot)
			Result.set_comment (tmp_comment)
			Result.set_result_type (Integer_type)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	initialize_com_feature: WIZARD_WRITER_FEATURE
			-- Initialize COM.
		local
			tmp_comment, tmp_body: STRING
		do
			create Result.make
			Result.set_name (initialize_com)
			Result.set_effective
			create tmp_comment.make (100)
			tmp_comment.append ("Initialize COM ")
			Result.set_comment (tmp_comment)

			create tmp_body.make (1000)
			tmp_body.append (Tab_tab_tab)
			tmp_body.append (Ccom_initialize_com)

			Result.set_body (tmp_body)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	cleanup_com_feature: WIZARD_WRITER_FEATURE
			-- Clean up COM.
		local
			tmp_comment, tmp_body: STRING
		do
			create Result.make
			Result.set_name (Cleanup_com)
			Result.set_effective
			create tmp_comment.make (100)
			tmp_comment.append ("Clean up COM ")
			Result.set_comment (tmp_comment)

			create tmp_body.make (1000)
			tmp_body.append (Tab_tab_tab)
			tmp_body.append (Ccom_cleanup_com)

			Result.set_body (tmp_body)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	register_server_feature: WIZARD_WRITER_FEATURE
			-- Register Server.
		local
			tmp_comment, tmp_body: STRING
		do
			create Result.make
			Result.set_name (Register_server)
			Result.set_effective
			create tmp_comment.make (100)
			tmp_comment.append ("Register Server")
			Result.set_comment (tmp_comment)

			create tmp_body.make (1000)
			tmp_body.append (Tab_tab_tab)
			tmp_body.append (Ccom_register_server)

			Result.set_body (tmp_body)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	unregister_server_feature: WIZARD_WRITER_FEATURE
			-- Clean up COM.
		local
			tmp_comment, tmp_body: STRING
		do
			create Result.make
			Result.set_name (Unregister_server)
			Result.set_effective
			create tmp_comment.make (100)
			tmp_comment.append ("Unregister Server")
			Result.set_comment (tmp_comment)

			create tmp_body.make (1000)
			tmp_body.append (Tab_tab_tab)
			tmp_body.append (Ccom_unregister_server)

			Result.set_body (tmp_body)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	ccom_initialize_com_feature: WIZARD_WRITER_FEATURE
			-- External Clean up COM feature.
		local
			tmp_body: STRING
		do
			create Result.make
			Result.set_name (Ccom_initialize_com)
			Result.set_external

			Result.set_comment ("Initialize COM.")

			create tmp_body.make (1000)
			tmp_body.append (Tab_tab_tab)
			tmp_body.append (Double_quote)
			tmp_body.append ("C++")
			tmp_body.append (Open_bracket)
			tmp_body.append (Macro)
			tmp_body.append (Space)
			tmp_body.append (Percent_double_quote)
			tmp_body.append ("server_registration.h")
			tmp_body.append (Percent_double_quote)
			tmp_body.append (Close_bracket)
			tmp_body.append (Double_quote)

			Result.set_body (tmp_body)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	ccom_cleanup_com_feature: WIZARD_WRITER_FEATURE
			-- External Initialize COM feature.
		local
			tmp_body: STRING
		do
			create Result.make
			Result.set_name (Ccom_cleanup_com)
			Result.set_external

			Result.set_comment ("Clean up COM.")

			create tmp_body.make (1000)
			tmp_body.append (Tab_tab_tab)
			tmp_body.append (Double_quote)
			tmp_body.append ("C++")
			tmp_body.append (Open_bracket)
			tmp_body.append (Macro)
			tmp_body.append (Space)
			tmp_body.append (Percent_double_quote)
			tmp_body.append ("server_registration.h")
			tmp_body.append (Percent_double_quote)
			tmp_body.append (Close_bracket)
			tmp_body.append (Double_quote)

			Result.set_body (tmp_body)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	ccom_register_server_feature: WIZARD_WRITER_FEATURE
			-- External Register server feature.
		local
			tmp_body: STRING
		do
			create Result.make
			Result.set_name (Ccom_register_server)
			Result.set_external

			Result.set_comment ("Register server.")

			create tmp_body.make (1000)
			tmp_body.append (Tab_tab_tab)
			tmp_body.append (Double_quote)
			tmp_body.append ("C++")
			tmp_body.append (Open_bracket)
			tmp_body.append (Macro)
			tmp_body.append (Space)
			tmp_body.append (Percent_double_quote)
			tmp_body.append ("server_registration.h")
			tmp_body.append (Percent_double_quote)
			tmp_body.append (Close_bracket)
			tmp_body.append (Double_quote)

			Result.set_body (tmp_body)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

	ccom_unregister_server_feature: WIZARD_WRITER_FEATURE
			-- External Unregister Server feature.
		local
			tmp_body: STRING
		do
			create Result.make
			Result.set_name (Ccom_unregister_server)
			Result.set_external

			Result.set_comment ("Unregister server.")

			create tmp_body.make (1000)
			tmp_body.append (Tab_tab_tab)
			tmp_body.append (Double_quote)
			tmp_body.append ("C++")
			tmp_body.append (Open_bracket)
			tmp_body.append (Macro)
			tmp_body.append (Space)
			tmp_body.append (Percent_double_quote)
			tmp_body.append ("server_registration.h")
			tmp_body.append (Percent_double_quote)
			tmp_body.append (Close_bracket)
			tmp_body.append (Double_quote)

			Result.set_body (tmp_body)
		ensure
			non_void_writer: Result /= Void
			valid_writer: Result.can_generate
		end

note
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
end -- class WIZARD_OUTPROC_EIFFEL_REGISTRATION_GENERATOR


