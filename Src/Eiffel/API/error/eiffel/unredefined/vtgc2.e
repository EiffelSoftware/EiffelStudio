
indexing
	description: "Error for the formal generic part of a class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VTGC2

inherit
	VTGC
		redefine
			build_explain,
			subcode
		end

create
	default_create

feature -- Properties

	subcode: INTEGER_32 is 2
			-- Subcode of error

	feature_name: STRING
			-- Feature name
			-- This is the name of the feature whch occured multiple times.

	classes_with_same_feature: LIST [CLASS_C]
			-- List of classes with same feature
			-- This is used to provide the user with a specific list of classes which contain the same feature.

	features_renamed_multiple_times: SEARCH_TABLE[STRING]
			-- Features which are renamed multiple times.
			--| Each feature should be reanmed at most once.

	features_renamed_to_the_same_name: SEARCH_TABLE[STRING]
			-- Features which are renamed to a existing name
			--| Features should be renamed to names which do not exist (or to a name of feature which itself has been renamed).

	non_existent_features: SEARCH_TABLE[STRING]
			-- Features which are renamed to a existing name

	constraint_class: CLASS_C
			-- Constraint class on which the renaming is actually applied.

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
		local
			l_output: STRING_8
		do
			if classes_with_same_feature /= Void then
				l_output := "The feature `" + feature_name + "' occurs in the following set of classes:%N   "
				a_text_formatter.add (l_output)
				if classes_with_same_feature /= Void then
					classes_with_same_feature.do_all (agent (a_text_formatter2: TEXT_FORMATTER; a_first: CLASS_C; a_item: CLASS_C)
						do
							if a_item /= a_first then
								a_text_formatter2.add (", ")
							end
							a_item.append_name (a_text_formatter2)
						end (a_text_formatter, classes_with_same_feature.first, ?))
					a_text_formatter.add_new_line
				end
			end
			if constraint_class /= Void then
				a_text_formatter.add ("Renaming of constraint class: ")
				a_text_formatter.process_class_name_text (constraint_class.name,constraint_class.lace_class, False)
				a_text_formatter.add_new_line
			end
			if features_renamed_multiple_times /= Void and then not features_renamed_multiple_times.is_empty then
				l_output := "The following features have been renamed multiple times:%N   "
				a_text_formatter.add (l_output)
				from
					features_renamed_multiple_times.start
				until
					features_renamed_multiple_times.after
				loop
					l_output :=	"`" + features_renamed_multiple_times.item_for_iteration + "'%N"
					a_text_formatter.add (l_output)
					features_renamed_multiple_times.forth
				end
				a_text_formatter.add_new_line
			end

			if features_renamed_to_the_same_name /= Void and then not features_renamed_to_the_same_name.is_empty then
				l_output := "The following features have been renamed to the same name, leading to conflicts:%N   "
				a_text_formatter.add (l_output)
				from
					features_renamed_to_the_same_name.start
				until
					features_renamed_to_the_same_name.after
				loop
					l_output :=	"`" + features_renamed_to_the_same_name.item_for_iteration + "'%N"
					a_text_formatter.add (l_output)
					features_renamed_to_the_same_name.forth
				end
				a_text_formatter.add_new_line
			end

			if non_existent_features /= Void and then not non_existent_features.is_empty then
				l_output := "The following features do not occur in the base class and therefore cannot be renamed:%N   "
				a_text_formatter.add (l_output)
				from
					non_existent_features.start
				until
					non_existent_features.after
				loop
					l_output :=	"`" + non_existent_features.item_for_iteration + "'%N"
					a_text_formatter.add (l_output)
					non_existent_features.forth
				end
			end
		end

feature {COMPILER_EXPORTER} -- Setting

	set_constraint_class (a_constraint_class: CLASS_C)
			-- Set `constraint_class' to `a_constraint_class'.
		require
			a_constraint_class_not_void: a_constraint_class /= Void
		do
			constraint_class := a_constraint_class
		ensure
			set: constraint_class = a_constraint_class
		end


	set_feature_name (a_feature_name: STRING_8)
			-- Set feature_name to `a_feature_name'.
		do
			feature_name := a_feature_name
		ensure
			set: feature_name = a_feature_name
		end

	set_features_renamed_multiple_times (a_hash_table_of_name_pairs: like features_renamed_multiple_times)
			-- Set classes_with_same_feature to `a_list'.
		require
			a_features_renamed_multiple_times_not_void: a_hash_table_of_name_pairs /= Void
		do
			features_renamed_multiple_times := a_hash_table_of_name_pairs
		ensure
			is_set: features_renamed_multiple_times = a_hash_table_of_name_pairs
		end

	set_features_renamed_to_the_same_name (a_features_renamed_to_the_same_name: like features_renamed_to_the_same_name)
			-- Set classes_with_same_feature to `a_list'.
		require
			a_features_renamed_to_the_same_name_not_void: a_features_renamed_to_the_same_name /= Void
		do
			features_renamed_to_the_same_name := a_features_renamed_to_the_same_name
		ensure
			is_set: features_renamed_to_the_same_name = a_features_renamed_to_the_same_name
		end

	set_non_existent_features (a_non_existent_features: like non_existent_features)
			-- Set classes_with_same_feature to `a_list'.
		require
			a_non_existent_features_not_void: a_non_existent_features /= Void
		do
			non_existent_features := a_non_existent_features
		ensure
			is_set: non_existent_features = a_non_existent_features
		end

	set_classes_with_same_feature (a_list: LIST [CLASS_C])
			-- Set classes_with_same_feature to `a_list'.
		require
			a_list_not_void: a_list /= Void
		do
			classes_with_same_feature := a_list
		ensure
			is_set: classes_with_same_feature = a_list
		end

indexing
	copyright: "Copyright (c) 1984-2006, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

end -- class VTGC2
