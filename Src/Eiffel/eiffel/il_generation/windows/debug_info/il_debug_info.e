indexing
	description: "Common information about System used by IL_DEBUG_INFO_XYZ objects"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_DEBUG_INFO

inherit
	ANY

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
		end

feature {SHARED_IL_DEBUG_INFO} -- Reset

	reset is
		do
			internal_class_types := Void
		end

feature -- Class info

	class_of_id (a_cls_id: INTEGER): CLASS_C is
			-- -- Class of id `a_cls_id'
		require
			a_cls_id_void: a_cls_id /= 0			
		do
			Result := System.class_of_id (a_cls_id)
		end
		
feature -- Class Types info

	class_types: ARRAY [CLASS_TYPE] is
			-- List all class types in system indexed using both `implementation_id' and
			-- `static_type_id'.
		local
			i, nb: INTEGER
			l_class_type: CLASS_TYPE
			l_class_types: ARRAY [CLASS_TYPE]
		do
			Result := internal_class_types
			if Result = Void then
					-- Collect all class types in system and initialize `internal_class_types'.
				from
					l_class_types := System.class_types
					i := l_class_types.lower
					nb := l_class_types.upper
					create Result.make (0, System.Static_type_id_counter.count)
				until
					i > nb
				loop
					l_class_type := l_class_types.item (i)
					if l_class_type /= Void then
						Result.put (l_class_type, l_class_type.static_type_id)
						Result.put (l_class_type, l_class_type.implementation_id)
					end
					i := i + 1
				end
				internal_class_types := Result
			end
		ensure
			class_types_not_void: Result /= Void
			class_types_not_empty: Result.count > 0
		end

feature {NONE} -- Class Types info Implementation

	internal_class_types: ARRAY [CLASS_TYPE];
			-- Array of CLASS_TYPE in system indexed by `implementation_id' and
			-- `static_type_id' of CLASS_TYPE.

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

end
