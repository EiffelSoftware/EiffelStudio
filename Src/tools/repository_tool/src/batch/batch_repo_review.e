note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	BATCH_REPO_REVIEW

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			cat: like catalog
			d: REPOSITORY_DATA
			rf: RAW_FILE
			svn_repo: REPOSITORY_SVN
		do
			create rf.make ("catalog.db")
			if rf.exists then
				rf.open_read
				cat ?= rf.retrieved
				rf.close
			end
			if cat = Void then
				create cat.make
				create svn_repo.make_with_location ("https://svn.eiffel.com/eiffelstudio/trunk")
				cat.add_repository ("EiffelStudio/trunk", svn_repo)

				create svn_repo.make_with_location ("https://svn.eiffel.com/eiffelstudio/branches/Eiffel_66")
				cat.add_repository ("EiffelStudio/66", svn_repo)
				catalog := cat
			end

			across cat.repositories as c loop
				if attached {REPOSITORY_SVN} c.item as rsvn then
					create {REPOSITORY_SVN_DATA} d.make (rsvn.uuid, rsvn)
					d.get_logs
				end
			end

			rf.create_read_write
			rf.independent_store (cat)
			rf.close
		end

	catalog: detachable REPOSITORY_CATALOG

feature -- Access

--	display_status (s: SVN_STATUS_INFO)
--		do
--			print ("[" + s.wc_status + "] " + s.display_path + ": " + s.wc_revision.out + "%N")
--		end

--	display_repository_info (info: SVN_REPOSITORY_INFO)
--		do
--			if attached info.url as l_url then
--				print ("[" + l_url + "] ")
--			else
--				print ("[ ] ")
--			end
--			print (info.last_changed_rev.out + " out of " + info.revision.out + "%N")
--		end

--	display_revision (r: SVN_REVISION_INFO)
--		do
--			print ("[" + r.revision.out + "] " + r.author + ": ")
--			if attached r.log_message as log then
--				if log.has ('%N') then
--					print ("%N" + log)
--				else
--					print (log)
--				end
--			end
--			if attached r.paths as lst then
--				if lst.count > 0 then
--					print ("%N%TCommon dir=" + r.common_parent_path)
--					print ("%N")
--				end

--				from
--					lst.start
--				until
--					lst.after
--				loop
--					if attached lst.item_for_iteration as p_data then
--						print ("%T[" + p_data.action + "] <" + r.kind_to_string (p_data.kind) + "> " + p_data.path + "%N")
--					end
--					lst.forth
--				end
--			end
--			print ("%N")
--		end

end
