note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEST_SVN

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create {SVN_ENGINE} svn.make_with_executable_path ("C:\apps\dev\SlikSvn\bin\svn.exe")

			test_working_copy
			test_remote
		end

	test_working_copy
		local
			g: UUID_GENERATOR
			id: STRING
			rn: STRING_32
			res: SVN_RESULT
			d: DIRECTORY
			p,r,wc: PATH
			f: PLAIN_TEXT_FILE
			sh: SHARED_PROCESS_MISC
		do
			create g
			id := g.generate_uuid.out

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
				res := svn.checkout (rn, wc.name, Void, Void)

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
									if res.failed then
										if attached res.message as msg then
											print (msg)
											print ("%N")
										end
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
				d.recursive_delete
			end
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
		do
			if attached svn.statuses ("c:\_dev\trunk\Src\scripts", True, False, False, Void) as lst then
				from
					lst.start
				until
					lst.after
				loop
					display_status (lst.item_for_iteration)
					lst.forth
				end
			end
		end

	test_logs
		local
			rev: like svn.logs.item_for_iteration
		do
			if attached svn.logs ("https://svn.eiffel.com/eiffelstudio/trunk", True, Void, Void, 10, Void) as lst then
				from
					lst.start
				until
					lst.after
				loop
					rev := lst.item_for_iteration
					display_revision (rev)
					lst.forth
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
					from
						l_logs.start
					until
						l_logs.after
					loop
						store_rev (l_logs.item)
						l_logs.forth
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
					d.lastentry = Void
				loop
					if
						attached d.last_entry_32 as s and then
						s.is_integer
					then
						Result := Result.max (s.to_integer)
					end
					d.readentry
				end
				d.close
			end
		end

	store_rev (r: SVN_REVISION_INFO)
		local
			fn: PATH
			d: DIRECTORY
			f: RAW_FILE
		do
			create d.make ("logs.db")
			if not d.exists then
				d.recursive_create_dir
			end
			fn := d.path.extended (r.revision.out)
			create f.make_with_path (fn)
			if not f.exists then
				f.create_read_write
				f.put_string ("revision=" + r.revision.out + "%N")
				f.put_string ("date=" + r.date + "%N")
				f.put_string ("author=" + r.author + "%N")
				f.put_string ("parent=" + r.common_parent_path + "%N")
				if attached r.paths as l_paths and then not l_paths.is_empty then
					from
						l_paths.start
					until
						l_paths.after
					loop
						f.put_string ("path[]=" + l_paths.item.path + "%N")
						l_paths.forth
					end
				end
				f.put_string ("message=" + r.log_message + "%N")
				f.close
				print ("Log for rev#" + r.revision.out + " stored%N")
			else
				print ("Log for rev#" + r.revision.out + " already fetched%N")
			end
		end

feature -- Status

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

				from
					lst.start
				until
					lst.after
				loop
					if attached lst.item_for_iteration as p_data then
						print ("%T[" + p_data.action + "] <" + r.kind_to_string (p_data.kind) + "> " + p_data.path + "%N")
					end
					lst.forth
				end
			end
			print ("%N")
		end

feature -- Change

end
