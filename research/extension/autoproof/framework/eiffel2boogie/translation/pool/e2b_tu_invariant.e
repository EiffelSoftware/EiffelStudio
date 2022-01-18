note
	description: "[
		Translation unit for a (possibly partial) class invariant of an Eiffel class.
	]"

class
	E2B_TU_INVARIANT

inherit

	E2B_TRANSLATION_UNIT

create
	make,
	make_filtered

feature {NONE} -- Implementation

	make (a_type: CL_TYPE_A)
			-- Initialize translation unit for the invariant of `a_type'.
		require
			type_exists: a_type /= Void
		do
			type := a_type
			id := "inv/" + type_id (a_type)
		end

	make_filtered (a_type: CL_TYPE_A; a_included, a_excluded: LIST [STRING]; a_ancestor: CLASS_C)
			-- Initialize translation unit for a partial invariant of `a_type'
			-- that only includes clauses `a_included', or excludes clauses `a_excluded',
			-- and only includes clauses inherited from `a_ancestor'.
		require
			type_exists: a_type /= Void
			not_both: a_included = Void or a_excluded = Void
		do
			type := a_type
			id := ""

			included := a_included
			if included /= Void then
				included.compare_objects
				across included as i loop id.append ("+" + i) end
			end
			excluded := a_excluded
			if excluded /= Void then
				excluded.compare_objects
				across excluded as i loop id.append ("-" + i) end
			end
			if a_ancestor /= Void then
				ancestor := a_ancestor
				id.append ("*" + ancestor.name_in_upper)
			else
				ancestor := type.base_class
			end
			id := "inv-filtered/" + id + "/" + type_id (a_type)
		end

feature -- Access

	type: CL_TYPE_A
			-- Type to which the invariant belongs.

	included, excluded: LIST [STRING]
			-- List of invariant tags to be filtered.

	ancestor: CLASS_C
			-- Class to which the invariant clauses will be restricted.

	id: STRING
			-- <Precursor>

feature -- Basic operations

	translate
			-- <Precursor>
		local
			l_translator: E2B_TYPE_TRANSLATOR
		do
			create l_translator
			if included = Void and excluded = Void then
				l_translator.translate_model (type) -- ToDo: refactor
				l_translator.translate_invariant (type)
			else
				l_translator.translate_filtered_invariant_function (type, included, excluded, ancestor)
			end
		end

invariant
	ancestor_exists: not (included = Void and excluded = Void) implies ancestor /= Void
	not_both: included = Void or excluded = Void

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2013-2014 ETH Zurich",
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
