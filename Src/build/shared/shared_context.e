class SHARED_CONTEXT 
	
feature {NONE}

	Shared_window_list: LINKED_LIST [WINDOW_C] is
			-- list of windows
		once
			!!Result.make
		end;

    Shared_group_list: LINKED_LIST [GROUP] is
        once
            !!Result.make
        end;

end
