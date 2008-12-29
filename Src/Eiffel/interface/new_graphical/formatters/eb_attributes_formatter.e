note
	description: "Command to display class attributes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ATTRIBUTES_FORMATTER

inherit
	EB_CLASS_FEATURE_FORMATTER

create
	make

feature -- Properties

	symbol: ARRAY [EV_PIXMAP]
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (pixmaps.icon_pixmaps.class_features_attribute_icon, 1)
			Result.put (pixmaps.icon_pixmaps.class_features_attribute_icon, 2)
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Graphical representation of the command.
		once
			Result := pixmaps.icon_pixmaps.class_features_attribute_icon_buffer
		end

	menu_name: STRING_GENERAL
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showattributes
		end

feature {NONE} -- Properties

	capital_command_name: STRING_GENERAL
			-- Name of the command.
		do
			Result := Interface_names.l_Attributes
		end

	post_fix: STRING = "att"
			-- String symbol of the command, used as an extension when saving.
feature -- Access

	mode: NATURAL_8
			-- Formatter mode, see {ES_CLASS_TOOL_VIEW_MODES} for applicable values.
		do
			Result := {ES_CLASS_TOOL_VIEW_MODES}.attributes
		end

feature{NONE} -- Implementation

	criterion: QL_CRITERION
			-- Criterion of current formatter
		local
			l_factory: like feature_criterion_factory
		do
			l_factory := feature_criterion_factory
			Result := l_factory.simple_criterion_with_index (l_factory.c_is_attribute)
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

end -- class EB_ATTRIBUTES_FORMATTER
