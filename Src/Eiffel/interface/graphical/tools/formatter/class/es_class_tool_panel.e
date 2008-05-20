indexing
	description:
		"View with information about a class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLASS_TOOL_PANEL

inherit
	ES_FORMATTER_TOOL_PANEL_BASE
		rename
			last_stone as stone
		redefine
			attach_to_docking_manager,
			stone
		end

	ES_CLASS_TOOL_COMMANDER_I
		export
			{ES_CLASS_TOOL} all
		end

create
	make

feature {EB_DEVELOPMENT_WINDOW_MAIN_BUILDER} -- Docking issues

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Attach to docking manager
		do
			build_docking_content (a_docking_manager)
			check not_already_has: not a_docking_manager.has_content (content) end
			a_docking_manager.contents.extend (content)
		end

feature -- Access

	stone: CLASSI_STONE
			-- Stone

	predefined_formatters: like formatters is
			-- Predefined formatters
		do
			Result := develop_window.managed_class_formatters
		end

	no_target_message: STRING_GENERAL is
			-- Message to be displayed in `output_line' when no stone is set
		do
			Result := Interface_names.l_Not_in_system_no_info
		end

feature {ES_CLASS_TOOL} -- Access

	mode: NATURAL_8 assign set_mode
			-- The feature relation tool's view mode.
			-- See {ES_FEATURE_RELATION_TOOL_VIEW_MODES} for applicable values.
		local
			l_formatters: like predefined_formatters
			l_cursor: CURSOR
			l_stop: BOOLEAN
		do
			l_formatters := predefined_formatters
			l_cursor := l_formatters.cursor
			from l_formatters.start until l_formatters.after or l_stop loop
				if {l_formatter: !EB_CLASS_INFO_FORMATTER} l_formatters.item and then l_formatter.selected then
					Result := l_formatter.mode
					l_stop := True
				else
					l_formatters.forth
				end
			end
			l_formatters.go_to (l_cursor)
		ensure then
			formatters_unmoved: formatters.cursor.is_equal (old formatters.cursor)
		end

feature {ES_CLASS_TOOL} -- Element change

	set_mode (a_mode: like mode)
			-- <Precursor>
		local
			l_formatters: like predefined_formatters
			l_cursor: CURSOR
			l_stop: BOOLEAN
		do
			if a_mode /= mode then
				l_formatters := predefined_formatters
				l_cursor := l_formatters.cursor
				from l_formatters.start until l_formatters.after or l_stop loop
					if {l_formatter: !EB_CLASS_INFO_FORMATTER} l_formatters.item and then l_formatter.mode = a_mode then
							-- Execute formatter
						l_formatter.execute
						l_stop := True
					else
						l_formatters.forth
					end
				end
				l_formatters.go_to (l_cursor)
			end
		ensure then
			formatters_unmoved: formatters.cursor.is_equal (old formatters.cursor)
		end

	set_mode_with_stone (a_mode: like mode; a_stone: STONE)
			-- <Precursor>
		do
				-- First clear the stone, for performance reasons
			set_stone (Void)

				-- Now set the mode and stone.
			set_mode (a_mode)
			set_stone (a_stone)
		ensure then
			formatters_unmoved: formatters.cursor.is_equal (old formatters.cursor)
			stone_set: stone = a_stone
		end

feature -- Status setting

	set_stone (new_stone: STONE) is
			-- Send a stone to class formatters.
		local
			fst: FEATURE_STONE
			cst: CLASSC_STONE
			ist: CLASSI_STONE
			type_changed: BOOLEAN
		do
			fst ?= new_stone
			if fst /= Void then
				check
					feature_not_void: fst.e_feature /= Void
					class_not_void: fst.e_feature.associated_class /= Void
				end
				create cst.make (fst.e_feature.associated_class)
			else
				cst ?= new_stone
				ist ?= new_stone
			end
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
			if cst = Void or else stone = Void or else not stone.same_as (cst) then
					-- Set the stones.
				set_last_stone (cst)
				develop_window.tools.set_last_stone (stone)
			end
			
			if widget.is_displayed or else is_auto_hide or else develop_window.link_tools then
				force_last_stone
			end
		end

	pop_default_formatter is
			-- Pop the default class formatter.
		local
			real_index: INTEGER
		do
			real_index := preferences.context_tool_data.default_class_formatter_index
			if
				real_index < 1 or
				real_index > formatters.count
			then
					-- The "default default formatter" is the ancestors (which is rather fast).
				real_index := 5
			end
			(formatters @ real_index).execute
		end

feature {NONE} -- Implementation

	enable_dotnet_formatters (a_flag: BOOLEAN) is
			-- Set sensitivity of formatters to 'a_flag'.
		local
			l_done: BOOLEAN
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

				-- Determine which formatter to give focus based upon previous one.
			if a_flag then
				if formatters.i_th (1).selected then
						-- Previously clickable so now move to contract.
					formatters.i_th (3).enable_select
				elseif formatters.i_th (2).selected then
						-- Previously flat so now interface.
					formatters.i_th (4).enable_select
				else
						-- Set formatter to same as previous one.
					from
						formatters.start
					until
						formatters.after or l_done
					loop
						if formatters.item.selected then
							formatters.i_th (formatters.index_of (formatters.item, 1)).enable_select
							l_done := True
						end
						formatters.forth
					end
				end
			end
		end

	drop_stone (st: like stone) is
			-- Set `st' in the stone manager and pop up the feature view if it is a feature stone.
		local
			fst: FEATURE_STONE
			l_tool: EB_STONABLE_TOOL
		do
			fst ?= st
			l_tool := decide_tool_to_display (st)
			if develop_window.unified_stone then
				develop_window.set_stone (st)
			elseif develop_window.link_tools then
				develop_window.tools.set_stone (st)
			else
				l_tool.set_stone (st)
			end
			if fst /= Void and then address_manager /= Void then
				address_manager.hide_address_bar
			end
		end

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

end -- class EB_CLASS_VIEW

