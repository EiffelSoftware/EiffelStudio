indexing
	description: "Common functionalities for all views of ES_INHERITANCE_LINKs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_INHERITANCE_FIGURE

inherit
	EIFFEL_LINK_FIGURE
		rename
			source as descendant,
			target as ancestor
		redefine
			default_create,
			initialize,
			model,
			recycle
		end

create
	default_create

create {EIFFEL_INHERITANCE_FIGURE}
	make_filled

feature {NONE} -- Initialization

	default_create is
			-- Create an inheritance figure.
		do
			Precursor {EIFFEL_LINK_FIGURE}
			create {INHERIT_STONE} pebble.make (Current)
			set_accept_cursor (cursors.cur_inherit_link)
			set_deny_cursor (cursors.cur_x_inherit_link)
		end

	initialize is
			-- Initialize `Current' with `model'.
		do
			Precursor {EIFFEL_LINK_FIGURE}
			model.needed_on_diagram_changed_actions.extend (agent on_needed_on_diagram_changed)
		end

feature -- Access

	model: ES_INHERITANCE_LINK
			-- Model for `Current'.

feature -- Element change

	recycle is
			-- Free `Current's resources.
		do
			Precursor {EIFFEL_LINK_FIGURE}
			if model /= Void then
				model.needed_on_diagram_changed_actions.prune_all (agent on_needed_on_diagram_changed)
			end
		end

feature {NONE} -- Implementation

	on_needed_on_diagram_changed is
			-- `model'.`is_needed_on_diagram' changed.
		do
			if model.is_needed_on_diagram then
				if world.is_inheritance_links_shown then
					show
					enable_sensitive
				end
			else
				hide
				disable_sensitive
			end
			request_update
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

end -- class EIFFEL_INHERITANCE_FIGURE
