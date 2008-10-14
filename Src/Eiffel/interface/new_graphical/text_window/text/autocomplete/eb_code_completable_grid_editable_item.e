indexing
	description: "Editable grid item that contains code completable text field."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CODE_COMPLETABLE_GRID_EDITABLE_ITEM

inherit
	EV_GRID_EDITABLE_ITEM
		redefine
			text_field,
			activate_action
		end

	PLATFORM
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

feature -- Access

	text_field: EB_CODE_COMPLETABLE_TEXT_FIELD
		-- Text field used to edit `Current' on `activate'.
		-- Void when `Current' isn't being activated.

	completion_possibilities_provider: EB_COMPLETION_POSSIBILITIES_PROVIDER

feature -- Element change

	set_completion_possibilities_provider (a_provider: EB_COMPLETION_POSSIBILITIES_PROVIDER) is
			-- Set `completion_possibilities_provider'.
		require
			a_provider_not_void: a_provider /= Void
		do
			completion_possibilities_provider := a_provider
		ensure
			completion_possibilities_provider_not_void: completion_possibilities_provider /= Void
		end

feature {NONE} -- Implementation

	activate_action (popup_window: EV_POPUP_WINDOW) is
			-- `Current' has been requested to be updated via `popup_window'.
		do
			Precursor {EV_GRID_EDITABLE_ITEM} (popup_window)
			if text_field /= Void then
					--| FIXME: Work around on Unix to get the same behavior as Windows. Vision2 GTK issue.
				if is_unix then
					text_field.focus_back_actions.extend (agent verify_popup_window_focus (popup_window))
				end

					--| Add completion capabilities			
				text_field.set_completion_possibilities_provider (completion_possibilities_provider)
				if completion_possibilities_provider /= Void then
					completion_possibilities_provider.set_code_completable (text_field)
				end
			end
		end

	verify_popup_window_focus (a_popup_window: EV_POPUP_WINDOW) is
			-- Verify focus on popup window.
			--| FIXME: Have to call `show' to maintain focus on Unix. Vision2 GTK issue.
		do
			if not a_popup_window.has_focus then
					-- Selected by default.
				if text_field /= Void and then not text_field.text.is_empty then
					text_field.set_caret_position (text_field.text.count + 1)
				end
				a_popup_window.show
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
