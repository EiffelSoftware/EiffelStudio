note
description: "Objects that ..."
author: ""
date: "$Date$"
revision: "$Revision$"

class
	SVN_TOOL_BATCH

inherit
	SHARED_SVN_ENGINE

	SVN_CONSTANTS

	DT_SHARED_SYSTEM_CLOCK

create
	make

feature -- Access

	make
		-- Main routine
		local
			parser: AP_PARSER
			opt, opt_c, opt_a, opt_f, opt_t, opt_tt, opt_e: AP_STRING_OPTION
			opt_i, opt_s, opt_v, opt_b: AP_FLAG
			excludes: ARRAYED_LIST [STRING]

			srcdir: STRING
			tgtdir: DIRECTORY_NAME
		do
			-- First we create the parser
			create parser.make

			-- We add a opt
			create opt_c.make ('c',"config")
			opt := opt_c
			opt.set_description ("Configuration file")
			parser.options.force_last (opt)

			create opt_a.make ('a',"action")
			opt := opt_a
			opt.set_description ("Action to execute : extract")
			parser.options.force_last (opt)

			create opt_e.make ('e',"exclude")
			opt := opt_e
			opt.set_description ("exclude pattern")
			parser.options.force_last (opt)

			create opt_t.make ('t',"target")
			opt := opt_t
			opt.set_description ("Target folder")
			parser.options.force_last (opt)

			create opt_tt.make ('T',"-append-time-to-target")
			opt := opt_tt
			opt.set_description ("Append time to target folder")
			parser.options.force_last (opt)

			create opt_f.make ('f',"from")
			opt := opt_f
			opt.set_description ("Source folder")
			parser.options.force_last (opt)

			create opt_i.make ('i',"action")
			opt_i.set_description ("Interactive mode")
			parser.options.force_last (opt_i)

			create opt_v.make ('v',"verbose")
			opt_v.set_description ("Verbose mode")
			parser.options.force_last (opt_v)

			create opt_s.make ('s',"simulate")
			opt_s.set_description ("Simulation mode")
			parser.options.force_last (opt_s)

			create opt_b.make ('b',"split-by-status")
			opt_b.set_description ("Split results by status")
			parser.options.force_last (opt_b)

			-- We parse the arguments
			parser.parse_arguments

			-- Lets see what we found
			if opt_c.was_found then
				-- not yet implemented
			end
			srcdir := opt_f.parameter
			create tgtdir.make_from_string (opt_t.parameter)
			if opt_tt.was_found then
				tgtdir.extend (datetime_as_foldername)
			end
			if opt_e.was_found then
				if attached opt_e.parameters as opt_e_params then
					create excludes.make (opt_e_params.count)
					from
						opt_e_params.start
					until
						opt_e_params.after
					loop
						excludes.force (opt_e_params.item_for_iteration)
						opt_e_params.forth
					end
				end
			end
			if opt_a.was_found and then opt_a.parameter.is_equal ("extract") then
				extract_files (srcdir, tgtdir, excludes, opt_b.was_found, opt_i.was_found, opt_v.was_found, opt_s.was_found)
			end
	--		if option.was_found then
	--			print ("The user has supplied the option with "+option.value.out+"%N")
	--		end
	--		print ("The number of parameters were "+parser.parameters.count.out+"%N")
		end

	extract_files (srcdir, tgtdir: STRING; excludes: LIST [STRING]; split_mode: BOOLEAN; interac_mode: BOOLEAN; is_verbose: BOOLEAN; is_simulation: BOOLEAN)
		local
			exporter: SVN_FILES_EXPORTER
			s: STRING
			lst: LIST [SVN_STATUS_INFO]
		do
			from
				s := ""
			until
				s.count > 0 and then (s.item (1) = 'y' or s.item(1) = 'n')
			loop
				if is_simulation then
					print ("*** Simulation (True) ***%N")
				end
				print ("Export differences : %N")
				print ("  from : " + srcdir + "%N")
				print ("    to : " + tgtdir + "%N")
				if excludes /= Void then
					from
						print ("  Excludes: %N")
						excludes.start
					until
						excludes.after
					loop
						print ("   -> " + excludes.item_for_iteration + "%N")
						excludes.forth
					end
				end
				if interac_mode then
					print (" Continue (y|n) [n] ? ")
					io.read_line
					s := io.last_string.as_lower
					if s.count = 0 then
						s := "n"
					end
				else
					s := "y"
				end
			end
			if s.item (1) = 'y' then
				print ("Start export ... %N")
				create exporter.make_with_option (srcdir, tgtdir, split_mode, False)
				exporter.set_simulation_mode (is_simulation)
				exporter.set_exclude_status_code_array (<<
							{SVN_CONSTANTS}.status_normal,
							{SVN_CONSTANTS}.status_update,
							{SVN_CONSTANTS}.status_none,
							{SVN_CONSTANTS}.status_error
						>>)
				exporter.set_exclude_patterns (excludes)
				if is_verbose then
					exporter.notify_actions.extend (agent notify_message)
				end

				lst := svn_engine_provider.computed_info ([srcdir, True, True, False])
				exporter.export_entries (lst)
				print ("Export completed.%N")
			else
				print ("Cancelled %N")
			end
		end

	notify_message (msg: STRING)
		do
			io.output.put_string (msg)
			io.output.put_new_line
		end

	datetime_as_foldername: STRING
			--
		local
			dt: DT_DATE_TIME
		do
			dt := system_clock.date_time_now
			create Result.make_empty
			Result.append_integer (dt.year)
			if dt.month < 10 then
				Result.append_integer (0)
			end
			Result.append_integer (dt.month)
			if dt.day < 10 then
				Result.append_integer (0)
			end
			Result.append_integer (dt.day)
			Result.append_character ('_')
			if dt.hour < 10 then
				Result.append_integer (0)
			end
			Result.append_integer (dt.hour)
			Result.append_character ('-')
			if dt.minute < 10 then
				Result.append_integer (0)
			end
			Result.append_integer (dt.minute)
		end

end
