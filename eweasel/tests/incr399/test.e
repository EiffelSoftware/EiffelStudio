
class TEST
inherit
	ANY
	EXCEPTION_MANAGER
		export
			{NONE} all
		end
create
	make
feature
	make
		local
			tried: BOOLEAN
		do
			if not tried then
				print (value); io.new_line
				print (value2); io.new_line
				print (value3); io.new_line
				print (value4); io.new_line
				print (value5); io.new_line
				print (value6); io.new_line
				print (value7); io.new_line
			else
				if attached last_exception as x then
					print (x.meaning); io.new_line
				end
			end
		rescue
			-- tried := True
			-- retry
		end

	value: like {TEST2}.value
		local
			a: TEST2
		once ("OBJECT")
			create a
			Result := a.value
		end

	value2: like {TEST1}.value
		local
			a: TEST1
		once ("OBJECT")
			create a
			Result := a.value
		end

	value3: like {TEST1}.value
		local
			a: TEST5
		once ("OBJECT")
			create {TEST1} a
			Result := a.value
		end

	value4: like {TEST1}.value
		local
			a: TEST5
		once ("OBJECT")
			create {TEST2} a
			Result := a.value
		end

	value5: like {TEST1}.value
		local
			a: TEST5
		once ("OBJECT")
			create {TEST3} a
			Result := a.value
		end

	value6: like {TEST1}.value
		local
			a: TEST4
		once ("OBJECT")
			create {TEST3} a
			Result := a.value
		end

	value7: like {TEST1}.value
		local
			a: TEST5
		once ("OBJECT")
			create {TEST5} a
			Result := a.value
		end

end
