indexing
	description: "Debug clause description in Ace"
	date: "$Date$"
	revision: "$Revision$"

class DEBUG_SD

inherit
	OPTION_SD
		rename
			initialize as o_initialize
		redefine
			is_debug
		end

	SHARED_DEBUG_LEVEL

feature {LACE_AST_FACTORY} -- Initialization

	initialize (v: BOOLEAN) is
			-- Create a new DEBUG AST node.
		do
			enabled := v
		ensure
			enabled_set: enabled = v
		end

feature -- Properties

	option_name: STRING is
		do
			if enabled then
				Result := "debug"
			else
				Result := "disabled_debug"
			end
		end

	is_debug: BOOLEAN is True
			-- Is the option a debug one?

	enabled: BOOLEAN
			-- Is current option active?

feature {COMPILER_EXPORTER}

	adapt ( value: OPT_VAL_SD
			classes:EXTEND_TABLE [CLASS_I, STRING]
			list: LACE_LIST [ID_SD]) is
		local
			debug_tag: DEBUG_TAG_I
			tag_value: STRING
			v: DEBUG_I
			class_name: STRING
		do
			if enabled then
				if value /= Void then
					if value.is_no then
						v := No_debug
					elseif value.is_yes or value.is_all then
						v := Yes_debug
					elseif value.is_name then
						tag_value := clone (value.value)
						tag_value.to_lower
						create debug_tag.make
						debug_tag.tags.put (tag_value)
						v := debug_tag
					else
						error (value)
					end
				else
					v := No_debug
				end
				if v /= Void then
					if list = Void then
						from
							classes.start
						until
							classes.after
						loop
							classes.item_for_iteration.set_debug_level (v)
							classes.forth
						end
					else
						from
							list.start
						until
							list.after
						loop
							class_name := clone (list.item)
							class_name.to_lower
							classes.item (class_name).set_debug_level (v)
							list.forth
						end
					end
				end
			end
		end

end -- class DEBUG_SD
