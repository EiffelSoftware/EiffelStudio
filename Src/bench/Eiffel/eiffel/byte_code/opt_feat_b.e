indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Enlarged access to an Eiffel special feature:
-- item, @, put of ARRAY or descendant

class OPT_FEAT_B 

inherit

	FEATURE_B
		redefine
			enlarged, inlined_byte_code
		end

feature 

	enlarged: OPT_FEAT_BL is
		do
			create Result
			Result.fill_from (Current)
		end

	set_special_feature_type is
		do
			if parameters.count = 1 then
				is_item := True
			end;
		end

	set_array_target (t: like array_desc) is
		do
			array_desc := t
		end

	set_access_area (b: BOOLEAN) is
		do
			access_area := b;
		end;

feature {OPT_FEAT_B} -- Implementation

	array_desc: ACCESS_B;
			-- Integer describing the type of target:
			-- arg: >0; Result: 0; local: <0

	is_item: BOOLEAN;

	access_area: BOOLEAN;
			-- Has the access to the area been generated in OPT_LOOP_BL ?

feature -- Inlining

	inlined_byte_code: like Current is
		do
			Result := Current
			parameters := parameters.inlined_byte_code
		end

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
