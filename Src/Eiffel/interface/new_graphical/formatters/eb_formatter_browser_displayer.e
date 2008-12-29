note
	description: "Formatter displayer which uses a grid browser to display result"
	author: ""
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FORMATTER_BROWSER_DISPLAYER

inherit
	EB_FORMATTER_DISPLAYER
		redefine
			set_refresher
		end

create
	make

feature{NONE} -- Initialization

	make (a_browser: like browser)
			-- Initialize Current with `a_browser'.
		require
			a_browser_attached: a_browser /= Void
		do
			set_browser (a_browser)
		end

feature -- Access

	browser: EB_CLASS_BROWSER_GRID_VIEW [ANY]
			-- Browser

	widget: EV_WIDGET
			-- Widget of Current displayer
		do
			Result := browser.widget
		end

feature -- Setting

	set_browser (a_browser: like browser)
			-- Set `browser' with `a_browser'.
		require
			a_browser_attached: a_browser /= Void
		do
			browser := a_browser
		ensure
			browser_set: browser = a_browser
		end

feature -- Setting

	set_refresher (a_refresher: PROCEDURE [ANY, TUPLE])
			-- Set `a_refresher' into Current, it serves as a refresher to be invoked to update Current displayer
		do
			browser.retrieve_data_actions.extend (a_refresher)
		end

feature {NONE} -- Recycle

	internal_recycle
			-- To be called when the button has became useless.
		do
			browser.retrieve_data_actions.wipe_out
			browser.recycle
			browser := Void
		end

invariant
	browser_attached: not is_recycled implies browser /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
