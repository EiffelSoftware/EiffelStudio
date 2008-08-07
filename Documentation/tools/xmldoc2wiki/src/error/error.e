indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR

feature -- Access

	to_string: STRING
		do
			create Result.make_from_string (message)
			if position > 0 then
				Result.append (" (pos=" + position.out + ")")

			end
		end

	position: INTEGER assign set_position

	associated_tag: STRING assign set_associated_tag
			-- Associated tag

	message: STRING assign set_message
			-- Message

feature -- Element change

	set_position (v: like position)
		do
			position := v
		end

	set_associated_tag (v: like associated_tag)
		require
			v_attached: v /= Void
		do
			associated_tag := v
		end

	set_message (m: like message)
		require
			m_attached: m /= Void
		do
			message := m
		end

end
