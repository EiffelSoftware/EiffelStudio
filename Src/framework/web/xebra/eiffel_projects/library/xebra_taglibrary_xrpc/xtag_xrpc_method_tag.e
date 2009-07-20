note
	description: "[
		TODO
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_XRPC_METHOD_TAG

inherit
	XTAG_TAG_SERIALIZER

create
	make

feature -- Initialization

	make
			-- <Precursor>
		do
			make_base
			create {XTAG_TAG_VALUE_ARGUMENT} name.make_default
		end

feature -- Access

	name: XTAG_TAG_ARGUMENT
			-- The name of the method

feature -- Implementation

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		do
			if attached {XEL_FEATURE_ELEMENT} a_variable_table [{XTAG_XRPC_API_TAG}.new_method_agents_feature] as l_new_method_agents_feature then
				l_new_method_agents_feature.append_expression ("Result.put (agent api." + name.value (current_controller_id)
					+ ", %"" + name.value (current_controller_id) + "%")")
			end
		end

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precursor>
		do
			if a_id.is_equal ("name") then
				name := a_attribute
			end
		end

end
