indexing
	description: "Unix implementation of PROCESS_INFO"
	author: ""
	date: ""
	revision: ""

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
			"getpid()"
		end

	environment_variables: HASH_TABLE [STRING, STRING] is
			-- Table of environment variables associated with current process,
			-- indexed by variable name
		local
			l_ptr: POINTER
			l_succ: BOOLEAN
			l_count: INTEGER
			l_managed_ptr: MANAGED_POINTER
			l_managed_ptr2: MANAGED_POINTER
			l_str: STRING
			i, j: INTEGER
			l_pos: INTEGER
			l_whole_len: INTEGER
			done: BOOLEAN
			l_ptr_size: INTEGER
		do
			get_environment_variables ($l_ptr, $l_whole_len, $l_count, $l_ptr_size, $l_succ)
			if l_succ then
				create Result.make (l_count)
				create l_managed_ptr.make_from_pointer (l_ptr, l_whole_len)
				from
					l_pos := 0
				until
					l_pos = l_count
				loop
					l_str := (create {C_STRING}.make_by_pointer (l_managed_ptr.read_pointer (l_pos * l_ptr_size))).string
					j := l_str.count
					from
						i := 1
						done := False
					until
						i > j or done
					loop
						if l_str.item (i) = '=' then
							done := True
						else
							i := i + 1
						end
					end
					if i > 1 and then i < j then
						Result.put (l_str.substring (i + 1, j), l_str.substring (1, i - 1))
					end
					l_pos := l_pos + 1
				end
			else
				create Result.make (0)
			end
		end


feature{NONE} -- Implementation

	get_environment_variables (a_pointer: TYPED_POINTER [POINTER]; a_len: TYPED_POINTER [INTEGER]; a_count: TYPED_POINTER [INTEGER]; a_size: TYPED_POINTER [INTEGER]; a_succ: TYPED_POINTER [BOOLEAN]) is
			-- Get environment variables associated with current process and store them in `a_pointer'.
			-- Length of `a_pointer' in bytes is stored in `a_len'.
			-- `a_count' indicates the number of environment variables.
			-- `a_var_len' is a list of integer, giving the length in bytes of every environment variable.
			-- `a_size' is the size of a pointer.
			-- If succeeded, set `a_succ' to True, otherwise False.
		external
			"C inline use <string.h>, <unistd.h>"
		alias
			"[
				{
					char **ep;
    				char *p;
    				int cnt = 0;
    				int size = 0;
    				*$a_size = sizeof(p);
    				*$a_pointer = (void*)__environ;
    				ep = (char **)*$a_pointer;
    				while ((p = *ep++)) {
						cnt++;
						size+=*$a_size;				
    				}
    				size++;
    				*$a_len=size;
    				*$a_count=cnt;
        			*$a_succ=1;
				}
			]"
		end

end
