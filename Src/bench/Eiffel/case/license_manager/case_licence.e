class CASE_LICENCE

inherit

	DUMMY_LICENSE

creation

	make

feature

	make is do end

	application_delay: INTEGER is 30

	override_key_line: INTEGER is 6;

end
