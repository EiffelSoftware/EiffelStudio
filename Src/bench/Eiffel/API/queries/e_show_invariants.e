indexing
	description: "Command to display invariants of `current_class'."
	date: "$Date$"
	revision: "$Revision$"

class E_SHOW_INVARIANTS 

inherit
	E_CLASS_CMD

create
	make, default_create

feature -- Execution

	work is
		local
			class_f: CLASS_TEXT_FORMATTER
		do
			create class_f
			class_f.set_clickable
			class_f.format_invariants (current_class)
			if not class_f.error then
				structured_text.append (class_f.text)
			end
		end

end
