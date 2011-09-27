note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ECF_BUILDER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			arg_parser: ARGUMENT_PARSER
		do
			create arg_parser.make
			arg_parser.set_is_usage_displayed_on_error (True)
			arg_parser.execute (agent start (arg_parser))
		end

feature {NONE} -- Execution

	start (args: ARGUMENT_PARSER)
		local
			app_ecf: detachable APPLICATION_ECF
			vis: ECF_PRINT_VISITOR
			bvis: ECF_BUILDER_VISITOR
			ecf: ECF
			buf: STRING
		do
			if args.is_application_target then
				create app_ecf.make (args.target_name)
				ecf := app_ecf
			elseif args.is_library_target then
				create {LIBRARY_ECF} ecf.make (args.target_name)
			elseif args.is_testing_target then
				create {TESTING_ECF} app_ecf.make (args.target_name)
				ecf := app_ecf
			else
				--| Default ...
				create {LIBRARY_ECF} ecf.make (args.target_name)
			end
			ecf.set_syntax (args.syntax_mode)
			ecf.set_uuid (args.uuid)

			if app_ecf /= Void then
				if attached args.executable_name as s then
					app_ecf.set_executable_name (s)
				end
				if attached args.root_info as tu then
					if args.is_testing_target then
						print ("Ignoring provided root_info settings%N")
					else
						if attached tu.cluster as l_root_cluster then
							app_ecf.set_root_info (l_root_cluster, tu.class_name, tu.feature_name)
						else
							app_ecf.set_root_info (Void, tu.class_name, tu.feature_name)
						end
					end
				end
				if args.is_testing_target then
					print ("Ignoring provided console_application settings%N")
				else
					app_ecf.set_is_console_application (args.is_console_application)
				end
				if attached args.concurrency as l_concurrency then
					app_ecf.set_concurrency (l_concurrency)
				end
			end
			if attached args.clusters as l_clusters then
				across
					l_clusters as cl
				loop
					ecf.clusters.force (cl.item)
				end
			end
			if attached args.tests_clusters as l_clusters then
				across
					l_clusters as cl
				loop
					ecf.tests_clusters.force (cl.item)
				end
			end
			if attached args.libraries as l_libraries then
				across
					l_libraries as libs
				loop
					ecf.libraries.force (libs.item)
				end
			end

			if not ecf.libraries.has ("base") then
				ecf.libraries.force ("base")
			end
			if args.is_testing_target and then not ecf.libraries.has ("testing") then
				ecf.libraries.force ("testing")
			end
			if not args.is_testing_target and ecf.clusters.is_empty then
				ecf.clusters.force (".")
			end
			if args.is_testing_target and ecf.tests_clusters.is_empty then
				ecf.tests_clusters.force (".")
			end

			if app_ecf /= Void and then app_ecf.concurrency.is_case_insensitive_equal ("thread") then
				if not ecf.libraries.has ("thread") then
					ecf.libraries.force ("thread")
				end
			end

			create vis
			ecf.process (vis)

			create buf.make (2048)
			create bvis.make (buf)
			ecf.process (bvis)
			save (buf, ecf, args.base_directory, args.force_enabled)

			ecf.set_is_voidsafe (True)
			create buf.make (2048)
			create bvis.make (buf)
			ecf.process (bvis)
			save (buf, ecf, args.base_directory, args.force_enabled)
		end

feature -- Storage

	save (buf: STRING; ecf: ECF; dir: STRING; a_force: BOOLEAN)
		local
			f: PLAIN_TEXT_FILE
			fn: FILE_NAME
		do
			create fn.make_from_string (dir)
			if ecf.is_voidsafe then
				fn.set_file_name (ecf.name + "-safe")
			else
				fn.set_file_name (ecf.name)
			end
			fn.add_extension ("ecf")

			create f.make (fn.string)
			if f.exists and not a_force then
				print ("File %""+ fn.string +"%" already exists ... delete it before%N")
			elseif f.exists and not f.is_writable then
				print ("File %""+ fn.string +"%" already exists and is not writable%N")
			else
				f.create_read_write
				f.put_string (buf)
				f.close
			end
		end

end
