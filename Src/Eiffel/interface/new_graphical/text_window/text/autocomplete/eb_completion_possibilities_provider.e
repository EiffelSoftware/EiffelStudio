indexing
	description: "Objects that provide code completion possibilities for a code completable"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_COMPLETION_POSSIBILITIES_PROVIDER

inherit
	COMPLETION_POSSIBILITIES_PROVIDER
		redefine
			code_completable,
			completion_possible,
			prepare_completion,
			name_type
		end

feature -- Access

	code_completable: EB_TAB_CODE_COMPLETABLE
			-- A code completable.

	class_completion_possibilities: SORTABLE_ARRAY [like name_type] is
			-- Completions proposals found by `prepare_auto_complete'
		require
			is_prepared : is_prepared
		deferred
		end

	name_type: EB_NAME_FOR_COMPLETION

feature -- Status report

	provide_features: BOOLEAN
			-- Provide `completion_possibilities'?

	provide_classes: BOOLEAN
			-- Provide `class_completion_possibilities'?

	completion_possible: BOOLEAN is
			-- Is completion possible?
		do
			if
				(provide_features implies (completion_possibilities /= Void and then not completion_possibilities.is_empty)) and
				(provide_classes implies (class_completion_possibilities /= Void and then not class_completion_possibilities.is_empty))
			then
				Result := true
			end
		end

feature {CODE_COMPLETABLE} -- Basic operation

	prepare_completion is
			-- Prepare completion possibilities.
		do
			Precursor {COMPLETION_POSSIBILITIES_PROVIDER}
			provide_features := code_completable.completing_feature
			provide_classes := not code_completable.completing_feature
		end

feature -- Element Change

	set_provide_features (a_provide: BOOLEAN) is
			-- Set `provide_features' with `a_provide'.
		do
			provide_features := a_provide
			is_prepared := false
		ensure
			provide_features_set: provide_features = a_provide
		end

	set_provide_classes (a_provide: BOOLEAN) is
			-- Set `provide_classes' with `a_provide'.
		do
			provide_classes := a_provide
			is_prepared := false
		ensure
			provide_classes_set: provide_classes = a_provide
		end

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

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
end
