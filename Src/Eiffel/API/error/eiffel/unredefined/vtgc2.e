
note
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

	subcode: INTEGER_32 = 2
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

	formal_constraint: FORMAL_CONSTRAINT_AS
			-- Formal constraint (belongs to `class_c')

	constraint_position: INTEGER
			-- Constraint position (relative to `formal_position')

	constraint_class: CLASS_C
			-- Constraint class on which the renaming is actually applied

	renaming: RENAME_CLAUSE_AS
			-- The renaming applied to `constraint_class'

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
		do
			if constraint_class /= Void then
				a_text_formatter.add ("Renaming of constraint class: ")
				a_text_formatter.process_class_name_text (constraint_class.name,constraint_class.lace_class, False)
				a_text_formatter.add_new_line
				a_text_formatter.add_space
				a_text_formatter.add_space
				if constraint_position > 0 then
					a_text_formatter.add ("at position #" + constraint_position.out)
					a_text_formatter.add_space
				end
				if formal_constraint /= Void then
					 a_text_formatter.add (" of formal ")
					a_text_formatter.process_generic_text (formal_constraint.name.name)
				end
				a_text_formatter.add_new_line
			end
			print_features_renamed_multiple_times (a_text_formatter)
			print_features_renamed_to_the_same_name (a_text_formatter)
			print_non_existent_features (a_text_formatter)
		end

feature {COMPILER_EXPORTER} -- Setting

	set_formal_constraint (a_formal_constraint: FORMAL_CONSTRAINT_AS)
			-- Set `formal' to `a_formal'
		require
			a_formal_not_void: a_formal_constraint /= Void
		do
			formal_constraint := a_formal_constraint
		ensure
			formal_set: formal_constraint = a_formal_constraint
		end

	set_constraint (a_constraint_class: CLASS_C; a_constraint_position: INTEGER)
			-- Set `constraint_class' to `a_constraint_class'.
		require
			a_constraint_class_not_void: a_constraint_class /= Void
		do
			constraint_class := a_constraint_class
			constraint_position := a_constraint_position
		ensure
			consraint_class_set: constraint_class = a_constraint_class
			constraint_position_set: constraint_position = a_constraint_position
		end

	set_feature_name (a_feature_name: STRING_8)
			-- Set feature_name to `a_feature_name'.
		do
			feature_name := a_feature_name
		ensure
			set: feature_name = a_feature_name
		end

	set_features_renamed_multiple_times (a_hash_table_of_name_pairs: like features_renamed_multiple_times)
			-- Set `features_renamed_multiple_times' to `a_hash_table_of_name_pairs'.
		require
			a_features_renamed_multiple_times_not_void: a_hash_table_of_name_pairs /= Void
		do
			features_renamed_multiple_times := a_hash_table_of_name_pairs
		ensure
			is_set: features_renamed_multiple_times = a_hash_table_of_name_pairs
		end

	set_features_renamed_to_the_same_name (a_features_renamed_to_the_same_name: like features_renamed_to_the_same_name)
			-- Set `features_renamed_to_the_same_name' to `a_features_renamed_to_the_same_name'.
		require
			a_features_renamed_to_the_same_name_not_void: a_features_renamed_to_the_same_name /= Void
		do
			features_renamed_to_the_same_name := a_features_renamed_to_the_same_name
		ensure
			is_set: features_renamed_to_the_same_name = a_features_renamed_to_the_same_name
		end

	set_non_existent_features (a_non_existent_features: like non_existent_features)
			-- Set `non_existent_features' to `a_non_existent_features'.
		require
			a_non_existent_features_not_void: a_non_existent_features /= Void
		do
			non_existent_features := a_non_existent_features
		ensure
			is_set: non_existent_features = a_non_existent_features
		end

	set_renaming (a_renaming: like renaming)
			-- Set renaming to `a_renaming'.
		require
			a_renaming_not_void: a_renaming /= Void
		do
			renaming := a_renaming
		ensure
			is_set: renaming = a_renaming
		end

feature {NONE} -- Implementation

	print_features_renamed_multiple_times (a_text_formatter: TEXT_FORMATTER)
			-- Prints a part of the error: Features which are renamed more than once.
			--
			-- `a_text_formatter': Used top print the output to.
		require
			a_text_formatter_not_void: a_text_formatter /= Void
		local
			l_new_names: LIST [STRING]
		do
			if features_renamed_multiple_times /= Void and then not features_renamed_multiple_times.is_empty then
				a_text_formatter.add ("The following features have been renamed multiple times:%N")
				from
					features_renamed_multiple_times.start
				until
					features_renamed_multiple_times.after
				loop
					a_text_formatter.add ("   `" + features_renamed_multiple_times.item_for_iteration + "'")
					if constraint_class /= Void and then renaming /= Void then
						l_new_names := renaming.new_names (features_renamed_multiple_times.item_for_iteration)
						if l_new_names /= Void then
							a_text_formatter.add (" (is renamed to ")
							print_name_list (l_new_names, a_text_formatter)
							 a_text_formatter.add (")%N")
						else
							a_text_formatter.add ("%N")
						end
					end
					features_renamed_multiple_times.forth
				end
				a_text_formatter.add_new_line
			end
		end

	print_features_renamed_to_the_same_name (a_text_formatter: TEXT_FORMATTER)
			-- Prints a part of the error report:
			-- Features which are renamed and produce a conflict because a feature
			-- with this name already exists.
			--
			-- `a_text_formatter': Used top print the output to.
		require
			a_text_formatter_not_void: a_text_formatter /= Void
		local
			l_original_names: LIST [STRING]
			l_feature: FEATURE_I
		do
			if features_renamed_to_the_same_name /= Void and then not features_renamed_to_the_same_name.is_empty then
				a_text_formatter.add ("The following features have been renamed and produce one or more conflicts:")
				from
					features_renamed_to_the_same_name.start
				until
					features_renamed_to_the_same_name.after
				loop
					a_text_formatter.add ("%N   `" + features_renamed_to_the_same_name.item_for_iteration + "' is in conflict because:%N")
					if constraint_class /= Void and then renaming /= Void then
						l_original_names := renaming.original_names (features_renamed_to_the_same_name.item_for_iteration)
						l_feature := constraint_class.feature_named (features_renamed_to_the_same_name.item_for_iteration)
						if l_feature /= Void then
									a_text_formatter.add ("      there exists ")
									a_text_formatter.add_feature (l_feature.api_feature (constraint_class.class_id), l_feature.feature_name)
									a_text_formatter.add (" in ")
									a_text_formatter.process_class_name_text (constraint_class.name,constraint_class.lace_class, False)
									a_text_formatter.add ("%N")
						end
						if l_original_names /= Void and then l_original_names.count > 1 then
							a_text_formatter.add ("      more than one feature is renamed to it: ")
							print_name_list (l_original_names, a_text_formatter)
							a_text_formatter.add ("%N")
						elseif  l_original_names /= Void and then l_original_names.count = 1  then
							a_text_formatter.add ("      (feature ")
							print_name_list (l_original_names, a_text_formatter)
							a_text_formatter.add (" is renamed to it)%N")
						end
					end
					features_renamed_to_the_same_name.forth
				end
				a_text_formatter.add_new_line
			end
		end

	print_non_existent_features (a_text_formatter: TEXT_FORMATTER)
			-- Prints a part of the error report:
			-- Features which are referred in a renaming but do not exist in the constrained class.
			--
			-- `a_text_formatter': Used top print the output to.
		require
			a_text_formatter_not_void: a_text_formatter /= Void
		do
			if non_existent_features /= Void and then not non_existent_features.is_empty then
				a_text_formatter.add ("The following features do not occur in the base class and therefore cannot be renamed:%N")
				from
					non_existent_features.start
				until
					non_existent_features.after
				loop
					a_text_formatter.add ("   `" + non_existent_features.item_for_iteration + "'")
					a_text_formatter.add_new_line
					non_existent_features.forth
				end
			end
		end

	print_name_list (a_name_list: LIST [STRING]; a_text_formatter: TEXT_FORMATTER)
			-- Print all names
		require
			a_name_list_attached: a_name_list /= Void
			a_text_formatter_attached: a_text_formatter /= Void
		do
			from
				a_name_list.start
			until
				a_name_list.after
			loop
				a_text_formatter.add ("`" + a_name_list.item + "'")
				a_name_list.forth
				if not a_name_list.after then
					a_text_formatter.add (", ")
				end
			end
		end


note
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

end
