indexing
	description: "Callbacks needed to load an uuid from a configuration file."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_LOAD_UUID_CALLBACKS

inherit
	CONF_LOAD_CALLBACKS
		redefine
			on_start_tag,
			on_attribute,
			on_end_tag
		end

create
	make

feature -- Access

	last_uuid: STRING
			-- The last parsed uuid.

feature -- Callbacks

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Start of start tag.
		do
			if not is_error then
					-- check version
				check_version (a_namespace)

				is_system := a_local_part.is_case_insensitive_equal ("system")
			end
		end


	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING) is
			-- Start of attribute.
		do
			if not is_error then
				if
					is_system and a_local_part.is_case_insensitive_equal ("uuid") and then check_uuid (a_value)
				then
					last_uuid := a_value
				end
			end
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- End tag.
		do
			if not is_error then
				is_system := False
			end
		end

feature {NONE} -- Implementation

	is_system: BOOLEAN
			-- Are we in a system tag?

end
