indexing
	description: "Objects that display the widget structure built by the user."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_DISPLAY_WINDOW

inherit

	EV_DIALOG
		redefine
			initialize
		end

	GB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		undefine
			default_create, copy
		end

	GB_ICONABLE_TOOL
		undefine
			default_create, copy
		end

create
	make_with_components

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			default_create
		ensure
			components_set: components = a_components
		end

feature -- Initialization

	initialize is
			-- Initalize `Current'.
		do
			Precursor {EV_DIALOG}
			set_title (gb_display_window_title)
			if components /= Void then
					-- We protect against `components' being Void for the special case where we create `Current'
					-- from DEFAULT_OBJECT_STATE_CHECKER `default_object_by_type'. In this case the feature returns an
					-- on object of type EV_ANY and so it is not possible to directly call `set_components' after
					-- calling `default_create'. We do not need `components' in this case as the only use for
					-- `Current' in that case is to query some of the default properties.
				fake_cancel_button (Current, agent (components.commands.show_hide_display_window_command).execute)
			end
			set_icon_pixmap (icon)
		end

feature -- Access

	icon: EV_PIXMAP is
			-- Icon displayed in title of `Current'.
		once
			Result := (create {GB_SHARED_PIXMAPS}).Icon_display_window @ 1
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class GB_DISPLAY_WINDOW
