class SHARED_ERROR_BEHAVIOR

feature

	stop_on_error: BOOLEAN is
		do
			Result := stop_mode.item
		end;

	set_stop_on_error (b: BOOLEAN) is
		do
			stop_mode.put (b)
		end;

feature {NONE}

	stop_mode: CELL [BOOLEAN] is
		once
			!!Result.put (False)
		end;

end
