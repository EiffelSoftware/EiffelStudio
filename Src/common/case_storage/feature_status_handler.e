indexing

	description: 
		"Horrible trick to keep backward compatibility and low disk %
		%occupancy without using Eiffel BIT N, reportedly bugged....";
	date: "$Date$";
	revision: "$Revision $"

class 
	FEATURE_STATUS_HANDLER


feature -- Properties

	is_constant (status: INTEGER): BOOLEAN is
		do
			Result := has_property (status, Status_is_constant)
		end

	is_deleted_since_last_re (status: INTEGER): BOOLEAN is
		do
			Result := has_property (status, Status_deleted_since_last_re)
		end

	is_new_since_last_re (status: INTEGER): BOOLEAN is
		do
			Result := has_property (status, Status_new_since_last_re)
		end

	is_once (status: INTEGER): BOOLEAN is
		do
			Result := has_property (status, Status_is_once)
		end

	is_reversed_engineered (status: INTEGER): BOOLEAN is
		do
			Result := has_property (status, Status_is_reversed_engineered)
		end

feature -- Settings

	set_is_constant (status: INTEGER): INTEGER is
		do
			Result := set_property (status, Status_is_constant)
		end

	set_is_deleted_since_last_re (status: INTEGER): INTEGER is
		do
			Result := set_property (status, Status_deleted_since_last_re)
		end

	set_is_new_since_last_re (status: INTEGER): INTEGER is
		do
			Result := set_property (status, Status_new_since_last_re)
		end

	set_is_once (status: INTEGER): INTEGER is
		do
			Result := set_property (status, Status_is_once)
		end

	set_reversed_engineered (status: INTEGER): INTEGER is
		do
			Result := set_property (status, Status_is_reversed_engineered)
		end

	unset_is_constant (status: INTEGER): INTEGER is
		do
			Result := unset_property (status, Status_is_constant)
		end

	unset_is_deleted_since_last_re (status: INTEGER): INTEGER is
		do
			Result := unset_property (status, Status_deleted_since_last_re)
		end

	unset_is_new_since_last_re (status: INTEGER): INTEGER is
		do
			Result := unset_property (status, Status_new_since_last_re)
		end

	unset_is_once (status: INTEGER): INTEGER is
		do
			Result := unset_property (status, Status_is_once)
		end

	unset_reversed_engineered (status: INTEGER): INTEGER is
		do
			Result := unset_property (status, Status_is_reversed_engineered)
		end

feature {NONE} -- Property numbers (= bit numbers)
				-- NB: Not possible to use `unique' (see ETL, p267)

	Status_deleted_since_last_re: INTEGER is 1;
	Status_new_since_last_re: INTEGER is 2;
	Status_is_once: INTEGER is 3;
	Status_is_constant: INTEGER is 4;
	Status_is_reversed_engineered: INTEGER is 5;

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
			-- not_set: not has_property (status, property_number)
		do
			Result := status + status_value (property_number)
		ensure
			set:  has_property (Result, property_number)
		end

	status_value (property_number: INTEGER): INTEGER is
		require
			property_number_not_too_small: property_number >= 1
			-- property_number >= number of bits in an INTEGER
		do
			Result := (2 ^ (property_number-1)).truncated_to_integer
		end

	unset_property (status: INTEGER; property_number: INTEGER): INTEGER is
		require
			property_number_not_too_small: property_number >= 1
			-- property_number >= number of bits in an INTEGER
			set: has_property (status, property_number)
		do
			Result := status - status_value (property_number)
		ensure
			not_set: not has_property (Result, property_number)
		end

end -- class FEATURE_STATUS_HANDLER

