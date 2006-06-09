indexing
	description: "Property for file rules."
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_RULE_PROPERTY

inherit
	DIALOG_PROPERTY [ARRAYED_LIST [CONF_FILE_RULE]]
		redefine
			displayed_value,
			dialog
		end

	CONF_ACCESS
		undefine
			default_create, copy
		end

create
	make

feature -- Display

	displayed_value: STRING_32 is
			-- Displayed format of the data.
		local
			l_fr: CONF_FILE_RULE
			l_pattern: LINKED_SET [STRING]
		do
			create Result.make_empty
			if value /= Void and then not value.is_empty then
				create l_fr.make
				from
					value.start
				until
					value.after
				loop
					l_fr.merge (value.item)
					value.forth
				end
				if not l_fr.is_empty then
					l_pattern := l_fr.exclude
					if l_pattern /= Void and then not l_pattern.is_empty then
						Result.append ("Excluded: ")
						from
							l_pattern.start
						until
							l_pattern.after
						loop
							Result.append (l_pattern.item + ";")
							l_pattern.forth
						end
					end

					l_pattern := l_fr.include
					if l_pattern /= Void and then not l_pattern.is_empty then
						Result.append ("Included: ")
						from
							l_pattern.start
						until
							l_pattern.after
						loop
							Result.append (l_pattern.item + ";")
							l_pattern.forth
						end
					end
					Result.remove_tail (1)
				end
			end
		end

feature {NONE} -- Dialog

	dialog: FILE_RULE_DIALOG
			-- Dialog to edit the value.

end
