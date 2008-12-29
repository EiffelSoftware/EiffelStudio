note
	description: "Boolean item in a property grid."
	date: "$Date$"
	revision: "$Revision$"

class
	BOOLEAN_PROPERTY

inherit
	CHOICE_PROPERTY [BOOLEAN]
		redefine
			convert_to_data
		end

create
	make_with_value

feature {NONE} -- Initialization

	make_with_value (a_name: like name; a_value: BOOLEAN)
			-- Create with `a_value'.
		do
			make_with_choices (a_name, <<True, False>>)
			disable_text_editing
			set_value (a_value)
		end

feature {NONE} -- Implementation

	convert_to_data (a_string: like displayed_value): like value
			-- Convert displayed data into data.
		do
			if convert_to_data_agent /= Void then
				Result := convert_to_data_agent.item ([a_string])
			else
				if a_string.is_boolean then
					Result := a_string.to_boolean
				end
			end
		end

end
