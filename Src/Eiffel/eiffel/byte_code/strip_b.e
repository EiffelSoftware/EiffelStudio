indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Byte code for strip expression

class STRIP_B

inherit
	EXPR_B
		redefine
			enlarged, is_type_fixed, size
		end

	SHARED_INSTANTIATOR

create
	make

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_strip_b (Current)
		end

feature

	feature_ids: LINKED_SET [INTEGER]
			-- Set of attributes feature ids to strip from the current
			-- type

	make is
		do
			create feature_ids.make
		end

	type: GEN_TYPE_A is
			-- Type of byte code strip expression
		do
			Result := Instantiator.array_type
		end

	used (r: REGISTRABLE): BOOLEAN is
		do
		end;

	enlarged: STRIP_BL is
			-- Enlarge node
		do
			create Result;
			Result.set_feature_ids (feature_ids)
		end;

	attribute_names: LINKED_LIST [STRING] is
			-- Get routine ids.
		local
			skeleton: SKELETON;
			attr: ATTR_DESC;
		do
			skeleton := Context.class_type.skeleton;
			from
				create Result.make;
				feature_ids.start
			until
				feature_ids.after
			loop
				skeleton.search_feature_id (feature_ids.item);
				attr := skeleton.item;
					--! Should always be found
				Result.put_right (attr.attribute_name);
				Result.forth;
				feature_ids.forth;
			end;
		end;

feature -- Status report

	is_type_fixed: BOOLEAN is True
			-- Is type of the expression statically fixed,
			-- so that there is no variation at run-time?

feature -- Inlining

	size: INTEGER is
		do
			Result := feature_ids.count + 1
		end

invariant

	set_exists: feature_ids /= Void

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
