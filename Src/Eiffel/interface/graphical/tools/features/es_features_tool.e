note
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
			-- <Precursor>
		do
			Result := stock_pixmaps.tool_features_icon_buffer
		end

	icon_pixmap: EV_PIXMAP
			-- <Precursor>
		do
			Result := stock_pixmaps.tool_features_icon
		end

	title: attached STRING_32
			-- <Precursor>
		do
			Result := locale_formatter.translation (t_tool_title)
		end

feature {NONE} -- Status report

	is_stone_usable_internal (a_stone: attached like stone): BOOLEAN
			-- <Precursor>
		do
			Result := (attached {CLASSI_STONE} a_stone as l_stone or attached {CLUSTER_STONE} a_stone as l_cluster)
		end

feature -- Basic operations

	select_feature_item (a_feature: detachable E_FEATURE)
			-- <Precursor>
		do
			if is_tool_instantiated then
				panel.select_feature_item (a_feature)
			end
		end

	select_feature_item_by_name (a_feature: attached STRING_GENERAL)
			-- <Precursor>
		do
			if is_tool_instantiated then
				panel.select_feature_item_by_name (a_feature)
			end
		end

feature {NONE} -- Factory

	new_tool: attached ES_FEATURES_TOOL_PANEL
			-- <Precursor>
		do
			create Result.make (window, Current)
		end

feature {NONE} -- Internationalization

	t_tool_title: STRING = "Features"

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
