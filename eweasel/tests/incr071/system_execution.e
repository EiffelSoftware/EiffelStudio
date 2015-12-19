
class SYSTEM_EXECUTION

inherit
	PROCESS
		rename
			make as process_make
		end;
	
create
	make

feature

	make (args: STRING)
		local
			s: STRING;
		do
			print (s.is_empty);
		end;

end
