indexing
	description: "Refactoring that allows to pull a feature to a parent."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERF_FEATURE_PULL

inherit
	ERF_REFACTORING
		redefine
			ask_run_settings,
			refactor
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} all
		end

create
	make

feature -- Status

	feature_set: BOOLEAN is
			-- Has the the feature to pull been set?
		do
			Result := feature_i /= Void
		end

feature -- Element change

	set_feature (a_feature: FEATURE_I) is
			-- The feature that get's pulled.
		require
			a_feature_not_void: a_feature /= Void
		do
			feature_i := a_feature
		ensure
			feature_set_correct: feature_set and feature_i = a_feature
		end

feature {NONE} -- Implementation

	recursive_descendants: SEARCH_TABLE [INTEGER]
			-- All the classes that are descendants of the class where the feature was written.

	compute_recursive_descendants (a_class: CLASS_C) is
			-- Compute all the recursive descendants
		require
			a_class_not_void: a_class /= Void
		local
			l_classes: LIST [CLASS_C]
		do
			recursive_descendants.put (a_class.class_id)
			from
				l_classes := a_class.descendants
				l_classes.start
			until
				l_classes.after
			loop
				compute_recursive_descendants (l_classes.item)
				l_classes.forth
			end
		end


	refactor is
			-- Do the refactoring changes.
		require else
			feature_set: feature_set
		local
			l_cm_src: ERF_CLASS_TEXT_MODIFICATION
			l_cm_dst: ERF_CLASS_TEXT_MODIFICATION
			l_code, l_export, l_comment: STRING
			l_name: STRING
		do
			create l_cm_src.make (feature_i.written_class.lace_class)
			create l_cm_dst.make (parent_class)
			current_actions.extend (l_cm_src)
			current_actions.extend (l_cm_dst)
			l_cm_src.prepare
			l_cm_dst.prepare

				-- get the feature code
			l_name := feature_i.feature_name
			l_cm_src.get_feature_named (l_name)
			l_code := l_cm_src.last_code
			l_export := l_cm_src.last_export
			l_comment := l_cm_src.last_comment
			l_cm_src.remove_feature_named (l_name)
			l_cm_src.redefine_into_undefine (l_name, parent_class.name)

				-- write the feature
			if is_parent_deferred then
				l_cm_dst.remove_feature_named (l_name)
			end
			l_cm_dst.add_feature_code (l_code, l_export, l_comment)

			l_cm_dst.commit
			l_cm_src.commit

				-- if the feature was deferred in the parent, we may have add some redefine clauses in descendants
			if is_parent_deferred and not feature_i.is_deferred then
				add_redefine ("ANY", parent_class.compiled_class)
			end
		end

	add_redefine (a_parent_name: STRING; a_class: CLASS_C) is
			-- Add some redefine clauses to descendants of the parent that implement the feature.
		require
			a_parent_name_ok: a_parent_name /= Void and not a_parent_name.is_empty
			a_class_not_void: a_class /= Void
		local
			l_feature: FEATURE_I
			l_descendants: LIST [CLASS_C]
			l_cm: ERF_CLASS_TEXT_MODIFICATION
		do
			l_feature := a_class.feature_of_rout_id (feature_i.rout_id_set.first)
			if l_feature /= Void and then not l_feature.is_deferred and l_feature.written_in /= feature_i.written_in then
					-- add redefine
				create l_cm.make (a_class.lace_class)
				current_actions.extend (l_cm)
				l_cm.prepare
				l_cm.add_redefine (a_parent_name, feature_i.feature_name)
				l_cm.commit
				-- else maybe a descendant implements it
			else
				l_descendants := a_class.descendants
				if l_descendants /= Void then
					from
						l_descendants.start
					until
						l_descendants.after
					loop
						add_redefine (a_class.name, l_descendants.item)
						l_descendants.forth
					end
				end
			end
		end


    ask_run_settings is
            -- Ask for the settings, that are run specific.
		require else
			feature_set: feature_set
		local
			dialog: ERF_CLASS_SELECT
			l_feature: FEATURE_I
			l_classes: LINKED_SET [CLASS_I]
        do
			create dialog

			dialog.set_classes (feature_i.written_class.parents_classes)
			dialog.show_modal_to_window (window_manager.last_focused_development_window.window)
			retry_ask_run_settings := dialog.ok_pressed
			if retry_ask_run_settings then
				parent_class := dialog.selected_class

					-- add the checks
				create recursive_descendants.make (20)
				compute_recursive_descendants (feature_i.written_class)
	        	checks.wipe_out
	        	create l_classes.make
	        	l_classes.extend (feature_i.written_class.lace_class)
	        	l_classes.extend (parent_class)
	        	checks.extend (create {ERF_CLASSES_WRITABLE}.make (l_classes))

		       		-- if the feature is deferred in the parent this is ok
				l_feature := parent_class.compiled_class.feature_of_rout_id (feature_i.rout_id_set.first)
	        	if l_feature /= Void and then l_feature.is_deferred then
					is_parent_deferred := True
	        		-- else we have to check if the feature is not in the class or a descendant
	        	else
		        	checks.extend (create {ERF_FEATURE_NOT_IN_CLASS}.make (feature_i.feature_name, parent_class.compiled_class, recursive_descendants, True, False))
		        end
			end
		ensure then
			parent_chosen_on_ok: retry_ask_run_settings implies parent_class /= Void
        end

	feature_i: FEATURE_I
			-- The feature to pull.

	is_parent_deferred: BOOLEAN
			-- Is the feature in the parent deferred?

	parent_class: CLASS_I;
			-- The parent class where we pull the feature into.

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

end
