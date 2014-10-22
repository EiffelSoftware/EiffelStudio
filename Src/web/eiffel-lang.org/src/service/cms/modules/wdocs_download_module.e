note
	description: "Summary description for {WDOCS_DOWNLOAD_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_DOWNLOAD_MODULE
inherit
	CMS_MODULE

	CMS_HOOK_AUTO_REGISTER

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	SHARED_HTML_ENCODER

	SHARED_WSF_PERCENT_ENCODER

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			name := "download"
			version := "1.0"
			description := "Eiffel GPL Download"
			package := "download"
			enable
		end

feature {CMS_SERVICE} -- Registration

	service: detachable CMS_SERVICE

	register (a_service: CMS_SERVICE)
		local
			fs: WSF_FILE_SYSTEM_HANDLER
			cfg: detachable WDOCS_CONFIG
		do
			service := a_service

				-- FIXME: this code could/should be retarded to when it is really needed
				-- then if the module is disabled, it won't take CPU+memory for nothing.
			cfg := configuration (a_service.site_var_dir)
--			root_dir := cfg.root_dir
--			temp_dir := cfg.temp_dir
--			documentation_dir := cfg.documentation_dir
			cache_duration := cfg.cache_duration

			a_service.map_uri_template ("/download", agent handle_download (a_service, ?, ?))

			create fs.make_with_path (a_service.theme_location.extended ("res").extended ("images"))
			fs.disable_index
			a_service.router.handle ("/theme/images", fs)
		end

feature -- Access: config

	configuration (a_dir: PATH): WDOCS_CONFIG
			-- Configuration setup.
		local
			cfg: detachable WDOCS_CONFIG
			p: detachable PATH
			ut: FILE_UTILITIES
		do
			if attached execution_environment.item ("WDOCS_CONFIG") as s then
				create p.make_from_string (s)
				if not ut.file_path_exists (p) then
					p := a_dir.extended (s)
					if not ut.file_path_exists (p) then
						p := Void
					end
				end
			end
			if p /= Void then
				if attached p.extension as ext then
					if ext.is_case_insensitive_equal_general ("ini") then
						create {WDOCS_INI_CONFIG} cfg.make (p)
					elseif ext.is_case_insensitive_equal_general ("json") then
						create {WDOCS_JSON_CONFIG} cfg.make (p)
					end
				end
				if cfg = Void then
					create {WDOCS_INI_CONFIG} Result.make (p)
				end
			else
				p := a_dir.extended ("eiffel-lang.ini")
				if ut.file_path_exists (p) then
					create {WDOCS_INI_CONFIG} cfg.make (p)
				else
					p := a_dir.extended ("eiffel-lang.json")
					if ut.file_path_exists (p) then
						create {WDOCS_JSON_CONFIG} cfg.make (p)
					end
				end
			end

			if cfg /= Void then
				Result := cfg
			else
					-- Default
				create {WDOCS_DEFAULT_CONFIG} Result.make_default
			end
		end

feature -- Access: docs

--	root_dir: PATH

--	temp_dir: PATH

--	documentation_dir: PATH

	cache_duration: INTEGER
			-- Caching duration
			--|  0: disable
			--| -1: cache always valie
			--| nb: cache expires after nb seconds.

	cache_disabled: BOOLEAN
		do
			Result := cache_duration = 0
		end


feature -- Hooks



feature -- Handler		

	handle_download (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			to_implement("Download Handler")
			hardcode_download (req, res)

		end

	hardcode_download  (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Simple response to download content
			-- Harcoded for testing.
		local
			h: HTTP_HEADER
		do
			create h.make
			h.put_content_disposition ("attachment; filename", "[
						http://sourceforge.net/projects/eiffelstudio/files/EiffelStudio%2014.05/Build_95417/Eiffel_14.05_gpl_95417-windows.msi/download
						]")
			h.put_current_date
			h.put_header_key_value ("Content-type", "application/octet-stream")
			h.put_location ("[
						http://sourceforge.net/projects/eiffelstudio/files/EiffelStudio%2014.05/Build_95417/Eiffel_14.05_gpl_95417-windows.msi/download
						]")
			res.set_status_code ({HTTP_STATUS_CODE}.see_other)
			res.put_header_text (h.string)
		end


feature {NONE} -- Implementation: date and time

	http_date_format_to_date (s: READABLE_STRING_8): detachable DATE_TIME
		local
			d: HTTP_DATE
		do
			create d.make_from_string (s)
			if not d.has_error then
				Result := d.date_time
			end
		end

	timestamp_to_date (n: INTEGER): DATE_TIME
		local
			d: HTTP_DATE
		do
			create d.make_from_timestamp (n)
			Result := d.date_time
		end


	html_encoded (s: detachable READABLE_STRING_GENERAL): STRING_8
		do
			if s /= Void then
				Result := html_encoder.general_encoded_string (s)
			else
				create Result.make_empty
			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
