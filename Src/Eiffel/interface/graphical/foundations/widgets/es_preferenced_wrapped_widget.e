note
	description: "[
		An EiffelVision2 wrapped ESF widget tied to a environment preferences.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_PREFERENCED_WRAPPED_WIDGET [G -> EV_WIDGET, P -> PREFERENCE, V -> ANY]

inherit
	ES_PREFERENCED_WIDGET [G, P, V]
		rename
			make as make_preferenced_widget
		end

convert
	widget: {EV_WIDGET, !G}

feature {NONE} -- Initialization

	frozen make (a_widget: !G; a_preference: !P)
			-- Initialize a widget based on a preference.
			--
			-- `a_widget'    : The widget to bind to the ESF widget.
			-- `a_preference': The preference object a widget is bound to.
		require
			not_a_widget_is_parented: not a_widget.has_parent
			not_a_widget_is_destroyed: not a_widget.is_destroyed
		do
			internal_widget := a_widget
			make_preferenced_widget (a_preference)
		ensure
			internal_widget_set: internal_widget = a_widget
			preference_set: a_preference = preference
			is_initialized: is_initialized
			is_initializing_unchanged: old is_initializing = is_initializing
		end

feature {NONE} -- User interface initialization

	build_widget_interface (a_widget: !G)
			-- <Precursor>
		do
		end

feature {NONE} -- Factory

	frozen create_widget: !G
			-- <Precursor>
		do
			Result := internal_widget
		ensure then
			result_is_internal_widget: Result = internal_widget
		end

feature {NONE} -- Implementation: Internal cache

	internal_widget: !G
			-- Cached version of `widget'.
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
