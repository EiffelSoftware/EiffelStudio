note
	description	: "Tools with information about a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_FEATURES_RELATION_TOOL_PANEL

inherit
	ES_FORMATTER_TOOL_PANEL_BASE
		rename
			last_stone as stone
		redefine
			stone,
			retrieve_formatters,
			force_last_stone,
			initialize,
			tool_veto_pebble_function,
			enable_dotnet_formatters,
			refresh
		end

	ES_FEATURE_RELATION_TOOL_COMMANDER_I
		export
			{ES_FEATURE_RELATION_TOOL} all
		end

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	initialize
			-- <Precursor>
		do
			Precursor {ES_FORMATTER_TOOL_PANEL_BASE}

			content.show_actions.extend (agent refresh_if_possible)
		end

feature -- Access

	flat_formatter: EB_ROUTINE_FLAT_FORMATTER
			-- Special handle to flat formatters of routine. Required to properly update
			-- breakpoint positions during debugging.

	stone: detachable STONE
			-- Currently managed stone.

	predefined_formatters: like formatters
			-- Predefined formatters
		do
			Result := develop_window.managed_feature_formatters
		end

	no_target_message: STRING_GENERAL
			-- Message to be displayed in `output_line' when no stone is set
		do
			Result := Interface_names.l_No_feature
		end

	is_refresh_needed: BOOLEAN
			-- If current need a fresh?
			-- Useful for refresh Current only when Current is redisplayed
			-- See bug#14840

feature -- Basic operations

	refresh
		do
			Precursor
			is_refresh_needed := False
		end

feature {ES_FEATURE_RELATION_TOOL} -- Access

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
				if attached {EB_FEATURE_INFO_FORMATTER} l_formatters.item as l_formatter and then l_formatter.selected then
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

feature {ES_FEATURE_RELATION_TOOL} -- Element change

	set_mode (a_mode: like mode)
			-- Sets the current view mode.
			--
			-- `a_mode': The view mode to set. See {ES_FEATURE_RELATION_TOOL_VIEW_MODES} for applicable values.
		local
			l_formatters: like predefined_formatters
			l_cursor: CURSOR
			l_stop: BOOLEAN
		do
			if a_mode /= mode then
				l_formatters := predefined_formatters
				l_cursor := l_formatters.cursor
				from l_formatters.start until l_formatters.after or l_stop loop
					if attached {EB_FEATURE_INFO_FORMATTER} l_formatters.item as l_formatter and then l_formatter.mode = a_mode then
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
			-- Sets the current view mode and the stone to view using the mode.
			--
			-- `a_mode': The view mode to set.
			-- `a_stone': The stone to set on the feature releation tool.
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

	set_stone (a_stone: detachable STONE)
			-- Send a stone to feature formatters.
		local
			l_last_stone: FEATURE_STONE
			l_feature_comparer: E_FEATURE_COMPARER
		do
				-- Avoid class stone from extending to the history.
			if attached {FEATURE_STONE} a_stone as fst then
					-- Update formatters.
				enable_dotnet_formatters (fst.is_dotnet_class)

				update_viewpoints (fst.e_class)
				create l_feature_comparer
				if attached {FEATURE_STONE} stone as l_feat_stone then
					l_last_stone := l_feat_stone
				else
					l_last_stone := Void
				end
				if
					l_last_stone = Void or else
					(not l_feature_comparer.same_feature (l_last_stone.e_feature, fst.e_feature))
				then
					set_last_stone (fst)
					develop_window.tools.set_last_stone (l_last_stone)
					history_manager.extend (fst)
				else
						-- Even it is possibly the same feature,
						-- we have to refresh since there maybe a change of the feature.
						-- See bug#15998. But when debugging, it is not necessary.
					if not debugger_manager.is_debugging then
						refresh
					end
				end
			else
				if a_stone = Void or else (not a_stone.is_valid) then
					across formatters as l_formatter loop
						l_formatter.item.reset_display
					end
				end
			end

			if widget.is_displayed or else is_auto_hide or else develop_window.link_tools then
				force_last_stone
			end
		end

	decide_tool_to_display (a_st: STONE): EB_STONABLE_TOOL
			-- Decide which tool to display.
		do
			if attached {FEATURE_STONE} a_st then
				show
				set_focus
				Result := Current
			end
		end

	drop_stone (st: like stone)
			-- Test if there is a feature with the same name (or routine id?)
			-- in the dropped class.
		local
			fst, new_fs: detachable FEATURE_STONE
			new_f: E_FEATURE
			cl: CLASS_C
			found: BOOLEAN
			l_tool: EB_STONABLE_TOOL
		do
			l_tool := decide_tool_to_display (st)
			fst := {FEATURE_STONE} / st
			if fst = Void then
				if attached {CLASSI_STONE} st as classi_stone then
					cl := classi_stone.class_i.compiled_representation
					if attached {FEATURE_STONE} stone as ofst then
						if cl /= Void then
							new_f := ofst.e_feature.ancestor_version (cl)
							if new_f /= Void then
								create new_fs.make (new_f)
								found := True
							end
						end
						if not found then
								-- The dropped class does not have any feature named like the current feature.
							output_line.set_text (Warning_messages.w_No_such_feature_in_this_class (
								ofst.feature_name, classi_stone.class_i.name))
						end
					elseif attached {ACCESS_ID_STONE} st as accst then
						found := False
					end
				end
			end

				-- Class tool is the default tool to display a class stone
				-- when ancestor of old feature is not found in the class stone.
			if fst = Void and then not found then
				develop_window.tools.show_default_tool_of_class
				l_tool := develop_window.tools.default_class_tool
			end

			if develop_window.is_unified_stone then
				develop_window.set_stone (st)
			elseif develop_window.link_tools then
				if not found then
					develop_window.tools.set_stone (st)
				else
					develop_window.tools.set_stone (new_fs)
				end
			else
				if l_tool = Void then
					if found then
							-- Reset the stone on the tool with the found new feature stone.
						set_stone (new_fs)
					end
				else
					if not found then
						l_tool.set_stone (st)
					else
						l_tool.set_stone (new_fs)
					end
				end
			end
		end

	pop_default_formatter
			-- Force the display of `Current' and select the default formatter.
		local
			l_index: INTEGER
			l_mode: NATURAL_8
		do
			l_mode := {ES_FEATURE_RELATION_TOOL_VIEW_MODES}.flat
			l_index := preferences.context_tool_data.default_feature_formatter_index
			if
				l_index >= 1 and
				l_index <= formatters.count and then
				attached {EB_FEATURE_INFO_FORMATTER} formatters.i_th (l_index) as l_formatter
			then
				l_mode := l_formatter.mode
			end
			set_mode (l_mode)
		end

	refresh_if_possible
			-- Call `refresh' if `is_refresh_needed'
		do
			if is_refresh_needed then
				refresh
			end
		ensure
			cleared: not is_refresh_needed
		end

	set_refresh_needed
			-- Set `is_refresh_needed' with True
		do
			if content.user_widget.is_displayed then
				refresh
			else
				is_refresh_needed := True
			end
		ensure
			set: content.user_widget.is_displayed = not is_refresh_needed
		end

feature {NONE} -- Implementation

	enable_dotnet_formatters (a_flag: BOOLEAN)
			-- Set sensitivity of formatters to 'a_flag'.
		local
			l_done: BOOLEAN
		do
			Precursor (a_flag)

					-- Determine which formatter to give focus based upon previous one.
			if a_flag then
				if formatters.i_th (1).selected then
						-- Previously text so now move to flat.
					formatters.i_th (2).enable_select
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

	force_last_stone
			-- Force that `last_stone' is displayed in formatters in Current view
			-- And show debugged line if any.
		do
			Precursor
			if flat_formatter /= Void then
				flat_formatter.show_debugged_line
			end
		end

feature {NONE} -- Implementation

	retrieve_formatters
			-- Retrieve all formatters related with Current tool and store them in `formatters'
		do
			Precursor
			across formatters as l_formatter until flat_formatter /= Void loop
				if attached {like flat_formatter} l_formatter.item as l_flat_formatter then
					flat_formatter := l_flat_formatter
				end
			end
		end

	tool_veto_pebble_function (a_stone: ANY): BOOLEAN
			-- Veto pebble function for the tool.
		do
			Result := Precursor (a_stone) and then not attached {TARGET_STONE} a_stone
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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

end -- class EB_FEATURES_VIEW

