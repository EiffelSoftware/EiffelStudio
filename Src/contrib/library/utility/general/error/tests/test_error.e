note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_ERROR

inherit
	EQA_TEST_SET

feature -- Test routines

	test_error
		note
			testing:  "error"
		local
			h: ERROR_HANDLER
			cl: CELL [INTEGER]
		do
			create h.make
			h.add_custom_error (123, "abc", "abc error occurred")
			h.add_custom_error (456, "abc", "abc error occurred")
			assert ("has 2 errors", h.count = 2)
			h.reset
			assert ("reset then no error", h.count = 0)

			-- error_added_actions
			create cl.put (0)
			h.error_added_actions.extend (agent (i_e: ERROR; i_cl: CELL [INTEGER]) do i_cl.replace (i_cl.item + 1)  end(?, cl))
			h.add_custom_error (123, "abc", "abc error occurred")
			h.add_custom_error (456, "abc", "abc error occurred")
			assert ("has 2 errors, same as counted", h.count = 2 and h.count = cl.item)

		end

	test_propagation_2
		note
			testing:  "error"
		local
			h1, h2: ERROR_HANDLER
--			cl: CELL [INTEGER]
		do
			create h1.make_with_id ("h1")
			create h2.make_with_id ("h2")

			h1.add_propagation (h2)

			h1.add_custom_error (123, "abc", "abc error occurred")
			h1.add_custom_error (456, "def", "def error occurred")

			assert ("has 2 errors", h1.count = 2 and h2.count = h1.count)

			h2.add_custom_error (789, "ghi", "error occurred only for h2")
			assert ("h1 has 2 errors, h2 has 3 errors", h1.count = 2 and h2.count = h1.count + 1)

			h1.remove_all_errors
			assert ("remove all error from h1, and one remaining on h2", h1.count = 0 and h2.count = 1)
		end

	test_sync_2
		note
			testing:  "error"
		local
			h1, h2: ERROR_HANDLER
--			cl: CELL [INTEGER]
		do
			create h1.make
			create h2.make
			h1.add_synchronization (h2)

			h1.add_custom_error (123, "abc", "abc error occurred")
			h1.add_custom_error (456, "def", "def error occurred")

			assert ("has 2 errors", h1.count = 2 and h2.count = h1.count)

			h1.reset
			assert ("reset then no error", h1.count = 0 and h2.count = h1.count)

		end

	test_sync_3
		note
			testing:  "error"
		local
			h1, h2, h3: ERROR_HANDLER
--			cl: CELL [INTEGER]
		do
			create h1.make
			create h2.make
			create h3.make

			h1.add_synchronization (h2)
			h2.add_synchronization (h3)

			h1.add_custom_error (123, "abc", "abc error occurred")
			h1.add_custom_error (456, "abc", "abc error occurred")

			assert ("has 2 errors", h1.count = 2 and h2.count = h1.count and h3.count = h2.count)

			h1.reset
			assert ("reset then no error", h1.count = 0 and h2.count = h1.count and h3.count = h2.count)

		end

	test_sync_3_with_cycle
		note
			testing:  "error"
		local
			h1, h2, h3: ERROR_HANDLER
