note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEMPLATE_STRUCTURE_ACTION

inherit
	TEMPLATE_STRUCTURE_ITEM
		rename
			name as action_name,
			set_name as set_action_name
		redefine
			action_name, set_action_name,
			make, get_output
		end

create {TEMPLATE_STRUCTURE_ACTION_FACTORY}
	make

feature {NONE} -- Initialization

	make
		do
			Precursor
			create parameters.make (3)
		end

feature {TEMPLATE_TEXT} -- Type

	is_literal_action: BOOLEAN
		do
			Result := False
		end

feature -- Output

	get_output
		do
			Precursor
--			if output = Void then
--				if is_foreach_action then
--					output := "{!! Action[" + action_name + "] !!}"
--				end
--			end
		end

feature -- Access

	action_name: detachable STRING

	parameters: STRING_TABLE [STRING]

feature -- Change

	set_action_name (v: like action_name)
		do
			action_name := v
		end

	add_parameter (pv, pn: STRING)
			-- add param_value, param_name
		do
			parameters.put (pv, pn)
		end

feature {NONE} -- Implementation

	inside_text: STRING
		do
			if attached template_context.current_template_string as cts then
				Result := cts.substring (end_index + 1, closing_start_index - 1).to_string_8
			else
				create Result.make_empty
				check has_inside_text: False end
			end
		end

	foreach_iteration_string (on_text: STRING; reset_offset: BOOLEAN): STRING
		require
			on_text /= Void
		local
			s1, s2: INTEGER
			t: TEMPLATE_STRUCTURE_ITEM
			val: detachable READABLE_STRING_8
			soffset: INTEGER
			item_output: STRING
		do
			if not reset_offset then
				soffset := 0 - end_index
			end
			item_output := on_text.twin

			across
				items as c
			loop -- Loop Iteration
				t := c.item
				s1 := t.start_index
				s2 := t.end_index

				t.process
				t.get_output
				val := t.output
				if val = Void then
					val := ""
				end

				if attached {TEMPLATE_STRUCTURE_ACTION} t then
					if t.has_closing_item then
						s2 := t.closing_end_index
					end
					item_output.replace_substring (val, soffset + s1, soffset + s2)
					soffset := soffset + val.count - 1 - (s2 - s1)
				else
					item_output.replace_substring (val, soffset + s1, soffset + s2)
					soffset := soffset + val.count - 1 - (s2 - s1)

						--| Close tag processing
					if t.has_closing_item then
						s1 := t.closing_start_index
						s2 := t.closing_end_index
						item_output.replace_substring ("", soffset + s1, soffset + s2)
						soffset := soffset - 1 - (s2 - s1)
					end
				end
			end -- end Loop Iteration
			Result := item_output
		end

note
	copyright: "2011-2013, Jocelyn Fiat, and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
