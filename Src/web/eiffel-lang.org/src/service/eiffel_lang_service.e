note
	description: "Summary description for {WDOCS_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_LANG_SERVICE

inherit
	WSF_SERVICE

	REFACTORING_HELPER

feature	-- Initialization

	initialize_wdocs
		do
			initialize_cms (create {PATH}.make_current) -- FIXME
		end

	initialize_cms (a_root_dir: PATH)
		local
			args: ARGUMENTS_32
			cfg: detachable READABLE_STRING_32
			i,n: INTEGER
			ut: FILE_UTILITIES
		do

				--| Arguments
			create args
			from
				i := 1
				n := args.argument_count
			until
				i > n or cfg /= Void
			loop
				if attached args.argument (i) as s then
					if s.same_string_general ("--config") or s.same_string_general ("-c") then
						if i < n then
							cfg := args.argument (i + 1)
						end
					end
				end
				i := i + 1
			end
			if cfg = Void then
				if ut.file_path_exists (a_root_dir.extended ("cms.ini")) then
					cfg := a_root_dir.extended ("cms.ini").name
				end
			end

			create cms_service.make (cms_setup (cfg))


			fixme ("Remove this hack to provide about, contribute and download page")
			cms_service.map_uri_template ("/about", agent handle_about)
			cms_service.map_uri_template ("/contribute", agent handle_contribute)
--			cms_service.map_uri_template ("/download", agent handle_download)
		end

feature -- Access: CMS

	cms_service: CMS_SERVICE

feature -- Implementation: CMS

	cms_setup (a_cfg_fn: detachable READABLE_STRING_GENERAL): CMS_CUSTOM_SETUP
		do
			if a_cfg_fn /= Void then
				create Result.make_from_file (a_cfg_fn)
			else
				create Result -- Default
			end
			setup_modules (Result)
			setup_storage (Result)
		end

	setup_modules (a_setup: CMS_SETUP)
		local
			m: CMS_MODULE
		do
			create {WDOCS_MODULE} m.make
			m.enable
			a_setup.add_module (m)


			create {EIFFEL_DOWNLOAD_MODULE} m.make
			m.enable
			a_setup.add_module (m)

			debug
				create {DEBUG_MODULE} m.make
				m.enable
				a_setup.add_module (m)
			end

--			create {OPENID_MODULE} m.make
--			m.enable
--			a_setup.add_module (m)
		end

	setup_storage (a_setup: CMS_SETUP)
		do

		end

feature	-- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute the request
			-- See `req.input' for input stream
    		--     `req.meta_variables' for the CGI meta variable
			-- and `res' for output buffer
		do
			cms_service.execute (req, res)
		end

	handle_about (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			e: CMS_EXECUTION
		do
			fixme ("Use CMS node and associated content for About link!")
			create {ANY_CMS_EXECUTION} e.make (req, res, cms_service)
			e.set_optional_content_type ("about")
			e.set_title ("About")
			e.set_main_content ("")
			e.execute
		end

	handle_contribute (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			e: CMS_EXECUTION
		do
			fixme ("Use CMS node and associated content for Contribute link!")
			create {ANY_CMS_EXECUTION} e.make (req, res, cms_service)
			e.set_optional_content_type ("contribute")
			e.set_title ("Contribute")
			e.set_main_content ("")
			e.execute
		end

--	handle_download (req: WSF_REQUEST; res: WSF_RESPONSE)
--		local
--			e: CMS_EXECUTION
--		do
--			fixme ("Use CMS node and associated content for Download link!")
--			create {ANY_CMS_EXECUTION} e.make (req, res, cms_service)
--			e.set_optional_content_type ("download")
--			e.set_title ("Download")
--			e.set_main_content ("")
--			e.execute
--		end

end
