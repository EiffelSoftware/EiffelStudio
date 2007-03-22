indexing
	metadata: create {CATEGORY_ATTRIBUTE}.make ({CONSTANTS}.category) end

class TEST

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	make is
			-- Run test
		local
			l_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]
			l_category: CATEGORY_ATTRIBUTE
		do
			l_attributes := get_type.get_custom_attributes ({CATEGORY_ATTRIBUTE}, False)
			if l_attributes.count > 0 then
				l_category ?= l_attributes.item (0)
				if l_category /= Void then
					io.put_string (l_category.category)
					io.new_line
				end
			end
		end

end
