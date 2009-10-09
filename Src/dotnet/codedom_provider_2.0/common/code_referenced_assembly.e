note
	description:	"Codedom referenced assembly."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date:			"$Date$"
	revision:		"$Revision$"

class
	CODE_REFERENCED_ASSEMBLY

inherit
	CODE_CONFIGURATION
		rename
			assembly_prefix as config_assembly_prefix
		end
create 
	make,
	make_with_prefix
		
feature {NONE} -- Initialization

	make (an_assembly: ASSEMBLY)
			-- Initialization.
			-- Set `assembly' with `an_assembly'.
		require
			non_void_an_assembly: an_assembly /= Void
		local
			l_name: STRING
			l_index: INTEGER
		do
			assembly := an_assembly
			l_name := assembly.location
			l_index := l_name.last_index_of ('\', l_name.count)
			if l_index > 0 then
				l_name.keep_tail (l_name.count - l_index)
			end
			-- Force a prefix if there isn't one so that if an Eiffel assembly is
			-- referenced base classes names don't clash.
			if l_name.is_equal ("mscorlib.dll") then
				create assembly_prefix.make_empty
			else
				assembly_prefix := config_assembly_prefix (l_name)
				if assembly_prefix = Void then
					generated_prefixes.search (l_name)
					if generated_prefixes.found then
						assembly_prefix := generated_prefixes.found_item
					else
						assembly_prefix := new_prefix
						generated_prefixes.put (assembly_prefix, l_name)
					end
				end
			end
		ensure
			assembly_prefix_set: assembly_prefix /= Void
			assembly_set: assembly = an_assembly
		end

	make_with_prefix (an_assembly: ASSEMBLY; a_prefix: STRING)
			-- Initialization.
			-- Set `assembly' with `an_assembly'.
			-- Set `assembly_prefix' with `a_prefix'.
		require
			non_void_an_assembly: an_assembly /= Void
			non_void_prefix: a_prefix /= Void
		do
			assembly := an_assembly
			assembly_prefix := a_prefix
		ensure
			assembly_prefix_set: assembly_prefix = a_prefix
			assembly_set: assembly = an_assembly
		end


feature -- Access

	assembly_prefix: STRING
			-- prefix used for assembly.
			
	assembly: ASSEMBLY
			-- actual assembly.

	cluster_name: STRING
			-- Cluster name for assembly
		do
			Result := assembly.get_name.name
			if not Result.is_empty and then not Result.item (1).is_alpha then
				Result.prepend ("a_")
			end
		ensure
			non_void_cluster_name: Result /= Void
		end

feature {NONE} -- Implementation

	new_prefix: STRING
			-- Creation procedure.
		local
			a, b, c: INTEGER
		do
			c := counter.item
			counter.set_item (counter.item + 1)
			a := c // 676
			c := c \\ 676
			b := c // 26
			c := c \\ 26
			create Result.make (4)
			Result.append_character ('A' + a)
			Result.append_character ('A' + b)
			Result.append_character ('A' + c)
			Result.append_character ('_')
		end

	counter: INTEGER_REF
			-- Counter
		once
			create Result
		end

	generated_prefixes: HASH_TABLE [STRING, STRING]
			-- Cache for generated prefixes
		once
			create Result.make (10)
		end

invariant
	non_void_assembly_prefix: assembly_prefix /= Void
	non_void_assembly: assembly /= Void

note
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
end -- Class CODE_REFERENCED_ASSEMBLY

