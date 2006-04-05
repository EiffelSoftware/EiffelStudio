indexing

	description:
		"Command to display ancestors version of `current_feature'."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"


class E_SHOW_ROUTINE_ANCESTORS

inherit

	E_FEATURE_CMD

create
	make, default_create

feature -- Execution

	work is
		local
			classes: PART_SORTED_TWO_WAY_LIST [CLASS_C];
			rout_id_set: ROUT_ID_SET;
			rout_id: INTEGER;
			i: INTEGER;
			other_feature: E_FEATURE;
			c: CLASS_C
		do
			create classes.make;
			rec_add_parents (classes, current_class);

			rout_id_set := current_feature.rout_id_set;
			from
				i := 1;
			until
				i > rout_id_set.count
			loop
				rout_id := rout_id_set.item (i);
				text_formatter.add_new_line;
				text_formatter.add ("History branch #");
				text_formatter.add_int (i);
				text_formatter.add_new_line;
				text_formatter.add ("-----------------");
				text_formatter.add_new_line;
				from
					classes.start
				until
					classes.after
				loop
					c := classes.item;
					other_feature := c.feature_with_rout_id (rout_id);
					if other_feature /= Void then
						classes.item.append_name (text_formatter);
						text_formatter.add (ti_Space);
						other_feature.append_signature (text_formatter);
						text_formatter.add_new_line;
						text_formatter.add_indent;
						text_formatter.add ("Version from class ");
						other_feature.written_class.append_name (text_formatter);
						text_formatter.add_new_line;
					end;
					classes.forth
				end;
				i := i + 1
			end;
		end;

	rec_add_parents (classes: PART_SORTED_TWO_WAY_LIST [CLASS_C];
			e_class: CLASS_C) is
			-- Record parents of `class_c' to `classes'.	
		local
			parents: FIXED_LIST [CL_TYPE_A];
			e_parent: CLASS_C
		do
			parents := e_class.parents;
			classes.extend (e_class);
			from
				parents.start
			until
				parents.after
			loop
				e_parent := parents.item.associated_class;
				if not classes.has (e_parent) then
					rec_add_parents (classes, e_parent);
				end;
				parents.forth;
			end;
		end;

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

end -- class E_SHOW_ROUTINE_ANCESTORS
