indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Representation for an attribute entry in an instance of ATTR_TABLE

class ATTR_ENTRY

inherit
	ENTRY
		redefine
			is_attribute
		end

feature -- for dead code removal

	is_attribute: BOOLEAN is True
			-- is the feature_i associated an attribute ?

feature -- previously in ATTR_UNIT

	new_poly_table (routine_id: INTEGER): ATTR_TABLE is
			-- New associated polymorhic table
		do
			create Result.make (routine_id)
		end;

	entry (class_type: CLASS_TYPE): ATTR_ENTRY is
			-- Attribute entry in an attribute offset table
		do
			create Result;
			Result.set_type_id (class_type.type_id);
			Result.set_feature_id (feature_id);
			Result.set_type (feature_type (class_type));
		end;

feature -- from ATTR_ENTRY

	make_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for an offset entry
		do
				-- Dynamic type
			ba.append_short_integer (type_id - 1);
				-- Offset encoding
			System.class_type_of_id (type_id).skeleton.make_offset_byte_code
					(ba, feature_id);
		end;

	used: BOOLEAN is True;
			-- Is an attribute entry used ?

	workbench_offset: INTEGER is
			-- Offset of attribute in object structure
		local
			skel: SKELETON
		do
			skel := System.class_type_of_id (type_id).skeleton;
			skel.search_feature_id (feature_id);
			Result := skel.workbench_offset
		end;

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

end
