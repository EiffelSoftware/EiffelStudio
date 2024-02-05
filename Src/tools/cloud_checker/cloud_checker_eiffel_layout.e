note
	description: "Summary description for {CLOUD_CHECKER_EIFFEL_LAYOUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLOUD_CHECKER_EIFFEL_LAYOUT

inherit
	EIFFEL_ENV
--		redefine
--			Hidden_files_path
--		end

feature -- Access

	application_name: STRING = "es_cloud_checker";

--	Hidden_files_path: PATH
--			-- Hidden application configuration Eiffel files.
--			-- With ISE_APP_DATA defined:
--			--   $ISE_APP_DATA
--			-- When hidden files is available:
--			--   On Windows: C:\Users\username\AppData\Local\Eiffel Software\.es\MM.mm
--			--   On Unix & Mac: ~/.es/MM.mm
--			-- Otherwise we use a subdirectory of `user_files_path`:
--			--   `user_files_path`\settings
--		require
--			is_valid_environment: is_valid_environment
--			is_user_files_supported: Is_user_files_supported
--		local
--			l_dir: STRING_32
--		once
--			l_dir := get_environment_32 ({EIFFEL_CONSTANTS}.ise_app_data_env)
--			if l_dir = Void or else l_dir.is_empty then
--				Result := hidden_files_path_for_version (Version_name, True)
--			else
--				create Result.make_from_string (l_dir)
--			end
--		ensure
--			not_result_is_empty: not Result.is_empty
--		end

end
