note
	description: "Boogie executable for Windows."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_PLATFORM_EXECUTABLE_IMPL

inherit

	E2B_PLATFORM_EXECUTABLE
		redefine
			default_create
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		redefine
			default_create
		end

feature {NONE} -- Implementation

	default_create
			-- Initialize Windows executable.
		local
		    index: INTEGER
		do
            index := unique_number
			boogie_file_name := system.eiffel_project.project_directory.target_path.extended ("Proofs").extended ("autoproof" + index.out + ".bpl")
			boogie_output_file_name := system.eiffel_project.project_directory.target_path.extended ("Proofs").extended ("output" + index.out + ".txt")
			model_file_name := system.eiffel_project.project_directory.target_path.extended ("Proofs").extended ("ce" + index.out + ".model")

			create input.make
		end

feature {NONE} -- Implementation

	boogie_file_name: PATH
			-- <Precursor>

	boogie_output_file_name: PATH
			-- <Precursor>

	model_file_name: PATH
			-- <Precursor>

	boogie_executable: READABLE_STRING_32
			-- <Precursor>
		local
			p: PATH
		once
				-- 0. Assume it's in the PATH.
			Result := {STRING_32} "boogie" + {EIFFEL_LAYOUT}.eiffel_layout.executable_suffix
			if {EIFFEL_LAYOUT}.is_eiffel_layout_defined then
					-- 1. Look in the installation directory.
				p := {EIFFEL_LAYOUT}.eiffel_layout.tools_path.extended ("boogie").extended (Result)
				if (create {RAW_FILE}.make_with_path (p)).exists then
					Result := p.name
				end
			end
		end



	global_counter: CELL [INTEGER]
		once
			create Result.put (0)
		end

	unique_number: INTEGER
		do
			Result := global_counter.item
			global_counter.put (Result + 1)
		end

note
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
