-- Controler of like types: the goal is to detect cycles in anchored types

class
	LIKE_CONTROLER  

inherit
	LINKED_SET [ROUTINE_ID]
		rename
			off as linked_set_off
		redefine
			wipe_out, make
		end

	EXCEPTIONS

	SHARED_RESCUE_STATUS

creation
	make

feature 

	is_on: BOOLEAN
			-- Status of the controller

	arguments: LINKED_SET [INTEGER]
			-- Used argument

	make is
			-- Initialization
		do
			{LINKED_SET} precursor
			compare_objects
			!!arguments.make
		end

	on is
			-- Active the controller.
		do
			is_on := True
		end

	off is
			-- Desactive the controller.
		do
			is_on := False
		end

	wipe_out is
			-- Reset controller
		do
			{LINKED_SET} precursor
			arguments.wipe_out
			is_on := False
		ensure then 
			not_active: not is_on
		end

	raise_error is
		do
			Rescue_status.set_is_like_exception (True)
			raise ("Like cycle")
		end

end
