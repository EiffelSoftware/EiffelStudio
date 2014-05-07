deferred class TEST1

feature

	mapping: ARRAY [like company.entity_map.item]
		deferred
		end

	company: TEST2
		deferred
		end
end
