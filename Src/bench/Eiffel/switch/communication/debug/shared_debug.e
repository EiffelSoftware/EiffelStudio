
class SHARED_DEBUG

inherit

	SHARED_APPLICATION_EXECUTION

feature

	debug_info: DEBUG_INFO is
		once
			Result := Application.debug_info
		end;

end
