note

	description:
		"Error for join rule when argument number is not the same."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VDJR

inherit

	EIFFEL_ERROR
		redefine
			build_explain, is_defined, trace_primary_context
		end;

	SHARED_WORKBENCH
		undefine
			is_equal
		end

feature -- Properties

	old_feature: E_FEATURE;
			-- Inherited feature

	new_feature: E_FEATURE;
			-- Joined feature

	code: STRING = "VDJR";
			-- Error code

feature -- Access

	is_defined: BOOLEAN
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				old_feature /= Void and then
				new_feature /= Void
		ensure then
			valid_old_feature: Result implies old_feature /= Void;
			valid_new_feature: Result implies new_feature /= Void
		end

feature -- Output

	print_signatures (a_text_formatter: TEXT_FORMATTER)
		local
			oclass, nclass: CLASS_C
		do
			oclass := old_feature.written_class;
			nclass := new_feature.written_class;
			a_text_formatter.add ("First feature: ");
			old_feature.append_signature (a_text_formatter);
			a_text_formatter.add_new_line;
			a_text_formatter.add ("Version from: ");
			oclass.append_name (a_text_formatter);
			a_text_formatter.add_new_line;
			a_text_formatter.add ("Second feature: ");
			new_feature.append_signature (a_text_formatter);
			a_text_formatter.add_new_line;
			a_text_formatter.add ("Version from: ");
			nclass.append_name (a_text_formatter);
			a_text_formatter.add_new_line;
		end;

	build_explain (a_text_formatter: TEXT_FORMATTER)
		do
			a_text_formatter.add ("Different numbers of arguments");
			a_text_formatter.add_new_line;
			print_signatures (a_text_formatter);
		end;

	trace_primary_context (a_text_formatter: TEXT_FORMATTER)
			-- Build the primary context string so errors can be navigated to
		do
			if {l_formatter: !TEXT_FORMATTER} a_text_formatter and then {l_feature: !like new_feature} new_feature and then {l_class: !like class_c} class_c then
				print_context_feature (l_formatter, l_feature, l_class)
			else
				Precursor (a_text_formatter)
			end
		end

feature {COMPILER_EXPORTER}

	init (old_feat, new_feat: FEATURE_I)
			-- Initialization
		require
			not (old_feat = Void or else new_feat = Void);
		do
			class_c := System.current_class;
			old_feature := old_feat.api_feature (old_feat.written_in);
			new_feature := new_feat.api_feature (new_feat.written_in);
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

end -- class VDJR
