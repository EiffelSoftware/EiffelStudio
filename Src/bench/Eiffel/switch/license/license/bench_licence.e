class BENCH_LICENCE

inherit
	ISE_LICENCE

creation
	make

feature

	crypt (t: INTEGER): INTEGER is
		do
			Result := t
		end

	override_key_line: INTEGER is 4;

	time_out1: INTEGER is 757411607;
		--override key in seconds. this is a hard coded time
		--after which the licence will not be overriden
		-- 1/1/94

	time_out2: INTEGER is 762514407;
		-- 3/1/94 + 1h 33m 20s

	time_out3: INTEGER is 770492006;
		-- 6/1/94 + 1h 33m 20s

	time_out4: INTEGER is 778444404
		-- 9/1/94 + 1h 33m 20s

	time_out5: INTEGER is 788985212;
		-- 1/1/95 + 1h 33m 20s

	time_out6: INTEGER is 946663816;
		-- 12/24/99 + 1h 33m 20s

	time_out7: INTEGER is 946663816;
		-- 12/24/99 + 1h 33m 20s

	time_out8: INTEGER is 946663816;
		-- 12/24/99 + 1h 33m 20s

	time_out9: INTEGER is 946663816;
		-- 12/24/99 + 1h 33m 20s

	time_out10: INTEGER is 946663816;
		-- 12/24/99 + 1h 33m 20s


end
