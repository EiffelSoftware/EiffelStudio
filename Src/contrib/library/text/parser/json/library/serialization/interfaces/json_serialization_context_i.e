note
	description: "Common ancestor for {JSON_SERIALIZER_CONTEXT and JSON_DESERIALIZER_CONTEXT}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JSON_SERIALIZATION_CONTEXT_I

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			is_type_name_included := True
			type_field_name := "$TYPE"
		end

feature -- Settings

	is_type_name_included: BOOLEAN assign set_is_type_name_included
			-- Is JSON output includes type name when possible?
			-- Default: True

	type_field_name: STRING assign set_type_field_name
			-- Field name to hold the type name informations

feature -- Settings change

	set_is_type_name_included (b: BOOLEAN)
			-- Set `is_type_name_included' to `b'.
		do
			is_type_name_included := b
		end

	set_type_field_name (s: STRING)
		require
			valid_field_name: s /= Void and then not s.is_whitespace
		do
			type_field_name := s
		end

feature -- Cleaning

	reset
			-- Clean any temporary data.
		deferred
		end

note
	copyright: "2010-2024, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
