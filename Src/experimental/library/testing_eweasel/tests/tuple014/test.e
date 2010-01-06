class TEST

create
	make

feature

	make is
		local
			l_tuple: TUPLE [LIST [STRING]]
		do
			action := agent f
			create t1
			l_tuple := [t1.g.h]
			io.put_string (l_tuple.generating_type)
			io.put_new_line
			action.call (l_tuple)
		end

	action: PROCEDURE [ANY, TUPLE [LIST [STRING]]]

	f (s: LIST [STRING]) is
		do
		end

	t1: TEST1

end
