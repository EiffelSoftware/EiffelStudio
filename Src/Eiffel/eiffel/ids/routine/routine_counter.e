indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- System level routine id counter.

class ROUTINE_COUNTER

inherit
	COMPILER_COUNTER
		rename
			next_id as next_rout_id
		export
			{NONE} current_count, set_value, set_precompiled_offset,
			is_precompiled
		redefine
			make
		end

create
	make

feature -- Initialization

	make is
			-- Create a new routine id counter.
		do
			create attribute_ids.make (1, Chunk)
			Precursor {COMPILER_COUNTER}
			invariant_rout_id := next_rout_id
			initialization_rout_id := next_rout_id
			dispose_rout_id := next_rout_id
			creation_rout_id := next_rout_id
		end

feature -- Access

	is_attribute (rout_id: INTEGER): BOOLEAN is
		do
			Result := rout_id <= attribute_ids.upper
			if Result then
				Result := attribute_ids.item (rout_id)
			end
		end

	next_attr_id: INTEGER is
			-- Next attribute id
		do
			count := count + 1
			Result := count
			attribute_ids.force (True, Result)
		ensure
			id_not_void: Result /= 0
		end

	invariant_rout_id: INTEGER
	initialization_rout_id: INTEGER
	dispose_rout_id: INTEGER
	creation_rout_id: INTEGER
            -- Predefined routine ids

feature -- Status report

	is_feature_routine_id (rout_id: like next_rout_id): BOOLEAN is
			-- Does `rout_id' correspond to some feature
			-- rather than to some special service entity?
		do
			Result := not (rout_id = invariant_rout_id or
				rout_id = initialization_rout_id or
				rout_id = dispose_rout_id or
				rout_id = creation_rout_id)
		end

feature {NONE} -- Implementation

	attribute_ids: ARRAY [BOOLEAN]
			-- Let us know which entries are attributes.

	Chunk: INTEGER is 500;
			-- Size of an array chunk at beginning.

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

end -- class ROUTINE_COUNTER
