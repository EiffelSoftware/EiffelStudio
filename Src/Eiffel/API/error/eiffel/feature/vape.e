indexing
	description: "Error when feature is not legally exported."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VAPE

inherit

	FEATURE_ERROR
		redefine
			build_explain, is_defined
		end

feature

	code: STRING is "VAPE"
			-- Error code

	exported_feature: E_FEATURE
			-- Name of routine not sufficiently exported.

feature -- Access

	is_defined: BOOLEAN is
			-- Is error fully defined?
		do
			Result := is_class_defined and then
				is_feature_defined and then
				exported_feature /= Void
		ensure then
			valid_exported_feature: Result implies exported_feature /= Void
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Construct `a_text_formatter' with error.
		local
			ec: CLASS_C
		do
			ec := exported_feature.written_class
			a_text_formatter.add ("Insufficiently exported feature: ")
			exported_feature.append_name (a_text_formatter)
			a_text_formatter.add (" from ")
			ec.append_name (a_text_formatter)
			a_text_formatter.add_new_line
		end

feature {ACCESS_FEAT_AS, CREATION_EXPR_AS, BINARY_AS, UNARY_AS, AST_FEATURE_CHECKER_GENERATOR} -- Setting

	set_exported_feature (f: FEATURE_I) is
			-- Set `exported_feature' to `f'.
		require
			valid_f: f /= Void
		do
			exported_feature := f.api_feature (f.written_in)
		ensure
			exported_feature_not_void: exported_feature /= Void
		end

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

end -- class VAPE
