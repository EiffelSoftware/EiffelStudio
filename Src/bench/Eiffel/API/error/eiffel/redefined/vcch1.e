indexing

	description: 
		"Error when a non-deferred class has a deferred feature."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VCCH1 

inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode, is_defined
		end
	
feature -- Properties

	deferred_feature: E_FEATURE;
			-- Deferred feature in non deferred class

	code: STRING is "VCCH";
			-- Error code

	subcode: INTEGER is 1;

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				deferred_feature /= Void
		ensure then
			valid_deferred_feature: Result implies deferred_feature /= Void
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
		local
			wclass: CLASS_C;
		do
			wclass := deferred_feature.written_class;
			a_text_formatter.add ("Deferred feature: ");
			deferred_feature.append_name (a_text_formatter);
			a_text_formatter.add (" From: ");
			wclass.append_name (a_text_formatter);
			a_text_formatter.add_new_line;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_a_feature (f: FEATURE_I) is
			-- Assign `f' to `a_feature'.
		require
			valid_f: f /= Void
		do
			deferred_feature := f.api_feature (f.written_in);
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

end -- class VCCH1
