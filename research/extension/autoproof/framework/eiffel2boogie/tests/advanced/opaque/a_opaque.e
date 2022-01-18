class
	A_OPAQUE

feature
	all_positive (s: MML_SEQUENCE [INTEGER]): BOOLEAN
			-- An opaque function.
		note
			status: functional, opaque
		do
			Result := across 1 |..| s.count as i all s [i] > 0 end
		end

	lemma_bad (s: MML_SEQUENCE [INTEGER])
		note
			status: lemma
		require
			all_positive (s)
			not s.is_empty
		do
			-- Definition of `all_positive' is not available here, since it is declared opaque
		ensure
			all_positive (s.but_first)
		end

	lemma_good (s: MML_SEQUENCE [INTEGER])
		note
			status: lemma
		require
			all_positive (s)
			not s.is_empty
		do
			use_definition (all_positive (s))
			use_definition (all_positive (s.but_first))
			-- Definition of `all_positive' is available thanks to the calls to `use_definition'
		ensure
			all_positive (s.but_first)
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2014 ETH Zurich",
		"Copyright (c) 2018 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Nadia Polikarpova", "Alexander Kogtenkov"
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
