indexing

	description:
		"Abstract description for a class format command which%
		%displays features of `current_class' that follow `criterium'."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class E_CLASS_FORMAT_CMD

inherit

	SHARED_EIFFEL_PROJECT;
	E_CLASS_CMD

feature -- Access

	criterium (f: E_FEATURE): BOOLEAN is
			-- Criterium for feature `f'
		require
			f_not_void: f /= Void
		deferred
		end;

	display_feature (f: E_FEATURE; st: TEXT_FORMATTER) is
			-- Display feature `f' defined in class `c'
			-- to `st'.
		require
			f_not_void: f /= Void
			st_not_void: st /= Void
		do
			f.append_signature (st);
		end;

feature -- Execution

	work is
			-- Display routines of `current_class' that follow `criterium'.
		local
				-- Compiler structures
			feature_table: E_FEATURE_TABLE;
			e_feature: E_FEATURE;
			e_class: CLASS_C;
			id: INTEGER;
				-- Temporary structures
			list: SORTED_TWO_WAY_LIST [E_FEATURE];
			table: HASH_TABLE [SORTED_TWO_WAY_LIST [E_FEATURE], INTEGER];
			classes: PART_SORTED_TWO_WAY_LIST [CLASS_C];
			c: like current_class
		do
			c := current_class;
			feature_table := c.api_feature_table;

			-- Group the features in terms of their origin.
			from
				create table.make (20);
				create classes.make;
				feature_table.start
			until
				feature_table.after
			loop
				e_feature := feature_table.item_for_iteration;
				if criterium (e_feature) then
					e_class := e_feature.written_class;
					id := e_class.class_id;
					if table.has (id) then
						list := table.found_item
					else
						create list.make;
						table.put (list, id);
						classes.put_front (e_class);
					end;
					list.put_front (e_feature);
				end;
				feature_table.forth
			end;
			classes.sort;

				-- Display the features.
			from
				classes.start
			until
				classes.after
			loop
				text_formatter.add ("Class ");
				e_class := classes.item;
				e_class.append_signature (text_formatter, True);
				text_formatter.add (":");
				text_formatter.add_new_line;
				text_formatter.add_new_line;
				list := table.item (e_class.class_id);
				list.sort;
				from
					list.start
				until
					list.after
				loop
					e_feature := list.item;
					text_formatter.add_indent;
					display_feature (e_feature, text_formatter);
					text_formatter.add_new_line;
					list.forth
				end;
				text_formatter.add_new_line;
				classes.forth
			end
		end

feature {NONE} -- Implementation

	any_class: CLASS_C is
		once
			Result := Eiffel_system.any_class.compiled_class
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

end -- class E_CLASS_FORMAT_CMD
