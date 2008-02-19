Class A

create
	f

feature

	f is
		local
			retried: BOOLEAN
			l_exception_1, l_exception_2: MY_EXCEPTION
			l_mnger: EXCEPTION_MANAGER
		do
			if not retried then
				create l_exception_1
				create l_exception_2
				l_mnger := (create {EXCEPTION_MANAGER_FACTORY}).exception_manager
				l_mnger.ignore ({MY_EXCEPTION})
				if l_exception_1.is_ignored then
					print ("True%N")
				else
					print ("False%N")
				end
				l_exception_1.raise
				l_mnger.catch ({MY_EXCEPTION})
				if not l_exception_1.is_ignored then
					print ("True%N")
				else
					print ("False%N")
				end
				l_exception_2.raise
			end
		rescue
			if l_exception_2 = l_mnger.last_exception then
				print ("True%N")
			else
				print ("False%N")
			end
			retried := True
			retry
		end

end
