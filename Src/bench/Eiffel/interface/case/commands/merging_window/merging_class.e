indexing

	description:
		"Information about a class for which two versions could be merged.";
	date: "$Date$";
	revision: "$Revision $"

class
	MERGING_CLASS

inherit
	COMPARABLE

creation
	make

feature -- Initialization

	make (n: like name; cn: like cluster_name; op: like old_path; np: like new_path) is 
		require
			n_exists: n /= Void
			cn_exists: cn /= Void
			op_exists: op /= Void
			np_exists: np /= Void
		do
			name := n
			cluster_name := cn
			new_path := np
			old_path := op
		ensure
			name_set: name = n
			cluster_name_set: cluster_name = cn
			old_path_set: old_path = op
			new_path_set: new_path = np
		end
 
feature -- Properties

	cluster_name: STRING
			-- Name of encompassing cluster

	extra_comments: STRING is
			-- Extra printable comments about Current class
			-- (invalid syntax only)
		do
			if invalid_new_syntax then
				Result := "(syntax error in Case version)"
			elseif invalid_old_syntax then
				Result := "(syntax error in code version)"
			else
				Result := ""
			end
		end

	invalid_syntax: BOOLEAN is
			-- Has one of the versions an invalid syntax ?
		do
			Result := invalid_new_syntax or else invalid_old_syntax
		ensure
			syntax_is_old_or_new: Result = invalid_new_syntax or else invalid_old_syntax
		end

	invalid_new_syntax, invalid_old_syntax: BOOLEAN
			-- Is the new Case (resp. old, code) version of Current class
			-- syntactically incorrect ?
			--| Valid only after it has been explicitely parsed 

	name: STRING
			-- Name

	name_with_cluster: STRING is
			-- Name, followed by the cluster name in parenthesis
		do
			Result := clone (name)
			Result.append (" (cluster ")
			Result.append (cluster_name)
			Result.extend (')')
		end

	new_path: STRING
			-- Directory where the new version of Current class is generated

	old_path: STRING
			-- Directory where the old version of Current class is

feature -- Setting

	set_invalid_new_syntax is
			-- Set `invalid_new_syntax' to True
		do
			invalid_new_syntax := True
		ensure
			invalid_new_syntax_set: invalid_new_syntax
		end

	set_invalid_old_syntax is
			-- Set `invalid_old_syntax' to True
		do
			invalid_old_syntax := True
		ensure
			invalid_old_syntax_set: invalid_old_syntax
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := (cluster_name < other.cluster_name) or else
					(cluster_name.is_equal(other.cluster_name) and then
					 name < other.name)
		end

invariant
	name_exists: name /= Void
	cluster_name_exists: cluster_name /= Void
	old_path_exists: old_path /= Void
	new_path_exists: new_path /= Void

end -- class MERGING_CLASS
