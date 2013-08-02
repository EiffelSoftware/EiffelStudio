note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEMPLATE_STRUCTURE_ACTION_ASSIGN

inherit
	TEMPLATE_STRUCTURE_ACTION
		redefine
			process
		end

create {TEMPLATE_STRUCTURE_ACTION_FACTORY}
	make

feature -- Output

	process
		do
			Precursor
			process_assign
		end

feature {NONE} -- Implementation

	process_assign
		local
			vv: detachable ANY
			vn: detachable STRING
			ve: detachable STRING
		do
			if parameters.has (name_param_id) then
				vn := parameters.item (name_param_id)
			end
			if parameters.has (value_param_id) then
				vv := parameters.item (value_param_id)
			elseif parameters.has (expression_param_id) then
				ve := parameters.item (expression_param_id)
				if ve = Void or else ve.is_empty then
					vv := Void
				else
					vv := resolved_composed_expression (ve)
					if vv = Void then
--						vv := ve -- Fixme
					end
				end
			end

			if vn /= Void then
				if vv /= Void then
					template_context.add_value (vv, vn)
--				else
--					template_context.remove_value (vn)
				end
			end
		end

note
	copyright: "2011-2013, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
