
class EWB_W_COMPILE

inherit

	EWB_C_CODE
		rename
			name as w_compile_cmd_name,
			help_message as w_compile_help,
			abbreviation as w_compile_abb
		end;

feature

	c_code_directory: STRING is
		do
			Result := Workbench_generation_path
		end;

end
