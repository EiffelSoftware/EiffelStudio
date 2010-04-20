note
	description: "[
		Objects describing the appearance and available pages in a test wizard and is .
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_WIZARD_COMPOSITION

inherit
	CHAIN [ES_TEST_WIZARD_PAGE]
		redefine
			replaceable,
			writable
		end

	SHARED_LOCALE

create
	make

feature {NONE} -- Initialization

	make (a_title: like title; a_pages: ARRAY [like item])
			-- Initialize `Current'.
			--
			-- `a_title': Title describing wizard page composition.
			-- `a_pages': Pages to be displayed in composition.
		require
			a_title_not_empty: not a_title.is_empty
			a_pages_not_empty: not a_pages.is_empty
		do
			title := a_title
			create pages.make_from_array (a_pages)
		ensure
			title_set: title ~ a_title
			-- `pages' has same items as `a_pages'
		end

feature -- Access

	title: STRING_32
			-- Title describing wizard page composition

	launch_text: STRING_32
			-- Text for launching session
		do
			Result := locale.translation (default_launch_text)
		end

	window: ES_TEST_WIZARD
			-- Window displaying `Current'
		require
			is_attached: is_attached_to_window
		local
			l_window: like internal_window
		do
			l_window := internal_window
			check l_window /= Void end
			Result := l_window
		ensure
			result_valid: Result = internal_window
		end

feature -- Access: Chain

	item: ES_TEST_WIZARD_PAGE
			-- <Precursor>
		do
			Result := pages.item
		end

	count: INTEGER
			-- <Precursor>
		do
			Result := pages.count
		ensure then
			correct_result: Result = pages.count
			result_positive: 0 < Result
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := pages.index
		end

	cursor: CURSOR
			-- <Precursor>
		do
			Result := pages.cursor
		end

feature {NONE} -- Access

	pages: ARRAYED_LIST [like item]
			-- Page list

	internal_window: detachable like window
			-- Internal storage for `window'

feature -- Status report

	are_pages_valid: BOOLEAN
			-- Are we able to launch a session with the current input?
		do
			Result := for_all (agent {ES_TEST_WIZARD_PAGE}.is_valid)
		end

	is_attached_to_window: BOOLEAN
			-- Is `Current' displayed by a wizard window?
		do
			Result := internal_window /= Void
		end

feature -- Status report: Chain

	after: BOOLEAN
			-- <Precursor>
		do
			Result := pages.after
		ensure then
			correct_result: Result = pages.after
		end

	before: BOOLEAN
			-- <Precursor>
		do
			Result := pages.before
		ensure then
			correct_result: Result = pages.after
		end

	writable, replaceable, extendible, prunable: BOOLEAN
			-- <Precursor>
		do
		end

	full: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

feature {ES_TEST_WIZARD} -- Status setting

	attach_to_window (a_window: like window)
			-- Attach `Current' to wizard window.
		require
			not_attached: not is_attached_to_window
		do
			internal_window := a_window
		ensure
			is_attached: is_attached_to_window
			window_set: window = a_window
		end

	detach_from_window (a_store: BOOLEAN)
			-- Detach `Current' from `window' and call corresponding action.
		require
			is_attached: is_attached_to_window
		do
			from
				start
			until
				after
			loop
				if item_for_iteration.is_panel_initialized then
					item_for_iteration.recycle_panel (a_store)
				end
				forth
			end
			internal_window := Void
		ensure
			not_attached: not is_attached_to_window
		end

	initialize_panel (an_index: INTEGER)
			-- Initialize page at position `an_index'.
		require
			an_index_valid: 1 <= an_index and an_index <= count
		do
			i_th (an_index).initialize_panel (Current)
		ensure
			page_initialized: i_th (an_index).is_panel_initialized
		end

	recycle_page (an_index: INTEGER; a_store: BOOLEAN)
			-- Recycle page at position `an_index'.
		require
			an_index_valid: 1 <= an_index and an_index <= count
		do
			i_th (an_index).recycle_panel (a_store)
		ensure
			page_recycled: not i_th (an_index).is_panel_initialized
		end

feature -- Status setting: Chain

	wipe_out
			-- <Precursor>
		do
			check not_allowed: False end
		end

feature -- Query

	valid_cursor (p: CURSOR): BOOLEAN
			-- <Precursor>
		do
			Result := pages.valid_cursor (p)
		ensure then
			correct_result: Result = pages.valid_cursor (p)
		end

feature -- Cursor movement

	forth
			-- <Precursor>
		do
			pages.forth
		end

	back
			-- <Precursor>
		do
			pages.back
		end

	go_to (p: CURSOR)
			-- <Precursor>
		do
			pages.go_to (p)
		end

feature -- Element change

	extend (v: ES_TEST_WIZARD_PAGE)
			-- <Precursor>
		do
		end

	replace (v: ES_TEST_WIZARD_PAGE)
			-- <Precursor>
		do
			check not_allowed: False end
		end

feature -- Basic operations

	on_valid_state_change
			-- Notify an attached `window` about a content update on one of the pages.
		do
			if is_attached_to_window then
				window.on_valid_state_change
			end
		end

feature -- Basic operations: Chain

	duplicate (n: INTEGER_32): like Current
			-- <Precursor>
		do
			create Result.make (title, pages.duplicate (n).to_array)
		end

feature {NONE} -- Internationalization

	default_launch_text: STRING = "Start"

invariant
	window_valid: is_attached_to_window implies not window.is_recycled

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
