note

	description:
		"Error for a creation of an instance of a deferred class."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VGCC2

inherit

	VGCC
		redefine
			subcode, print_name
		end

feature -- Properties

	subcode: INTEGER = 2;

	set_deferred_classes (a_deferred_class_list: LIST[CLASS_C])
			-- Set deferred_classes to `a_list_of_deferred_classes'.
		require
			a_deferred_class_list_not_void: a_deferred_class_list /= Void
		do
			deferred_classes := a_deferred_class_list
		end

	deferred_classes: LIST[CLASS_C]
			-- List of deferred classes

feature -- Output

print_name (a_text_formatter: TEXT_FORMATTER)
		do
			if target_name /= Void then
				a_text_formatter.add ("Creation of: ");
				a_text_formatter.add (target_name);
				a_text_formatter.add_new_line;
			end
			a_text_formatter.add ("Target type set: ");
			type.append_to (a_text_formatter);
			a_text_formatter.add_new_line;
			a_text_formatter.add ("Deferred classes: ")
			deferred_classes.do_all (agent (t: TEXT_FORMATTER; c: CLASS_C)
								do
								 		c.append_name (t)
										t.add (" ")
								end (a_text_formatter, ?))
			a_text_formatter.add_new_line
		end;

note
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

end -- class VGCC2
