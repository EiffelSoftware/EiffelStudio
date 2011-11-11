note
	description: "An object that is DER encodable"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "I think the terror most people are concerned with is the IRS. - Malcolm Forbes, when asked if he was afraid of terrorism"

deferred class
	DER_ENCODABLE

inherit
	DER_FACILITIES

feature
	der_encode (target: DER_OCTET_SINK)
		deferred
		end
end
