indexing
	description: "Information on a feature of the system for XMI export"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMI_FEATURE

inherit
	XMI_ITEM

feature -- Initialization

	make (id: INTEGER; n: STRING; t: XMI_TYPE) is
			-- Initialization of `Current'.
		do
			xmi_id := id
			type := t
			is_public := false
			is_protected := false
			is_private := false
			name := n
		end

feature -- Properties

	is_public: BOOLEAN
			-- Is `Current' exorted to all classes?

	is_protected: BOOLEAN
			-- Is `Current' exported to some classes only?

	is_private: BOOLEAN
			-- Is `Current' exported to none?

feature -- Status setting

	set_public is
			-- Set `Current' export status to public.
		do
			is_public := true
		end

	set_protected is
			-- Set `Current' export status to protected.
		do
			is_protected := true
		end

	set_private is
			-- Set `Current' export status to private.
		do
			is_private := true
		end

feature -- Access

	type: XMI_TYPE
			-- Type of the feature represented by `Current'.

	name: STRING
			-- Name of `Current'.

end -- class XMI_FEATURE
