class TEST

create
	make

feature
	 make
		local
			l_fun: FUNCTION [ANY, TUPLE [ANY], ANY]
			l_any: ANY
		do
			l_fun := agent func
			create t1
			l_any := l_fun.item ([t1.t2.h])
			print (l_any.generating_type)
			print ("%N")
		end

	func (a: ANY): ANY is
		do 
			print (a.generating_type)
			print ("%N")
			Result := a
		end

	
	t1: TEST1 [STRING]

end
