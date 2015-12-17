note
	description: "Fix messages that are subject to translation."

class
	FIX_MESSAGE

inherit
	FORMATTED_MESSAGE
	SHARED_LOCALE
		export {NONE} all end

feature -- Format: action

	format_action_unused_local (t: TEXT_FORMATTER; local_list: like listable)
			-- Add a name of an action to remove unused locals `local_list' to `t'.
		do
			format (t, locale.translation_in_context ("Remove {1}", "fix"), <<list (local_list)>>)
		end

	format_action_missing_local_type (t: TEXT_FORMATTER; v: PROCEDURE [TEXT_FORMATTER])
			-- Add a name of an action to add a local type `v' to `t'.
		do
			format (t, locale.translation_in_context ("Add type {1}", "fix"), <<element (v)>>)
		end

feature -- Format: description

	format_description_unused_local (t: TEXT_FORMATTER; local_list: like listable)
			-- Add a description of an action to remove unused locals `local_list' to `t'.
		do
			format (t, locale.translation_in_context ("Remove declarations of the local variables {1}.", "fix"), <<list (local_list)>>)
		end

	format_description_missing_local_type (t: TEXT_FORMATTER; v: PROCEDURE [TEXT_FORMATTER])
			-- Add a description of an action to add a local type `v' to `t'.
		do
			format (t, locale.translation_in_context ("Add type declaration {1} to the local declaration list.", "fix"), <<element (v)>>)
		end

note
	date: "$Date$"
	revision: "$Revision$"
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
