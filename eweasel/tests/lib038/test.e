
class TEST
create
	make
feature
	make
		local
			p: MANAGED_POINTER
		do
			create p.own_from_pointer (default_pointer, 0)
		end
end

	