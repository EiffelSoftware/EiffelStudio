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
			h1.add_custom_error (456, "abc", "abc error occurred")

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
			create h1.make
			create h2.make
			create h3.make

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


