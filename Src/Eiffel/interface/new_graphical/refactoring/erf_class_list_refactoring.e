note
	description: "Class for refactorings that can be applied to each class in a list."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ERF_CLASS_LIST_REFACTORING

inherit
	ERF_REFACTORING
		redefine
			make
		end

feature {NONE} -- Initialization

	make (an_undo_stack: STACK [LIST [ERF_ACTION]]; a_preference: PREFERENCES)
		do
			Precursor (an_undo_stack, a_preference)
			create affected_classes.make_with_key_tester (0, create {REFERENCE_EQUALITY_TESTER [CLASS_I]})
		end

feature {NONE} -- Implementation

	affected_classes: SEARCH_TABLE [CLASS_I]
			-- The classes that are affected by this refactoring.

	handle_classes
			-- Handle all classes in `affected_classes'.
		local
			chk_writable: ERF_CLASSES_WRITABLE
			l_class: CLASS_I
			i: INTEGER
		do
        		-- check if all classes are writable
        	create chk_writable.make (affected_classes)
        	chk_writable.execute
        	if not chk_writable.success then
        		rollback
        		prompts.show_error_prompt (chk_writable.error_message, Void, Void)
        	else
        			-- apply the refactoring to each class in the list
				from
					affected_classes.start
					status_bar.reset_progress_bar_with_range (0 |..| affected_classes.count)
					i := 0
				until
					affected_classes.after
				loop
					status_bar.display_progress_value (i)
					l_class := affected_classes.item_for_iteration
					status_bar.display_message (interface_names.l_updating (l_class.name))
					apply_to_class (l_class)
					i := i + 1
					affected_classes.forth
				end
				status_bar.reset
				success := True
        	end
		end

    apply_to_class (a_class: CLASS_I)
            -- Make the changes in `a_class'.
        require
        	a_class_not_void: a_class /= Void
        	a_class_writable: not a_class.is_read_only
		deferred
        end

invariant
	affected_classes_not_void: affected_classes /= Void

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

end
