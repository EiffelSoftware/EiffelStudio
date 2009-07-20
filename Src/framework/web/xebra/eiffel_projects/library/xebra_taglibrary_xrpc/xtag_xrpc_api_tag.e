note
	description: "[
		TODO
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XTAG_XRPC_API_TAG

inherit
	XTAG_TAG_SERIALIZER

create
	make

feature -- Initialization

	make
			-- <Precursor>
		do
			make_base
			create {XTAG_TAG_VALUE_ARGUMENT} i_class.make_default
			create {XTAG_TAG_VALUE_ARGUMENT} namespace.make_default
		ensure
			i_class_attached: attached i_class
			namespace_attached: attached namespace
		end

feature -- Access

	i_class: XTAG_TAG_ARGUMENT
			-- The name of the associated class (controller)

	namespace: XTAG_TAG_ARGUMENT
			-- Optional namespace of the xrpc api

feature -- Implementation

	internal_generate (a_servlet_class: XEL_SERVLET_CLASS_ELEMENT; a_variable_table: HASH_TABLE [ANY, STRING])
			-- <Precursor>
		local
			l_namespace_feature: XEL_FEATURE_ELEMENT
			l_new_method_agents_feature: XEL_FEATURE_ELEMENT
		do
			create l_namespace_feature.make ("namespace: IMMUTABLE_STRING_8")
			l_namespace_feature.set_once
			l_namespace_feature.append_expression ("Result := %"" + namespace.value (current_controller_id) + "%"")
			a_servlet_class.add_feature (l_namespace_feature)
			create l_new_method_agents_feature.make (New_method_agents_feature)
			l_new_method_agents_feature.append_expression ("create Result.make (2)")
			a_servlet_class.add_feature (l_new_method_agents_feature)
			a_variable_table.put (l_new_method_agents_feature, New_method_agents_feature)
			generate_children (a_servlet_class, a_variable_table)
			a_variable_table.remove (New_method_agents_feature)
		end

	internal_put_attribute (a_id: STRING; a_attribute: XTAG_TAG_ARGUMENT)
			-- <Precusor>
		do
			if a_id.is_equal ("i_class") then
				i_class := a_attribute
			end
			if a_id.is_equal ("namespace") then
				namespace := a_attribute
			end
		end

feature -- Constants

	New_method_agents_feature: STRING = "new_method_agents: HASH_TABLE [ROUTINE [ANY, TUPLE], READABLE_STRING_8]"

end
