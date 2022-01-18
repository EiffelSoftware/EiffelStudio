class
	IV_HAVOC

inherit

	IV_STATEMENT

inherit {NONE}

	IV_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_8)
			-- Initialize havoc with `a_name'.
		require
			a_name_valid: is_valid_name (a_name)
		do
			create names.make
			names.extend (a_name.twin)
		ensure
			a_name_added: names.first ~ a_name
		end

feature -- Access

	names: LINKED_LIST [READABLE_STRING_8]
			-- Names of entities.

feature -- Element changed

	add_name (a_name: READABLE_STRING_8)
			-- Add `a_name' to `names'.
		require
			a_name_valid: is_valid_name (a_name)
		do
			names.extend (a_name)
		ensure
			a_name_added: names.last ~ a_name
		end

feature -- Visitor

	process (a_visitor: IV_STATEMENT_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_havoc (Current)
		end

invariant
	names_attached: attached names
	names_valid: across names as i all is_valid_name (i) end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2012 ETH Zurich",
		"Copyright (c) 2018-2019 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Nadia Polikarpova", "Alexander Kogtenkov"
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
