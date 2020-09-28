note
	description: "Message handled by service {NOTIFICATION_S}."
	date: "$Date$"
	revision: "$Revision$"

class
	NOTIFICATION_MESSAGE

create
	make

create {NOTIFICATION_MESSAGE}
	make_with_date

feature {NONE} -- Creation

	make (txt: READABLE_STRING_GENERAL; a_category: READABLE_STRING_GENERAL)
			-- Create a message for notification, with `txt` and `a_category`.
		do
			make_with_date (txt, a_category, create {DATE_TIME}.make_now)
		end

	make_with_date (txt: READABLE_STRING_GENERAL; a_category: detachable READABLE_STRING_GENERAL; dt: like date)
			-- Create a message for notification, with `txt` and `a_category`, with creation date `dt`.
		do
			set_text (txt)
			set_category (a_category)
			date := dt
		end

feature -- Access

	date: DATE_TIME
			-- Notification date, when it was created.

	text: IMMUTABLE_STRING_32
			-- Message text.

	title: detachable IMMUTABLE_STRING_32
			-- Optional title.

	category: IMMUTABLE_STRING_32
			-- Mandatory category to allow filtering.

	is_acknowledged: BOOLEAN
			-- Message acknowledged?
			-- i.e either dismissed by user, or action taken by user.
			-- if auto dismissed, then not acknowledged.

feature -- Element change

	set_text (txt: READABLE_STRING_GENERAL)
			-- Set message `text` to `txt`.
		do
			create text.make_from_string_general (txt)
		end

	set_title (a_title: READABLE_STRING_GENERAL)
			-- Set message `title` to `a_title`.
		do
			create title.make_from_string_general (a_title)
		end

	set_category (a_category: READABLE_STRING_GENERAL)
			-- Set message `category` to `a_category.as_lower`.
		do
			create category.make_from_string_general (a_category.as_lower)
		end

	mark_acknowledged
			-- Mark message as acknowledged / read.
		do
			is_acknowledged := True
		end

feature -- Conversion

	to_archive: NOTIFICATION_MESSAGE
			-- Copy of Current message for archiving.
		do
			create Result.make_with_date (text, category, date.twin)
			if attached title as l_title then
				Result.set_title (l_title)
			end
			if is_acknowledged then
				Result.mark_acknowledged
			end
		end

;note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
