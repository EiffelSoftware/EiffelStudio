note
	description: "Objects that represent EV_CHECKABLE_LIST_ACTION_SEQUENCES."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_CHECKABLE_LIST_ACTION_SEQUENCES

inherit

	GB_EV_ACTION_SEQUENCES

feature -- Access

	names: ARRAYED_LIST [STRING]
			-- All names of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("check_actions")
			Result.extend ("uncheck_actions")
			Result.compare_objects
		end


	types: ARRAYED_LIST [STRING]
			-- All types of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("EV_LIST_ITEM_CHECK_ACTION_SEQUENCE")
			Result.extend ("EV_LIST_ITEM_CHECK_ACTION_SEQUENCE")
		end

	comments: ARRAYED_LIST [STRING]
			-- All comments of action sequences contained in `Current'.
		once
			create Result.make (0)
			Result.extend ("-- Actions to be performed when item is checked.")
			Result.extend ("-- Actions to be performed when item is unchecked.")
		end

	connect_event_output_agent (widget: EV_WIDGET; action_sequence: STRING; adding: BOOLEAN; string_handler: ORDERED_STRING_HANDLER)
			-- If `adding', then connect an agent to `action_sequence' actions of `widget' which will display name of
			-- action sequence and all arguments in `textable'. If no `adding' then `remove_only_added' `action_sequence'.
		local
			item_check_sequence: GB_EV_LIST_ITEM_CHECK_ACTION_SEQUENCE
			checkable_list: EV_CHECKABLE_LIST
		do
			checkable_list ?= widget
			check
				checkable_list_not_void: checkable_list /= Void
			end
			if action_sequence.is_equal (names @ 1) then
				if adding then
					create item_check_sequence
					checkable_list.check_actions.extend (item_check_sequence.display_agent (action_sequence, string_handler))
				else
					remove_only_added (checkable_list.check_actions)
				end
			elseif action_sequence.is_equal (names @ 2) then
				if adding then
					create item_check_sequence
					checkable_list.uncheck_actions.extend (item_check_sequence.display_agent (action_sequence, string_handler))
				else
					remove_only_added (checkable_list.uncheck_actions)
				end
			end
		end

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


end -- class GB_EV_CHECKABLE_LIST_ACTION_SEQUENCES
