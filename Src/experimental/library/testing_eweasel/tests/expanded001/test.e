indexing
	author: "Urs Doenni"

class
	TEST
create
	make

feature
	make is
		do
			-- Ok
			array := create {ARRAY[ANY]}.make_from_array (<<1.2>>); output

			-- Ok
			array := <<1.2>>; output

			-- Ok
			array := create {ARRAYED_LIST[ANY]}.make_from_array (<<1.2>>); output

			-- Crash
			array := create {ARRAY[DOUBLE]}.make_from_array (<<1.2>>); output

			-- Crash
			array := create {ARRAYED_LIST[DOUBLE]}.make_from_array (<<1.2>>); output
		end

	output is
		do
			-- Calling 'out' blows up (sometimes with a 'Feature call on Void target',
			-- sometimes with a segmentation violation) as soon as the generic type
			-- of the array assigned to 'array' is a DOUBLE
			io.put_string (array.item (1).out + "%N")
		end

feature -- Access
	array: INDEXABLE [ANY, INTEGER]
end
