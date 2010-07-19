
deferred class TEST1
inherit
	PARENT
feature
	try
		local
			l_action: PROCEDURE [ANY, TUPLE]
		do
			l_action := agent
				do
					if is_valid then 
					   print ("OK%N")
					end
				end
			l_action.call ([])
		end

end

