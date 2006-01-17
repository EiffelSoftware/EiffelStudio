indexing
	description: "Common functionality for all views of ES_CLIENT_SUPPLIER_LINKs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_CLIENT_SUPPLIER_FIGURE

inherit
	EIFFEL_LINK_FIGURE
		redefine
			default_create,
			initialize,
			model,
			recycle
		end

create
	default_create

create {EIFFEL_CLIENT_SUPPLIER_FIGURE}
	make_filled

feature {NONE} -- Initialization

	default_create is
			-- Create an EIFFEL_CLIENT_SUPPLIER_LINK
		do
			Precursor {EIFFEL_LINK_FIGURE}
			create {CLIENT_STONE} pebble.make (Current)
			set_accept_cursor (cursors.cur_client_link)
			set_deny_cursor (cursors.cur_x_client_link)
		end

	initialize is
			-- Initialize `Current' with `model'.
		do
			Precursor {EIFFEL_LINK_FIGURE}
			model.needed_on_diagram_changed_actions.extend (agent on_needed_on_diagram_changed)
		end

feature -- Access

	model: ES_CLIENT_SUPPLIER_LINK
			-- The model for `Current'.

	feature_names: ARRAYED_LIST [STRING] is
			-- List of names of all features.
		local
			l_features: LIST [FEATURE_AS]
		do
			l_features := model.features
			create Result.make (l_features.count)
			from
				l_features.start
			until
				l_features.after
			loop
				Result.extend (l_features.item.feature_name)
				l_features.forth
			end
		ensure
			Result_not_void: Result /= Void
		end

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
				if world.is_client_supplier_links_shown then
					show
					enable_sensitive
				end
			else
				hide
				disable_sensitive
			end
			request_update
		end

	e_feature_from_abstract (a_feature: FEATURE_AS): E_FEATURE is
			-- compiled version of `a_feature' if any.
		require
			a_feature_exists: a_feature /= Void
		local
			l_class: CLASS_C
		do
			l_class := model.client.class_c
			if l_class /= Void then
				Result := l_class.feature_with_name (a_feature.feature_name)
			end
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

end -- class EIFFEL_CLIENT_SUPPLIER_FIGURE
