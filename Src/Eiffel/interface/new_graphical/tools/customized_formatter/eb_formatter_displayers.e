note
	description: "Supported formatter displayers (names and their generators)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FORMATTER_DISPLAYERS

inherit
	EB_SHARED_PREFERENCES

feature -- Views

	editor_displayer: STRING = "editor view"

	class_tree_displayer: STRING = "class tree view"

	class_flat_displayer: STRING = "class flat view"

	class_feature_displayer: STRING = "feature flat view"

	feature_displayer: STRING = "feature tree view"

	feature_caller_displayer: STRING = "feature caller view"

	feature_callee_displayer: STRING = "feature callee view"

	dependency_displayer: STRING = "dependency view"

	domain_displayer: STRING = "domain view"

feature -- Generators

	generator_with_name (a_name: STRING): FUNCTION [ANY, TUPLE, EB_FORMATTER_BROWSER_DISPLAYER]
			-- Generator with `a_name'.
		require
			a_name_attached: a_name /= Void
			a_name_valid: True
		do
			if generators_internal = Void then
				create generators_internal.make (6)
				generators_internal.put (agent new_class_tree_displayer, class_tree_displayer)
				generators_internal.put (agent new_class_flat_displayer, class_flat_displayer)
				generators_internal.put (agent new_class_feature_displayer, class_feature_displayer)
				generators_internal.put (agent new_feature_displayer, feature_displayer)
				generators_internal.put (agent new_feature_caller_displayer, feature_caller_displayer)
				generators_internal.put (agent new_feature_callee_displayer, feature_callee_displayer)
				generators_internal.put (agent new_dependency_displayer, dependency_displayer)
				generators_internal.put (agent new_domain_displayer, domain_displayer)
			end
			Result := generators_internal.item (a_name)
		ensure
			result_attached: Result /= Void
		end

	new_editor_displayer (a_dev_window: EB_DEVELOPMENT_WINDOW; a_drop_actions: EV_PND_ACTION_SEQUENCE): EB_FORMATTER_EDITOR_DISPLAYER
			-- New editor displayer.
		local
			l_editor: EB_CLICKABLE_EDITOR
		do
			create l_editor.make (a_dev_window)
			l_editor.widget.set_border_width (1)
			l_editor.widget.set_background_color ((create {EV_STOCK_COLORS}).gray)
			l_editor.disable_line_numbers
			l_editor.drop_actions.append (a_drop_actions)
			l_editor.drop_actions.set_veto_pebble_function (agent (s: STONE): BOOLEAN do Result := True end)
			create Result.make (l_editor)
		ensure
			result_attached: Result /= Void
		end

	new_class_tree_displayer (a_dev_window: EB_DEVELOPMENT_WINDOW; a_drop_actions: EV_PND_ACTION_SEQUENCE): EB_FORMATTER_BROWSER_DISPLAYER
			-- New class tree view
		do
			create Result.make (create {EB_CLASS_BROWSER_TREE_VIEW}.make_with_flag (a_dev_window, True))
		ensure
			result_attached: Result /= Void
		end

	new_class_flat_displayer (a_dev_window: EB_DEVELOPMENT_WINDOW; a_drop_actions: EV_PND_ACTION_SEQUENCE): EB_FORMATTER_BROWSER_DISPLAYER
			-- New class flat view
		do
			create Result.make (create {EB_CLASS_BROWSER_TREE_VIEW}.make_with_flag (a_dev_window, False))
		ensure
			result_attached: Result /= Void
		end

	new_class_feature_displayer (a_dev_window: EB_DEVELOPMENT_WINDOW; a_drop_actions: EV_PND_ACTION_SEQUENCE): EB_FORMATTER_BROWSER_DISPLAYER
			-- New class feature displayer
		do
			create Result.make (create {EB_CLASS_BROWSER_FLAT_VIEW}.make (a_dev_window))
		ensure
			result_attached: Result /= Void
		end

	new_feature_displayer (a_dev_window: EB_DEVELOPMENT_WINDOW; a_drop_actions: EV_PND_ACTION_SEQUENCE): EB_FORMATTER_BROWSER_DISPLAYER
			-- New feature caller/callee displayer
		do
			create Result.make (create {EB_FEATURE_BROWSER_GRID_VIEW}.make (a_dev_window))
		ensure
			result_attached: Result /= Void
		end

	new_feature_caller_displayer (a_dev_window: EB_DEVELOPMENT_WINDOW; a_drop_actions: EV_PND_ACTION_SEQUENCE): EB_FORMATTER_BROWSER_DISPLAYER
			-- New feature caller displayer
		do
			create Result.make (create {EB_CLASS_BROWSER_CALLER_CALLEE_VIEW}.make (a_dev_window, True))
		ensure
			result_attached: Result /= Void
		end

	new_feature_callee_displayer (a_dev_window: EB_DEVELOPMENT_WINDOW; a_drop_actions: EV_PND_ACTION_SEQUENCE): EB_FORMATTER_BROWSER_DISPLAYER
			-- New feature caller displayer
		do
			create Result.make (create {EB_CLASS_BROWSER_CALLER_CALLEE_VIEW}.make (a_dev_window, False))
		ensure
			result_attached: Result /= Void
		end

	new_dependency_displayer (a_dev_window: EB_DEVELOPMENT_WINDOW; a_drop_actions: EV_PND_ACTION_SEQUENCE): EB_FORMATTER_BROWSER_DISPLAYER
			-- New dependency displayer
		do
			create Result.make (create {EB_CLASS_BROWSER_DEPENDENCY_VIEW}.make (a_dev_window))
		ensure
			result_attached: Result /= Void
		end

	new_domain_displayer (a_dev_window: EB_DEVELOPMENT_WINDOW; a_drop_actions: EV_PND_ACTION_SEQUENCE): EB_FORMATTER_BROWSER_DISPLAYER
			-- New dependency displayer
		do
			create Result.make (create {EB_CLASS_BROWSER_DOMAIN_VIEW}.make (a_dev_window))
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implementation

	generators_internal: HASH_TABLE [FUNCTION [ANY, TUPLE, EB_FORMATTER_BROWSER_DISPLAYER], STRING];
		-- Generators indexed with name

note
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
