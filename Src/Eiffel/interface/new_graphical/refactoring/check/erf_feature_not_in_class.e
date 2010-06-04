note
	description: "Check that checks if a given feature name could be added as feature to a class. (There is no feature with this name in the class or a descendant.)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERF_FEATURE_NOT_IN_CLASS

inherit
	ERF_CHECK

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_class: CLASS_C; a_ignore_list: SEARCH_TABLE [INTEGER]; a_recursive, a_ignore_deferred: BOOLEAN)
			-- Create a check which may be `a_recursive', ignore classes in `a_ignore_list' and may also `ignore_deferred'.
		require
			a_name_not_void: a_name /= Void
			a_class_not_void: a_class /= Void
		do
			name := a_name
			class_c := a_class
			ignore_list := a_ignore_list
			if ignore_list = Void then
				create ignore_list.make(0)
			end
			recursive := a_recursive
			ignore_deferred := a_ignore_deferred
		end

feature -- Basic operation

	execute
            -- Execute a check.
        do
			success := True
			check_class (class_c)
        end

feature {NONE} -- Implementation

	check_class (a_class: CLASS_C)
			-- Check if `a_class' and all descendants are ok.
		require
			a_class_not_void: a_class /= Void
		local
			l_feature: FEATURE_I
			l_classes: LIST [CLASS_C]
		do
			if not ignore_list.has (a_class.class_id) then
				l_feature := a_class.feature_named_32 (name)
				if l_feature /= Void and then (not ignore_deferred or not l_feature.is_deferred) then
					success := False
					error_message := interface_names.l_there_is_already_a_feature_in (a_class.name_in_upper)
				end

				if recursive then
					l_classes := a_class.direct_descendants
					if l_classes /= Void then
						from
							l_classes.start
						until
							not success or l_classes.after
						loop
							check_class (l_classes.item)
							l_classes.forth
						end
					end
				end
			end
		end

	name: STRING
			-- The name to check.

	class_c: CLASS_C
			-- The class to check.

	ignore_list: SEARCH_TABLE [INTEGER]
			-- The classes to ignore

	recursive: BOOLEAN
			-- Check recursively in descendants?

	ignore_deferred: BOOLEAN
			-- Ignore deferred features?

invariant
	name_ok: name /= Void and not name.is_empty
	class_not_void: class_c /= Void
	ignore_list_not_void: ignore_list /= Void

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
