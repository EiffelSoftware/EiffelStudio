indexing
	description: "List of all breakpoints currently set. %
				 %Breakpoints can be enabled, disabled, or not set. %
				 %(Breakpoints are equal if they represente the same physical %
				 %point in code, that's to say that they share the %
				 %same body_index and line number)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY (aranud@mail.dotcom.fr)"
	date: "$Date$"
	revision: "$Revision$"

class
	BREAK_LIST

inherit
	HASH_TABLE [BREAKPOINT, BREAKPOINT_KEY]
		rename
			make as ht_make
		end

create
	make

create {DEBUGGER_MANAGER}
	make_copy_for_saving

feature {NONE} -- Initialization

	make is
			-- Create an empty list of break points.
		do
			ht_make (50)
		end

	make_copy_for_saving (lst: like Current) is
		local
			bp: BREAKPOINT
		do
			ht_make (lst.count)
			from
				lst.start
			until
				lst.after
			loop
				bp := lst.item_for_iteration.copy_for_saving
				put (bp, bp)
				lst.forth
			end
		end

feature {DEBUGGER_MANAGER,BREAKPOINTS_MANAGER} -- Update after loading

	reload is
			-- Reload after loading breakpoints
		do
			from
				start
			until
				after
			loop
				item_for_iteration.reload
				forth
			end
		end

	restore is
			-- reset information about breakpoints set/removed during execution
		do
				-- loop on the entire list, and reset the application status of the breakpoint
			from
				start
			until
				after
			loop
				item_for_iteration.location.set_application_not_set
				forth
			end
			update
		end

	update is
			-- remove breakpoint that no more useful from the hash_table
			-- see `{BREAKPOINT}.is_useless' for further comments
		local
			bp: BREAKPOINT
			newlst: ARRAYED_LIST [BREAKPOINT]
		do
			if not is_empty then
					--| Remove useless breakpoints
				from
					create newlst.make (count)
					start
				until
					after
				loop
					bp := item_for_iteration
					if
						not bp.is_useless --| i.e: bench not set, and application not set
						and then bp.location.is_valid --| in this case (app not set) this is safe to get rid of invalid bp
					then
						newlst.force (bp)
					end
					forth
				end

					--| Wipe out all breakpoints
				wipe_out

					--| Add again the remaining breakpoints to ensure up to date keys ...
				from
					newlst.start
				until
					newlst.after
				loop
					bp := newlst.item
					force (bp, bp)
					newlst.forth
				end
			end
		end

feature -- Element change

	add_breakpoint (bp: BREAKPOINT) is
			-- Add the new breakpoint `bp' to the list.
			-- If a breakpoint is already held in the
			-- list, the breakpoint is set and activated.
		require else
			bp_exists: bp /= Void
		do
			if not has_key (bp) then
				put (bp, bp)
			else
				found_item.enable
			end
		end

	append (other: like Current) is
			-- Add breakpoints held in `other' into `Current'.
		require
			other_exists: other /= Void
		do
			from
				other.start
			until
				other.off
			loop
				add_breakpoint (other.item_for_iteration)
				other.forth
			end
		end

feature -- Access

	has_location (loc: BREAKPOINT_LOCATION): BOOLEAN is
			-- Has_key associated with `loc' ?
			-- Set found_item to the found item.
		do
			Result := has_key (create {BREAKPOINT_KEY}.make (loc))
			if not Result then
				Result := has_key (create {BREAKPOINT_KEY}.make_hidden (loc))
			end
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

end -- class BREAK_LIST

