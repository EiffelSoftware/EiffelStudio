class MT_SERVICE_FUNCTION 

inherit

	MT_ATTACH

creation

	make

feature
	
	make(r:MT_ROUTINE) is
		-- Associate service funcion to routine 'r'
		do
			set_behavior(r)
		end -- make

end -- class MT_SERVICE_FUNCTION
