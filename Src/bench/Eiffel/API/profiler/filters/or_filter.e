indexing

	description:
		"Profile filter used to perform the OR operation between %
		%two other filters.";
	date: "$Date$";
	revision: "$Revision$"

class OR_FILTER

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
				Result := Result or filters.item.check_item (item)
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

end -- class OR_FILTER
