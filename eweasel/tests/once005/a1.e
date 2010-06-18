class A

create
	make

feature
	
	make
		do
		end

	o_procedure
		once ("OBJECT")
		end

	o_object: STRING
		once ("OBJECT")
			Result := "o_object"
		end

	o_thread: STRING
		once ("THREAD")
			Result := "o_thread"
		end

	o_process: STRING
		once ("PROCESS")
			Result := "o_process"
		end


end
