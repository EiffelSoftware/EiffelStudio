indexing
	description: "[
		Tool descriptor for EiffelStudio's features tool.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

frozen class
	ES_FEATURES_TOOL

inherit
	ES_STONABLE_TOOL [ES_FEATURES_TOOL_PANEL]

	ES_FEATURES_TOOL_COMMANDER_I
		undefine
			out
		end

create {NONE}
	default_create

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- Tool icon
			-- Note: Do not call `tool.icon' as it will create the tool unnecessarly!
		do
			Result := stock_pixmaps.tool_features_icon_buffer
		end

	icon_pixmap: EV_PIXMAP
			-- Tool icon pixmap
			-- Note: Do not call `tool.icon' as it will create the tool unnecessarly!
		do
			Result := stock_pixmaps.tool_features_icon
		end

	title: STRING_32
			-- Tool title.
			-- Note: Do not call `tool.title' as it will create the tool unnecessarly!
		do
			Result := interface_names.t_features_tool
		end

feature -- Query

	is_stone_usable (a_stone: STONE): BOOLEAN
			-- Determines if a stone can be used by Current.
			--
			-- `a_stone': Stone to determine usablity.
			-- `Result': True if the stone can be used, False otherwise.
		do
			Result := {l_stone: !CLASSI_STONE} a_stone or {l_cluster: !CLUSTER_STONE} a_stone
		end

feature -- Basic operations

	select_feature_item (a_feature: ?E_FEATURE)
			-- Selects a feature in the feature tree
			--
			-- `a_feature': The feature to select an assocated node in the feature tree.
		do
			if is_tool_instantiated then
				panel.select_feature_item (a_feature)
			end
		end

	select_feature_item_by_name (a_feature: !STRING_GENERAL)
			-- Selects a feature in the feature tree, using a string name
			--
			-- `a_feature': The name of a feature to select an assocated node in the feature tree.
		do
			if is_tool_instantiated then
				panel.select_feature_item_by_name (a_feature)
			end
		end

feature {NONE} -- Factory

	create_tool: ES_FEATURES_TOOL_PANEL
			-- Creates the tool for first use on the development `window'
		do
			create Result.make (window, Current)
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
