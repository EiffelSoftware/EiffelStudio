class SHARED_ERROR_BEHAVIOR

feature

	stop_on_error: BOOLEAN is
		do
			Result := stop_mode.item
		end

	set_stop_on_error (b: BOOLEAN) is
		do
			stop_mode.set_item (b)
		end

feature {NONE}

	stop_mode: BOOLEAN_REF is
			-- Structure to keep `stop_on_error'.
		once
			create Result
		end

end
