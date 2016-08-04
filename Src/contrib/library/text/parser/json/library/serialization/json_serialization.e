note
	description: "Utility interface to use JSON (de)serialization."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_SERIALIZATION

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make_with_context
	
feature {NONE} -- Initialization

	default_create
		do
			make_with_context (create {JSON_SERIALIZATION_CONTEXT})
		end

	make_with_context (ctx: JSON_SERIALIZATION_CONTEXT)
		do
			context := ctx
		end

feature -- Access

	context: JSON_SERIALIZATION_CONTEXT
			-- Context related to serialization and deserialization.

feature -- Status

	has_deserialization_error: BOOLEAN
			-- Error occurred during deserialization?
		do
			Result := context.has_deserialization_error
		end

feature -- Element change

	set_pretty_printing
			-- Generate pretty indented JSON for `to_json_string'.
		do
			context.set_pretty_printing
		end

	set_compact_printing
			-- Generate compact JSON for `to_json_string'.
		do
			context.set_compact_printing
		end

	register (a_serialization: JSON_SERIALIZATION_I; a_type: TYPE [detachable ANY])
		do
			if attached {JSON_SERIALIZER} a_serialization as s then
				context.register_serializer (s, a_type)
			end
			if attached {JSON_DESERIALIZER} a_serialization as d then
				context.register_deserializer (d, a_type)
			end
		end

	register_default (a_serialization: JSON_SERIALIZATION_I)
		do
			if attached {JSON_SERIALIZER} a_serialization as s then
				context.set_default_serializer (s)
			end
			if attached {JSON_DESERIALIZER} a_serialization as d then
				context.set_default_deserializer (d)
			end
		end


feature -- Cleaning

	reset
			-- Clean temporary data if relevant.
		do
			context.reset
		end

feature -- Conversion to JSON

	to_json (obj: detachable ANY): JSON_VALUE
		do
			if obj = Void then
				create {JSON_NULL} Result
			elseif attached context.to_json (obj, Void) as j then
				Result := j
			else
				create {JSON_NULL} Result -- FIXME
			end
		end

	append_to_json_string (obj: detachable ANY; a_output: STRING_GENERAL)
		do
			append_json_to_string (to_json (obj), a_output)
		end

	to_json_string (obj: detachable ANY): STRING
		do
			create Result.make (0)
			append_to_json_string (obj, Result)
		end

feature -- Conversion from JSON		

	from_json (a_json: detachable JSON_VALUE; a_type: TYPE [detachable ANY]): detachable ANY
		do
			Result := context.value_from_json (a_json, a_type)
			if context.has_deserialization_error then
				Result := Void
			end
		end

	from_json_string (a_json_string: STRING; a_type: TYPE [detachable ANY]): detachable ANY
		do
			Result := from_json (json_from_string (a_json_string), a_type)
		end

feature -- Helper

	append_json_to_string (a_json: JSON_VALUE; a_output: STRING_GENERAL)
		local
			vis: JSON_VISITOR
		do
			if context.is_pretty_printing then
				create {JSON_PRETTY_STRING_VISITOR} vis.make (a_output)
			else
				create {JSON_SERIALIZATION_VISITOR} vis.make (a_output)
			end
			a_json.accept (vis)
		end

	json_from_string (a_json_string: STRING): detachable JSON_VALUE
		local
			p: JSON_PARSER
		do
			create p.make_with_string (a_json_string)
			p.parse_content
			if
				p.is_parsed and then p.is_valid
			then
				Result := p.parsed_json_value
			end
		end

note
	copyright: "2010-2016, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
