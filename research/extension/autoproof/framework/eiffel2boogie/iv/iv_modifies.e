class
	IV_MODIFIES

inherit

	IV_CONTRACT
		redefine
			is_equal
		end

inherit {NONE}

	IV_HELPER
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING)
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

	names: LINKED_LIST [STRING]
			-- Names of entities.

feature -- Comparison

	is_equal (a_other: like Current): BOOLEAN
			-- Is this clause the same as `a_other'?
		do
			Result := names.count = a_other.names.count and
				across names as i all a_other.names.has (i) end
		end

feature -- Element changed

	add_name (a_name: STRING)
			-- Add `a_name' to `names'.
		require
			a_name_valid: is_valid_name (a_name)
		do
			names.extend (a_name)
		ensure
			a_name_added: names.last ~ a_name
		end

feature -- Visitor

	process (a_visitor: IV_CONTRACT_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_modifies (Current)
		end

invariant
	names_attached: attached names
	names_valid: across names as i all is_valid_name (i) end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2012-2014 ETH Zurich",
		"Copyright (c) 2018 Politecnico di Milano",
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
