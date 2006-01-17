indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	PRECOMP_INFO

inherit
	HASH_TABLE [INTEGER, STRING]
		rename
			make as ht_make
		end

	SHARED_WORKBENCH
		undefine
			copy, is_equal
		end

	SYSTEM_CONSTANTS
		undefine
			copy, is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (precomp_dirs: HASH_TABLE [REMOTE_PROJECT_DIRECTORY, INTEGER];
			check_license: BOOLEAN) is
			-- Create a new structure containing precompilation info.
		require
			precomp_dirs_not_void: precomp_dirs /= Void
		do
			ht_make (precomp_dirs.count);
			from precomp_dirs.start until precomp_dirs.after loop
				force (precomp_dirs.key_for_iteration,
					precomp_dirs.item_for_iteration.dollar_name);
				precomp_dirs.forth
			end
			compiler_version := Version_number;
			compilation_id := System.compilation_id
			licensed := check_license
			name := System.name
		end

feature -- Access

	compilation_id: INTEGER
			-- Precompilation identifier

	compiler_version: STRING
			-- Compiler version

	licensed: BOOLEAN
			-- Is this precompilation protected by a license?

	name: STRING;
			-- Name of the precompiled system

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class PRECOMP_INFO
