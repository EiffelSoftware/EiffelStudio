indexing
	description: "Implementation of PROCESS_INFO"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_INFO_IMP

inherit
	PROCESS_INFO

feature -- Access

	process_id: INTEGER is
			-- Process ID of current process
		external
			"C inline"
		alias
			"GetCurrentProcessId ()"
		end


feature{NONE} -- Implementation

	get_process_module (a_module: TYPED_POINTER [POINTER]; a_count: TYPED_POINTER [INTEGER]; a_succ: TYPED_POINTER [BOOLEAN]) is
			-- Get module of current process and store it in `a_module'.
			-- Length of `a_module' in bytes is stored in `a_count'.
			-- If succeeded, set `a_succ' to True, otherwise False.
			-- Free `a_module' after use.
		external
			"C inline"
		alias
			"[
				{										
					TCHAR *buffer;
					int returnedSize;					
					buffer = (TCHAR *)malloc (MAX_PATH *sizeof(TCHAR));
					returnedSize = GetModuleFileName (NULL, buffer, MAX_PATH);
					if(returnedSize) {
						*$a_succ = 1;
						*$a_count = MAX_PATH * sizeof(TCHAR);
						*$a_module = buffer;
					} else {
						*$a_succ = 0;
					}				
				}
			]"
		end

end
