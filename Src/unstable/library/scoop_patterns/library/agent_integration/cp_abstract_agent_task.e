note
	description: "Defines the shared features for {CP_AGENT_TASK} and {CP_AGENT_COMPUTATION}. %
				% Check the class header comments of the descendants for the restrictions imposed on the agent."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CP_ABSTRACT_AGENT_TASK [G -> ROUTINE]

inherit

	CP_TASK

	CP_IMPORT_VALIDATOR

	REFACTORING_HELPER

feature {NONE} -- Initialization

	make_safe (a_routine: like routine)
			-- Initialize `Current' with `a_routine'.
			-- Check out the class header for restrictions on `a_routine'.
		require
			importable: is_agent_importable (a_routine)
			no_attributes: not is_defining_attributes (a_routine)
			no_open_arguents: not has_open_arguments (a_routine)
		do
			routine := a_routine
		end

	make_unsafe (a_routine: like routine)
			-- Initialize `Current' wiht `a_routine'.
			-- Note: This function is dangerous, as it may introduce traitors or Void calls.
			-- Make sure you follow these two rules:
			--- All closed arguments are either expanded or declared as separate.
			--- The agent must never access its target (i.e. no implicit or explicit use of Current).
		require
			unsafe_importable: is_agent_unsafe_importable (a_routine)
			no_open_arguents: not has_open_arguments (a_routine)
		do
			routine := a_routine
		end

	make_from_separate (other: separate like Current)
			-- <Precursor>
		local
			importer: CP_AGENT_IMPORTER
		do
			is_unsafe := other.is_unsafe
			set_promise (other.promise)

			create importer
			if is_unsafe then
					-- Both checks should succeed because the importer copies based on dynamic type.
				check attached {G} importer.unsafe_import (other.routine) as l_routine then
					routine := l_routine
				end
			else
				check attached {G} importer.import (other.routine) as l_routine then
					routine := l_routine
				end
			end
		end

feature -- Access

	routine: G
			-- The agent to run.

feature -- Status report

	is_unsafe: BOOLEAN
			-- Should an unsafe import be used?

feature -- Contract support

	is_defining_attributes (a_routine: ROUTINE): BOOLEAN
			-- Does the target of `a_routine' define attributes?
		local
			l_type_id: INTEGER
		do
				-- The type of the target should not define any attributes.
			l_type_id := {ISE_RUNTIME}.dynamic_type (a_routine)
			l_type_id := reflector.generic_dynamic_type_of_type (l_type_id, 1)
			Result := reflector.field_count_of_type (l_type_id) /= 0
		end

	has_open_arguments (a_routine: ROUTINE): BOOLEAN
			-- Does `a_routine' have an open argument (except for a target)?
		do
			if a_routine.is_target_closed then
				Result := a_routine.open_count > 0
			else
				Result := a_routine.open_count > 1
			end
		end

feature {NONE} -- Implementation

	new_target: ANY
			-- Create an empty, uninitialized target for `routine'.
		local
			l_type_id: INTEGER
		do
				-- Get type of the routine.
			l_type_id := {ISE_RUNTIME}.dynamic_type (routine)
				-- Get the type of its target.
			l_type_id := reflector.generic_dynamic_type_of_type (l_type_id, 1)
				-- Create the target.
			Result := reflector.new_instance_of (l_type_id)
		end

end
