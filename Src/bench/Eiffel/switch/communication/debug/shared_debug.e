
class SHARED_DEBUG

inherit

	SHARED_APPLICATION_EXECUTION

feature

	debug_info: DEBUG_INFO is
		once
			Result := Application.debug_info
		end;

	min_slice_ref: INTEGER_REF is
			-- Minimum bound asked for special objects.
		once
			create Result
			Result.set_item (0)
		end

	max_slice_ref: INTEGER_REF is
			-- Maximum bound asked for special objects.
		once
			create Result
			Result.set_item (50)
		end

end
