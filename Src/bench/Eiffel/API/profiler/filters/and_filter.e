indexing

	description:
		"Profile filter to filter with the AND operation.";
	date: "$Date$";
	revision: "$Revision$"

class AND_FILTER

inherit
	BOOLEAN_FILTER

create
	make

feature -- Checking

	check_item (item: PROFILE_DATA): BOOLEAN is
		do
			from
				filters.start
				Result := filters.item.check_item (item)
				filters.forth
			until
				filters.after
			loop
				Result := Result and filters.item.check_item (item)
				filters.forth
			end
		end

	filter (input_set: PROFILE_SET): PROFILE_SET is
		do
			from
				create Result.make
				input_set.start
			until
				input_set.after
			loop
				if check_item (input_set.item) then
					Result.insert_unknown_profile_data (input_set.item)
				end
				input_set.forth
			end
			Result.stop_computation;
		end

end -- class AND_FILTER
