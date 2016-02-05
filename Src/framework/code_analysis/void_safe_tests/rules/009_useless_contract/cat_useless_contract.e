note
	ca_only: "CA009"
class
	CAT_USELESS_CONTRACT

feature {NONE} -- Test

	preconditions (a_arg1: attached INTEGER; a_arg2: attached STRING)
		require
			a_arg1 /= Void
			a_arg2 /= Void
		do
			do_nothing
		ensure
			a_arg2 /= Void
		end
end
