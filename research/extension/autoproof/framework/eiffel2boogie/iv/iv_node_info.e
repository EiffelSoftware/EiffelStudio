note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IV_NODE_INFO

create
	make,
	make_with_type

feature {NONE} -- Initialization

	make
			-- Initialize empty node info.
		do
		end

	make_with_type (a_type: STRING)
			-- Initialize node info with type.
		do
			set_type (a_type)
		end

feature -- Access

	type: detachable READABLE_STRING_8
			-- Type associated with this node.
		do
			if attributes.has_key ("type") then
				Result := attributes["type"]
			end
		end

	tag: detachable READABLE_STRING_8
			-- Tag associated with this node.
		do
			if attributes.has_key ("tag") then
				Result := attributes["tag"]
			end
		end

	line: detachable READABLE_STRING_8
			-- Line associated with this node.
		do
			if attributes.has_key ("line") then
				Result := attributes["line"]
			end
		end

	attributes: detachable STRING_TABLE [READABLE_STRING_8]
			-- Attributes associated with this node.

feature -- Element change

	set_type (a_value: READABLE_STRING_8)
			-- Set `type' to `a_value'.
		do
			set_attribute ("type", a_value)
		ensure
			type_set: type ~ a_value
		end

	set_tag (a_value: READABLE_STRING_8)
			-- Set `tag' to `a_value'.
		do
			set_attribute ("tag", a_value)
		ensure
			tag_set: tag ~ a_value
		end

	set_line (a_value: INTEGER)
			-- Set `line' to `a_value'.
		do
			set_attribute ("line", a_value.out)
		ensure
			line_set: line.to_integer = a_value
		end

	set_attribute (a_key: READABLE_STRING_8; a_value: READABLE_STRING_8)
			-- Set attribute `a_key' to `a_value'.
		do
			if not attached attributes then
				create attributes.make (5)
				attributes.compare_objects
			end
			if a_value = Void then
				attributes.remove (a_key)
			else
				attributes.force (a_value.twin, a_key)
			end
		ensure
			attribute_set: attributes[a_key] ~ a_value
		end

	load (a_other: IV_NODE_INFO)
			-- Load data from `a_other'.
		do
			attributes := a_other.attributes
		end

end
