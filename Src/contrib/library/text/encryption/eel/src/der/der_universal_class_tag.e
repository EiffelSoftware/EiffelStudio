note
	description: "ASN.1 universal class tag assignments X.680 8.4"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "The usual road to slavery is that first they take away your guns, then they take away your property, then last of all they tell you to shut up and say you are enjoying it. - James A. Donald"

deferred class
	DER_UNIVERSAL_CLASS_TAG

feature
	reserved: NATURAL_8 = 0x0
	boolean: NATURAL_8 = 0x1
	integer: NATURAL_8 = 0x2
	bit_string: NATURAL_8 = 0x3
	octet_string: NATURAL_8 = 0x4
	null: NATURAL_8 = 0x5
	object_identifier: NATURAL_8 = 0x6
	object_descriptor: NATURAL_8 = 0x7
	external_type: NATURAL_8 = 0x8
	real: NATURAL_8 = 0x9
	enumerated: NATURAL_8 = 0xa
	embedded_pdv: NATURAL_8 = 0xb
	utf8_string: NATURAL_8 = 0xc
	relative_object_identifier: NATURAL_8 = 0xd
	sequence: NATURAL_8 = 0x10
	set: NATURAL_8 = 0x11
	universal_time: NATURAL_8 = 0x17
	generalized_time: NATURAL_8 = 0x18

end
