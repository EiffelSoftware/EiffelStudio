class
	IV_UNIVERSE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize universe.
		do
			create declarations.make
			create dependencies.make
			dependencies.compare_objects
		end

feature -- Access

	declarations: LINKED_LIST [IV_DECLARATION]
			-- List of top-level declarations.

	dependencies: LINKED_LIST [PATH]
			-- List of file dependencies.

	procedure_named (a_name: READABLE_STRING_8): detachable IV_PROCEDURE
			-- Boogie procedure with name `a_name'.
		do
			from
				declarations.start
			until
				declarations.after or Result /= Void
			loop
				if attached {IV_PROCEDURE} declarations.item as l_proc and then l_proc.name.same_string (a_name) then
					Result := l_proc
				end
				declarations.forth
			end
		end

	constant_named (a_name: READABLE_STRING_8): detachable IV_CONSTANT
			-- Boogie constant with name `a_name'.
		do
			from
				declarations.start
			until
				declarations.after or Result /= Void
			loop
				if attached {IV_CONSTANT} declarations.item as l_const and then l_const.name.same_string (a_name) then
					Result := l_const
				end
				declarations.forth
			end
		end

	function_named (a_name: READABLE_STRING_8): detachable IV_FUNCTION
			-- Boogie function with name `a_name'.
		do
			from
				declarations.start
			until
				declarations.after or Result /= Void
			loop
				if attached {IV_FUNCTION} declarations.item as l_fun and then l_fun.name.same_string (a_name) then
					Result := l_fun
				end
				declarations.forth
			end
		end

feature -- Element change

	add_declaration (a_declaration: IV_DECLARATION)
			-- Add top-level declaration to `declarations'.
		require
			a_delcaration_attached: attached a_declaration
		do
			declarations.extend (a_declaration)
		ensure
			a_declaration_added: declarations.last = a_declaration
		end

	add_dependency (a_file_name: PATH)
			-- Add a file to `dependencies'.
		require
			a_file_name_attached: attached a_file_name
		do
			if not dependencies.has (a_file_name) then
				dependencies.extend (a_file_name)
			end
		ensure
			dependency_added: dependencies.has (a_file_name)
		end

feature -- Visitor

	process (a_visitor: IV_UNIVERSE_VISITOR)
			-- Process universe with `a_visitor'.
		do
			across declarations as i loop
				i.process (a_visitor)
			end
		end

	process_non_built_in (a_visitor: IV_UNIVERSE_VISITOR)
			-- Process declarations that are not built-in with `a_visitor'.
		do
			across declarations as i loop
				if not i.is_built_in then
					i.process (a_visitor)
				end
			end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2012-2014 ETH Zurich",
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
