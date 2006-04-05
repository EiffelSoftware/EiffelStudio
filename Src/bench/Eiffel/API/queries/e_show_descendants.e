indexing

	description:
		"Command to display descendants of `current_class'."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_DESCENDANTS

inherit

	E_CLASS_CMD

create
	make, default_create

feature -- Output

	work is
			-- Execute Current command.	
		do
			create displayed.make;
			current_class.append_signature (text_formatter, True);
			text_formatter.add_new_line;
			rec_display (1, current_class, text_formatter);
			displayed := Void
		end;

feature {NONE} -- Implementation

	displayed: LINKED_LIST [CLASS_C];

	rec_display (i: INTEGER; c: CLASS_C; a_text_formatter: TEXT_FORMATTER) is
			-- Display parents of `c' in tree form.
		local
			descendants: ARRAYED_LIST [CLASS_C]
			descendant_class: CLASS_C;
		do
			descendants := c.descendants;
			if not descendants.is_empty then
				from
					descendants.start
				until
					descendants.after
				loop
					descendant_class := descendants.item;
					add_tabs (a_text_formatter, i);
					descendant_class.append_signature (a_text_formatter, True);
					if displayed.has (descendant_class) then
						if not descendant_class.descendants.is_empty then
							a_text_formatter.add ("...")
						end;
						a_text_formatter.add_new_line;
					else
						a_text_formatter.add_new_line;
						displayed.extend (descendant_class);
						displayed.finish
						rec_display (i+1, descendant_class, a_text_formatter);
					end;
					descendants.forth
				end
			end
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

end -- class E_SHOW_DESCENDANTS
