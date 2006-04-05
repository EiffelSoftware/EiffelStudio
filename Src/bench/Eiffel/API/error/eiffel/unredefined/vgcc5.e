indexing

	description: 
		"Error the feature called after a creation is not a creation procedure."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VGCC5 

inherit

	VGCC
		redefine
			subcode, build_explain
		end

feature -- Properties

	subcode: INTEGER is 6

	creation_feature: E_FEATURE;
			-- Creation feature involved

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
			print_name (a_text_formatter);
			a_text_formatter.add ("Feature name: ");
			if creation_feature /= Void then
				creation_feature.append_signature (a_text_formatter);
			end;
			a_text_formatter.add_new_line;
		end;

feature {COMPILER_EXPORTER}

	set_creation_feature (f: FEATURE_I) is
			-- Assign `f' to `creation_feature'.
		do
			if f /= Void then
				creation_feature := f.api_feature (f.written_in);
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

end -- class VGCC5
