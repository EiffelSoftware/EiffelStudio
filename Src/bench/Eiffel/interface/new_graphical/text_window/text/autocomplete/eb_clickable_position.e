indexing
	description	: "Objects that represent a clickable position in the editor."
	author		: "Etienne Amodeo"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CLICKABLE_POSITION
inherit
	COMPARABLE
create
	make, make_from_token

feature -- Initialisation

	make(a_beginning: INTEGER; an_end: INTEGER ) is
		do
			start := a_beginning
			stop := an_end
		end

	make_from_token(a_token: EDITOR_TOKEN) is
		do
			start := a_token.position
			stop := a_token.width + start
		end

feature -- Access

	start: INTEGER

	stop: INTEGER	

	is_feature: BOOLEAN

	is_class: BOOLEAN

	class_name: STRING

	feature_name: STRING

feature -- element change

	set_feature (a_class_name, a_feature_name: STRING) is
		require
			valid_class_name: a_class_name /= Void
			valid_feature_feature_name: a_feature_name /= Void
		do
			class_name := a_class_name
			feature_name := a_feature_name
			is_feature := True
			is_class := False
		end

	set_class(a_class_name: STRING) is
		require
			valid_class_name: a_class_name /= Void
		do
			class_name := a_class_name
			feature_name := Void
			is_feature := False
			is_class := True
		end

feature -- comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := start < other.start
		ensure then
			asymmetric: Result implies not (other < Current)
		end

invariant

	coherent_feature: is_feature implies class_name /= Void and feature_name /= Void
	coherent_class: is_class implies class_name /= Void and feature_name = Void
	class_or_feature: not (is_class and is_feature)

end -- class EB_CLICKABLE_POSITION
