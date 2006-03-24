indexing
	description: "Object that represents an EQL result item for a metric"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_METRIC_ITEM

inherit
	EQL_RESULT_ITEM
		redefine
			is_equal
		end

create
	make_with_data
	
feature{NONE} -- Initialization

	make_with_data (a_data: like data) is
			-- Initialize `data' with `a_data'.			
		do
			set_data (a_data)
		end

feature -- status reporting

	data: DOUBLE
			-- data of the metric

feature -- Setting

	set_data (a_data: like data) is
			-- Set `data' with `a_data'.
		do
			data := a_data
		ensure
			data_set: data = a_data
		end

feature -- Equality

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			if Precursor (other) then
				Result := data.is_equal (other.data)
			end
		end

end
