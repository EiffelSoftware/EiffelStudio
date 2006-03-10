indexing

	description:
		"Display the implementers of a `current_feature'."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_ROUTINE_IMPLEMENTERS

inherit

	E_FEATURE_CMD;
	SHARED_EIFFEL_PROJECT

create
	make, default_create

feature -- Execution

	work is
		local
			classes: PART_SORTED_TWO_WAY_LIST [CLASS_C];
			rout_id_set: ROUT_ID_SET;
			rout_id: INTEGER;
			i: INTEGER;
			written_in: INTEGER;
			feat: E_FEATURE;
			c: CLASS_C;
			written_cl: CLASS_C;
			precursors: LIST [CLASS_C];
			rc: INTEGER
        do
			written_cl := current_feature.written_class;
			precursors := current_feature.precursors;
			create classes.make;
			record_descendants (classes, current_class);
			if not classes.has (current_class) then
				classes.extend (current_class)
			end;
			if precursors /= Void then
				classes.append (precursors)
			end;
			rout_id_set := current_feature.rout_id_set;
			from
				rc := rout_id_set.count;
				i := 1
			until
				i > rc
			loop
				rout_id := rout_id_set.item (i);
				if rc > 1 then
					text_formatter.add_new_line;
					text_formatter.add ("Class history branch #");
					text_formatter.add_int (i);
					text_formatter.add_new_line;
					text_formatter.add ("-----------------------");
					text_formatter.add_new_line;
				end;
				from
					classes.start;
				until
					classes.after
				loop
					c := classes.item;
					written_in := c.class_id;
					if c.has_feature_table then
						feat := c.feature_with_rout_id (rout_id);
						if feat /= Void and then feat.written_in = written_in then
							c.append_name (text_formatter);
							text_formatter.add (ti_Space);
							feat.append_full_name (text_formatter);
							if c = written_cl then
								text_formatter.add (" (version from)");
							end;
							text_formatter.add_new_line;
						end
					end
					classes.forth
				end;
				i := i + 1
			end;
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

end -- class E_SHOW_ROUTINE_IMPLEMENTERS
