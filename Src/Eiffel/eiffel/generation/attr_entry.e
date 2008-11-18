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

	is_attribute: BOOLEAN is
			-- Is the entry associated with an attribute?
		do
			Result := True
		end

feature -- previously in ATTR_UNIT

	entry (class_type: CLASS_TYPE): ATTR_ENTRY is
			-- Attribute entry in an attribute offset table
		do
			create Result
			Result.set_type_id (class_type.type_id)
			Result.set_feature_id (feature_id)
			Result.set_type (feature_type (class_type))
			if has_body then
				Result.set_has_body
			end
		end

feature -- from ATTR_ENTRY

	used: BOOLEAN is
			-- Is an attribute entry used?
		do
			Result := True
		end

	workbench_offset: INTEGER is
			-- Offset of attribute in object structure
		require
			is_attribute: is_attribute
		local
			skel: SKELETON
		do
			skel := System.class_type_of_id (type_id).skeleton;
			skel.search_feature_id (feature_id);
			Result := skel.workbench_offset
		end;

feature -- Status report

	has_body: BOOLEAN
			-- Does this attribute has an explicit body?

	is_initialization_required: BOOLEAN
			-- Is initialization of an attribute required?
		do
			Result := has_body and then type.is_initialization_required
		end

feature -- Status setting

	set_has_body
			-- Set `has_body' to True.
		do
			has_body := True
		end

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
