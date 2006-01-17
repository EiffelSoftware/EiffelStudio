indexing
	description: "Generate error when a list of possible overloaded features matches a call."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VIOF

inherit
	FEATURE_ERROR
		redefine
			build_explain
		end

create
	make

feature {NONE} -- Initialization

	make (
			a_class: like class_c; a_feature: FEATURE_I; a_features: like matching_features;
			a_name: like feature_name; a_class_id: like context_class_id;
			a_list_type: like arg_list)
		is
			-- Create VIOF instance with `l_features'.
		require
			a_class_not_void: a_class /= Void
			a_feature_not_void: a_feature /= Void
			a_features_not_void: a_features /= Void
			a_features_not_empty: not a_features.is_empty
			a_name_not_void: a_name /= Void
			a_class_id_positive: a_class_id > 0
			a_list_type_not_void: a_list_type /= Void
			a_list_type_not_empty: not a_list_type.is_empty
		do
			class_c := a_class
			set_feature (a_feature)
			matching_features := a_features
			feature_name := a_name
			context_class_id := a_class_id
			arg_list := a_list_type
		ensure
			class_c_set: class_c = a_class
			e_feature_set: e_feature /= Void
			matching_features_set: matching_features = a_features
			feature_name_set: feature_name = a_name
			context_class_id_set: context_class_id = a_class_id
			arg_list_set: arg_list = a_list_type
		end
		
feature -- Access

	code: STRING is "VIOF"
			-- Error code.

	matching_features: LIST [FEATURE_I]
			-- List of overloaded features matching call.

	arg_list: LIST [TYPE_A]
			-- List of types used to perform call.
			
	context_class_id: INTEGER
			-- Class id where all features from `matching_features' are coming from.

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Display error message
		local
			l_feature: E_FEATURE
			l_feat: FEATURE_I
		do
				-- Display information on call being made.
			st.add_string ("Call made: ")
			st.add_string (feature_name)
			
			st.add_string (" (")
			from
				arg_list.start
			until
				arg_list.after
			loop
				arg_list.item.append_to (st)
				arg_list.forth
				if not arg_list.after then
					st.add_string ("; ")
				end
			end
			st.add_char (')')
			st.add_new_line
			
				-- Display all possible matches for above call.
			st.add_string ("List of possible matches: ")
			st.add_new_line
			from
				matching_features.start
			until
				matching_features.after
			loop
				l_feat := matching_features.item
				l_feature := l_feat.api_feature (context_class_id)
				st.add_indent
				st.add_feature (l_feature, feature_name)
				l_feature.append_just_signature (st);
				st.add_string (" Disambiguated name: ");
				st.add_feature (l_feature, l_feat.feature_name)
				st.add_new_line
				matching_features.forth
			end
			st.add_new_line
		end

invariant
	class_c_not_void: class_c /= Void
	e_feature_not_void: e_feature /= Void
	matching_features_not_void: matching_features /= Void
	matching_features_not_empty: not matching_features.is_empty
	arg_list_not_void: arg_list /= Void
	arg_list_not_empty: not arg_list.is_empty
	feature_name_not_void: feature_name /= Void
	context_class_id_positive: context_class_id > 0
	
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

end -- class VIOF
