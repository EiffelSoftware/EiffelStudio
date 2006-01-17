indexing

	description: 
		"Displays class text in output_window."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_TEXT 

inherit

	EWB_FILTER_CLASS
		rename
			name as text_cmd_name,
			help_message as text_help,
			abbreviation as text_abb
		redefine
			process_uncompiled_class, process_compiled_class,
			want_compiled_class
		end

create
	make, default_create

feature {NONE} -- Implementation

	associated_cmd: E_CLASS_CMD is
			-- Associated class command to be executed
			-- after successfully retrieving the compiled
			-- class
		do
			check
				not_be_called: false
			end
		end;

feature {NONE} -- Execution

	want_compiled_class (class_i: CLASS_I): BOOLEAN is
			-- Does Current want `class_i' to be compiled?
			--| If the class is in the system: True
			--| else: False.
		do
			Result := class_i.compiled_class /= Void
		end;

	process_compiled_class (e_class: CLASS_C) is
			-- Display the (may be) filtered text of `e_class'.
		local
			ctxt: CLASS_TEXT_FORMATTER;
			filter: TEXT_FILTER
		do
			create ctxt;
			ctxt.set_one_class_only;
			ctxt.set_order_same_as_text;
			ctxt.format (e_class);
			if filter_name = Void or else filter_name.is_empty then
				output_window.put_string (ctxt.text.image);
			else
				create filter.make (filter_name);
				filter.process_text (ctxt.text);
				output_window.put_string (filter.image);
			end;
			output_window.put_new_line;
		end;

	process_uncompiled_class (class_i: CLASS_I) is
			-- Display the class text.
		local
			text: STRING
		do
			if class_i.file_name /= Void then
				text := class_i.text
			end;
			if text /= Void then
				output_window.put_string (text);
				output_window.put_new_line;
			else
				output_window.put_string ("Cannot open ");
				output_window.put_string (class_i.file_name);
				output_window.put_new_line;
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

end -- class EWB_TEXT
