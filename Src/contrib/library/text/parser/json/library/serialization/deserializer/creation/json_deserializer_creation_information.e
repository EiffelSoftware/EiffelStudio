note
	description: "Summary description for {JSON_DESERIALIZER_CREATION_INFORMATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_DESERIALIZER_CREATION_INFORMATION

create
	make

feature {NONE} -- Initialization

	make (a_static_type: detachable TYPE [detachable ANY]; a_json: detachable JSON_VALUE)
		do
			static_type := a_static_type
			json_value := a_json
		end

feature -- Access

	static_type: detachable TYPE [detachable ANY]

	json_value: detachable JSON_VALUE assign set_json_value

	parent_object: detachable ANY

	feature_name: detachable READABLE_STRING_GENERAL

feature -- Response

	object: detachable ANY
			-- Provide expected object.

feature -- Element change

	set_json_value (a_value: like json_value)
		do
			json_value := a_value
		end

	set_parent_object (o: detachable ANY)
		do
			parent_object := o
		end

	set_feature_name (fn: detachable READABLE_STRING_GENERAL)
		do
			feature_name := fn
		end

	set_object (obj: like object)
		do
			object := obj
		end


;note
	copyright: "2010-2016, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
