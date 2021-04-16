note
	description: "Dependency view panel"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_DEPENDENCY_TOOL_PANEL

inherit
	ES_FORMATTER_TOOL_PANEL_BASE
		rename
			last_stone as stone
		redefine
			close
		end

create
	make

feature -- Access

	predefined_formatters: like formatters
			-- Predefined formatters
		do
			Result := develop_window.managed_dependency_formatters
		end

	no_target_message: STRING_GENERAL
			-- Message to be displayed in `output_line' when no stone is set
		do
			Result := interface_names.l_no_info_of_element
		end

feature -- Status report

	is_stone_equal (a_stone, b_stone: STONE): BOOLEAN
			-- Is `a_stone' equal to `b_stone'?
		require
			a_stone_attached: a_stone /= Void
			b_stone_attached: b_stone /= Void
		do
			Result := a_stone.same_as (b_stone)
			if
				Result and then
				attached {CLUSTER_STONE} a_stone as l_a_cluster_stone and then
				attached {CLUSTER_STONE} b_stone as l_b_cluster_stone
			then
				Result := l_a_cluster_stone.path.same_string (l_b_cluster_stone.path)
			end
		end

feature -- Status setting

	pop_default_formatter
			-- Pop the default class formatter.
		local
			real_index: INTEGER
		do
			real_index := 2
			(formatters [real_index]).execute
		end

	close
			-- Redefine
		do
			on_deselect
			Precursor {ES_FORMATTER_TOOL_PANEL_BASE}
		end

	set_stone (a_stone: detachable STONE)
			-- Send a stone to formatters.
		local
			l_stone: STONE
		do
				-- If `a_stone' is a feature stone, take the associated class.
			if attached {FEATURE_STONE} a_stone as fst and then fst.e_feature /= Void then
				create {CLASSC_STONE} l_stone.make (fst.e_feature.associated_class)

			elseif attached {CLASSI_STONE} a_stone as ist then
				if attached {CLASSC_STONE} a_stone as cst then
					update_viewpoints (cst.e_class)
					l_stone := cst
				end

	            	-- Update formatters.
				enable_dotnet_formatters (ist.is_dotnet_class)

			elseif attached {CLUSTER_STONE} a_stone or attached {TARGET_STONE} a_stone then
				l_stone := a_stone
			end

			if l_stone = Void or else stone = Void or else not is_stone_equal (l_stone, stone) then
					-- Set the stones.
				set_last_stone (l_stone)
				develop_window.tools.set_last_stone (stone)
			end

			if widget.is_displayed or else is_auto_hide or else develop_window.link_tools then
				force_last_stone
			end
		end

feature {NONE} -- Implementation

	decide_tool_to_display (a_st: STONE): EB_STONABLE_TOOL
			-- Decide which tool to display.
		do
			if attached {FEATURE_STONE} a_st then
				develop_window.tools.show_default_tool_of_feature
				Result := develop_window.tools.default_feature_tool
			else
				show
				set_focus
				Result := Current
			end
		ensure
			Result_not_void: Result /= Void
		end

	drop_stone (st: detachable STONE)
			-- Set `st' in the stone manager and pop up the feature view if it is a feature stone.
		local
			l_tool: EB_STONABLE_TOOL
		do
			l_tool := decide_tool_to_display (st)
			if develop_window.is_unified_stone then
				develop_window.set_stone (st)
			elseif develop_window.link_tools then
				develop_window.tools.set_stone (st)
			else
				l_tool.set_stone (st)
			end
			if attached {FEATURE_STONE} st and then address_manager /= Void then
				address_manager.hide_address_bar
			end
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
