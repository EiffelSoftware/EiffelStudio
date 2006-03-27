indexing

	description:
		"Command to display list of the classes in the%
		%universe, in alphabetical order."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_CLASSES

inherit
	E_OUTPUT_CMD;
	SHARED_EIFFEL_PROJECT

create
	make, do_nothing

feature -- Execution

	work is
			-- Show classes in universe
		local
			l_groups: ARRAYED_LIST [CONF_GROUP];
			cursor: CURSOR;
			l_classes: HASH_TABLE [CONF_CLASS, STRING];
			l_sorted_classes: SORTED_TWO_WAY_LIST [CONF_CLASS];
			a_classi: CLASS_I;
			a_classe: CLASS_C;
		do
			l_groups := Eiffel_universe.groups
			if not l_groups.is_empty then
				create l_sorted_classes.make;
				from
					l_groups.start
				until
					l_groups.after
				loop
					cursor := l_groups.cursor;
					l_classes := l_groups.item.classes;
					if l_classes /= Void then
						from
							l_classes.start
						until
							l_classes.after
						loop
							l_sorted_classes.put_front (l_classes.item_for_iteration);
							l_classes.forth
						end;
					end
					l_groups.go_to (cursor);
					l_groups.forth
				end;
				l_sorted_classes.sort;
				from
					l_sorted_classes.start
				until
					l_sorted_classes.after
				loop
					a_classi ?= l_sorted_classes.item;
					check
						a_classi_not_void: a_classi /= Void
					end
					a_classe := a_classi.compiled_class;
					if a_classe /= Void then
						a_classe.append_signature (text_formatter, True)
					else
						a_classi.append_name (text_formatter)
					end;
					text_formatter.add_new_line;
					text_formatter.add_indent;
					text_formatter.add ("-- Group: ");
					text_formatter.add_group (a_classi.group, a_classi.group.name);
					text_formatter.add_new_line;
					l_sorted_classes.forth
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

end -- class E_SHOW_CLASSES
