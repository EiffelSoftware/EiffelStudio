note
	description: "[
		Helper base class for handling exception cases and displaying graphical error messages.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_EXCEPTION_HANDLER

inherit
	ANY

	ES_SHARED_LOCALE_FORMATTER
		export
			{NONE} all
		end

feature -- Basic operations

	show_last_exception
			-- Displays the last known exception message.
		do
			show_last_exception_with_template ("$1")
		end

	show_last_exception_with_template (a_template_1: READABLE_STRING_GENERAL)
			-- Displays the last known exception message using a template message.
			--
			-- `a_template_1': A template containing a $1 replacement variable for the exception message
			--                 meaning.
		require
			a_template_1_attached: a_template_1/= Void
			not_a_template_1_is_empty: not a_template_1.is_empty
		local
			l_exception: EXCEPTION
			l_exception_tag: detachable READABLE_STRING_GENERAL
			l_tag: STRING_32
			l_prompt: ES_ERROR_PROMPT
		do
				-- Fetch exception.
			if attached {EXCEPTION_MANAGER} Current as l_exception_manger then
				l_exception := l_exception_manger.last_exception
			else
				l_exception := (create {EXCEPTION_MANAGER}).last_exception
			end
			if l_exception /= Void then
					-- Fetch the exception's meaning.
				l_exception_tag := l_exception.tag
			end

				-- Translate
			if l_exception_tag /= Void then
				l_tag := locale_formatter.translation (l_exception_tag)
			else
				l_tag := (create {ERROR_MESSAGES}).e_unknown_error
			end

				-- Display prompt
			create l_prompt.make_standard (locale_formatter.formatted_translation (a_template_1, [l_tag]))
			l_prompt.show_on_active_window
		end

;note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
