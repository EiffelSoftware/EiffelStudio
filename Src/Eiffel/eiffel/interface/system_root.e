indexing
	description: "[
		Objects representing root creation procedures.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_ROOT

create
	make_with_class

feature {NONE} -- Initialization

	make_with_class (a_class: like root_class; a_name: like procedure_name)
			-- Initialize `Current'
			--
			-- `a_class': Class representing root class of system
			-- `a_name': Name of root creation procedure
		require
			a_class_attached: a_class /= Void
			not_an_override_class: a_class.config_class.overrides = Void or else a_class.config_class.overrides.is_empty
			a_name_attached: a_name /= Void
		do
			root_class := a_class
			procedure_name := a_name
		ensure
			root_class_set: root_class = a_class
			procedure_name_set: procedure_name = a_name
		end

feature -- Access

	root_class: CLASS_I
			-- Root class

	procedure_name: STRING
			-- Name of root creation procedure in `root_class'

	class_type: CL_TYPE_A
			-- Corresponding type of `root_class'
		require
			type_set: is_class_type_set
		do
			Result := internal_class_type
		end

	class_type_as: CLASS_TYPE_AS
			-- Corresponding type as of `root_class'
		require
			type_set: is_class_type_as_set
		do
			Result := internal_class_type_as
		end

feature -- Query

	cluster: CONF_GROUP
			-- Group of `root_class'
		do
			Result := root_class.group
		end

feature {NONE} -- Access

	internal_class_type: ?like class_type
			-- Internal storage for `class_type'

	internal_class_type_as: ?like class_type_as
			-- Internal storage for `class_type_as'

feature -- Status report

	is_class_type_set: BOOLEAN
			-- Has `class_type' been set yet?
		do
			Result := internal_class_type /= Void
		end

	is_class_type_as_set: BOOLEAN
			-- Has `class_type_as' been set yet?
		do
			Result := internal_class_type_as /= Void
		end

feature -- Status setting

	set_class_type (a_type: like class_type)
			-- Set `class_type' to `a_type'.
		do
			internal_class_type := a_type
		ensure
			class_type_set: is_class_type_set and then class_type = a_type
		end

	set_class_type_as (a_type: like class_type_as)
			-- Set `class_type_as' to `a_type'.
		do
			internal_class_type_as := a_type
		ensure
			class_type_as_set: is_class_type_as_set and then class_type_as = a_type
		end

invariant
	root_class_attached: root_class /= Void
	not_an_override: root_class.config_class.overrides = Void or else root_class.config_class.overrides.is_empty
	procedure_name_attached: procedure_name /= Void

end
