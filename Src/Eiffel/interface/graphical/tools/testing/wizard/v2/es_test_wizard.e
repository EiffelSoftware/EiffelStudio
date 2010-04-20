note
	description: "Summary description for {ES_TEST_WIZARD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TEST_WIZARD

inherit
	EV_LAYOUT_CONSTANTS

	EB_VISION2_FACILITIES

	EV_STOCK_COLORS

	SHARED_LOCALE

feature {NONE} -- Initialization

	make (a_composition: like composition; a_window: EV_WINDOW)
			-- Initialize `Current'.
			--
			-- `a_composition': Composition providing pages to `Current'.
			-- `a_window': Window in which `Current' should be shown.
		require
			a_composition_not_attached: not a_composition.is_attached_to_window
		do
			composition := a_composition
			initialize_dialog
			composition.attach_to_window (Current)

			load_page (1)
			dialog.show_modal_to_window (a_window)
		ensure
			recycled: is_recycled
		end

	initialize_dialog
			-- Initialize `dialog'.
		local
			l_dialog: like dialog
			l_vbox: EV_VERTICAL_BOX
		do
			create l_dialog.make_with_title (composition.title)
			l_dialog.set_size (dialog_unit_to_pixels(503), dialog_unit_to_pixels(500))
			create l_vbox
			l_dialog.extend (l_vbox)
			dialog := l_dialog

			create {EV_VERTICAL_BOX} page_container
			initialize_dialog_content (l_vbox)
		end

	initialize_dialog_content (a_vbox: EV_VERTICAL_BOX)
			-- Initialize content of `dialog'.
			--
			-- `a_vbox': Box in which content is placed.
		require
			page_container_unused: not page_container.has_parent
		deferred
		ensure
			page_container_parented: page_container.has_parent
		end

feature -- Access

	composition: ES_TEST_WIZARD_COMPOSITION
			-- Composition providing pages to `Current'

	dialog: EV_DIALOG
			-- Wizard window

feature {NONE} -- Access

	page_index: INTEGER
			-- Index of currently loaded wizard page

	page: ES_TEST_WIZARD_PAGE
			-- Page currently loaded
		do
			Result := composition.i_th (page_index)
		end

	page_container: EV_BOX
			-- Box which contains wizard page widget

feature -- Status report

	frozen is_recycled: BOOLEAN
			-- Has `Current' been recycled?
		do
			Result := dialog.is_destroyed
		end

feature {NONE} -- Query

	frozen is_valid_page_index (a_index: INTEGER): BOOLEAN
			-- Is `a_index' a valid value for `page_index'?
		do
			Result := 1 <= a_index and a_index <= composition.count
		ensure
			definition: Result = (1 <= a_index and a_index <= composition.count)
		end

feature -- Basic operations

	on_valid_state_change
			-- Called when content on one of the pages has been updated.
		do
		end

feature {NONE} -- Basic operations

	load_page (an_index: INTEGER)
			-- Load wizard page for given index.
		require
			an_index_valid: is_valid_page_index (an_index)
		local
			l_widget: EV_WIDGET
		do
			if page_index /= an_index then
					-- Move to requested page
				page_index := an_index

					-- Display widget of new page
				if not page.is_panel_initialized then
					composition.initialize_panel (page_index)
				end
				l_widget := page.panel.widget
				page_container.wipe_out
				page_container.extend (l_widget)

				on_valid_state_change
			end
		ensure
			page_loaded: page_index = an_index
		end

	close_wizard (a_store: BOOLEAN)
			-- Close `Current' and store entered data if `a_store' is True.
		do
			composition.detach_from_window (a_store)
			dialog.destroy
		end

invariant
	page_index_valid: is_valid_page_index (page_index)

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
