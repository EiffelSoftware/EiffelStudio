indexing
	description: "Objects that handle object id's in Build."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_ID

feature -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	initialize_id_handler (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			current_id_counter := 1
		ensure
			components_set: components = a_components
		end

feature -- Status setting

	reset_id_counter is
			-- Reset `counter' to 1.
			-- This forces object ids to start
			-- at one again. Should be performed
			-- when closing an open project.
		do
			set_current_id_counter (1)
		end

feature -- Basic operations

	new_id: INTEGER is
			-- `Result' is a new id.
		do
			Result := current_id_counter
			set_current_id_counter (Result + 1)
		ensure
			result_positive: Result > 0
		end

	set_current_id_counter (value: INTEGER) is
			-- Set `value' to `internal_counter'.
		do
			current_id_counter := value
		end

	current_id_counter: INTEGER
			-- `Result' is value of `internal_counter'.

end -- class GB_SHARED_ID
