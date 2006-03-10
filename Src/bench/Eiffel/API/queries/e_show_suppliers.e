indexing

	description:
		"Command to display suppliers of `current_class'."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"


class E_SHOW_SUPPLIERS

inherit

	E_CLASS_CMD

create
	make, default_create

feature -- Output

	work is
			-- Execute Current command.
		local
			suppliers: SORTED_TWO_WAY_LIST [CLASS_I];
			a_supplier: CLASS_C
		do
			text_formatter.add ("Suppliers of class ");
			current_class.append_signature (text_formatter, True);
			text_formatter.add (":");
			text_formatter.add_new_line;
			text_formatter.add_new_line;
			from
				suppliers := sorted_list (current_class.suppliers.classes);
				suppliers.start
			until
				suppliers.after
			loop
				a_supplier := suppliers.item.compiled_class;
				if (current_class /= a_supplier) then
					text_formatter.add_indent;
					a_supplier.append_signature (text_formatter, True);
					text_formatter.add_new_line
				end;
				suppliers.forth
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

end -- class E_SHOW_SUPPLIERS
