indexing
	description	: "Mechanism to call an action when a file/pipe is changed.%N%
				  %Windows Implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	EB_IO_WATCHER_IMP

inherit
	ANY
		redefine
			default_create
		end

	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		undefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
		local
			delay: INTEGER
		do
				-- Retrieve delay.
			delay := Configure_resources.get_pos_integer (r_Windows_timer_delay, 10)

				-- Adjust timer range.
			if delay < 5 then
				delay := 5
			elseif delay > 200 then	
				delay := 200
			end
				
				-- Setup the callback mechanism.
			win_ioh_make_client ($call_back, Current, delay) 
		end

feature -- Access

	action: PROCEDURE [ANY, TUPLE]
			-- Callback feature called with the file/pipe is changed.

feature -- Element change

	set_action (an_action: like action) is
			-- Set `an_action' as callback feature.
		require
			an_agent_not_void: an_action /= Void
		do
			action := an_action
		ensure
			agent_set: action = an_action
		end

	remove_action is
			-- Remove the current action
		do
			action := Void
		ensure
			no_action: action = Void
		end

feature {NONE} -- Implementation

	interface: EB_IO_WATCHER
			-- Platform independent interface.

	call_back is
			-- Called back by the implementation when the
			-- file/pipe is changed.
		do
			-- We just call the action if any.
			if action /= Void then
				action.call(Void)
			end
		end

feature {NONE} -- Externals

	win_ioh_make_client (callback_feature: POINTER; obj: like Current; delay: INTEGER) is
			-- Make the io handler function
		external
			"C"
		end

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

end -- EB_IO_WATCHER_IMP


