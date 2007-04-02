indexing
	description	: "Tools with information about a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Xavier Rousselot"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_FEATURES_RELATION_TOOL

inherit
	EB_FORMATTER_BASED_TOOL
		rename
			last_stone as stone
		redefine
			attach_to_docking_manager,
			pixmap,
			stone,
			retrieve_formatters,
			force_last_stone
		end

create
	make

feature{EB_DEVELOPMENT_WINDOW_MAIN_BUILDER} -- Docking issue

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Attach to docking manager
		do
			build_docking_content (a_docking_manager)
			check friend_tool_created: develop_window.tools.class_tool /= Void end
			check not_already_has: not a_docking_manager.has_content (content) end
			a_docking_manager.contents.extend (content)
		end

feature -- Access

	title: STRING_GENERAL is
			-- Title
		local
			l_constatns: EB_CONSTANTS
		do
			create l_constatns
			Result := l_constatns.interface_names.l_tab_feature_info
		end

	title_for_pre: STRING is
			-- Title
		local
			l_constatns: EB_CONSTANTS
		do
			create l_constatns
			Result := l_constatns.interface_names.to_Feature_relation_tool
		end

	pixmap: EV_PIXMAP is
			-- Pixmap
		local
			l_constants: EB_CONSTANTS
		do
			create l_constants
			Result := l_constants.pixmaps.icon_pixmaps.tool_feature_icon
		end

	flat_formatter: EB_ROUTINE_FLAT_FORMATTER
			-- Special handle to flat formatters of routine. Required to properly update
			-- breakpoint positions during debugging.

	stone: FEATURE_STONE
			-- Currently managed stone.

	predefined_formatters: like formatters is
			-- Predefined formatters
		do
			Result := develop_window.managed_feature_formatters
		end

	flat_format_index: INTEGER is 2
			-- Index of the flat format in the managed formatters.

	no_target_message: STRING_GENERAL is
			-- Message to be displayed in `output_line' when no stone is set
		do
			Result := Interface_names.l_No_feature
		end

feature -- Status setting

	set_stone (new_stone: STONE) is
			-- Send a stone to feature formatters.
		local
			fst: FEATURE_STONE
			type_changed: BOOLEAN
			l_feature_comparer: E_FEATURE_COMPARER
		do
			fst ?= new_stone
				-- Avoid class stone from extending to the history.
			if fst /= Void then
				type_changed := (fst.e_class.is_true_external and not is_stone_external) or
					(not fst.e_class.is_true_external and is_stone_external)

					-- Toggle stone flag.
				if type_changed then
					is_stone_external := not is_stone_external
				end

					-- Update formatters.
	            if is_stone_external then
					enable_dotnet_formatters (True)
				else
					enable_dotnet_formatters (False)
				end
				update_viewpoints (fst.e_class)
				create l_feature_comparer
				if
					stone = Void or else
					(stone /= Void and then not l_feature_comparer.same_feature (stone.e_feature, fst.e_feature))
				then
					set_last_stone (fst)
					develop_window.tools.set_last_stone (stone)
					history_manager.extend (fst)
				end
			else
				if new_stone = Void or else (not new_stone.is_valid) then
					do_all_in_list (formatters, agent (a_formatter: EB_FORMATTER) do a_formatter.reset_display end)
				end
			end
			if widget.is_displayed or else is_auto_hide then
				force_last_stone
					--| Note: this will also call `flat_formatter.show_debugged_line' if any
			end
		end

	decide_tool_to_display (a_st: STONE): EB_STONABLE_TOOL is
			-- Decide which tool to display.
		local
			fs: FEATURE_STONE
		do
			fs ?= a_st
			if fs /= Void then
				show
				set_focus
				Result := Current
			end
		end

	drop_stone (st: like stone) is
			-- Test if there is a feature with the same name (or routine id?)
			-- in the dropped class.
		local
			fst, ofst, new_fs: FEATURE_STONE
			new_f: E_FEATURE
			classi_stone: CLASSI_STONE
			cl: CLASS_C
			found: BOOLEAN
			l_tool: EB_STONABLE_TOOL
		do
			l_tool := decide_tool_to_display (st)
			fst ?= st
			if fst = Void then
				classi_stone ?= st
				if classi_stone /= Void then
					cl := classi_stone.class_i.compiled_representation
					ofst ?= stone
					if ofst /= Void and then cl /= Void then
						new_f := ofst.e_feature.ancestor_version (cl)
						if new_f /= Void then
							create new_fs.make (new_f)
							found := True
						end
					end
				end
				if not found and ofst /= Void then
						-- The dropped class does not have any feature named like the current feature.
					output_line.set_text (Warning_messages.w_No_such_feature_in_this_class (
						ofst.feature_name, st.class_i.name))
				end
			end

				-- Class tool is the default tool to display a class stone
				-- when ancestor of old feature is not found in the class stone.
			if fst = Void and then not found then
				develop_window.tools.show_default_tool_of_class
				l_tool := develop_window.tools.default_class_tool
			end

			if develop_window.unified_stone then
				develop_window.set_stone (st)
			elseif develop_window.link_tools then
				if not found then
					develop_window.tools.set_stone (st)
				else
					develop_window.tools.set_stone (new_fs)
				end
			else
				if l_tool /= Void then
					if not found then
						l_tool.set_stone (st)
					else
						l_tool.set_stone (new_fs)
					end
				end
			end
		end

	pop_feature_flat is
			-- Force the display of `Current' and select the flat form.
		do
			(formatters @ flat_format_index).execute
		end

	pop_default_formatter is
			-- Force the display of `Current' and select the default formatter.
		local
			real_index: INTEGER
		do
			real_index := preferences.context_tool_data.default_feature_formatter_index
			if
				real_index < 1 or
				real_index > formatters.count
			then
					-- The "default default formatter" is the flat format (which is rather fast).
				real_index := flat_format_index
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

	force_last_stone is
			-- Force that `last_stone' is displayed in formatters in Current view
			-- And show debugged line if any.
		do
			Precursor
			if flat_formatter /= Void then
				flat_formatter.show_debugged_line
			end
		end

feature{NONE} -- Implementation

	retrieve_formatters is
			-- Retrieve all formatters related with Current tool and store them in `formatters'
		do
			Precursor
			do_all_in_list (
				formatters,
				agent (a_formatter: EB_FORMATTER)
					local
						l_flat_formatter: like flat_formatter
					do
						l_flat_formatter ?= a_formatter
						if l_flat_formatter /= Void then
							flat_formatter := l_flat_formatter
						end
					end
			)
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

end -- class EB_FEATURES_VIEW


