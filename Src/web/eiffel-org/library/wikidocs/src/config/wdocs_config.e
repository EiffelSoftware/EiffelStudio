note
	description: "Summary description for {WDOCS_CONFIG}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WDOCS_CONFIG

feature -- Access

	root_dir: PATH

	temp_dir: PATH

	documentation_dir: PATH

	documentation_default_version: STRING

	cache_duration: INTEGER

feature -- Element change

	set_root_dir (p: like root_dir)
		do
			root_dir := p
		end

	set_temp_dir (p: like temp_dir)
		do
			temp_dir := p
		end

	set_documentation_dir (p: like documentation_dir)
		do
			documentation_dir := p
		end

	set_documentation_default_version (v: like documentation_default_version)
		do
			documentation_default_version := v
		end

	set_cache_duration (d: like cache_duration)
		do
			cache_duration := d
		end

end
