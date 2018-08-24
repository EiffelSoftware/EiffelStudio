note
	description: "[
		Helper class to minimize changes of proper EiffelStudio for the integration of AutoProof.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_AUTOPROOF_BENCH_HELPER

inherit

	EB_SHARED_PIXMAPS

feature -- Basic operations

	build_context_menu_for_class_stone (a_menu: EV_MENU; a_stone: CLASSC_STONE)
			-- Build context menu for class stone `a_stone' and add it to `a_menu'.
			--
			-- Added to {EB_CONTEXT_MENU_FACTORY}.extend_standard_compiler_item_menu
		require
			a_menu_not_void: a_menu /= Void
			a_stone_not_void: a_stone /= Void
		local
			l_item: EV_MENU_ITEM
		do
			if a_stone.class_i.is_compiled then
				create l_item.make_with_text_and_action ("Verify with AutoProof", agent verify_class (a_stone.e_class))
				l_item.set_pixmap (icon_pixmaps.general_tick_icon)
				if autoproof.is_running then
					l_item.disable_sensitive
					l_item.set_text (l_item.text + " (running)")
				end
				a_menu.extend (l_item)
			end
		end

	build_context_menu_for_feature_stone (a_menu: EV_MENU; a_stone: FEATURE_STONE)
			-- Build context menu for feature stone `a_stone' and add it to `a_menu'.
			--
			-- Added to {EB_CONTEXT_MENU_FACTORY}.extend_standard_compiler_item_menu
		require
			a_menu_not_void: a_menu /= Void
			a_stone_not_void: a_stone /= Void
		local
			l_item: EV_MENU_ITEM
		do
			if a_stone.e_feature.is_procedure or a_stone.e_feature.is_function then
				create l_item.make_with_text_and_action ("Verify with AutoProof", agent verify_feature (a_stone.e_feature.associated_feature_i))
				l_item.set_pixmap (icon_pixmaps.general_tick_icon)
				if autoproof.is_running then
					l_item.disable_sensitive
					l_item.set_text (l_item.text + " (running)")
				end
				a_menu.extend (l_item)
			end
		end

feature -- Verification

	autoproof: E2B_AUTOPROOF
			-- Shared autoproof instance.
		once
			create Result.make
		end

	autoproof_command: ES_AUTOPROOF_COMMAND
			-- Shared autoproof command.
		once
			create Result.make
		end

	verify_class (a_class: CLASS_C)
			-- Verify class `a_class'.
		require
			a_class_attached: attached a_class
			autoproof_not_running: not autoproof.is_running
		local
			l_stone: CLASSC_STONE
		do
			create l_stone.make (a_class)
			autoproof_command.execute_with_stone (l_stone)
		end

	verify_feature (a_feature: FEATURE_I)
			-- Verify feature `a_feature'.
		require
			a_feature_attached: attached a_feature
			autoproof_not_running: not autoproof.is_running
		local
			l_stone: FEATURE_STONE
		do
			create l_stone.make (a_feature.e_feature)
			autoproof_command.execute_with_stone (l_stone)
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
