indexing
	description: "[
		Utility functions for working with {ES_TOOL}
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ES_TOOL_UTILITIES

inherit
	ANY

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature {NONE} -- Helpers

	file_utils: !FILE_UTILITIES
			-- Access to file utilies
		once
			create Result
		end

feature -- Query

	tool_id (a_tool: !ES_TOOL [EB_TOOL]): !STRING_32
			-- Retrieves a type identifier, used in storing and retrieving layout information, for a tool
			--
			-- `a_tool': A tool descriptor to retrieve a type identifier for.
			-- `Result': A unique identifier for the tool descriptor.
		require
			a_tool_is_interface_usable: a_tool.is_interface_usable
		local
			l_type: STRING_32
			l_edition: NATURAL_8
		do
			l_type := a_tool.generating_type
			create Result.make (l_type.count + 2)
			Result.append (l_type)

			if a_tool.is_supporting_multiple_instances then
				l_edition := a_tool.edition
				if l_edition > 1 then
					Result.append (":" + l_edition.out)
				end
			end
		ensure
			not_result_is_empty: not Result.is_empty
			result_consistent: Result.is_equal (tool_id (a_tool))
		end

	tool_info (a_tool_id: STRING_32): ?TUPLE [type: TYPE [ES_TOOL [EB_TOOL]]; edition: NATURAL_8]
			-- Examines a tool identifier and splits it into a tool type and edition.
			--
			-- `a_tool_id': A tool identifier as created with `tool_id'
			-- `Result': The parsed information split into a tool type and edition; Void if the parse failed.
		require
			a_tool_id_attached: a_tool_id /= Void
			not_a_tool_id_is_empty: not a_tool_id.is_empty
		local
			l_pos: INTEGER
			l_type: STRING_32
			l_edition: STRING_32
			l_internal: INTERNAL
			l_id: INTEGER
			l_tool_type: TYPE [ES_TOOL [EB_TOOL]]
		do
			l_pos := a_tool_id.index_of (':', 1)
			if l_pos > 1 then
				l_type := a_tool_id.substring (1, l_pos - 1)
				if l_pos < a_tool_id.count then
					l_edition := a_tool_id.substring (l_pos + 1, a_tool_id.count)
				end
			else
				l_type := a_tool_id
			end

			create l_internal
			l_type := l_type.as_upper
			if l_internal.is_valid_type_string (l_type) then
				l_id := l_internal.dynamic_type_from_string (l_type)
				if l_id > 0 then
						-- Set type
					l_tool_type ?= l_internal.type_of_type (l_id)
					if l_tool_type /= Void then
						create Result
						Result.type := l_tool_type

							-- Set edition
						if l_edition = Void then
							Result.edition := 1
						elseif l_edition.is_natural_8 then
							Result.edition := l_edition.to_natural_8
						else
								-- Invalid edition, therefore nothing can be returned.
							Result := Void
						end
					end
				end
			end
		ensure
			result_type_attached: Result /= Void implies Result.type /= Void
			result_edition_big_enough: Result /= Void implies Result.edition > 0
		end

	tool_associated_name (a_tool: !ES_TOOL [EB_TOOL]): !STRING
			-- The tool's associated name, used for modularizing development of a tool.
			--
			-- `a_tool': A tool descriptor to retrieve a type identifier for.
			-- `Result': The tool name.
		require
			a_tool_is_interface_usable: a_tool.is_interface_usable
		do
			Result ?= a_tool.generating_type.as_lower
			if Result.substring (1, (3).min (Result.count)).is_equal (once "es_") then
					-- Remove ES_ prefix
				Result.keep_tail (Result.count - 3)
				if Result.substring ((Result.count - 4).max (1), Result.count).is_equal (once "_tool") then
						-- Remove _TOOL suffix
					Result.keep_head (Result.count - 5)
				else
					check use_standard_name_convention: False end
				end
			else
				check use_standard_name_convention: False end
			end
			check not_result_is_empty: not Result.is_empty end
		ensure
			result_consistent: Result.is_equal (tool_associated_name (a_tool))
		end

	tool_associated_path (a_tool: !ES_TOOL [EB_TOOL]): !DIRECTORY_NAME
			-- The tool's associated folder, used for modularizing development of a tool.
			--
			-- `a_tool': A tool descriptor to retrieve a type identifier for.
			-- `Result': A directory name, which may or may not exist.
		require
			a_tool_is_interface_usable: a_tool.is_interface_usable
		do
			Result ?= eiffel_layout.tools_path.twin
			file_utils.create_directory (Result)

				-- Build folder and create it
			Result.extend (a_tool.name)
			file_utils.create_directory (Result)
		ensure
			not_result_is_empty: not Result.is_empty
			result_consistent: Result.is_equal (tool_associated_path (a_tool))
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
