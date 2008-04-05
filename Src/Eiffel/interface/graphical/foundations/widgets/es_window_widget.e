indexing
	description: "[
		A foundation widget that provides access to the host development window.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_WINDOW_WIDGET [G -> EV_WIDGET]

inherit
	ES_WIDGET [G]
		rename
			make as make_widget
		redefine
			internal_detach_entities
		end

feature {NONE} -- Initialization

	make (a_window: like develop_window)
			-- Initializes a foundation widget
		require
			a_window_attached: a_window /= Void
			a_window_is_interface_usable: a_window.is_interface_usable
		do
			develop_window := a_window
			make_widget
		ensure
			is_initialized: is_initialized
			is_initializing_unchanged: old is_initializing = is_initializing
		end

feature -- Clean up

	internal_detach_entities
			-- <Precursor>
		do
			Precursor
			develop_window := Void
		ensure then
			develop_window_detached: develop_window = Void
		end

feature -- Access

	develop_window: ?EB_DEVELOPMENT_WINDOW
			-- Access to the development window

invariant
	develop_window_attached: is_interface_usable implies develop_window /= Void

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
