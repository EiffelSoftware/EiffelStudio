class A
inherit
	SYSTEM_OBJECT

feature
	f: FUNCTION [ANY, TUPLE, STRING] is
		do
			Result := agent: STRING do Result := "Hello from agent." end
		end

end
