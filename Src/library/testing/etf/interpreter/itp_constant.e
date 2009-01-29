note
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

	make (a_value: like value)
			-- Create new constant.
		do
			value := a_value
		ensure
			value_set: value = a_value
		end

feature -- Access

	value: ANY
		-- Value

	type_name: STRING
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

	process (a_processor: ITP_EXPRESSION_PROCESSOR)
		do
			a_processor.process_constant (Current)
		end

feature{NONE} -- Implementation

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
