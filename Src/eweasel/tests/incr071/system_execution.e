
class SYSTEM_EXECUTION

inherit
	PROCESS
		rename
			make as process_make
		end;
	
creation
	make

feature

	make (args: STRING) is
		local
			s: STRING;
		do
			print (s.is_empty);
		end;

end
