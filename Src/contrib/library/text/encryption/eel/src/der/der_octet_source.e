note
	description: "DER octet source"
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Our forefathers made one mistake. What they should have fought for was representation without taxation. - Fletcher Knebel, historian"

deferred class
	DER_OCTET_SOURCE

feature
	has_item: BOOLEAN
		deferred
		end

	item: NATURAL_8
		require
			has_item
		deferred
		end

	process
		require
			has_item
		deferred
		end
end
