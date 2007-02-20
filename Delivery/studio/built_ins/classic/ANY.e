class ANY

feature

	frozen standard_twin: like Current
		local
			l_temp: BOOLEAN
		do
			l_temp := {ISE_RUNTIME}.check_assert (False)
			Result ?= {ISE_RUNTIME}.c_standard_clone ($Current)
			Result.standard_copy (Current)
			l_temp := {ISE_RUNTIME}.check_assert (l_temp)
		end

	frozen twin: like Current
		local
			l_temp: BOOLEAN
		do
			l_temp := {ISE_RUNTIME}.check_assert (False)
			Result ?= {ISE_RUNTIME}.c_standard_clone ($Current)
			Result.copy (Current)
			l_temp := {ISE_RUNTIME}.check_assert (l_temp)
		end

end
