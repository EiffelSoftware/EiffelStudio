indexing

	description: 
		".";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_STATUS_HANDLER


feature -- Properties

	is_deleted_since_last_re (status: INTEGER): BOOLEAN is
		do
			Result := has_property (status, Status_deleted_since_last_re)
		end

	is_new_since_last_re (status: INTEGER): BOOLEAN is
		do
			Result := has_property (status, Status_new_since_last_re)
		end

feature -- Settings

	set_is_deleted_since_last_re (status: INTEGER): INTEGER is
		do
			Result := set_property (status, Status_deleted_since_last_re)
		end

	set_is_new_since_last_re (status: INTEGER): INTEGER is
		do
			Result := set_property (status, Status_new_since_last_re)
		end

feature {NONE} -- Property numbers (= bit numbers)

	Status_deleted_since_last_re: INTEGER is 1;
	Status_new_since_last_re: INTEGER is 2;

feature {NONE} -- Implementation

	has_property (status: INTEGER; property_number: INTEGER): BOOLEAN is
		require
			property_number_not_too_small: property_number >= 1
			-- property_number >= number of bits in an INTEGER
		local
			mask: INTEGER
			shifted: INTEGER
		do
			mask := status_value (property_number)
			shifted := status // mask
			Result := ((shifted \\ 2) = 1)
		end

	set_property (status: INTEGER; property_number: INTEGER): INTEGER is
		require
			property_number_not_too_small: property_number >= 1
			-- property_number >= number of bits in an INTEGER
			not_set: not has_property (status, property_number)
		do
			Result := status + status_value (property_number)
		end

	status_value (property_number: INTEGER): INTEGER is
		require
			property_number_not_too_small: property_number >= 1
			-- property_number >= number of bits in an INTEGER
		do
			Result := (2 ^ (property_number-1)).truncated_to_integer
		end

end -- class FEATURE_STATUS_HANDLER

