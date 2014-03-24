note
	description: "[
		Helper class to minimize changes of proper EiffelStudio for the integration of the Code Analysis Tool.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CODE_ANALYSIS_BENCH_HELPER

inherit

	CA_SHARED_NAMES

	EB_SHARED_PIXMAPS

	EB_SHARED_WINDOW_MANAGER

feature -- Basic operations

	build_context_menu_for_class_stone (a_menu: attached EV_MENU; a_stone: attached CLASSC_STONE)
			-- Build context menu for class stone `a_stone' and add it to `a_menu'.
			--
			-- Added to {EB_CONTEXT_MENU_FACTORY}.extend_standard_compiler_item_menu.
		require
			a_menu_not_void: a_menu /= Void
			a_stone_not_void: a_stone /= Void
		local
			l_item: EV_MENU_ITEM
		do
				-- The class should be compiled in any case. Make it sure anyway.
			if a_stone.class_i.is_compiled then
				create l_item.make_with_text_and_action (ca_messages.class_context_menu_caption (a_stone.class_name)
					, agent ca_command.execute_with_stone (a_stone))
					-- Although the icon name is not very suitable, the icon itself seems appropriate.
				l_item.set_pixmap (icon_pixmaps.view_flat_icon)

				if code_analyzer.is_running then
					l_item.disable_sensitive
					l_item.set_text (l_item.text + ca_messages.already_running)
				end
				a_menu.extend (l_item)
			end
		end

	build_context_menu_for_cluster_stone (a_menu: attached EV_MENU; a_stone: attached CLUSTER_STONE)
			-- Build context menu for cluster stone `a_stone' and add it to `a_menu'.
			-- Very similar to `build_context_menu_for_class_stone'.
			-- Added to {EB_CONTEXT_MENU_FACTORY}.extend_standard_compiler_item_menu.
		require
			a_menu_not_void: a_menu /= Void
			a_stone_not_void: a_stone /= Void
		local
			l_item: EV_MENU_ITEM
		do
			create l_item.make_with_text_and_action (ca_messages.cluster_context_menu_caption
				, agent ca_command.execute_with_stone (a_stone))
			l_item.set_pixmap (icon_pixmaps.view_flat_icon)

			if code_analyzer.is_running then
				l_item.disable_sensitive
				l_item.set_text (l_item.text + ca_messages.already_running)
			end
			a_menu.extend (l_item)
		end

feature -- Shared instances

	code_analyzer: CA_CODE_ANALYZER
			-- Shared Code Analyzer instance.
		once
			create Result.make
				-- Delegate any output to the status bar.
			Result.add_output_action (agent window_manager.display_message)
		ensure
			valid_result: Result /= Void
		end

	ca_command: ES_CODE_ANALYSIS_COMMAND
			-- Shared Code Analysis command.
		once
			create Result.make
		ensure
			valid_result: Result /= Void
		end
note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
