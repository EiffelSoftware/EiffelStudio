note
	description: "[
				This class implements the Demo of WEB CMS service

			]"

class
	WEB_CMS

inherit
	WSF_DEFAULT_SERVICE
		redefine
			initialize
		end

create
	make_and_launch

feature {NONE} -- Initialization

	initialize
		local
			args: ARGUMENTS_32
			cfg: detachable READABLE_STRING_32
			i,n: INTEGER
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
				if file_exists ("cms.ini") then
					cfg := {STRING_32} "cms.ini"
				end
			end

				--| EWF settings
			service_options := create {WSF_SERVICE_LAUNCHER_OPTIONS_FROM_INI}.make_from_file ("ewf.ini")
			Precursor

				--| CMS initialization
			launch_cms (cms_setup (cfg))
		end

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

	launch_cms (a_setup: CMS_SETUP)
		local
			cms: CMS_SERVICE
		do
			create cms.make (a_setup)
			on_launched (cms)
			cms_service := cms
		end

feature -- Execution

	cms_service: CMS_SERVICE

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			cms_service.execute (req, res)
		end

feature -- Access

	setup_modules (a_setup: CMS_SETUP)
		local
			m: CMS_MODULE
		do
			create {DEMO_MODULE} m.make
			m.enable
			a_setup.add_module (m)

			create {SHUTDOWN_MODULE} m.make
			m.enable
			a_setup.add_module (m)

			create {DEBUG_MODULE} m.make
			m.enable
			a_setup.add_module (m)

			create {OPENID_MODULE} m.make
			m.enable
			a_setup.add_module (m)
		end

	setup_storage (a_setup: CMS_SETUP)
		do

		end

feature -- Event		

	on_launched (cms: CMS_SERVICE)
		local
			e: CMS_EMAIL
		do
			create e.make (cms.site_email, cms.site_email, "[" + cms.site_name + "] launched...", "The site [" + cms.site_name + "] was launched at " + (create {DATE_TIME}.make_now_utc).out + " UTC.")
			cms.mailer.safe_process_email (e)
		end

feature -- Helper		

	file_exists (fn: READABLE_STRING_GENERAL): BOOLEAN
		local
			f: RAW_FILE
		do
			create f.make_with_name (fn)
			Result := f.exists and then f.is_readable
		end

end
