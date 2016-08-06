note
	description: "[
		A web socket message has an opcode specifying the type of the message payload. The
		opcode consists of the last four bits in the first byte of the frame header.
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Data Frame", "src=http://tools.ietf.org/html/rfc6455#section-5.6", "protocol=uri"
	EIS: "name=Control Frame", "src=http://tools.ietf.org/html/rfc6455#section-5.5", "protocol=uri"

class
	WEB_SOCKET_MESSAGE_TYPE

feature -- Data Frames

	Text: INTEGER = 0x1
			-- The data type of the message is text.

	Binary: INTEGER = 0x2
			-- The data type of the message is binary.

feature -- Control Frames

	Close: INTEGER = 0x8
			-- The client or server is sending a closing
			-- handshake to the server or client.

	Ping: INTEGER = 0x9
			-- The client or server sends a ping to the server or client.

	Pong: INTEGER = 0xA
			-- The client or server sends a pong to the server or client.

feature -- Reserverd

		-- Opcodes  0x3-0x7 are reserved for further non-control frames yet to be
		-- defined.

end
