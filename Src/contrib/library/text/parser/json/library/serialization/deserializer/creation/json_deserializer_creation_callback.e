note
	description: "Summary description for {JSON_DESERIALIZER_CREATION_CALLBACK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JSON_DESERIALIZER_CREATION_CALLBACK

feature -- Callback

	on_value_creation (a_value_info: JSON_DESERIALIZER_CREATION_INFORMATION)
		deferred
		end

note
	copyright: "2010-2016, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
