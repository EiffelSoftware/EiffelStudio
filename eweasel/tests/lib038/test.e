class TEST
inherit
	EXCEPTION_MANAGER

create
	make
feature
	make
		local
			p: MANAGED_POINTER
			retried: BOOLEAN
		do
			if not retried then
				create p.own_from_pointer (default_pointer, 0)
			end
		rescue
			if
				attached last_exception as l_exception and then
				attached {PRECONDITION_VIOLATION} l_exception.original
			then
				retried := True
				retry
			end
		end
end

	
