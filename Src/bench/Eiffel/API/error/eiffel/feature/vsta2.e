indexing
	description: "Error when feature is not valid for static access."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VSTA2 

inherit
	FEATURE_ERROR
		redefine
			build_explain, is_defined, subcode
		end

feature -- Access

	code: STRING is "VSTA"
			-- Error code
			
	subcode: INTEGER is 2

	non_static_feature: E_FEATURE
			-- Name of routine on which non-valid static access is performed.

feature -- Status report

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				is_feature_defined and then	
				non_static_feature /= Void
		ensure then
			valid_non_static_feature: Result implies non_static_feature /= Void
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		local
			ec: CLASS_C
		do
			ec := non_static_feature.written_class
			a_text_formatter.add ("Not valid for static call: ")
			non_static_feature.append_name (a_text_formatter)
			a_text_formatter.add (" from ")
			ec.append_name (a_text_formatter)
			a_text_formatter.add_new_line
		end

feature -- Setting

	set_non_static_feature (f: FEATURE_I) is
		require
			valid_f: f /= Void
		do
			non_static_feature := f.api_feature (f.written_in)
		end

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

end -- class VSTA2
