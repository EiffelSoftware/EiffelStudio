
class ANONYMOUS_OPERATION
inherit
	EXCEPTIONS

create
	make

feature {NONE}

	make (imp: like implementation)
		do
			implementation := imp
		end

feature

	implementation: PROCEDURE [ANY, TUPLE]

	aborted: BOOLEAN

	execute
		local
			tried: BOOLEAN
		do
			if not tried then
				aborted := False
				implementation.call ([])
			end
		rescue
			tried := True
			if is_developer_exception_of_name ("Abort") then
				aborted := True
				retry
			end
		end

end
