indexing

	description: 
		"Array of click stone computed from CLICK_LIST."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class CLICK_STONE_ARRAY

inherit

	ARRAY [CLICK_STONE]
		rename
			make as array_make
		end;

create

	make
	
feature {NONE} -- Initialization

	make (list: CLICK_LIST; ref_class: CLASS_C) is
			-- Create a click_stone array from `list' 
			-- with reference class `ref_class'.
		local
			pos: INTEGER;
			a_click_ast: CLICK_AST;
			clickable: CLICKABLE_AST;
			new_click_stone: CLICK_STONE;
			c: INTEGER;
			stone: STONE;
			local_copy: like Current
		do
			if list = Void then
				array_make (1, 0);
			else
				local_copy := Current
				c := list.count;
				array_make (1, c);
				from
					pos := 1
				until
					pos > c
				loop
					a_click_ast := list.i_th (pos);
					clickable := a_click_ast.node;
					if clickable.is_class or else clickable.is_precursor then
						create {CLASSC_STONE} stone.make 
							(clickable.associated_eiffel_class (ref_class))
					else
						create {FEATURE_NAME_STONE} stone.make 
							(clickable.associated_feature_name,
								ref_class)
					end;
					create new_click_stone.make
						(stone,
						a_click_ast.start_position,
						a_click_ast.end_position);
					local_copy.put (new_click_stone, pos);
					pos := pos + 1;
				end
			end
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

end -- class CLICK_STONE_ARRAY
