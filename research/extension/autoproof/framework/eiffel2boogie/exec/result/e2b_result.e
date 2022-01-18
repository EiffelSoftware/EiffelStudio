note
	description: "Result of an AutoProof run."

class
	E2B_RESULT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize Boogie result.
		do
			create verification_results.make
		end

feature -- Access

	verification_results: LINKED_LIST [E2B_VERIFICATION_RESULT]
			-- List of verification results.

	successful_verifications: READABLE_INDEXABLE [E2B_SUCCESSFUL_VERIFICATION]
			-- List of successfully verified features.
		local
			l_list: LINKED_LIST [E2B_SUCCESSFUL_VERIFICATION]
		do
			create l_list.make
			across verification_results as i loop
				if attached {E2B_SUCCESSFUL_VERIFICATION} i as l_failed then
					l_list.extend (l_failed)
				end
			end
			Result := l_list
		end

	failed_verifications: READABLE_INDEXABLE [E2B_FAILED_VERIFICATION]
			-- List of verification errors.
		local
			l_list: LINKED_LIST [E2B_FAILED_VERIFICATION]
		do
			create l_list.make
			across verification_results as i loop
				if attached {E2B_FAILED_VERIFICATION} i as l_failed then
					l_list.extend (l_failed)
				end
			end
			Result := l_list
		end

	autoproof_errors: LINKED_LIST [E2B_AUTOPROOF_ERROR]
			-- List of AutoProof translation and execution errors.
		do
			create Result.make
			across verification_results as i loop
				if attached {E2B_AUTOPROOF_ERROR} i as l_failed then
					Result.extend (l_failed)
				end
			end
		end

feature -- Status report

	has_execution_errors: BOOLEAN
			-- Did syntax errors occur?
		do
			Result := not autoproof_errors.is_empty
		end

	has_verification_errors: BOOLEAN
			-- Did verification errors occur?
		do
			from
				verification_results.start
			until
				verification_results.after or Result
			loop
				Result := attached {E2B_FAILED_VERIFICATION} verification_results.item
				verification_results.forth
			end
		end

	is_verification_successful: BOOLEAN
			-- Did verification succeed?
		do
			Result := not has_execution_errors and then not has_verification_errors
		end

feature -- Element change

	add_result (a_verification_result: E2B_VERIFICATION_RESULT)
			-- Add `a_verification_result' to `verification_results'.
		do
			verification_results.extend (a_verification_result)
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2010-2013 ETH Zurich",
		"Copyright (c) 2018 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Alexander Kogtenkov"
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
