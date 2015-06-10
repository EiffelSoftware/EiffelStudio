note
	description: "[
			Constants related to HTTP request method identification
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	HTTP_REQUEST_METHOD_CONSTANTS

inherit
	HTTP_REQUEST_METHODS

feature -- Id

	head: INTEGER = 0x1

	get: INTEGER = 0x2

	trace: INTEGER = 0x4

	options: INTEGER = 0x8

	post: INTEGER = 0x10

	put: INTEGER = 0x20

	delete: INTEGER = 0x40

	connect: INTEGER = 0x80

	patch: INTEGER = 0x100

feature -- Name

	method_empty: STRING = ""

feature -- Query

	method_id (a_id: STRING): INTEGER
		local
			s: STRING
		do
			s := a_id.as_lower
			if s.same_string (method_get) then
				Result := get
			elseif s.same_string (method_post) then
				Result := post
			elseif s.same_string (method_put) then
				Result := put
			elseif s.same_string (method_patch) then
				Result := patch
			elseif s.same_string (method_delete) then
				Result := delete
			elseif s.same_string (method_head) then
				Result := head
			elseif s.same_string (method_trace) then
				Result := trace
			elseif s.same_string (method_options) then
				Result := options
			elseif s.same_string (method_connect) then
				Result := connect
			end
		end

	method_name (a_id: INTEGER): STRING
		do
			inspect a_id
			when head then Result := method_head
			when get then Result := method_get
			when trace then Result := method_trace
			when options then Result := method_options
			when post then Result := method_post
			when put then Result := method_put
			when patch then Result := method_patch
			when delete then Result := method_delete
			when connect then Result := method_connect
			else
				Result := method_empty
			end
		ensure
			result_is_upper_case: Result /= Void and then Result.as_upper ~ Result
		end

note
	copyright: "2011-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
