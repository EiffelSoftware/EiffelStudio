indexing

	description: 
		"Warning for obsolete features."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class OBS_FEAT_WARN

inherit

	OBS_CLASS_WARN
		redefine
			build_explain, code, help_file_name, is_defined
		end;

feature -- Properties

	code: STRING is
		do
			Result := "Obsolete call"
		end;

	help_file_name: STRING is
		do
			Result := "OBS_CALL"
		end;

	obsolete_feature: E_FEATURE;
			-- feature name

	a_feature: E_FEATURE;
			-- Feature using the obsolete
			-- (Void `a_feature' implies feature is invariant)

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := classes_defined and then
				obsolete_feature /= Void
		ensure then
			valid_features: Result implies obsolete_feature /= Void	
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		local
			m: STRING
		do
			a_text_formatter.add ("Class: ")
			associated_class.append_name (a_text_formatter)
			if a_feature /= Void then
				a_text_formatter.add_new_line
				a_text_formatter.add ("Feature: ")
				a_feature.append_name (a_text_formatter)
			else
				a_text_formatter.add_new_line
				a_text_formatter.add ("Feature: invariant")
			end
			a_text_formatter.add_new_line
			a_text_formatter.add ("Obsolete feature: ")
			obsolete_feature.append_signature (a_text_formatter)
			a_text_formatter.add (" (class ")
			obsolete_class.append_name (a_text_formatter)
			a_text_formatter.add (")")
			a_text_formatter.add_new_line
			a_text_formatter.add ("Obsolete message: ")
			m := obsolete_feature.obsolete_message
			if m.has ('%N') then
					-- Preserve formatting for multi-line message
				a_text_formatter.add_new_line
			end
			a_text_formatter.add_multiline_string (m, 1)
			a_text_formatter.add_new_line
		end

feature -- Setting

	set_obsolete_feature (f: FEATURE_I) is
			-- Assign `f' to `obsolete_feature'
		require
			valid_f: f /= Void
		do
			obsolete_feature := f.api_feature (f.written_in)
		end;

	set_feature (f: FEATURE_I) is
			-- Assign `f' to `feature'
		require
			valid_associated_class: associated_class /= Void
		do
			if f /= Void then
				a_feature := f.api_feature (associated_class.class_id)
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

end -- class OBS_FEAT_WARN
