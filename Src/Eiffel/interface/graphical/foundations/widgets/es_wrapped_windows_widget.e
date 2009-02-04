note
	description: "[
			An ESF wrapper for EiffelVision2 widgets ({ES_WIDGET}), needing access to a host shell window.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_WRAPPED_WINDOWS_WIDGET [G -> EV_WIDGET]

inherit
	ES_WINDOW_WIDGET [G]
		rename
			make as make_window_widget
		end

create
	make

feature {NONE} -- Initialization

	make (a_widget: !like widget; a_window: !like develop_window)
			-- Initializes a standard window widget.
			--
			-- `a_widget': The source EiffelVision2 widget to wrap.
			-- `a_window': Host window on which the widget will be displayed.
		require
			not_a_widget_is_destroyed: not a_widget.is_destroyed
			not_a_widget_has_parent: a_widget.parent = Void
			a_window_is_interface_usable: a_window.is_interface_usable
		do
			internal_widget := a_widget
			make_window_widget (a_window)
		ensure
			widget_set: widget = a_widget
			develop_window_set: develop_window = a_window
		end

	build_widget_interface (a_widget: !G)
			-- <Precursor>
		do
		end

feature {NONE} -- Factory

	create_widget: !G
			-- <Precursor>
		do
			Result := internal_widget
		end

feature {NONE} -- Implementation: Internal cache

	internal_widget: !G
			-- Cached version of `widget', used only for fake creation.
			-- Note: Do not use directly!

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
