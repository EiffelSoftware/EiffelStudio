-- Evalauator of local type

class
	LOCAL_EVALUATOR 

inherit
	TYPE_EVALUATOR
	
feature

	local_name: STRING
			-- Local name involved in an error

	set_local_name (s: STRING) is
			-- Assign `s' to `local_name'.
		do
			local_name := s
		end

	new_error: VTAT1L is
			-- New error message
		do
			!! Result
		end

	update (error_msg: VTAT1L) is
			-- Update error message
		do
			error_msg.set_local_name (local_name)
		end -- update

end
