indexing
	description: "Representation of a once procedure"
	date: "$Date$"
	revision: "$Revision$"

class ONCE_PROC_I 

inherit
	DYN_PROC_I
		redefine
			is_once,
			is_process_relative,
			replicated,
			transfer_to,
			unselected,
			update_api
		end
	
feature -- Status report

	is_once: BOOLEAN is True
			-- Is the current feature a once one?

	is_process_relative: BOOLEAN
			-- Is once routine process-wide (rather than thread-specific)?

feature -- Status setting

	set_is_process_relative (value: BOOLEAN) is
			-- Set `is_process_relative' to `value'.
		do
			is_process_relative := value
		ensure
			is_process_relative_set: is_process_relative = value
		end

feature -- Adaptation

	transfer_to (other: ONCE_PROC_I) is
			-- Transfer data from Current into `other'.
		do
			Precursor (other)
			other.set_is_process_relative (is_process_relative)
		end

	replicated: FEATURE_I is
			-- Replication
		local
			rep: R_ONCE_PROC_I
		do
			create rep
			transfer_to (rep)
			rep.set_code_id (new_code_id)
			Result := rep
		end

	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature
		local
			unselect: D_ONCE_PROC_I
		do
			create unselect
			transfer_to (unselect)
			unselect.set_access_in (in)
			Result := unselect
		end

feature {NONE} -- Implementation

	update_api (f: E_ROUTINE) is
			-- Update api feature `f' attribute features.
		do
			Precursor {DYN_PROC_I} (f)
			f.set_once (True)
		end

end
