note
	description: "An AutoProof error due to failed verification."

class
	AP_VERIFICATION_FAILURE

inherit
	COMPILER_ERROR
		redefine
			help_text,
			trace_single_line
		end

	SHARED_LOCALE

create
	make

feature {NONE} -- Creation

	make
			-- Initialize the error object.
		do
		end

feature -- Access

	file_name: like {ERROR}.file_name
			-- <Precursor>
		do
			check from_precondition: False then end
		end

feature -- Properties

	code: STRING = "APVF"
			-- <Precursor>

feature {NONE} -- Output

	help_text: like {COMPILER_ERROR}.help_text
		do
			create {LINKED_LIST [like {COMPILER_ERROR}.help_text.item]} Result.make_from_iterable (<<
				locale.translation_in_context ("Error: Cannot verify selected item(s).", "autoproof.error").as_string_8,
				locale.translation_in_context ("What to do: check AutoProof error messages and update the involved code accordingly.", "autoproof.error").as_string_8
			>>)
		end

	build_explain (t: TEXT_FORMATTER)
		do
			t.add (locale.translation_in_context ("Verification failed.", "autoproof.error"))
			t.add_new_line
		end

	trace_single_line (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			t.add (locale.translation_in_context ("Verification failed.", "autoproof.error"))
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
