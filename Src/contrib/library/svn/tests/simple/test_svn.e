note
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SVN

inherit
	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			if {PLATFORM}.is_windows then
				create {SVN_ENGINE} svn.make_with_executable_path ("C:\apps\dev\SlikSvn\bin\svn.exe")
			else
				create {SVN_ENGINE} svn.make_with_executable_path ("/usr/bin/svn")
			end


			test_working_copy
			test_remote
		end

	test_working_copy
		local
			id: STRING
			rn: STRING_32
			res: SVN_RESULT
			d: DIRECTORY
			p,r,wc: PATH
			f: PLAIN_TEXT_FILE
			sh: SHARED_PROCESS_MISC
		do
			id := {UUID_GENERATOR}.generate_uuid.out

			create p.make_current
			p := p.extended ("test-" + id)
			create d.make_with_path (p)
			d.recursive_create_dir
			r := p.extended ("repo")
			rn := r.absolute_path.canonical_path.name
			if {PLATFORM}.is_windows then
				rn.replace_substring_all ("\", "/")
			end
			rn.prepend ("file:///")

			create sh
			if
				attached sh.process_misc.output_of_command ({STRING_32} "svnadmin create " + r.name, Void) as l_admin_res and then
				l_admin_res.exit_code = 0
			then
				wc := p.extended ("wc")
				svn.checkout (rn, wc.name, Void, Void).do_nothing

				create d.make_with_path (wc.extended ("dir"))
				d.recursive_create_dir

				create f.make_with_path (d.path.extended ("test.txt"))
				f.create_read_write
				f.put_string ("Hello, this is a test for svn lib%N")
				f.close

				res := svn.add (d.path.name, Void)
				if res.failed then
					if attached res.message as msg then
						print (msg)
						print ("%N")
					end
				else
					res := svn.move (f.path.name, d.path.extended ("new_test.txt").name, Void)
					if res.failed then
						if attached res.message as msg then
							print (msg)
							print ("%N")
						end
					else
						create f.make_with_path (d.path.extended ("new_test.txt"))
						res := svn.commit (d.path.name, "new folder, and renamed", Void)
						if res.failed then
							if attached res.message as msg then
								print (msg)
								print ("%N")
							end
						else
							res := svn.update (wc.name, Void, Void)
							if res.failed then
								if attached res.message as msg then
									print (msg)
									print ("%N")
								end
							else
								res := svn.delete (f.path.name, Void)
								if res.failed then
									if attached res.message as msg then
										print (msg)
										print ("%N")
									end
								else
									res := svn.commit (wc.name, "delete file", Void)
									if
										res.failed and then
										attached res.message as msg
									then
										print (msg)
										print ("%N")
									end
								end
							end
						end
					end
				end
			end
			-- Cleanup
			create d.make_with_path (p)
			if d.exists then
				safe_delete (d)
			end
		end

	safe_delete (d: DIRECTORY)
		local
			retried: INTEGER
		do
			if retried <= 1 then
				d.recursive_delete
			end
		rescue
			retried := retried + 1
			execution_environment.sleep (100_000_000);
			retry
		end

	test_remote
		do
			test_statuses
			test_repository_info
			test_logs
			get_logs
		end

	svn: SVN

feature -- Test

	test_repository_info
		do
			if attached svn.repository_info ("https://svn.eiffel.com/eiffelstudio/trunk", Void) as info then
				display_repository_info (info)
			end
		end

	test_statuses
		local
			l_src: READABLE_STRING_GENERAL
		do
			if attached execution_environment.item ("EIFFEL_SRC") as env_src then
				l_src := env_src
			else
				l_src := execution_environment.current_working_path.name
			end
			if attached svn.statuses (l_src, True, False, False, Void) as lst then
				across
					lst as l
				loop
					display_status (l.item)
				end
			end
		end

	test_logs
		do
			if attached svn.logs ("https://svn.eiffel.com/eiffelstudio/trunk", True, Void, Void, 10, Void) as lst then
				across
					lst as l
				loop
					display_revision (l.item)
				end
			end
		end

	get_logs
		local
			l_url: STRING
			l_head_rev: INTEGER
			l_last_fetched_rev: INTEGER
			l_logs: like svn.logs
		do
			l_url := "https://svn.eiffel.com/eiffelstudio/trunk"
			if attached svn.repository_info (l_url, Void) as repo_info then
				l_head_rev := repo_info.last_changed_rev
				l_last_fetched_rev := last_stored_rev
				if l_last_fetched_rev > 0 then
					l_logs := svn.logs (l_url, True, l_last_fetched_rev, l_head_rev, 10, Void)
				else
					l_logs := svn.logs (l_url, True, 0, 0, 100, Void)
				end
				if l_logs /= Void then
					across
						l_logs as l
					loop
						store_rev (l.item)
					end
				end
			end
		end

	last_stored_rev: INTEGER
		local
			d: DIRECTORY
		do
			create d.make ("logs.db")
			if d.exists then
				d.open_read
				from
					d.start
					d.readentry
				until
					not attached d.last_entry_32 as s
				loop
					if s.is_integer then
						Result := Result.max (s.to_integer)
					end
					d.readentry
				end
				d.close
			end
		end

	store_rev (r: SVN_REVISION_INFO)
		local
			d: DIRECTORY
			f: RAW_FILE
		do
			create d.make ("logs.db")
			if not d.exists then
				d.recursive_create_dir
			end
			create f.make_with_path (d.path.extended (r.revision.out))
			if not f.exists then
				f.create_read_write
				f.put_string ("revision=" + r.revision.out + "%N")
				f.put_string ("date=" + r.date + "%N")
				f.put_string ("author=" + r.author + "%N")
				f.put_string ("parent=" + r.common_parent_path + "%N")
				if attached r.paths as l_paths and then not l_paths.is_empty then
					across
						l_paths as p
					loop
						f.put_string ("path[]=" + p.item.path + "%N")
					end
				end
				f.put_string ("message=" + r.log_message + "%N")
				f.close
				print ("Log for rev#" + r.revision.out + " stored%N")
			else
				print ("Log for rev#" + r.revision.out + " already fetched%N")
			end
		end

feature -- Access

	display_status (s: SVN_STATUS_INFO)
		do
			print ("[" + s.wc_status + "] " + s.display_path + ": " + s.wc_revision.out + "%N")
		end

	display_repository_info (info: SVN_REPOSITORY_INFO)
		do
			if attached info.url as l_url then
				print ("[" + l_url + "] ")
			else
				print ("[...] ")
			end
			print (info.last_changed_rev.out + " out of " + info.revision.out + "%N")
		end

	display_revision (r: SVN_REVISION_INFO)
		do
			print ("[" + r.revision.out + "] " + r.author + ": ")
			if attached r.log_message as log then
				if log.has ('%N') then
					print ("%N" + log)
				else
					print (log)
				end
			end
			if attached r.paths as lst then
				if lst.count > 0 then
					print ("%N%TCommon dir=" + r.common_parent_path)
					print ("%N")
				end

				across
					lst as l
				loop
					if attached l.item as p_data then
						print ("%T[" + p_data.action + "] <" + r.kind_to_string (p_data.kind) + "> " + p_data.path + "%N")
					end
				end
			end
			print ("%N")
		end

end
