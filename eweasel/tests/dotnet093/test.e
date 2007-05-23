class
	TEST

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			metadata:
					-- Attribute declaration should not be permitted, GUID_ATTRIBUTE is not permitted to be used on members
				create {GUID_ATTRIBUTE}.make ("E562C6BC-46FE-4682-986F-F7EF69AA56AD") end
		do
		end
			
end
