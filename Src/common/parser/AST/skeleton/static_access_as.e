indexing
	description:
		"Abstract description of an access to the precursor of%
		%an Eiffel feature. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class STATIC_ACCESS_AS

inherit
	ACCESS_FEAT_AS
		rename
			initialize as feat_initialize
		export
			{NONE} feat_initialize
		redefine
			process, is_equivalent
		end

	ATOMIC_AS

create
	initialize

feature {AST_FACTORY} -- Initialization

	initialize (c: like class_type; f: like feature_name; p: like parameters; f_as: like feature_keyword; d_as: like dot_symbol) is
			-- Create a new STATIC_ACCESS_AS AST node.
		require
			c_not_void: c /= Void
			f_not_void: f /= Void
		do
			class_type := c
			feature_name := f
			internal_parameters := p
			if parameters /= Void then
				parameters.start
			end
			feature_keyword := f_as
			dot_symbol := d_as
		ensure
			class_type_set: class_type = c
			feature_name_set: feature_name = f
			internal_parameters_set: internal_parameters = p
			feature_keyword_set: feature_keyword = f_as
			dot_symbol_set: dot_symbol = d_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_static_access_as (Current)
		end

feature -- Roundtrip

	feature_keyword: KEYWORD_AS
			-- Keyword "feature" associated with this structure

	dot_symbol: SYMBOL_AS
			-- Symbol "." associated with this structure

feature -- Attributes

	class_type: TYPE_AS
			-- Type in which `feature_name' is defined.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := Precursor {ACCESS_FEAT_AS} (other) and then
				equivalent (class_type, other.class_type)
		end

feature {AST_EIFFEL} -- Output

	string_value: STRING is
			-- Printed value of Current
		do
			Result := "{" + class_type.dump + "}." + feature_name.string_value
		end

invariant
	class_type_not_void: class_type /= Void
	feature_name_not_void: feature_name /= Void

end -- class STATIC_ACCESS_AS
