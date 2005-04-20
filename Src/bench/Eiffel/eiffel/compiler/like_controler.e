indexing
	description: "Controler of like types: the goal is to detect cycles in anchored types"
	date: "$Date$"
	revision: "$Revision$"

class
	LIKE_CONTROLER  

inherit
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

end
