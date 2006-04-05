indexing
	description: "Name formatter, checks for unicity of Eiffel type names"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_NAME_FORMATTER

inherit
	NAME_FORMATTER
		redefine
			full_formatted_type_name,
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			-- Initialize instance
		do
			create generated_names.make (100)
		end
		
feature -- Access

	full_formatted_type_name (name: STRING): STRING is
			-- Format .NET type name `name' to Eiffel class name.
			-- Ensure result is unique since last call to `reset'.
		local
			i: INTEGER
			l_name: STRING
		do
			i := name.last_index_of ('.', name.count)
			if i > 0 then
				l_name := name.substring (i + 1, name.count)
			else
				l_name := name
			end
			Result := Precursor {NAME_FORMATTER} (l_name)
			from
				if generated_names.has (Result) then
					Result.append ("_2")
					i := 3
				end
			until
				not generated_names.has (Result)
			loop
				Result.keep_head (Result.last_index_of ('_', Result.count))
				Result.append (i.out)
				i := i + 1
			end
			generated_names.put (Result, Void)
			check
				not_there: not generated_names.conflict
			end
		end

feature -- Basic Operations

	reset is
			-- Reset generated names list.
		do
			generated_names.clear_all
		end

feature {NONE} -- Implementation

	generated_names: HASH_TABLE [STRING, STRING];
			-- Generated Eiffel type names

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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


end -- class CODE_NAME_FORMATTER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------