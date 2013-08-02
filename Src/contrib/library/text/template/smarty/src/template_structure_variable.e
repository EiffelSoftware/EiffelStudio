note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEMPLATE_STRUCTURE_VARIABLE

inherit
	TEMPLATE_STRUCTURE_ITEM
		rename
			forced_output as forced_value,
			set_forced_output as set_forced_value
		redefine
			forced_value, set_forced_value,
			get_output
		end

create
	make

feature {NONE} -- Initialization

feature -- Output

	get_output
		do
			Precursor
			if output = Void then
				if attached variable_name as vn then
					if runtime_values.has (vn) then
						output := string_value (runtime_values.item (vn))
					elseif template_context.runtime_values.has (vn) then
						output := string_value (template_context.runtime_values.item (vn))
					elseif template_context.values.has (vn) then
						output := string_value (template_context.values.item (vn))
					else
						output := "{!! Error = No value for " + vn + " variable !!}"
					end
				elseif attached variable_expression as ve then
					output := string_value (resolved_expression (ve))
				end
			end
		end

feature -- Access

	variable_name: detachable STRING

	variable_expression: detachable STRING

	forced_value: detachable STRING

feature -- Change

	set_variable_name (v: like variable_name)
		do
			variable_name := v
			name := v
		end

	set_variable_expression (v: like variable_expression)
		do
			variable_expression := v
			name := v
		end

	set_forced_value (v: like forced_value)
		do
			forced_value := v
		end

note
	copyright: "2011-2013, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
