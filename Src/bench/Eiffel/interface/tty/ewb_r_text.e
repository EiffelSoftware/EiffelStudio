indexing

	description:
		"Displays routine text in output_window."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_R_TEXT

inherit

	EWB_FEATURE
		rename
			name as text_cmd_name,
			help_message as r_text_help,
			abbreviation as text_abb
		redefine
			process_feature
		end

create
	make, default_create

feature {NONE} -- Implementation

	associated_cmd: E_FEATURE_CMD is
			-- Associated feature command to be executed
			-- after successfully retrieving the feature_i
			-- (No associated cmd)
		do
			check
				not_be_called: false
			end
		end;

	process_feature (e_feature: E_FEATURE; e_class: CLASS_C) is
			-- Process feature `e_feature' defined in `e_class'.
		local
			filter: TEXT_FILTER
			l_error: BOOLEAN
		do
			if e_class.file_name /= Void then
				if filter_name /= Void and then not filter_name.is_empty then
					create filter.make (filter_name);
					l_error := e_feature.text (filter)
					if not l_error then
						output_window.put_string (filter.image)
					end
				else
					l_error := e_feature.text (output_window)
				end
				output_window.put_new_line

				if l_error then
					output_window.put_string ("Cannot open ");
					output_window.put_string (e_class.file_name);
					output_window.put_new_line;
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

end -- class EWB_R_TEXT
