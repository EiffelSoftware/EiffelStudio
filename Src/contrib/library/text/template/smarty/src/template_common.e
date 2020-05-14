note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

deferred
class
	TEMPLATE_COMMON

inherit
	SHARED_TEMPLATE_CONTEXT

	TEMPLATE_CONSTANTS

feature {NONE} -- Helpers

	string_value (a: detachable ANY): detachable READABLE_STRING_8
		local
			utf: UTF_CONVERTER
		do
			if a /= Void then
				if attached {READABLE_STRING_32} a as s32 then
					Result := utf.utf_32_string_to_utf_8_string_8 (s32)
				else
					Result := a.out
				end
			end
		end

	resolved_variable_name (exp: READABLE_STRING_8): READABLE_STRING_8
		require
			exp_not_empty: not exp.is_empty
		do
			if exp.item (1).is_equal ('$') then
				Result := exp.substring (2, exp.count)
			else
				Result := exp.twin
			end
		end

	resolved_formatted_variable (exp: READABLE_STRING_8): detachable ANY
			-- `e' should be "$var_name"
			-- to improve .. later
		local
			l_var: READABLE_STRING_8
		do
			if attached template_context as tt then
				l_var := resolved_variable_name (exp)
				if tt.runtime_values.has (l_var) then
					Result := tt.runtime_values.item (l_var)
				elseif tt.values.has (l_var) then
					Result := tt.values.item (l_var)
				end
			end
		end

feature {NONE} -- Nested and Internal

	resolved_nested_message (obj: detachable ANY; mesg: STRING_8): detachable ANY
			-- `e' should be "$var_name"
		do
			if obj = Void then
				if attached template_context.expression_error_report_function as fct then
					Result := fct (obj, mesg)
				else
--					Result := "Call on Void"
				end
			elseif attached Template_routines.internal_field_value (obj, mesg) as cl then
				Result := cl.item
			elseif attached template_context.expression_error_report_function as fct then
				Result := fct (obj, mesg) -- "ERROR{$" + mesg + "}"
			end
		end

	Template_routines: TEMPLATE_ROUTINES
		once
			create Result
		end

note
	copyright: "2011-2013, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
