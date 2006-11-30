class TEST

inherit

$C1	A select ad end

	A
		rename
			ad as dd
		end

$C2	B	select
$C2			ba, 
$C5			bb,
$C2			bd
$C2		end

	B
		rename
			ba as tba,
$C5			bb as tbb,
			bd as tbd
		end

create
	make

feature

	make is
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i >= 10
			loop
				inspect i
				when dd then
					if i = dd then
						io.put_string ("Test 1: OK.")
					else
						io.put_string ("Test 1: Failed.")
					end
					io.put_new_line
					i := 10
				else
				end
				i := i + 1
			end
			if i = 10 then
				io.put_string ("Test 1: Failed.")
				io.put_new_line
			end
			from
				i := 1
			until
				i >= 10
			loop
				inspect i
				when tbd then
					if i = tbd then
						io.put_string ("Test 2: OK.")
					else
						io.put_string ("Test 2: Failed.")
					end
					io.put_new_line
					i := 10
				else
				end
				i := i + 1
			end
			if i = 10 then
				io.put_string ("Test 2: Failed.")
				io.put_new_line
			end
		end

end