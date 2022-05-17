note
	description: "Summary description for {SCM_TEXT}."
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_TEXT

inherit
	EV_TEXT
		redefine
			create_interface_objects,
			initialize,
			set_font
		end

	IDE_OBSERVER
		undefine
			default_create, copy
		redefine
			on_zoom
		end

	EB_RECYCLABLE
		undefine
			default_create, copy
		end

feature {NONE} -- Initialization

	create_interface_objects
		do
			Precursor
		end

	initialize
		do
			Precursor
			set_font (create {EV_FONT})
			register_as_ide_observer

			on_zoom (zoom_factor)
		end

feature {IDE_S} -- Event handlers

	base_font: detachable EV_FONT

	on_zoom (a_zoom_factor: INTEGER)
		local
			ft: EV_FONT
		do
			if attached base_font as bft then
				ft := font
				ft.set_height (bft.height + a_zoom_factor)
				set_font (ft)
			end
		end

feature -- Element change

	set_font (a_font: EV_FONT)
		do
			if base_font = Void then
				base_font := a_font.twin
			end
			Precursor (a_font)
		end

feature {NONE} -- Internal memory management

	internal_recycle
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			unregister_as_ide_observer
		end

invariant

note
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
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
