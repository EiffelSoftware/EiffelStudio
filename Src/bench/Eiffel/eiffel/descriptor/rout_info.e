indexing
	description: "[
		Information about a routine.
		A routine represents a feature with all its versions in descendant classes, 
		obtained through renaming or adaptation. a new routine is introduced either 
		when there are no precursors or trough duplication (in the case of repeated 
		inheritance). a routine has an origin, which is the class in which it was 
		introduced, and an offset which is an unique identification number of the 
		routine in the origin class.
		Currently the offset mechanism is only used in workbench mode since it is 
		more incremental but yields less efficient feature call mechanism.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	FIXME: "Manu 1/18/2002: should be made expanded when they work."	
	date: "$Date$"
	revision: "$Revision$"

class
	ROUT_INFO 

create
	make

feature -- Initialization

	make (org: CLASS_C; offs: INTEGER) is
		require
			org_not_void: org /= Void
			valid_offset: offs >= 0
		do
			origin := org.class_id
			offset := offs
		ensure
			origin_set: origin = org.class_id
			offset_set: offset = offs
		end

feature -- Access

	origin: INTEGER
			-- Class in which routine was initially declared.

	offset: INTEGER
			-- Offset of routine in origin class.
			-- This offset is used at run-time to locate
			-- routine in objects conforming to origin class.

invariant
	valid_origin: origin > 0
	valid_offset: offset >= 0

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

end -- class ROUT_INFO
