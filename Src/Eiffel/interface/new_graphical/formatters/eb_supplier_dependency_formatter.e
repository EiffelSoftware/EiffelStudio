note
	description: "Client dependency formatter"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SUPPLIER_DEPENDENCY_FORMATTER

inherit
	EB_DEPENDENCY_FORMATTER

create
	make

feature -- Access

	symbol: ARRAY [EV_PIXMAP]
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (pixmaps.icon_pixmaps.class_supliers_icon, 1)
			Result.put (pixmaps.icon_pixmaps.class_supliers_icon, 2)
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Graphical representation of the command.
		once
			Result := pixmaps.icon_pixmaps.class_supliers_icon_buffer
		end

	menu_name: STRING_GENERAL
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showclients
		end

	capital_command_name: STRING_GENERAL
			-- Name of the command.
		do
			Result := Interface_names.l_suppliers
		end

	post_fix: STRING = "sup"
			-- String symbol of the command, used as an extension when saving.

feature -- Formatting

	format
			-- Refresh `widget' if `must_format' and `selected'.
		do
			if stone /= Void and then selected and then actual_veto_format_result then
				retrieve_sorting_order
				display_temp_header
				if not widget.is_displayed then
					widget.show
				end
				setup_viewpoint
				browser.prepare_for_supplier_view (name_of_stone (stone))
				generate_result
				display_header
			end
		end

feature{NONE} -- Implementation

	dependency_criterion (a_domain: QL_DOMAIN): QL_CLASS_CRITERION
			-- Criterion to filter dependency classes		
		do
			create {QL_CLASS_SUPPLIER_RELATION_CRI} Result.make (a_domain, browser.normal_referenced_button.is_selected, browser.syntactical_button.is_selected, False)
			if browser.inheritance_button.is_selected then
				Result := Result or (create {QL_CLASS_ANCESTOR_RELATION_CRI}.make (a_domain, {QL_CLASS_ANCESTOR_RELATION_CRI}.proper_ancestor_type))
			end
		end

note
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
