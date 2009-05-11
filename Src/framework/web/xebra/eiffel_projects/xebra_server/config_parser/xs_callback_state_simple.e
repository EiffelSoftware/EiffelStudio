note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_CALLBACK_STATE_SIMPLE

inherit
	XS_CALLBACK_STATE redefine make end
	ERROR_SHARED_MULTI_ERROR_MANAGER

create
	make

feature -- Initialization

	make (a_config_callback: XS_XML_CONFIG_CALLBACK)
			--
		do
			Precursor (a_config_callback)
			create pairs.make (5)
		end


feature -- Access

	pairs: ARRAYED_STACK [XS_XML_SIMPLE_PAIR]

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
			-- <Precursor>
		do
			pairs.item.set_value (a_value)
		end

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- <Precursor>
		do
			pairs.force (create {XS_XML_SIMPLE_PAIR})
			pairs.item.set_tag (a_local_part)
		end

end

