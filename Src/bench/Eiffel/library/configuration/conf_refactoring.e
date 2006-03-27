class CONF_REFACTORING

feature
	conf_todo is
		do
			print ("Configuration refactoring%N")
		end

	conf_todo_msg (a_msg: STRING) is
		do
			print ("Configuration refactoring: "+a_msg+"%N")
		end
end
