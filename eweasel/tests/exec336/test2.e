
class TEST2
inherit
	MEMORY
create
	make
feature
	make
		do
			print (value); io.new_line
		end

	value: STRING
	       local
			tried: BOOLEAN
	       once
			if not tried then
			   	try
			   	Result := "Ermine"
			else
				full_collect
				Result := "Weasel"
			end
	       rescue
			tried := true
			retry
	       end

	 try
		do
			check False then
			end
		end
end

