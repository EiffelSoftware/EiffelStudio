note
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

feature -- Status Report

	count: INTEGER
			-- Number of action sequence in Current.
		do
			Result := names.count
		end

	has_name (a_feature_name: STRING): BOOLEAN
			-- Is `a_feature_name' listed in `names'?
		require
			a_feature_name_not_void: a_feature_name /= Void
		do
			Result := names.has (a_feature_name)
		end

	valid_index (a_index: INTEGER): BOOLEAN
			-- Is `a_index' valid for accessing the data?
		do
			Result := names.valid_index (a_index)
		end

feature -- Access

	action_sequence_type_name (a_feature_name: STRING): STRING
			-- Associated type for action sequence `a_feature_name'.
		require
			a_feature_name_not_void: a_feature_name /= Void
			has_name: has_name (a_feature_name)
		do
			Result := types.i_th (names.index_of (a_feature_name, 1))
		end

	name (a_type: STRING; an_index: INTEGER): STRING
		require
			a_type_not_void: a_type /= Void
			valid_index: valid_index (an_index)
		do
			Result := names.i_th (an_index)
		end

	types: ARRAYED_LIST [STRING]
			-- All types of action sequences contained in `Current'.
		deferred
		end

	comments: ARRAYED_LIST [STRING]
			-- All comments of action sequences contained in `Current'.
		deferred
		end

	connect_event_output_agent (object: EV_ANY; action_sequence: STRING; adding: BOOLEAN; string_handler: ORDERED_STRING_HANDLER)
			-- If `adding', then connect an agent to `action_sequence' actions of `object' which will display name of
			-- action sequence and all arguments in `textable'. If not `adding' then `remove_only_added' `action_sequence'.
		require
			object_not_void: object /= Void
			action_sequence_not_void_or_empty: action_sequence /= Void and not action_sequence.is_empty
			string_handler_not_void: string_handler /= Void
		deferred
		end

	remove_only_added (a: EV_ACTION_SEQUENCE [TUPLE []])
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

feature {NONE} -- Access

	names: ARRAYED_LIST [STRING]
			-- All names of action sequences contained in `Current'.
		deferred
		ensure
			proper_comparison: names.object_comparison
		end

invariant
	-- Cannot be executed as the invariant will not execute the once.
	-- Could reference each atribute in the
	--lists_equal_in_length: (names.count = types.count) and (names.count = comments.count)

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


end -- class GB_ACTION_SEQUENCES
