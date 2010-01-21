class TEST

create
	make
feature

	make
		local
			p: TEST_PROC [ANY, TUPLE]
		do
			create p.make (agent (i: INTEGER) do io.put_integer (i); io.put_new_line end)
			p.call ([]) -- OK in workbench and finalized modes
			bar.call ([]) -- OK in workbench mode; fails in finalized mode
			foo (p) -- OK in workbench mode; fails in finalized mode
		end

	bar: PROCEDURE[ANY, TUPLE]
		do
			create {TEST_PROC [ANY, TUPLE]} Result.make (agent (i: INTEGER) do io.put_integer (i); io.put_new_line end)
		end

	foo (p: PROCEDURE[ANY, TUPLE])
		do
			p.call ([])
		end

end
