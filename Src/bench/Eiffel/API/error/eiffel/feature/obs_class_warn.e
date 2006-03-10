indexing

	description:
		"Warning for obsolete features."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class OBS_CLASS_WARN

inherit
	EIFFEL_WARNING
		redefine
			build_explain, help_file_name,
			is_defined
		end;

feature -- Properties

	obsolete_class: CLASS_C;
			-- Obsolete class

	code: STRING is
			-- Error code
		do
			Result := "Obsolete";
		end;

	help_file_name: STRING is
		do
			Result := "OBS_CLASS"
		end;

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := classes_defined
		end;

	classes_defined: BOOLEAN is
			-- Is the feature defined for error?
		do
			Result := associated_class /= Void and then
				obsolete_class /= Void
		ensure
			yes_implies_valid_classes: Result implies
							associated_class /= Void and then
							obsolete_class /= Void
		end;

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		local
			m: STRING
		do
			a_text_formatter.add ("Class: ")
			associated_class.append_name (a_text_formatter)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Obsolete class: ")
			obsolete_class.append_name (a_text_formatter)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Obsolete message: ")
			m := obsolete_class.obsolete_message
			if m.has ('%N') then
					-- Preserve formatting for multi-line message
				a_text_formatter.add_new_line
			end
			a_text_formatter.add_multiline_string (m, 1)
			a_text_formatter.add_new_line
		end

feature {COMPILER_EXPORTER}

	set_class (c: CLASS_C) is
		require
			valid_c: c /= Void
		do
			associated_class := c
		end;

	set_obsolete_class (c: CLASS_C) is
		require
			valid_c: c /= Void
		do
			obsolete_class := c
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

end -- class OBS_CLASS_WARN
