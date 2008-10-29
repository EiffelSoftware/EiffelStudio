indexing
	description: "[
		Objects representing constants.
		]"
	author: "Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"

class ITP_CONSTANT

inherit

	ITP_EXPRESSION

	ERL_CONSTANTS

create

	make

feature {NONE} -- Initialization

	make (a_value: like value) is
			-- Create new constant.
		do
			value := a_value
		ensure
			value_set: value = a_value
		end

feature -- Access

	value: ANY
		-- Value

	type_name: STRING is
			-- Type name of constant
		do
			if value = Void then
				Result := none_type_name
			else
				Result := value.generating_type
			end
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
		end

feature -- Processing

	process (a_processor: ITP_EXPRESSION_PROCESSOR) is
		do
			a_processor.process_constant (Current)
		end

feature{NONE} -- Implementation

end
