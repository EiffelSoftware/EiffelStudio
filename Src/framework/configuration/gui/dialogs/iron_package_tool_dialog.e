note
	description: "Summary description for {IRON_PACKAGE_TOOL_DIALOG}."
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_PACKAGE_TOOL_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize
		end

	CONF_GUI_INTERFACE_CONSTANTS
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_iron_service: ES_IRON_SERVICE)
		require
			a_iron_service_set: a_iron_service /= Void
		do
			iron_service := a_iron_service
			create iron_box.make (a_iron_service)
			default_create
		end

	initialize
		local
			v: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			but: EV_BUTTON
		do
			Precursor

			create v
			v.set_padding_width (layout_constants.default_padding_size)
			v.set_border_width (layout_constants.large_border_size)

			extend (v)
			v.extend (iron_box.widget)

			create hb
			hb.set_padding_width (layout_constants.default_padding_size)

			v.extend (hb)
			v.disable_item_expand (hb)

			create but.make_with_text_and_action ("Close", agent on_close)
			layout_constants.set_default_size_for_button (but)
			hb.extend (create {EV_CELL})
			hb.extend (but)
			hb.disable_item_expand (but)

			set_icon_pixmap (conf_pixmaps.library_iron_package_icon)
			set_title ("IRON Packages manager")
			show_actions.extend_kamikaze (agent on_show)

			set_default_cancel_button (but)
			set_default_push_button (but)

			set_size (500, 400)
		end

	iron_service: ES_IRON_SERVICE

feature -- Access	

	iron_box: IRON_PACKAGE_COLLECTION_BOX

feature -- Events

	on_show
		do
			iron_box.populate
		end

	on_close
		do
			destroy
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
