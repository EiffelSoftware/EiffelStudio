indexing
	description: "Controler of like types: the goal is to detect cycles in anchored types"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	LIKE_CONTROLER

inherit
	ANY

	EXCEPTIONS
		export
			{NONE} all
		end

	SHARED_RESCUE_STATUS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialize	

	make is
			-- Initialization
		do
			create routine_ids.make (10)
			create arguments.make (10)
		end

feature -- Status report

	is_on: BOOLEAN
			-- Status of the controller

	has_argument (a_position: INTEGER): BOOLEAN is
			-- Does current have an anchor on `a_position'?
		do
			Result := arguments.has (a_position)
		end

	has_routine_id (a_routine_id: INTEGER): BOOLEAN is
			-- Does current have an anchor on `a_routine_id'?
		do
			Result := routine_ids.has (a_routine_id)
		end

feature -- Settings

	turn_on is
			-- Active the controler.
		do
			is_on := True
		ensure
			active: is_on
		end

	turn_off is
			-- Desactive the controller.
		do
			routine_ids.wipe_out
			arguments.wipe_out
			is_on := False
		ensure
			not_active: not is_on
		end

	raise_error is
		do
			Rescue_status.set_is_like_exception (True)
			raise ("Like cycle")
		end

feature -- Element change

	put_routine_id (a_routine_id: INTEGER) is
			-- Insert an anchor based on `a_routine_id'.
		do
			routine_ids.put (a_routine_id)
		ensure
			has_routine_id: has_routine_id (a_routine_id)
		end

	put_argument (a_position: INTEGER) is
			-- Insert an anchor based on `a_position'.
		do
			arguments.put (a_position)
		ensure
			has_argument: has_argument (a_position)
		end

feature {NONE} -- implementation

	arguments: SEARCH_TABLE [INTEGER]
			-- Used arguments

	routine_ids: SEARCH_TABLE [INTEGER]
			-- Used features

invariant
	arguments_not_void: arguments /= Void
	routine_ids_not_void: routine_ids /= Void

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
