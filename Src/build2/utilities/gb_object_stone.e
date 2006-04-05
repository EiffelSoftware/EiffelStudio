indexing
	description: "Objects that represent stones for transport which carry a GB_OBJECT"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_OBJECT_STONE

feature -- Access

	object: GB_OBJECT is
			-- Object which `Current' is representing.
		deferred
		end

	object_type: STRING is
			-- EiffelVision2 Type of object represented.
		deferred
		end

	is_instance_of_top_level_object: BOOLEAN is
			-- Does `object' represent a top level object?
		do
			Result := associated_top_level_object > 0
		end

	associated_top_level_object: INTEGER
		-- The id of the top level object `Current' represents,
		-- or `0' if NONE.

	all_contained_instances: HASH_TABLE [INTEGER, INTEGER]
		-- All instance of other widget structures that are contained in the
		-- current object structure.

invariant
	all_contained_instance_not_void: all_contained_instances /= Void

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


end -- class GB_OBJECT_STONE
