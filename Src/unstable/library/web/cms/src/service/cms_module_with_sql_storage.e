note
	description: "Summary description for {CMS_MODULE_WITH_SQL_STORAGE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_MODULE_WITH_SQL_STORAGE

inherit
	CMS_MODULE
		redefine
			install, uninstall,
			update
		end

feature {CMS_API} -- SQL queries

	sql_storage (api: CMS_API): detachable CMS_STORAGE_SQL_I
		do
			Result := api.storage.as_sql_storage
		end

	has_sql_table (a_table_name: READABLE_STRING_8; api: CMS_API): BOOLEAN
		do
			if attached sql_storage (api) as l_sql_storage then
				Result := l_sql_storage.sql_table_exists (a_table_name)
			end
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
		local
			p, l_script_location: PATH
			fut: FILE_UTILITIES
		do
				-- Schema
			if attached sql_storage (api) as l_sql_storage then
				p := (create {PATH}.make_from_string ("scripts")).extended (name).appended_with_extension ("sql")
				l_script_location := api.module_resource_location (Current, p)
				if not fut.file_path_exists (l_script_location) then
					p := (create {PATH}.make_from_string ("scripts")).extended ("install.sql")
					l_script_location := api.module_resource_location (Current, p)
				end
				l_sql_storage.sql_execute_file_script (l_script_location, Void)
				if l_sql_storage.has_error then
					api.logger.put_error ("Could not install database for module [" + name + "]: " + utf_8_encoded (l_sql_storage.error_handler.as_string_representation), generating_type)
				else
					Precursor {CMS_MODULE} (api)
				end
			end
		end

	uninstall (api: CMS_API)
			-- (export status {CMS_API})
		do
			if attached sql_storage (api) as l_sql_storage then
				l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("uninstall").appended_with_extension ("sql")), Void)
				if l_sql_storage.has_error then
					api.logger.put_error ("Could not uninstall database for module [" + name + "]: " + utf_8_encoded (l_sql_storage.error_handler.as_string_representation), generating_type)
				end
			end
			Precursor (api)
		end

	update (a_installed_version: READABLE_STRING_GENERAL; api: CMS_API)
			-- Update module from version `a_installed_version` to current `version`.
		local
			v_from, v_to: STRING_32
			p: PATH
			fut: FILE_UTILITIES
		do
			if attached sql_storage (api) as l_sql_storage then
					-- TODO: documentate this global update facility for SQL storage.
				v_from := a_installed_version
				v_from.left_adjust
				v_from.right_adjust
				v_to := version
				v_to.left_adjust
				v_to.right_adjust
				v_from.replace_substring_all (".", "_")
				v_to.replace_substring_all (".", "_")
				create p.make_from_string ("scripts")
				p := p.extended ("update")
				if fut.directory_path_exists (p) then
					p := p.extended (name).appended ("-")
				else
					p := p.appended ("-")
				end
				p := p.appended (v_from)
				p := p.appended ("-")
				p := p.appended (v_to)
				p := p.appended_with_extension ("sql")

				l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, p), Void)

				if l_sql_storage.has_error then
					api.log_error (name, "Could not update database for module [" + name + "]: " + utf_8_encoded (l_sql_storage.error_handler.as_string_representation), Void)
				else
					Precursor (a_installed_version, api)
				end
			else
				Precursor (a_installed_version, api)
			end
		end

note
	copyright: "2011-2021, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
