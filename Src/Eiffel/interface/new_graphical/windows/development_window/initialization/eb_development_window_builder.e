indexing
	description: "Builder for EB_DEVELOPMENT_WINDOW"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_DEVELOPMENT_WINDOW_BUILDER

inherit
	EB_RECYCLABLE
		redefine
			internal_detach_entities
		end

-- inherit {NONE}
	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature{NONE} -- Initlization

	make (a_window: EB_DEVELOPMENT_WINDOW) is
			-- Creation method
		require
			not_void: a_window /= Void
		do
			develop_window := a_window

				-- Forces current to be recycled by the development window.
			a_window.auto_recycle (Current)
		ensure
			set: develop_window = a_window
		end

feature {NONE} -- Clean up

	internal_recycle is
			-- To be called when the button has became useless.
		do
			develop_window := Void
		end

	internal_detach_entities is
			-- Detaches objects from their container
		do
			develop_window := Void
			Precursor {EB_RECYCLABLE}
		ensure then
			develop_window_detached: develop_window = Void
		end

feature {NONE} -- Implementation

	develop_window: EB_DEVELOPMENT_WINDOW
			-- Development window associate with.

invariant
	not_void: develop_window /= Void

indexing
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
