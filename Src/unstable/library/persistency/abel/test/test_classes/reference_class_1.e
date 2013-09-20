note
	description: "Summary description for {REFERENCE_CLASS_1}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REFERENCE_CLASS_1

create
	make

feature

	make (i: INTEGER)
		do
			ref_class_id := i
			create references.make
		end

	ref_class_id: INTEGER

	references: LINKED_LIST [REFERENCE_CLASS_1]

	refer: detachable REFERENCE_CLASS_1

	add_ref (ref: REFERENCE_CLASS_1)
		do
			refer := ref
		end

	update
		do
			ref_class_id := ref_class_id + 1
		end

end
