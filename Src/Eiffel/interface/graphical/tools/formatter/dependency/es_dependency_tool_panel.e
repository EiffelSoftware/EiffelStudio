indexing
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
			close,
			build_docking_content
		end

create
	make

feature {NONE} -- Initialization

	build_docking_content (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Build docking content.
		do
			Precursor (a_docking_manager)
			content.drop_actions.extend (agent on_item_dropped)
		end

feature -- Access

	predefined_formatters: like formatters is
			-- Predefined formatters
		do
			Result := develop_window.managed_dependency_formatters
		end

	no_target_message: STRING_GENERAL is
			-- Message to be displayed in `output_line' when no stone is set
		do
			Result := interface_names.l_no_info_of_element
		end

feature -- Status report

	is_stone_equal (a_stone, b_stone: STONE): BOOLEAN is
			-- Is `a_stone' equal to `b_stone'?
		require
			a_stone_attached: a_stone /= Void
			b_stone_attached: b_stone /= Void
		local
			l_a_cluster_stone: CLUSTER_STONE
			l_b_cluster_stone: CLUSTER_STONE
			l_a_path: STRING
			l_b_path: STRING
		do
			Result := a_stone.same_as (b_stone)
			if Result then
				l_a_cluster_stone ?= a_stone
				if l_a_cluster_stone /= Void then
					l_b_cluster_stone ?= b_stone
					l_a_path := l_a_cluster_stone.path
					l_b_path := l_b_cluster_stone.path
					Result := equal (l_a_path, l_b_path)
				end
			end
		end

feature -- Status setting

	pop_default_formatter is
			-- Pop the default class formatter.
		local
			real_index: INTEGER
		do
			real_index := 2
			(formatters @ real_index).execute
		end

	close is
			-- Redefine
		do
			on_deselect
			Precursor {ES_FORMATTER_TOOL_PANEL_BASE}
		end

	set_stone (new_stone: STONE) is
			-- Send a stone to formatters.
		local
			cst: CLASSC_STONE
			ist: CLASSI_STONE
			fst: FEATURE_STONE
			type_changed: BOOLEAN
			cluster_stone: CLUSTER_STONE
			target_stone: TARGET_STONE
			l_stone: STONE
		do
			fst ?= new_stone
			cst ?= new_stone
			ist ?= new_stone
			cluster_stone ?= new_stone
			target_stone ?= new_stone
				-- If `new_stone' is a feature stone, take the associated class.
			if fst /= Void and then fst.e_feature /= Void then
				create cst.make (fst.e_feature.associated_class)
				l_stone := cst
			elseif cst /= Void or else ist /= Void then
				if cst /= Void then
					type_changed := (cst.e_class.is_true_external and not is_stone_external) or
						(not cst.e_class.is_true_external and is_stone_external)
				elseif ist /= Void then
					type_changed := (ist.class_i.is_external_class and not is_stone_external) or
						(not ist.class_i.is_external_class and is_stone_external)
				end

				if type_changed then
					-- Toggle stone flag.
	            	is_stone_external := not is_stone_external
	            end

	            	-- Update formatters.
	            if is_stone_external and cst /= Void then
					enable_dotnet_formatters (True)
				else
					enable_dotnet_formatters (False)
				end
				if cst /= Void then
					update_viewpoints (cst.e_class)
				end
				l_stone := cst
			elseif target_stone /= Void or else cluster_stone /= Void then
				l_stone := new_stone
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

	decide_tool_to_display (a_st: STONE): EB_STONABLE_TOOL is
			-- Decide which tool to display.
		local
			fs: FEATURE_STONE
		do
			fs ?= a_st
			if fs /= Void then
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

	enable_dotnet_formatters (a_flag: BOOLEAN) is
			-- Set sensitivity of formatters to 'a_flag'.
		do
			from
				formatters.start
			until
				formatters.after
			loop
				if
					(formatters.item.is_dotnet_formatter and a_flag) or
					(not a_flag)
				then
					formatters.item.enable_sensitive
				else
					formatters.item.disable_sensitive
				end
				formatters.forth
			end
		end

	drop_stone (st: STONE) is
			-- Set `st' in the stone manager and pop up the feature view if it is a feature stone.
		local
			fst: FEATURE_STONE
			l_tool: EB_STONABLE_TOOL
		do
			l_tool := decide_tool_to_display (st)
			if develop_window.unified_stone then
				develop_window.set_stone (st)
			elseif develop_window.link_tools then
				develop_window.tools.set_stone (st)
			else
				l_tool.set_stone (st)
			end
			fst ?= st
			if fst /= Void and then address_manager /= Void then
				address_manager.hide_address_bar
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