--			cl: CELL [INTEGER]
		do
			create h1.make
			create h2.make
			create h3.make

			h1.add_synchronization (h2)
			h2.add_synchronization (h3)
			h3.add_synchronization (h1)

			h1.add_custom_error (123, "abc", "abc error occurred")
			h1.add_custom_error (456, "abc", "abc error occurred")

			assert ("has 2 errors", h1.count = 2 and h2.count = h1.count and h3.count = h2.count)

			h1.reset
			assert ("reset then no error", h1.count = 0 and h2.count = h1.count and h3.count = h2.count)

		end

	test_tree_propag
			--| Testing tree propagation
			--|
			--|          |-----> batch ..........
			--|          |                      :
			--| db ---> core ---> app ----> ui  :
			--|  :       :         :        :   :
			--|  :.......:.........:........:...:.....> logger
			--|
		note
			testing:  "error"
		local
			hdb, hcore, happ, hui, hlog, hbat: ERROR_HANDLER
		do
			create hdb.make_with_id ("db")
			create hcore.make_with_id ("core")
			create happ.make_with_id ("app")
			create hui.make_with_id ("ui")
			create hlog.make_with_id ("logger")
			create hbat.make_with_id ("batch")

			hdb.add_propagation (hcore)
			hcore.add_propagation (happ)
			hcore.add_propagation (hbat)
			happ.add_propagation (hui)

			hdb.add_propagation (hlog)
			hcore.add_propagation (hlog)
			happ.add_propagation (hlog)
			hui.add_propagation (hlog)
			hbat.add_propagation (hlog)

			hdb.add_custom_error (1, "db", "database connection error")
			hdb.add_custom_error (2, "db", "database query error")
			assert ("2 errors", hdb.count = 2 and hcore.count = 2 and happ.count = 2 and hui.count = 2 and hlog.count = 2)
			hcore.add_custom_error (11, "core", "core error")
			assert ("3 errors", hdb.count = 2 and hcore.count = 3 and happ.count = 3 and hui.count = 3 and hlog.count = 3)
			happ.add_custom_error (101, "app", "app issue")
			assert ("2 errors", hdb.count = 2 and hcore.count = 3 and happ.count = 4 and hui.count = 4 and hlog.count = 4)
			hui.add_custom_error (1001, "ui", "user interface trouble")
			assert ("2 errors", hdb.count = 2 and hcore.count = 3 and happ.count = 4 and hui.count = 5 and hlog.count = 5)

			assert ("hbat", hbat.count = 3 and hlog.count = 5)
			hbat.add_custom_error (10001, "bat", "Batch issue")
			assert ("2 errors", hdb.count = 2 and hcore.count = 3 and happ.count = 4 and hui.count = 5 and hbat.count = 4 and hlog.count = 6)
			hbat.remove_all_errors
			assert ("2 errors", hdb.count = 2 and hcore.count = 3 and happ.count = 4 and hui.count = 5 and hbat.count = 0 and hlog.count = 2)

			hui.remove_all_errors
			assert ("2 errors", hdb.count = 2 and hcore.count = 3 and happ.count = 4 and hui.count = 0 and hlog.count = 0)

			hdb.reset
			assert ("no more errors", hdb.count = 0 and hcore.count = 3 and happ.count = 4 and hui.count = 0 and hlog.count = 0)

		end

	test_remove_sync
		note
			testing:  "error"
		local
			h1, h2, h3: ERROR_HANDLER
--			cl: CELL [INTEGER]
		do
			create h1.make
			create h2.make
			create h3.make

			h1.add_synchronization (h2)
			h2.add_synchronization (h3)
			h3.add_synchronization (h1)

			h1.add_custom_error (123, "abc", "abc error occurred")
			h1.add_custom_error (456, "def", "def error occurred")

			assert ("has 2 errors", h1.count = 2 and h2.count = h1.count and h3.count = h2.count)

			h2.remove_synchronization (h3)
			h2.remove_synchronization (h1)

			h1.add_custom_error (789, "ghi", "ghi error occurred")
			assert ("correct count of errors", h1.count = 3 and h2.count = 2 and h3.count = h1.count)

			h1.reset
			assert ("reset then no error", h1.count = 0 and h2.count = 2 and h3.count = h1.count)
		end

	test_destroy
		note
			testing:  "error"
		local
			h1, h2, h3: ERROR_HANDLER
--			cl: CELL [INTEGER]
		do
			create h1.make_with_id ("h1")
			create h2.make_with_id ("h2")
			create h3.make_with_id ("h3")

			h1.add_synchronization (h2)
			h2.add_synchronization (h3)
			h3.add_synchronization (h1)

			h1.add_custom_error (123, "abc", "abc error occurred")
			h1.add_custom_error (456, "def", "def error occurred")

			assert ("has 2 errors", h1.count = 2 and h2.count = h1.count and h3.count = h2.count)

			h2.destroy

			h1.add_custom_error (789, "ghi", "ghi error occurred")
			assert ("correct count of errors", h1.count = 3 and h2.count = 0 and h3.count = h1.count)

			h1.reset
			assert ("reset then no error", h1.count = 0 and h2.count = h1.count and h3.count = h1.count)
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end


