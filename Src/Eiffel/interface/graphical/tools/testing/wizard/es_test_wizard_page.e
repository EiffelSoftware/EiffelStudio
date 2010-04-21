note
	description: "[
		Objects representing a page within some test wizard.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TEST_WIZARD_PAGE

inherit
	SHARED_LOCALE

feature -- Access

	title: STRING_32
			-- Title for `Current'
		deferred
		ensure
			not_empty: not Result.is_empty
		end

	frozen panel: like new_panel
			-- Panel containing widgets
		require
			initialized: is_panel_initialized
		local
			l_panel: like panel_cache
		do
			l_panel := panel_cache
			check l_panel /= Void end
			Result := l_panel
		ensure
			result_equals_cache: Result = panel_cache
		end

feature {NONE} -- Access

	panel_cache: detachable like panel
			-- Cache for `panel'
			--
			-- Note: do not access directly, use `panel' instead.

feature -- Status report

	frozen is_panel_initialized: BOOLEAN
			-- Has `panel' been accessed yet?
		do
			Result := panel_cache /= Void
		end

	is_valid: BOOLEAN
			-- Is the content entered by the user in `Current' valid?
		do
			if attached panel_cache as l_panel then
				Result := l_panel.is_valid
			else
				Result := True
			end
		end

feature {ES_TEST_WIZARD_COMPOSITION} -- Status setting

	initialize_panel (a_composition: ES_TEST_WIZARD_COMPOSITION)
			-- Initialize `panel'.
		require
			not_initialized: not is_panel_initialized
		do
			panel_cache := new_panel (a_composition)
		ensure
			initialized: is_panel_initialized
			initialized_with_composition: panel.composition = a_composition
		end

	frozen recycle_panel (a_store: BOOLEAN)
			-- Recyle `panel'.
		do
			if attached panel_cache as l_panel then
				if a_store and l_panel.is_valid then
					l_panel.store
				end
				l_panel.recycle
				panel_cache := l_panel.default
			end
		ensure
			not_initialized: not is_panel_initialized
		end

feature {NONE} -- Factory

	new_panel (a_composition: ES_TEST_WIZARD_COMPOSITION): ES_TEST_WIZARD_PAGE_PANEL
			-- Create new panel.
		deferred
		ensure
			result_uses_composition: Result.composition = a_composition
		end

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
