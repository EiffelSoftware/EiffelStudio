indexing

	description:

		"Constant attributes implemented in .NET"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2006, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_DOTNET_CONSTANT_ATTRIBUTE

inherit

	ET_CONSTANT_ATTRIBUTE
		undefine
			is_frozen, is_dotnet,
			overloaded_extended_name
		redefine
			process, make,
			new_synonym, renamed_feature
		end

	ET_DOTNET_QUERY
		undefine
			is_constant_attribute,
			is_prefixable
		end

create

	make

feature {NONE} -- Initialization

	make (a_name: like extended_name; a_type: like declared_type; a_constant: like constant; a_class: like implementation_class) is
			-- Create a new .NET constant attribute.
		do
			precursor (a_name, a_type, a_constant, a_class)
			dotnet_name := name.name
			overloaded_extended_name := a_name
		ensure then
			dotnet_name_set: dotnet_name.same_string (name.name)
			overloaded_extended_name_set: overloaded_extended_name = a_name
		end

feature -- Duplication

	new_synonym (a_name: like extended_name): like Current is
			-- Synonym feature
		do
			Result := precursor (a_name)
			Result.set_overloaded_extended_name (overloaded_extended_name)
			Result.set_dotnet_name (dotnet_name)
		end

feature -- Conversion

	renamed_feature (a_name: like extended_name): like Current is
			-- Renamed version of current feature
		do
			Result := precursor (a_name)
			Result.set_overloaded_extended_name (overloaded_extended_name)
			Result.set_dotnet_name (dotnet_name)
		end

feature -- Processing

	process (a_processor: ET_AST_PROCESSOR) is
			-- Process current node.
		do
			a_processor.process_dotnet_constant_attribute (Current)
		end

end
