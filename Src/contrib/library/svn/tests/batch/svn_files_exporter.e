note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SVN_FILES_EXPORTER

inherit

	SHARED_SVN_ENGINE

	SHARED_SVN_SORTERS

	SVN_CONSTANTS

	SVN_SHARED_PREFERENCES

	KL_SHARED_FILE_SYSTEM

create
	make,
	make_with_option

feature

	make (a_path: STRING; a_target_dir: STRING)
		do
			make_with_option (a_path, a_target_dir, True, True)
		end

	make_with_option (a_path: STRING; a_target_dir: STRING; a_sep_results: BOOLEAN; a_generate_target_name: BOOLEAN)
		local
			s: STRING
		do
			create notify_actions
			source_path := a_path
			separate_results := a_sep_results

			create target_dir.make_from_string (a_target_dir)
			if a_generate_target_name then
				s := source_path.twin
				s.replace_substring_all (":", "#")
				s.replace_substring_all ((create {OPERATING_ENVIRONMENT}).Directory_separator.out , "__")
				target_dir.extend (s)
			end
		end

feature -- properties

	source_path: STRING

	target_dir: DIRECTORY_NAME

	separate_results: BOOLEAN
			-- Split by status ?

feature -- helper

	target_file_name (a_info: SVN_STATUS_INFO): FILE_NAME
		do
			create Result.make_from_string (target_dir)
			if separate_results then
				Result.extend ("_" + a_info.wc_status + "_")
			end
			Result.extend (a_info.display_path)
		end

	copy_dir_to (from_dn, target_dn: STRING)
		local
			dn: STRING
			retried: BOOLEAN
			l_dir: KL_DIRECTORY
		do
			if not retried then
				if simulation_mode then
					notify_log (" + copy dir : " + target_dn + "")
				else
					dn := file_system.dirname (target_dn)
					if not file_system.directory_exists (dn) then
						notify_log (" + create directory [" + dn + "]")
						file_system.recursive_create_directory (dn)
					end
					notify_log (" + copy dir : " + target_dn + "")
					create l_dir.make (from_dn)
					l_dir.do_if (
							agent (s: STRING; fm,tt: STRING)
								local
									n: RAW_FILE
									fn,tn: FILE_NAME
								do
									print (s + "%N")
									create fn.make_from_string (fm)
									fn.set_file_name (s)
									create tn.make_from_string (tt)
									tn.set_file_name (s)
									create n.make (fn.string)
									if n.exists and then n.is_directory then
										copy_dir_to (fn.string, tn.string)
									else
										copy_file_to (fn.string, tn.string)
									end
								end(?, from_dn, target_dn),
							agent path_included
						)
--					file_system.recursive_copy_directory (from_dn, target_dn)
				end
			else
				notify_log ("!! copy dir : " + target_dn + " : ERROR")
			end
		rescue
			retried := True
			retry
		end

	copy_file_to (from_fn, target_fn: STRING)
		local
			dn: STRING
			retried: BOOLEAN
		do
			if not retried then
				if simulation_mode then
					notify_log (" + copy file : " + target_fn + "")
				else
					dn := file_system.dirname (target_fn)
					if not file_system.directory_exists (dn) then
						notify_log (" + create directory ["+dn+"]")
						file_system.recursive_create_directory (dn)
					end
					notify_log (" + copy file : " + target_fn + "")
					file_system.copy_file (from_fn, target_fn)
				end
			else
				notify_log ("!! copy file : " + target_fn + " : ERROR")
			end
		rescue
			retried := True
			retry
		end

feature -- Access

	exclude_status_code_array: ARRAY [INTEGER]

	exclude_patterns: LIST [RX_PCRE_REGULAR_EXPRESSION]

	simulation_mode: BOOLEAN

	set_exclude_status_code_array (v:like exclude_status_code_array)
		do
			exclude_status_code_array := v
		end

	set_exclude_patterns (lst: LIST [STRING])
		local
			r: RX_PCRE_REGULAR_EXPRESSION
		do
			if lst = Void or else lst.is_empty then
				exclude_patterns := Void
			else
				create {ARRAYED_LIST [RX_PCRE_REGULAR_EXPRESSION]} exclude_patterns.make (lst.count)
				from
					lst.start
				until
					lst.after
				loop
					create r.make
					r.set_caseless (False)
					r.compile (lst.item_for_iteration)
					if r.is_compiled then
						exclude_patterns.force (r)
					else
						print ("Pattern [" + lst.item_for_iteration + "] is invalid.%N")
					end
					lst.forth
				end
			end
		end

	set_simulation_mode	(v: like simulation_mode)
		do
			simulation_mode := v
		end

	export_entries (a_lst: LIST [SVN_STATUS_INFO])
		do
			init_log
			if a_lst = Void then
				notify_log ("Nothing to export.")
			else
				notify_log ("Start exporting " + a_lst.count.out + " items.")
				from
					info_sorter.sort (a_lst)
					a_lst.start
				until
					a_lst.after
				loop
					export_entry (a_lst.item_for_iteration)
					a_lst.forth
				end
			end
			notify_log ("Export finished.")
			close_log
		end


	entry_excluded (a_info: SVN_STATUS_INFO): BOOLEAN
		do
			Result := attached exclude_status_code_array as l_arr and then l_arr.has (a_info.wc_status_code)
			if not Result then
				Result := path_excluded (a_info.path)
			end
		end

	path_excluded (a_path: STRING): BOOLEAN
		local
			r: RX_PCRE_REGULAR_EXPRESSION
			rs: like exclude_patterns
		do
			rs := exclude_patterns
			if rs /= Void then
				from
					rs.start
				until
					Result or rs.after
				loop
					r := rs.item_for_iteration
					r.match (a_path)
					Result := r.has_matched
					rs.forth
				end
			end
		end

	path_included (a_path: STRING): BOOLEAN
		do
			Result := not path_excluded (a_path)
		end

	export_entry (a_info: SVN_STATUS_INFO)
		local
			fp: PATH
			target_fn: READABLE_STRING_8
			exc: BOOLEAN
		do
			if a_info /= Void then
				exc := entry_excluded (a_info)
				if exc then
					--| excluded
				else
					fp := a_info.absolute_path
					target_fn := target_file_name (a_info)
					if a_info.path_is_directory then
						copy_dir_to (fp.utf_8_name, target_fn)
					else
						copy_file_to (fp.utf_8_name, target_fn)
					end
				end
			end
		end

feature -- Log

	init_log
		local
			fn: FILE_NAME
		do
			if file_system.directory_exists (target_dir) then
				file_system.recursive_create_directory (target_dir)
			end
			create fn.make_from_string (target_dir)
			file_system.recursive_create_directory (target_dir)
			fn.set_file_name ("log.txt")
			if file_system.file_exists (fn) then
				create log_file.make_open_append (fn)
			else
				create log_file.make_create_read_write (fn)
			end
		end

	close_log
		do
			log_file.close
		end

	log_file: PLAIN_TEXT_FILE

	notify_log (msg: STRING)
		do
			log_file.put_string (msg)
			log_file.put_new_line
			if notify_actions /= Void then
				notify_actions.call ([msg])
			end
		end

	notify_actions: ACTION_SEQUENCE [TUPLE [STRING]]

end
