indexing
	description: "[
		Representation a local signature used for defining type of all
		local variables of a method.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_LOCAL_SIGNATURE

inherit
	MD_SIGNATURE
		rename
			set_type as add_local_type
		redefine
			make
		end
	
create
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialize current.
		do
			Precursor {MD_SIGNATURE}
			internal_put (feature {MD_SIGNATURE_CONSTANTS}.Local_sig, 0)
			current_position := 1
			state := local_count_state
		ensure then
			current_position_set: current_position = 1
			state_set: state = local_count_state
		end

feature -- Settings

	set_local_count (n: INTEGER) is
			-- Set number of method locals.
			-- To be compressed.
		require
			valid_state: state = Local_count_state
		do
			compress_data (n)
			state := 0
		end

feature -- State

	state: INTEGER
			-- Current state of signature settings.

	local_count_state: INTEGER is 1

end -- class MD_LOCAL_SIGNATURE
