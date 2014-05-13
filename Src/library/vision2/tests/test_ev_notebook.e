note
	description: "Tests for EV_NOTEBOOK"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EV_NOTEBOOK

inherit
	EV_VISION2_TEST_SET

	EQA_TEST_SET

feature -- Test routines

	test_wipe_out
			-- After creating a few notebook tabs wipe out the whole notebook.
		note
			testing: "execution/isolated"
		local
			l_book: EV_NOTEBOOK
			l_button: EV_BUTTON
		do
				-- Select the first one and wipe out.
			create l_book
			create l_button.make_with_text ("TEST")
			l_book.extend (l_button)
			l_book.extend (create {EV_BUTTON})
			l_book.extend (create {EV_BUTTON})
			l_book.select_item (l_button)
			l_book.wipe_out

				-- Select the last one and wipe out.
			create l_book
			l_book.extend (create {EV_BUTTON})
			l_book.extend (create {EV_BUTTON})
			create l_button.make_with_text ("TEST")
			l_book.extend (l_button)
			l_book.select_item (l_button)
			l_book.wipe_out
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
