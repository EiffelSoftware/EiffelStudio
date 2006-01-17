indexing

	description: 
		"Command to display descendants version of `current_feature'."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_ROUTINE_DESCENDANTS 

inherit

	E_FEATURE_CMD

create
	make, default_create

feature -- Execution

	work is
		local
			classes: PART_SORTED_TWO_WAY_LIST [CLASS_C];
			rout_id_set: ROUT_ID_SET;
			i: INTEGER;
			other_feature: E_FEATURE;
			e_class: CLASS_C;
		do
			create classes.make;
			record_descendants (classes, current_class);

			rout_id_set := current_feature.rout_id_set;
			from
				i := 1;
			until
				i > rout_id_set.count
			loop
				structured_text.add_new_line;	
				structured_text.add_string ("History branch #");
				structured_text.add_int (i);
				structured_text.add_new_line;	
				structured_text.add_string ("-----------------");
				structured_text.add_new_line;	
				from
					classes.start
				until
					classes.after
				loop
					e_class := classes.item
					if e_class.has_feature_table then
						other_feature := e_class.feature_with_rout_id (rout_id_set.item (i))
						if other_feature /= Void then
							e_class.append_name (structured_text)
							structured_text.add (ti_Space)
							other_feature.append_signature (structured_text)
							structured_text.add_new_line
							structured_text.add_indent
							structured_text.add_string ("Version from class ")
							other_feature.written_class.append_name (structured_text)
							structured_text.add_new_line
						end
					end
					classes.forth
				end;
				i := i + 1
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

end -- class E_SHOW_ROUTINE_FUTURE
