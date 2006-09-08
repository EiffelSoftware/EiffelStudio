indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_INFO_ONLY_CONSUMER

inherit
	TYPE_CONSUMER
		redefine
			make
		end

create
	make

feature -- Initialization

	make (t: SYSTEM_TYPE; en: STRING) is
			-- Initialize type consumer for type `t' with eiffel name `en'.
		local
			dotnet_name: STRING
			parent_name: SYSTEM_STRING
			inter: NATIVE_ARRAY [SYSTEM_TYPE]
			interfaces: ARRAYED_LIST [CONSUMED_REFERENCED_TYPE]
			parent: CONSUMED_REFERENCED_TYPE
			i, nb, count: INTEGER
			parent_type: SYSTEM_TYPE
			l_ab_type: EC_CHECKED_ABSTRACT_TYPE
			l_force_sealed: BOOLEAN
		do
			create dotnet_name.make_from_cil (t.full_name)
			if t.is_nested_public or t.is_nested_family or t.is_nested_fam_or_assem then
					-- `t.declaring_type' contains enclosing type of current nested type.
				check
					is_declaring_type_consumed: is_consumed_type (t.declaring_type)
				end
				create {CONSUMED_NESTED_TYPE} consumed_type.make (
					dotnet_name, en, t.is_interface, t.is_abstract,
					False, t.is_value_type, t.is_enum, Void, create {ARRAYED_LIST [CONSUMED_REFERENCED_TYPE]}.make (0),
					referenced_type_from_type (t.declaring_type))
			else
				create consumed_type.make (dotnet_name, en, t.is_interface, t.is_abstract,
					False, t.is_value_type, t.is_enum, Void, create {ARRAYED_LIST [CONSUMED_REFERENCED_TYPE]}.make (0))
			end

			create internal_members.make (0)
			create internal_properties.make (0)
			create internal_events.make (0)
			create internal_constructors.make (0)
			create properties_and_events.make

			internal_referenced_type := referenced_type_from_type (t)
		end

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
