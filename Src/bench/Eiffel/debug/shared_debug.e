
class SHARED_DEBUG

feature

	new_debuggables: LINKED_LIST [DEBUGGABLE] is
		once
			!!Result.make
		end;

	new_breakpoints: LINKED_LIST [BREAKPOINT] is
		once
			!!Result.make
		end;

	old_debuggables: LINKED_LIST [DEBUGGABLE] is
		once
			!!Result.make
		end;

	removed_breakpoints: LINKED_LIST [BREAKPOINT] is
		once
			!!Result.make
		end;

	old_breakpoints: LINKED_LIST [BREAKPOINT] is
		once
			!!Result.make
		end;

	tenure is
			-- BE SMART. New breakpoint + Remove breakpoint = No breakpoint
		do
		end;

	restore is
		do
		end;

end
