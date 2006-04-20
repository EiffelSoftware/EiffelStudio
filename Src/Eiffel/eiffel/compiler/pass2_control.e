indexing
	description: "Second pass controler: it is the result of the incrementality%
		%test after the second pass"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class PASS2_CONTROL 

inherit
	PASS_CONTROL
		redefine
			wipe_out, make
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialization
		do
			Precursor {PASS_CONTROL}
			create old_externals.make (50)
			create new_externals.make (50)
		end

feature -- Settings

	add_external (an_external: EXTERNAL_I) is
			-- Assign `an_external' to `new_externals'.
		require
			an_external_not_void: an_external /= Void
		do
			new_externals.extend (an_external)
		end

	remove_external (an_external: EXTERNAL_I) is
			-- Add `an_external' to `old_externals'.
		require
			an_external_not_void: an_external /= Void
		do
			if not old_externals.has (an_external) then
				old_externals.extend (an_external)
			end
		end

feature -- Processing

	process_externals is
			-- Update the system external feature controler
		require
			new_externals_exists: new_externals /= Void
		local
			l_externals: EXTERNALS
			l_external: EXTERNAL_I
		do
			l_externals := System.externals
			from
				old_externals.start
			until
				old_externals.after
			loop
				l_external := old_externals.item
				if l_externals.has (l_external.written_in) then
					l_externals.remove_external (l_external)
				end
				old_externals.forth
			end

			from
				new_externals.start
			until
				new_externals.after
			loop
				l_externals.add_external (new_externals.item)
				new_externals.forth
			end
		end

feature -- Removal

	wipe_out is
			-- Empty the structure
		do
			Precursor {PASS_CONTROL}
			old_externals.wipe_out
			new_externals.wipe_out
		end

feature -- Access

	old_externals: ARRAYED_LIST [EXTERNAL_I]
			-- Old externals written in a class
			-- | Processed by feature `pass2_control' of FEATURE_TABLE

	new_externals: ARRAYED_LIST [EXTERNAL_I];
			-- New externals written in a class
			-- | Processed by feature `feature_unit' of INHERIT_TABLE

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

end -- class PASS2_CONTROL
