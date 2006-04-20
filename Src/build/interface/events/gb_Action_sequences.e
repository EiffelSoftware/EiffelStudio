indexing
	description: "Objects that represent a Vision2 action sequences class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_ACTION_SEQUENCES
	
inherit
	internal

feature -- Access

	count: INTEGER is
			-- Number of action sequence in Current.
		do
			Result := names.count		
		end
		
	names: ARRAYED_LIST [STRING] is
			-- All names of action sequences contained in `Current'.
		deferred
		end
		
	
	types: ARRAYED_LIST [STRING] is
			-- All types of action sequences contained in `Current'.
		deferred
		end
	
	comments: ARRAYED_LIST [STRING] is
			-- All comments of action sequences contained in `Current'.
		deferred
		end
		
	connect_event_output_agent (object: EV_ANY; action_sequence: STRING; adding: BOOLEAN; string_handler: ORDERED_STRING_HANDLER) is
			-- If `adding', then connect an agent to `action_sequence' actions of `object' which will display name of 
			-- action sequence and all arguments in `textable'. If not `adding' then `remove_only_added' `action_sequence'.
		require
			object_not_void: object /= Void
			action_sequence_not_void_or_empty: action_sequence /= Void and not action_sequence.is_empty
			string_handler_not_void: string_handler /= Void
		deferred
		end
		
	remove_only_added (a: EV_ACTION_SEQUENCE [TUPLE []]) is
			-- Remove all procedures from `a' who's `target' correponds
			-- to GB_EV_ACTION_SEQUENCE. This allows us to selectively
			-- add and remove events define in these action squences, leaving
			-- any other events untouched.
		local
			t: GB_EV_ACTION_SEQUENCE
		do
			from
				a.start
			until
				a.off
			loop
				t ?= a.item.target
				if t /= Void then
					a.remove	
				else
					a.forth
				end
			end
		end
		
invariant
	-- Cannot be executed as the invariant will not execute the once.
	-- Could reference each atribute in the 
	--lists_equal_in_length: (names.count = types.count) and (names.count = comments.count)

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


end -- class GB_ACTION_SEQUENCES
