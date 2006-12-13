indexing
	description: "Client dependency formatter"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLIENT_DEPENDENCY_FORMATTER

inherit
	EB_DEPENDENCY_FORMATTER

create
	make

feature -- Access

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (pixmaps.icon_pixmaps.class_clients_icon, 1)
			Result.put (pixmaps.icon_pixmaps.class_clients_icon, 2)
		end

	menu_name: STRING_GENERAL is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showclients
		end

	command_name: STRING_GENERAL is
			-- Name of the command.
		do
			Result := Interface_names.l_clients
		end

	post_fix: STRING is "cli"
			-- String symbol of the command, used as an extension when saving.


feature -- Formatting

	format is
			-- Refresh `widget' if `must_format' and `selected'.
		do
			if associated_stone /= Void and then selected and then displayed then
				display_temp_header
				if not widget.is_displayed then
					widget.show
				end
				setup_viewpoint
				browser.prepare_for_client_view (name_of_stone (associated_stone))
				generate_result
				display_header
			end
		end

feature{NONE} -- Implementation

	dependency_criterion (a_domain: QL_DOMAIN): QL_CLASS_CRITERION is
			-- Criterion to filter dependency classes		
		do
			create {QL_CLASS_CLIENT_RELATION_CRI} Result.make (a_domain, browser.syntactical_button.is_selected, False)
			if browser.inheritance_button.is_selected then
				Result := Result or (create {QL_CLASS_DESCENDANT_RELATION_CRI}.make (a_domain, {QL_CLASS_DESCENDANT_RELATION_CRI}.proper_descendant_type))
			end
		end

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
