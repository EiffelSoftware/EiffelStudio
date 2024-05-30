note
	description: "Summary description for {EB_COMPOSER_COMMAND_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_COMPOSER_COMMAND_I

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			shortcut_string,
			shortcut_available
		end

	EB_SHARED_PREFERENCES

feature {NONE} -- Initialization

	make (a_manager: COMPOSER_MANAGER)
			-- Create associated to `a_manager'.
		require
			a_manager_not_void: a_manager /= Void
		do
			manager := a_manager
			initialize
		end

	initialize
		do
		end

feature -- Basic operations

	drop (s: ANY)
		require
			can_drop (s)
		deferred
		end

	execute
		deferred
		end

feature -- Status

	can_drop (a_stone: ANY): BOOLEAN
			-- Can `a_stone' be dropped onto current?
		deferred
		end

feature -- Shortcuts

	shortcut_available: BOOLEAN
		do
			Result := Precursor
			if not Result then
				Result := manager.shortcut_command.shortcut_available and then composer_and_then_accelerator /= Void
			end
		end

	shortcut_string: STRING_GENERAL
			-- Shortcut string.
		do
			Result := Precursor
			if
				Result.is_whitespace and then
				attached composer_and_then_accelerator as sc
			then
				create {STRING_32} Result.make_from_string_general (manager.shortcut_command.shortcut_string)
				Result.append (" , ")
				Result.append (sc.text)
			end
		end

	composer_and_then_accelerator: detachable EV_ACCELERATOR
			-- Optional key associated with the global composer shortcut (if any)

feature -- Element change

	register_composer_and_then_accelerator (acc: EV_ACCELERATOR)
		require
			composer_and_then_accelerator = Void
		do
			composer_and_then_accelerator := acc
		end

feature {NONE} -- Helpers

	composer_shortcut (a_name: READABLE_STRING_8): detachable SHORTCUT_PREFERENCE
		do
			Result := preferences.editor_data.shortcuts.item (manager.preferences_prefix +  "then." + a_name)
		end

	composer_custom_shortcut (a_name: READABLE_STRING_8; is_ctrl, is_alt, is_shift: BOOLEAN; key: READABLE_STRING_8): SHORTCUT_PREFERENCE
		do
			Result := preferences.editor_data.custom_shortcut (manager.preferences_prefix +  "then." + a_name, [is_alt, is_ctrl, is_shift, key])
		end

	feature_stone: detachable FEATURE_STONE
			-- Eventual feature stone
		local
			window: EB_DEVELOPMENT_WINDOW
		do
			window := window_manager.last_focused_development_window
			if attached {FEATURE_STONE} window.stone as fs then
				Result := fs
			elseif attached {CLASSC_STONE} window.stone as cls then
				if
					attached window.editors_manager.current_editor as ed and then
					attached ed.text_displayed as txt and then
					attached txt.current_feature_containing as tu and then
					attached tu.name.visual_name_32 as l_feature_name and then
					attached cls.e_class.feature_with_name_32 (l_feature_name) as f
				then
					create {FEATURE_STONE} Result.make (f)
				end
			end
		end

	class_stone: detachable CLASSI_STONE
			-- Eventual feature stone
		local
			window: EB_DEVELOPMENT_WINDOW
		do
			window := window_manager.last_focused_development_window
			if attached {CLASSI_STONE} window.stone as cs then
				Result := cs
			end
		end

feature {NONE} -- Implementation

	manager: COMPOSER_MANAGER
			-- Composer manager

invariant
	manager_not_void: manager /= Void


note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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
