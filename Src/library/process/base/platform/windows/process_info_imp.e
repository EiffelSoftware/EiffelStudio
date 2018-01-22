note
	description: "Implementation of PROCESS_INFO"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_INFO_IMP

inherit
	PROCESS_INFO

feature -- Access

	process_id: INTEGER
			-- Process ID of current process
		do
			Result := c_process_id
		end

feature{NONE} -- Implementation

	c_process_id: INTEGER
			-- Process ID of current process
		external
			"C inline"
		alias
			"GetCurrentProcessId ()"
		end

	get_process_module (a_module: TYPED_POINTER [POINTER]; a_count: TYPED_POINTER [INTEGER]; a_succ: TYPED_POINTER [BOOLEAN])
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

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
