class WORKER
inherit
	THREAD
feature

	make is
		do
		end;

	execute is
		local
			f: PLAIN_TEXT_FILE
			k: INTEGER
			s: STRING
			tried: BOOLEAN
		do
			if not tried then
				from
					k := 1
				until
					k > 5000
				loop
					s := "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww"
					k := k + 1
				end
				create f.make_open_write ("this/path/is/garbage/weasel")
			end
		rescue
$COMMENT			tried := True
			retry
		end;

	
end
