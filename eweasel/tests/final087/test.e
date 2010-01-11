
class TEST
create
	make

feature {NONE} -- Initialization

	make
		local
			a, b: INTEGER
		do
			is_plain := True
			if is_plain then
				create {CHILD1} parent.make
			else
				create {CHILD2} parent.make
			end
			a := parent.index
			b := parent.position
			print (a = b); io.new_line
			print (a.to_hex_string); io.new_line
			print (b.to_hex_string); io.new_line
		end

feature {NONE}

	parent: PARENT

	is_plain: BOOLEAN

end
