-- Abstract description of a repeated class export

class REPEAT_AS
obsolete "No repeat in Eiffel. What is this class for"
inherit

	EXPORT_AS

feature -- Attributes

	class_to_repeat: ID_AS;
			-- Class to repeat what concrens exports

feature -- Initilization

	set is
			-- Yacc initialization
		do
			class_to_repeat ?= yacc_arg (0);
		ensure then
			class_to_repeat_exists: class_to_repeat /= Void;
		end;

end
