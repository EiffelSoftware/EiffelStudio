indexing
	description: "Combo box that allows the user to choose a view"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_VIEW_SELECTOR

inherit
	EV_COMBO_BOX

create
	make_default

feature -- Initialization

	make_default is
			-- Initialize with "DEFAULT" as selected view.
		do
			make_with_strings (Initial_strings)
			set_text ("DEFAULT")
			set_minimum_width (100)
			return_actions.extend (~on_view_name_typed)
		end

feature {NONE} -- Events

	on_view_name_typed is
			-- A view name was typed in `Current' text field.
		local
			tmp: LINKED_LIST [STRING]
		do
			tmp := strings
			tmp.compare_objects
			if not is_trivial (text) then
				if tmp.has (text) then
					tmp.prune_all (text)
				end
				tmp.put_front (text)
				set_strings (tmp)
			end
		end

feature {NONE} -- Implementation

	initial_strings: ARRAY [STRING] is
			-- Initial list items.
		once
			Result := <<"DEFAULT">>
		end

	is_trivial (str: STRING): BOOLEAN is
			-- Is str only composed	of blank characters?
		local
			i: INTEGER
			c: CHARACTER
		do
			Result := True
			if str /= Void and then not str.is_empty then
				from
					i := 1
				until
					Result = False or else i > str.count
				loop
					c := str.item (i)
					if c /= ' ' and c /= '%T' then
						Result := False
					end
					i := i + 1
				end
			end
		end

end -- class EB_VIEW_SELECTOR
