indexing
	description: "Command to display the descendants of a class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DESCENDANTS_FORMATTER

inherit
	EB_CLASS_HIERARCHY_FORMATTER
		redefine
			is_tree_node_highlight_enabled,
			is_inheritance_formatter,
			browser
		end

	EB_CONSTANTS

create
	make

feature -- Properties

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (pixmaps.icon_pixmaps.class_descendents_icon, 1)
			Result.put (pixmaps.icon_pixmaps.class_descendents_icon, 2)
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Graphical representation of the command.
		once
			Result := pixmaps.icon_pixmaps.class_descendents_icon_buffer
		end

	class_cmd: E_SHOW_DESCENDANTS
			-- Class command that can generate the information.

	menu_name: STRING_GENERAL is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showdescendants
		end

	browser: EB_CLASS_BROWSER_TREE_VIEW
			-- Browser

	displayer_generator: TUPLE [any_generator: FUNCTION [ANY, TUPLE, like displayer]; name: STRING] is
			-- Generator to generate proper `displayer' for Current formatter
		do
			Result := [agent displayer_generators.new_class_tree_displayer, displayer_generators.class_tree_displayer]
		end

	sorting_status_preference: STRING_PREFERENCE is
			-- Preference to store last sorting orders of Current formatter
		do
			Result := preferences.class_browser_data.class_tree_view_sorting_order_preference
		end
feature -- Access

	mode: NATURAL_8
			-- Formatter mode, see {ES_CLASS_TOOL_VIEW_MODES} for applicable values.
		do
			Result := {ES_CLASS_TOOL_VIEW_MODES}.descendents
		end

feature -- Status report

	is_tree_node_highlight_enabled: BOOLEAN is True
			-- Is tree node highlight enabled?

	is_inheritance_formatter: BOOLEAN is True
			-- Is current a class inheritance (ancestor/descendant) formatter?

feature {NONE} -- Properties

	capital_command_name: STRING_GENERAL is
			-- Name of the command.
		do
			Result := Interface_names.l_Descendants
		end

	post_fix: STRING is "des"
			-- String symbol of the command, used as an extension when saving.

feature {NONE} -- Implementation

	start_class: QL_CLASS is
			-- Start class
		do
			check associated_class /= Void end
			Result := query_class_item_from_class_c (associated_class)
		ensure then
			result_attached: Result /= Void
		end

	criterion: QL_CRITERION is
			-- Criterion of current formatter
		local
			l_class: QL_CLASS
		do
			check associated_class /= Void end
			l_class := query_class_item_from_class_c (associated_class)
			create {QL_CLASS_DESCENDANT_RELATION_CRI}Result.make (l_class.wrapped_domain, {QL_CLASS_DESCENDANT_RELATION_CRI}.descendant_type)
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

end -- class EB_DESCENDANTS_FORMATTER
