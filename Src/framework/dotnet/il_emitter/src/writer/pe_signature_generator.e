note
	description: "Summary description for {PE_SIGNATURE_GENERATOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	PE_SIGNATURE_GENERATOR


inherit

	ANY
		redefine
			default_create
		end

feature {NONE} -- Initilization

	default_create
		do
			create work_area.make_filled (0, 400 * 1024)
		end

feature -- Access

	work_area: SPECIAL [INTEGER]
			-- 400 * 1024

	basic_types: SPECIAL [INTEGER]
		do
			Result := <<
										0,
                                        0,
                                        0,
                                        0,
                                        {PE_TYPES_ENUM}.ELEMENT_TYPE_VOID,
                                        {PE_TYPES_ENUM}.ELEMENT_TYPE_bool,
                                        {PE_TYPES_ENUM}.ELEMENT_TYPE_CHAR,
                                        {PE_TYPES_ENUM}.ELEMENT_TYPE_I1,
                                        {PE_TYPES_ENUM}.ELEMENT_TYPE_U1,
                                        {PE_TYPES_ENUM}.ELEMENT_TYPE_I2,
                                        {PE_TYPES_ENUM}.ELEMENT_TYPE_U2,
                                        {PE_TYPES_ENUM}.ELEMENT_TYPE_I4,
                                        {PE_TYPES_ENUM}.ELEMENT_TYPE_U4,
                                        {PE_TYPES_ENUM}.ELEMENT_TYPE_I8,
                                        {PE_TYPES_ENUM}.ELEMENT_TYPE_U8,
                                        {PE_TYPES_ENUM}.ELEMENT_TYPE_I,
                                        {PE_TYPES_ENUM}.ELEMENT_TYPE_U,
                                        {PE_TYPES_ENUM}.ELEMENT_TYPE_R4,
                                        {PE_TYPES_ENUM}.ELEMENT_TYPE_R8,
                                        0,
                                        {PE_TYPES_ENUM}.ELEMENT_TYPE_STRING
			>>
		ensure
			instance_free: class
		end

	object_base: INTEGER assign set_object_base

feature -- Element Change

	set_object_base (a_base: INTEGER)
			-- Set `object_base` with `a_base`
		do
			object_base := a_base
		ensure
			object_base_set: object_base = a_base
		end

end
